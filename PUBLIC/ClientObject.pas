{ $HDR$ }
{ ********************************************************************** }
{ Unit archived using Team Coherence }
{ Team Coherence is Copyright 2002 by Quality Software Components }
{ }
{ For further information / comments, visit our WEB site at }
{ http://www.TeamCoherence.com }
{ ********************************************************************** }
{ }
{ $Log:  22956: ClientThread.pas
  {
  {   Rev 1.0    09/10/2003 3:10:54 PM  Jeremy Darling
  { Project Checked into TC for the first time
}
unit ClientObject;

interface

uses
  Vcl.StdCtrls,
  IdTCPClient,
  IdUDPServer,
  IdTCPConnection,
  IdBaseComponent, IdGlobal, IdSocketHandle,
  IdUDPBase,
  ComCtrls,
  Classes,
  SysUtils,
  SyncObjs,
  Windows,
  MyMessageQueue,
  GlobalFunctions;

type
  TClientObject = class(TObject)
    Memo: TMemo;
  private
    FTCPClient: TIdTCPClient;
    FUDP: TIdUDPServer;
    FFree: Boolean;
    // FLastTick: Cardinal;
    FuiLock: TCriticalSection;
    FSleepTime: Integer;
    procedure SetuiLock(const Value: TCriticalSection);
    procedure SetSleepTime(const Value: Integer);
    procedure Log(msg: String); overload;
    procedure Log(sl: TStringList); overload;

    procedure IdUDPRead(AThread: TIdUDPListenerThread; const AData: TIdBytes; ABinding: TIdSocketHandle);
    procedure InitUDP(lip: String; lPort: Integer);
  public
    procedure AssignTCPClient(AClient: TIdTCPClient);
    procedure AssignUDP(AClient: TIdUDPServer; lip: String; lPort: Integer);
    procedure Execute;

    Constructor Create(Free: Boolean);
    destructor Destroy; override;
    property SleepTime: Integer read FSleepTime write SetSleepTime;
    property Client: TIdTCPClient read FTCPClient;
    property uiLock: TCriticalSection read FuiLock write SetuiLock;

    procedure UDPSendHexStr(Ip: String; Port: Integer; hs: String);
    procedure TCPSendHexStr(hs: String);
    procedure TCPSendStr(str: String);
  end;

implementation

uses Unit200, VDevice;
{ TClientThread }

procedure TClientObject.AssignUDP(AClient: TIdUDPServer; lip: String; lPort: Integer);
begin
  if not Assigned(FUDP) then
    FUDP := TIdUDPServer.Create(nil);
  with FUDP do
  begin
    // OnStatus := AClient.OnStatus;
    OnUDPRead := IdUDPRead;
    ThreadedEvent := true;
  end;
  InitUDP(lip, lPort);
end;

procedure TClientObject.InitUDP(lip: String; lPort: Integer);
var
  i: Integer;
begin
  try
    FUDP.Active := False;
    FUDP.BroadcastEnabled := False;
    FUDP.Bindings.Clear;
    FUDP.Bindings.Add;
    FUDP.Bindings[FUDP.Bindings.count - 1].Ip := lip; // 本地IP
    FUDP.Bindings[FUDP.Bindings.count - 1].Port := lPort;
    // 本地IP
    FUDP.Bindings[FUDP.Bindings.count - 1].IPVersion := Id_IPv4;
    FUDP.DefaultPort := lPort;
    FUDP.BroadcastEnabled := true;
    FUDP.Active := true;
    // IdUDPServer1.Broadcast();
  Except
    on e: Exception do
    begin
      // St(1, 'InitUDP' + e.tostring);
      Exit;
    end;
  end;
end;

procedure TClientObject.AssignTCPClient(AClient: TIdTCPClient);
begin
  if not Assigned(FTCPClient) then
    FTCPClient := TIdTCPClient.Create(nil);
    FTCPClient.IOHandler.DefStringEncoding := IndyTextEncoding_UTF8();
  with FTCPClient do
  begin
    Port := AClient.Port;
    Host := AClient.Host;
    IOHandler := AClient.IOHandler;
    OnConnected := AClient.OnConnected;
    OnDisconnected := AClient.OnDisconnected;
    OnStatus := AClient.OnStatus;
    OnWork := AClient.OnWork;
    OnWorkBegin := AClient.OnWorkBegin;
    OnWorkEnd := AClient.OnWorkEnd;
    ConnectTimeout := AClient.ConnectTimeout;
  end;
end;

Constructor TClientObject.Create(Free: Boolean);
begin
  FFree := Free;
  Memo := nil;
  // inherited;
end;

destructor TClientObject.Destroy;
begin
  FFree := true;
  if FTCPClient <> nil then
    if FTCPClient.Connected then
      FTCPClient.Disconnect;

  if FTCPClient <> nil then
    FTCPClient.Free;

  if FUDP <> nil then
    FUDP.Free;
  inherited;
end;

procedure TClientObject.Execute; // TCP 同步柱塞式
var
  // i: Integer;
  str: String;
begin
  if (not FTCPClient.Connected) then
  begin
    FTCPClient.Connect;
  end;

  while not FFree do
  begin
    try
      str := FTCPClient.IOHandler.ReadLn();
    Except
    Exit;
    end;
    if (str <> '') then
    begin
      if (Memo <> nil) then
      begin
        Log(GetSystemDateTimeStr() + ' TCP数据来自：' + FTCPClient.Socket.Host + ':' + IntToStr(FTCPClient.Socket.Port));

        Log(str);
      end;
      MQueue.SendMessage(TMyMessage.Create(200, 0, 0, str));
    end;
  end;
end;

// 一个binding一个线程
// 一个线程里面有多个套接字 ABinding
// 一个套接字就是一个设备
procedure TClientObject.IdUDPRead(AThread: TIdUDPListenerThread; const AData: TIdBytes; ABinding: TIdSocketHandle);
var
  sl: TStringList;
  dv: TVDevice;
begin
  sl := TStringList.Create;
  Log(GetSystemDateTimeStr() + ' UDP数据来自：' + ABinding.PeerIP + ':' + IntToStr(ABinding.PeerPort) + ':' + IntToStr(AThread.ThreadID));

  FormatBuff(AData, sl, 16);
  Log(sl);
  sl.Clear;
  sl.Free;

  /// ///////////////////////////////////////////////////////////////////////
  // 解析鲲鹏节点设备
  if Length(AData) >= 292 then
  begin
    dv := TVDevice.Create(ABinding.PeerIP, IntToStr(ABinding.PeerPort), AData);
    if dv.Parser_Check_KP() then
    begin
      MQueue.SendMessage(TMyMessage.Create(100, dv)); // 通知UI跟新设备
    end
    else
    begin
      dv.Free;
    end;
  end;
end;

procedure TClientObject.UDPSendHexStr(Ip: String; Port: Integer; hs: String);
var
  str1, str2: String;
  buf: TIdBytes;
  count: Integer;
begin
  str1 := FormatHexStr(trim(hs), count);
  SetLength(buf, count);
  str2 := HexStrToBuff(str1, buf, count);
  Log('UDP发送IP:' + FUDP.Bindings[0].Ip + ':' + IntToStr(FUDP.Bindings[0].Port) + ' --> ' + Ip + ':' + IntToStr(Port));
  Log(str2);
  try
    FUDP.SendBuffer(Ip, Port, buf);
  Except
    on e: Exception do
    begin
      Log(e.tostring);
    end;
  end;
end;

procedure TClientObject.TCPSendHexStr(hs: string);
var
  str1, str2: String;
  buf: TIdBytes;
  count: Integer;
begin
  str1 := FormatHexStr(trim(hs), count);
  SetLength(buf, count);
  str2 := HexStrToBuff(str1, buf, count);
  Log('TCP发送IP:' + FTCPClient.Socket.Binding.Ip + ':' + IntToStr(FTCPClient.Socket.Binding.Port) + ' --> ' + FTCPClient.Host + ':' + IntToStr(FTCPClient.Port));
  Log(str2);
  try
    FTCPClient.IOHandler.Write(buf,count);
  Except
    on e: Exception do
    begin
      Log(e.tostring);
    end;
  end;
end;
procedure TClientObject.TCPSendStr(str: string);
begin
   FTCPClient.IOHandler.WriteLn(str);
end;
procedure TClientObject.Log(sl: TStringList);
begin
  if (Memo = nil) then
    Exit;
  if uiLock <> nil then
    uiLock.Enter;
  Memo.Lines.AddStrings(sl);
  if uiLock <> nil then
    uiLock.Leave;
end;

procedure TClientObject.Log(msg: String);
begin
  if (Memo = nil) then
    Exit;

  if uiLock <> nil then
    uiLock.Enter;

  Memo.Lines.Add(msg);

  if uiLock <> nil then
    uiLock.Leave;
end;

procedure TClientObject.SetSleepTime(const Value: Integer);
begin
  FSleepTime := Value;
end;

procedure TClientObject.SetuiLock(const Value: TCriticalSection);
begin
  FuiLock := Value;
end;

end.

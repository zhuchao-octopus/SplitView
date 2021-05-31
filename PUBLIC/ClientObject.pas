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
  TWork = class
    Data: string;
    Id: Integer;
  public

    Constructor Create(Data: String; Id: Integer);
  end;

type
  TTCPWorkEent = procedure(const AData: String; Id: Integer) of object;

  TClientObject = class(TObject)
    Memo: TMemo;

  private
    FTCPClient: TIdTCPClient;
    FUDP: TIdUDPServer;
    FRunning: Boolean;
    // FLastTick: Cardinal;
    //FuiLock: TCriticalSection;
    FSleepTime: Integer;
    FDataCallBack: TTCPWorkEent;
    cs: TCriticalSection;

    FWorkList: TList;
    procedure SetuiLock(const Value: TCriticalSection);
    procedure SetSleepTime(const Value: Integer);

    procedure IdUDPRead(AThread: TIdUDPListenerThread; const AData: TIdBytes; ABinding: TIdSocketHandle);
    procedure InitUDP(lip: String; lPort: Integer);
    procedure DoWork(w: TWork);
  public
    procedure AssignTCPClient(AClient: TIdTCPClient);
    procedure AssignUDP(AClient: TIdUDPServer; lip: String; lPort: Integer);
    procedure OpenTCP;

    Procedure SetWork(Data: String; Id: Integer = 0);
    procedure addWorks(StringLsit: TStrings; Id: Integer);
    Constructor Create(Free: Boolean);
    destructor Destroy; override;
    procedure stop();
    property SleepTime: Integer read FSleepTime write SetSleepTime;
    property Client: TIdTCPClient read FTCPClient;
    //property uiLock: TCriticalSection read FuiLock write SetuiLock;

    procedure UDPSendHexStr(Ip: String; Port: Integer; hs: String);
    procedure TCPSendHexStr(hs: String);
    procedure TCPSendStr(str: String);
    procedure SetCallBack(DataCallBack: TTCPWorkEent);
    function GetWork(): TWork;
    function checkStOK():Boolean;


    procedure Log(msg: String); overload;
    procedure Log(sl: TStringlist); overload;
  end;

implementation

uses Unit200, VDevice;
{ TClientThread }

Constructor TWork.Create(Data: String; Id: Integer);
begin
  Self.Data := Data;
  Self.Id := Id;
end;

function TClientObject.checkStOK():Boolean;
begin
    Result:= FRunning;
end;
procedure TClientObject.SetWork(Data: string; Id: Integer = 0);
begin
  // if FWorkList.Count > 0 then // ��������ģʽ
  // Exit;
  cs.Enter;
  FWorkList.Add(TWork.Create(Data, Id));
  cs.Leave;
end;

procedure TClientObject.addWorks(StringLsit: TStrings; Id: Integer);
var
  i: Integer;
begin
  // if FWorkList.Count > 0 then // ��������ģʽ
  // Exit;
  cs.Enter;
  for i := 0 to StringLsit.count - 1 do
    FWorkList.Add(TWork.Create(StringLsit[i], Id));
  cs.Leave;
end;

function TClientObject.GetWork(): TWork;
begin
  Result := nil;
  try
    if FWorkList.count > 0 then
    begin
      cs.Enter;
      Result := FWorkList.First;
      // FWorkList.Remove(Result); //���������˲�����
      cs.Leave;
    end;
  finally
  end;

end;

procedure TClientObject.SetCallBack(DataCallBack: TTCPWorkEent);
begin
  FDataCallBack := DataCallBack;
end;

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
    FUDP.Bindings[FUDP.Bindings.count - 1].Ip := lip; // ����IP
    FUDP.Bindings[FUDP.Bindings.count - 1].Port := lPort;
    // ����IP
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
  // FTCPClient.IOHandler.DefStringEncoding := IndyTextEncoding_UTF8();
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
  FTCPClient.ReadTimeout := 1000;
end;

Constructor TClientObject.Create(Free: Boolean);
begin
  FRunning := Free;
  Memo := nil;
  FWorkList := TList.Create;
  cs := TCriticalSection.Create;
  // inherited;
end;

destructor TClientObject.Destroy;
begin
  try
    FRunning := false;
    if FTCPClient <> nil then
    begin
      FTCPClient.Disconnect;
      FTCPClient.Free;
    end;

    if FUDP <> nil then
      FUDP.Free;

  finally
    cs.Free;
  end;
  inherited;
end;

procedure TClientObject.stop;
begin
  FRunning := false;
  if FTCPClient <> nil then
  begin
    FTCPClient.Disconnect;
  end;
  if FUDP <> nil then
    FUDP.Active := False;
end;

procedure TClientObject.OpenTCP; // TCP ͬ������ʽ
var
  w, ww: TWork;
  i: Integer;
  str, temp: String;
begin
  try
    if FTCPClient.Connected then // һ������һ���̣߳����ӶϿ��Ƴ��߳�
      Exit;
    if (not FTCPClient.Connected) then
    begin
      FTCPClient.Connect;
      FTCPClient.IOHandler.WriteLn('root' + #13#10);
    end;
  except
    Log('OpenTCP ʧ�ܣ��޷��� TCP.');
    Exit;
  end;
  ww := nil;
  temp := '';
  while FRunning do
  begin
    try
      if (not FTCPClient.Connected) then
      begin
        FRunning := False;
        Log('�����Ѿ��Ͽ���' + FTCPClient.Socket.Host + ':' + inttostr(FTCPClient.Socket.Port));
        break;
      end;
      for i := 0 to FWorkList.count - 1 do
      begin
        w := GetWork();
        if (w <> nil) and ((ww = nil) or (ww.Id = w.Id)) then
        begin
          DoWork(w);
          FWorkList.Remove(w); // �Ƴ��Ѿ���ɵ�����
          ww := w;
        end
        else
        begin
          break;
        end;
      end;

      str := FTCPClient.IOHandler.ReadLn();
    except
     Log('TCP ͨ���رգ�' + FTCPClient.Socket.Host + ':' + inttostr(FTCPClient.Socket.Port));
     FRunning:=false;//��д����ر��߳�
     FTCPClient.Disconnect;
     break;
    end;

    if (str <> '') then
    begin
      temp := temp + ' ' + str;
      if Assigned(FDataCallBack) then
        if ww <> nil then
          FDataCallBack(str, ww.Id)
        else
          FDataCallBack(str, 0);

      // Log('TCP�������ԣ�' + FTCPClient.Socket.Host + ':' + inttostr(FTCPClient.Socket.Port));
      Log(str);
    end
    else
    begin
      if Assigned(FDataCallBack) and (temp <> '') then
      begin
        FDataCallBack(temp, -1);
      end;
      temp := '';
      ww.Free;
      ww := nil;
    end;

  end;//while
end;

procedure TClientObject.DoWork(w: TWork);
begin
  FTCPClient.IOHandler.WriteLn(w.Data + #13#10);

  // while FTCPClient.IOHandler.InputBuffer.Size > 0 do
  // begin
  // str := FTCPClient.IOHandler.ReadLn();
  // end;

  // MQueue.SendMessage(TMyMessage.Create(200, 0, w.Id, str));

end;

// һ��bindingһ���߳�
// һ���߳������ж���׽��� ABinding
// һ���׽��־���һ���豸
procedure TClientObject.IdUDPRead(AThread: TIdUDPListenerThread; const AData: TIdBytes; ABinding: TIdSocketHandle);
var
  //sl: TStringlist;
  dv: TVDevice;
  // s:String;
begin
  //sl := TStringlist.Create;
  Log(' UDP�������ԣ�' + ABinding.PeerIP + ':' + inttostr(ABinding.PeerPort) + ':' + inttostr(AThread.ThreadID)+'|�ֽڣ�'+IntToStr(Length(AData)));
  // s:=BytesToString(AData,IndyTextEncoding_UTF8);
  //FormatBuff(AData, sl, 16);
  //Log(sl);
  //sl.Clear;
  //sl.Free;

  /// ///////////////////////////////////////////////////////////////////////
  // ���������ڵ��豸
  if Length(AData) >= 292 then
  begin
    dv := TVDevice.Create(ABinding.PeerIP, inttostr(ABinding.PeerPort), AData);
    if dv.Parser_Check_KP() then
    begin
      MQueue.SendMessage(TMyMessage.Create(100, dv)); // ֪ͨUI�����豸
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
  Log('UDP����IP:' + FUDP.Bindings[0].Ip + ':' + inttostr(FUDP.Bindings[0].Port) + ' --> ' + Ip + ':' + inttostr(Port));
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
  Log('TCP����IP:' + FTCPClient.Socket.Binding.Ip + ':' + inttostr(FTCPClient.Socket.Binding.Port) + ' --> ' + FTCPClient.Host + ':' + inttostr(FTCPClient.Port));
  Log(str2);
  try
    FTCPClient.IOHandler.Write(buf, count);
  Except
    on e: Exception do
    begin
      Log(e.tostring);
    end;
  end;
end;

procedure TClientObject.TCPSendStr(str: string);
begin
  if not FTCPClient.Connected then
    FTCPClient.Connect;
  FTCPClient.IOHandler.WriteLn(str);
end;

procedure TClientObject.Log(sl: TStringlist);
begin
  if (Memo = nil) then
    Exit;

  Memo.Clear;
  Memo.Lines.AddStrings(sl);

  Memo.Perform($0115, SB_BOTTOM, 0);
end;

procedure TClientObject.Log(msg: String);
begin
  if (Memo = nil) then
    Exit;


  Memo.Lines.Add(msg);
  Memo.Perform($0115, SB_BOTTOM, 0);

end;

procedure TClientObject.SetSleepTime(const Value: Integer);
begin
  FSleepTime := Value;
end;

procedure TClientObject.SetuiLock(const Value: TCriticalSection);
begin
  //FuiLock := Value;
end;

end.

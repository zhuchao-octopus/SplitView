unit VDevice;

interface

uses
{$IFDEF UNIX}Unix, {$ENDIF}
{$IFDEF MSWINDOWS}Windows, {$ENDIF}
{$IFDEF FPC}
  LCLType, LCLIntf, LazarusPackageIntf, LMessages, LResources, Forms, Dialogs,
{$ELSE}
  Messages,
{$ENDIF}
  Classes, SysUtils, Controls, ExtCtrls, Graphics;

type
  TVDevice = Class
    Name: String;
    ID: String;
    IP: String;
    MAC: String;
    Port: String;
    MASK: String;
    Gateway: String;
    Typee: String;
    St: String;
    TxaID: String;
    TxvID: String;
    // x:Integer;
    // y:Integer;
    User: String;
    Password: String;
    MainRTSP: String;
    SubRTSP: String;

    TxPull: String;
    RxPush: String;
    RxGet: String;

    bNew: Boolean;
  private
    FBuff: array of Byte;
  protected
  public
    constructor Create(IP: String; Port: String); Overload;
    constructor Create(Buff: array of Byte); Overload;
    constructor Create(IP: String; Port: String; Buff: array of Byte); Overload;
    constructor Create(); Overload;
    destructor Destroy;

    procedure SetBuffer(Buff: array of Byte);
    function Parser_Check_KP(): Boolean;
    procedure save();
    procedure load();
  end;

implementation

uses StrUtils, Unit200, GlobalFunctions, IP;
{ TVDevice }

constructor TVDevice.Create(IP: String; Port: String);
begin
  Self.IP := IP;
  Self.Port := Port;
  bNew := true;
  TxPull := '';
  RxPush := '';
  RxGet := '';
end;

constructor TVDevice.Create(Buff: array of Byte);
begin
  bNew := true;
  TxPull := '';
  RxPush := '';
  RxGet := '';
  SetBuffer(Buff);
end;

constructor TVDevice.Create(IP: String; Port: String; Buff: array of Byte);
begin
  Self.IP := IP;
  Self.Port := Port;
  bNew := true;
  TxPull := '';
  RxPush := '';
  RxGet := '';
  SetBuffer(Buff);
end;

constructor TVDevice.Create();
begin
  bNew := true;
  TxPull := '';
  RxPush := '';
  RxGet := '';
end;

destructor TVDevice.Destroy;
begin
  SetLength(FBuff, 0);
end;

procedure TVDevice.save;
begin
  if ini <> nil then
  begin
    ini.WriteString(name, 'txpull', TxPull);
    ini.WriteString(name, 'rxpush', RxPush);
    ini.WriteString(name, 'rxget', RxGet);
  end;
end;

procedure TVDevice.load;
begin
  if ini <> nil then
  begin
    TxPull := ini.ReadString(name, 'txpull', '');
    RxPush := ini.ReadString(name, 'rxpush', '');
    RxGet := ini.ReadString(name, 'rxget', '');
  end;
end;

procedure TVDevice.SetBuffer(Buff: array of Byte);
var
  l: Integer;
  i: Integer;
begin
  l := Length(Buff);
  if l <= 292 then
    Exit;

  SetLength(FBuff, l);
  // CopyMemory(@Buff[0], @FBuff[0], l);
  for i := 0 to l do
    FBuff[i] := Buff[i];

  // ParserUpdate_KP();
end;

function TVDevice.Parser_Check_KP(): Boolean;
var
  i, l: Integer;
  pb: PByte;
  Pi: PInteger;
  s: String;
  ipIP: TIP;
begin
  // i:= MakeLong(MakeWord($CC,$DD),
  Result := false;
  l := Length(FBuff);
  if l < 292 then
    Exit;

  pb := @FBuff[0];
  Pi := @FBuff[0];
  if Pi^ = 1 then
  begin
    Self.Typee := 'Tx';
  end
  else if Pi^ = 2 then
  begin
    Self.Typee := 'Rx';
  end
  else
  begin
    Self.Typee := 'δ֪';
    Exit;
  end;
  pb := @FBuff[8];
  Self.St := ByteToWideString2(pb, 32);
  pb := @FBuff[40];
  Self.Name := Trim(ByteToWideString2(pb, 20));
  s := '';
  for i := 1 to Length(Self.Name) - 1 do
  begin
    if (Self.Name[i] >= ' ') and (Self.Name[i] <= '~') then
    begin
      s := s + Self.Name[i];
    end;
  end;
  Self.Name := s;
  for i := Length(Self.Name) - 1 downto 1 do
  begin
    if (Self.Name[i] >= '0') and (Self.Name[i] <= '9') then
    begin
      break;
    end;
  end;

  if i < (Length(Self.Name) - 1) then
    Self.Name := copy(Name, 1, i + 1);

  { for i := Length(Self.Name) - 1 downto 1 do
    begin
    if (Self.Name[i] < '0') and (Self.Name[i] > '9') then
    begin
    break;
    end;
    end; }

  Self.ID := RightStr(Self.Name, 4);
  s := '';
  for i := 1 to Length(Self.ID) do
  begin
    if (Self.ID[i] >= '0') and (Self.ID[i] <= '9') then
    begin
      s := s + Self.ID[i];
    end;
  end;
  Self.ID := s;

  // 修正设备名称
  i := pos(ID, name);
  Name := copy(Name, 1, i - 1);
  Name := Name + ID;

  pb := @FBuff[259];
  Self.TxaID := ByteToWideString2(pb, 5);

  pb := @FBuff[269];
  Self.TxvID := ByteToWideString2(pb, 5);

  pb := @FBuff[279];
  s := ByteToWideString2(pb, 13);
  Self.MAC := s; // '';
  { Self.MAC := Self.MAC + LeftStr(s, 2) + '-';
    Delete(s, 1, 2);
    Self.MAC := Self.MAC + LeftStr(s, 2) + '-';
    Delete(s, 1, 2);
    Self.MAC := Self.MAC + LeftStr(s, 2) + '-';
    Delete(s, 1, 2);
    Self.MAC := Self.MAC + LeftStr(s, 2) + '-';
    Delete(s, 1, 2);
    Self.MAC := Self.MAC + LeftStr(s, 2) + '-';
    Delete(s, 1, 2);
    Self.MAC := Self.MAC + LeftStr(s, 2); }

  ipIP := TIP.Create(IP);
  if (Typee = 'Tx') then
  begin
    MainRTSP := 'rtsp://' + ipIP.ip1 + '.' + ipIP.ip2 + '.' + IntToStr(StrToInt(ipIP.ip3) + 1) + '.' + ipIP.ip4 + ':8554/chn0';
    SubRTSP := 'rtsp://' + ipIP.ip1 + '.' + ipIP.ip2 + '.' + IntToStr(StrToInt(ipIP.ip3) + 1) + '.' + ipIP.ip4 + ':8554/chn1';
  end;
  SetLength(FBuff, 0);
  Result := True;
end;

end.

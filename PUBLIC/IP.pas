unit IP;

interface

uses

  Windows, SysUtils, Classes, Controls, Winsock,
  StdCtrls, System.Math;

type
  PIPOptionInformation = ^TIPOptionInformation;

  TIPOptionInformation = packed record
    TTL: Byte;
    TOS: Byte;
    Flags: Byte;
    OptionsSize: Byte;
    OptionsData: PChar;
  end;

  PIcmpEchoReply = ^TIcmpEchoReply;

  TIcmpEchoReply = packed record
    Address: DWORD;
    Status: DWORD;
    RTT: DWORD;
    DataSize: Word;
    Reserved: Word;
    Data: Pointer;
    Options: TIPOptionInformation;
  end;

  TIcmpCreateFile = function: THandle; stdcall;
  TIcmpCloseHandle = function(IcmpHandle: THandle): Boolean; stdcall;
  TIcmpSendEcho = function(IcmpHandle: THandle; DestinationAddress: DWORD; RequestData: Pointer; RequestSize: Word; RequestOptions: PIPOptionInformation; ReplyBuffer: Pointer; ReplySize: DWORD;
    Timeout: DWORD): DWORD; stdcall;

  Tping = class(Tobject)
  private
    { Private declarations }
    hICMP: THandle;
    IcmpCreateFile: TIcmpCreateFile;
    IcmpCloseHandle: TIcmpCloseHandle;
    IcmpSendEcho: TIcmpSendEcho;
  public
    procedure pinghost(IP: string; var info: string);
    constructor create;
    destructor destroy; override;
    { Public declarations }
  end;

function IsValidIP(astrIP: string): Boolean;
function CheckPing(DvrIP: string): integer;
function CheckTelnet(State_Ping: Byte; DvrIP: string; DvrPort: integer): integer;
function CheckIpPort(IP: string; Port: integer): Boolean;
function IPToInt64(IPStr: string): Int64;
function Int64ToIP(IPInt: Int64): string;
function IncIp(IPStr: string; IpCount: Int64): string;
function DecIp(IPStr: string; IpCount: Int64): string;
function CompIp(IPStr1, IPStr2: string): Int64;
function GetIPList(): TStringList;
function _GetComputerName: String;

var
  hICMPdll: HMODULE;
  LocalIPList: TStringList;

implementation

uses IdStackWindows, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient;
// =============================================================================================

function _GetComputerName: String;
var
  mPcName: array [0 .. 255] of char;
  nSize: Cardinal;
begin
  nSize := 256;
  FillChar(mPcName, sizeof(mPcName), 0);
  GetComputerName(mPcName, nSize);
  if StrPas(mPcName) = '' then
    Result := ''
  else
    Result := StrPas(mPcName);
end;

function GetIPList(): TStringList;
var
  Isw: TIdStackWindows;
  slist: TStringList;
begin
  Isw := TIdStackWindows.create;
  slist := TStringList.create;
  try
    Isw.AddLocalAddressesToList(slist); // 这个方法可以取出IP
  finally
    FreeAndNil(Isw);
    // FreeAndNil(slist);
  end;
  Result := slist;
end;

function IsValidIP(astrIP: string): Boolean;
var
  iCount: integer;
  iIPLength: integer;
  iFieldLength: integer;
  iFieldStart: integer;
  iDotCount: integer;
  strTemp: string;
begin
  iIPLength := Length(astrIP);
  if (iIPLength > 15) or (iIPLength < 7) then
  begin
    Result := False;
    Exit;
  end;

  iDotCount := 0;
  iFieldLength := 0;
  iFieldStart := 1;
  for iCount := 1 to iIPLength do
  begin
    case astrIP[iCount] of
      '0', '1', '2', '3', '4', '5', '6', '7', '8', '9':
        begin
          iFieldLength := iFieldLength + 1;
          if (3 < iFieldLength) then
          begin
            Result := False;
            Exit;
          end;
        end;
      '.':
        begin
          if 0 = iFieldLength then
          begin
            Result := False;
            Exit;
          end;
          strTemp := copy(astrIP, iFieldStart, iCount - iFieldStart);
          if (255 < StrToInt(strTemp)) then
          begin
            Result := False;
            Exit;
          end;
          iDotCount := iDotCount + 1;
          if 3 < iDotCount then
          begin
            Result := False;
            Exit;
          end;
          iFieldLength := 0;
          iFieldStart := iCount + 1;
        end;
    else
      begin
        Result := False;
        Exit;
      end;
    end;

    Result := True;
  end;
end;

function CheckPing(DvrIP: string): integer;
var
  NetPing: Tping;
  pinginfo: string;
  i, failCount: integer;
begin
  Result := -1;
  try
    try
      NetPing := Tping.create;
      if IsValidIP(DvrIP) then
      begin
        pinginfo := '';
        NetPing.pinghost(DvrIP, pinginfo);
        if pinginfo = 'FAIL' then
          Result := 1
        else
          Result := 0;
      end
      else
        Exit;
    except
      Result := -1;
    end
  finally
    NetPing.Free;
  end;
end;

function CheckTelnet(State_Ping: Byte; DvrIP: string; DvrPort: integer): integer;
var
  IdTCPClient: TIdTCPClient;
var
  t1: integer;
begin
  Result := -1;
  if DvrPort <= 0 then
    Exit;

  if State_Ping = 0 then
  begin
    try
      IdTCPClient := TIdTCPClient.create(nil);
      // IdTCPClient.ConnectTimeout:=100;
      try
        IdTCPClient.Disconnect;
        IdTCPClient.Host := DvrIP;
        IdTCPClient.Port := DvrPort;
        IdTCPClient.Connect();
        IdTCPClient.Disconnect;
        Result := 1;
      except
        Result := 0;
      end;
    finally
      IdTCPClient.CleanupInstance;
      IdTCPClient.Free;
    end;
  end
  else
    Result := 0;
end;

function CheckIpPort(IP: string; Port: integer): Boolean;
var
  res: integer;
begin
  Result := False;
  res := CheckTelnet(0, IP, Port);
  if res > 0 then
  begin
    Result := True;
  end;
end;

// =============================================================================================
function IPToInt64(IPStr: string): Int64;
var
  strList: TStringList;
  i: integer;
begin
  strList := TStringList.create;
  strList.Delimiter := '.';
  strList.DelimitedText := IPStr;
  Result := 0;
  for i := 0 to strList.Count - 1 do
  begin
    Result := Result + StrToInt(strList.Strings[i]) * Trunc(Power(256, strList.Count - 1 - i));
  end;
  strList.Free;
end;

function Int64ToIP(IPInt: Int64): string;
var
  IP1, Ip2, IP3, IP4: Int64;
begin
  IP1 := IPInt div Trunc(Power(256, 3));
  Ip2 := (IPInt - IP1 * Trunc(Power(256, 3))) div Trunc(Power(256, 2));
  IP3 := (IPInt - IP1 * Trunc(Power(256, 3)) - Ip2 * Trunc(Power(256, 2))) div Trunc(Power(256, 1));
  IP4 := IPInt - IP1 * Trunc(Power(256, 3)) - Ip2 * Trunc(Power(256, 2)) - IP3 * Trunc(Power(256, 1));
  Result := IntToStr(IP1) + '.' + IntToStr(Ip2) + '.' + IntToStr(IP3) + '.' + IntToStr(IP4);
end;

function IncIp(IPStr: string; IpCount: Int64): string;
begin
  Result := Int64ToIP(IPToInt64(IPStr) + IpCount);
end;

function DecIp(IPStr: string; IpCount: Int64): string;
begin
  Result := Int64ToIP(IPToInt64(IPStr) - IpCount);
end;

function CompIp(IPStr1, IPStr2: string): Int64;
begin
  Result := IPToInt64(IPStr1) - IPToInt64(IPStr2);
end;

constructor Tping.create;
begin
  inherited create;
  hICMPdll := LoadLibrary('icmp.dll');
  @IcmpCreateFile := GetProcAddress(hICMPdll, 'IcmpCreateFile');
  @IcmpCloseHandle := GetProcAddress(hICMPdll, 'IcmpCloseHandle');
  @IcmpSendEcho := GetProcAddress(hICMPdll, 'IcmpSendEcho');
  hICMP := IcmpCreateFile;
end;

destructor Tping.destroy;
begin
  FreeLibrary(hICMPdll);
  inherited destroy;
end;

procedure Tping.pinghost(IP: string; var info: string);
var
  // IP Options for packet to send
  IPOpt: TIPOptionInformation;
  FIPAddress: DWORD;
  pReqData, pRevData: PChar;
  // ICMP Echo reply buffer
  pIPE: PIcmpEchoReply;
  FSize: DWORD;
  MyString: string;
  FTimeOut: DWORD;
  BufferSize: DWORD;
begin

  if IP <> '' then
  begin
    FIPAddress := inet_addr(PAnsiChar(IP));
    FSize := 400;
    BufferSize := sizeof(TIcmpEchoReply) + FSize;
    GetMem(pRevData, FSize);
    GetMem(pIPE, BufferSize);
    FillChar(pIPE^, sizeof(pIPE^), 0);
    pIPE^.Data := pRevData;
    MyString := 'Test Net - Sos Admin';
    pReqData := PChar(MyString);
    FillChar(IPOpt, sizeof(IPOpt), 0);
    IPOpt.TTL := 64;
    FTimeOut := 1000;
    try
      IcmpSendEcho(hICMP, FIPAddress, pReqData, Length(MyString), @IPOpt, pIPE, BufferSize, FTimeOut);
      if pReqData^ = pIPE^.Options.OptionsData^ then
        info := 'Reply from ' + IP + ': bytes=' + IntToStr(pIPE^.DataSize) + ' time<' + IntToStr(pIPE^.RTT) + 'ms TTL=' + IntToStr(pIPE^.Options.TTL);
    except
      info := 'FAIL';
      FreeMem(pRevData);
      FreeMem(pIPE);
      Exit;
    end;
    FreeMem(pRevData);
    FreeMem(pIPE);
  end;
end;

end.

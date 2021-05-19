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
    Typee: String;
    St: String;
    TxaID: String;
    TxvID: String;
    User: String;
    Password: String;
    MainRTSP: String;
    SubRTSP: String;

  private
    FBuff: array of Byte;
  protected
  public
    constructor Create(Name: String; ID: String; IP: String; MAC: String;
      Port: String; Typee: String); Overload;
    constructor Create(Buff: array of Byte); Overload;
    constructor Create(); Overload;
    destructor Destroy;

    procedure SetBuffer(Buff: array of Byte);
    procedure ParserUpdate_KP();
  end;

implementation

uses StrUtils, Unit200;
{ TVDevice }

constructor TVDevice.Create(Name: String; ID: String; IP: String; MAC: String;
  Port: String; Typee: String);
begin
  Self.Name := Name;
  Self.ID := ID;
  Self.IP := IP;
  Self.MAC := MAC;
  Self.Port := Port;
  Self.Typee := Typee;
end;

constructor TVDevice.Create(Buff: array of Byte);
begin
  SetBuffer(Buff);
end;

constructor TVDevice.Create();
begin

end;

destructor TVDevice.Destroy;
begin
  SetLength(FBuff, 0);
end;

procedure TVDevice.SetBuffer(Buff: array of Byte);
var
  l: Integer;
  i:Integer;
begin
  l := Length(Buff);
  if l <= 0 then
    Exit;

  SetLength(FBuff, l);
  //CopyMemory(@Buff[0], @FBuff[0], l);
  for I := 0 to l do
   FBuff[i]:=buff[i];
  ParserUpdate_KP();
end;

procedure TVDevice.ParserUpdate_KP;
var
  i, l: Integer;
  pb: PByte;
  Pi: PInteger;
  s:String;
begin
  // i:= MakeLong(MakeWord($CC,$DD),
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
  end;
  pb := @FBuff[8];
  Self.St := ByteToWideString2(pb, 32);
  pb := @FBuff[40];
  Self.Name := ByteToWideString2(pb, 20);
  s:='';
  for I := 1 to  Length(Self.Name)-1 do
  begin
     if (Self.Name[i] >=' ') and (Self.Name[i] <= '~') then
     begin
        s := s+Self.Name[i];
     end;
  end;
  Self.Name :=s;
  Self.ID := RightStr(Self.Name, 4);
  s:='';
  for I := 1 to  Length(Self.ID) do
  begin
     if (Self.ID[i] >='0') and (Self.ID[i] <= '9') then
     begin
        s := s+Self.ID[i];
     end;
  end;
  Self.ID:= s;

  pb := @FBuff[259];
  Self.TxaID := ByteToWideString2(pb, 5);
  pb := @FBuff[269];
  Self.TxaID := ByteToWideString2(pb, 5);
  pb := @FBuff[279];
  s := ByteToWideString2(pb, 13);
  Self.MAC:='';
  Self.MAC:=Self.MAC +  LeftStr(s, 2) + '-';
  Delete(s,1,2);
  Self.MAC:=Self.MAC +  LeftStr(s, 2) + '-';
  Delete(s,1,2);
  Self.MAC:=Self.MAC +  LeftStr(s, 2) + '-';
  Delete(s,1,2);
  Self.MAC:=Self.MAC +  LeftStr(s, 2) + '-';
  Delete(s,1,2);
  Self.MAC:=Self.MAC +  LeftStr(s, 2) + '-';
  Delete(s,1,2);
  Self.MAC:=Self.MAC +  LeftStr(s, 2);

end;

end.

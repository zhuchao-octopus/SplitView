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
    ID:String;
    IP: String;
    MAC: String;
    Port: String;
    Typee: String;
    User: String;
    Password: String;
    MainRTSP: String;
    SubRTSP: String;

  private
  protected
  public
    constructor Create(Name: String;
    ID:String;
    IP: String;
    MAC: String;
    Port: String;
    Typee: String);
    destructor Destroy;
  end;

implementation

{ TVDevice }

constructor TVDevice.Create(Name: String;
    ID:String;
    IP: String;
    MAC: String;
    Port: String;
    Typee: String);
begin
  Self.Name:=Name;
  Self.ID:=ID;
  Self.IP:=IP;
  Self.MAC:=MAC;
  Self.Port:=Port;
  Self.Typee:=Typee;
end;

destructor TVDevice.Destroy;
begin

end;

end.

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
    constructor Create();
    destructor Destroy;
  end;

implementation

{ TVDevice }

constructor TVDevice.Create;
begin

end;

destructor TVDevice.Destroy;
begin

end;

end.

unit VPlace;

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
  TVPlace = Class
  private
  protected
  public
    constructor Create();
    destructor Destroy;
  end;
implementation

{ TVPlace }

constructor TVPlace.Create;
begin

end;

destructor TVPlace.Destroy;
begin

end;

end.

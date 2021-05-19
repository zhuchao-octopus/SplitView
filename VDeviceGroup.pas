unit VDeviceGroup;

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
  TVDeviceGroup = Class
  Gname:String;
  Devices:TStringList;
  private
  protected
  public
    constructor Create(name:string);
    destructor Destroy;
  end;

implementation

{ TVDeviceGroup }

constructor TVDeviceGroup.Create(name:string);
begin
   Devices:=TStringList.Create;
   Devices.OwnsObjects:=true;
   Gname:=name;
end;

destructor TVDeviceGroup.Destroy;
begin
   Devices.Free;
   Devices.Clear;
   Devices.Free
end;


end.

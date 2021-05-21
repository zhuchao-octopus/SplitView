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
  Classes, SysUtils, Controls, ExtCtrls, Graphics, VDevice;

type
  TVDeviceGroup = Class
    Gname: String;
    Tag:Integer;
    DevicesTx: TStringList;
    DevicesRx: TStringList;
    FBuff: array of Byte;
  private
  protected
  public
    constructor Create(name: string;tag:Integer);
    destructor Destroy;
    procedure Add(Dname: String; Dv: TVDevice);
    procedure Clear();
    procedure ParserUpdate_KP();
  end;

var
  DeviceList: TVDeviceGroup;

implementation

{ TVDeviceGroup }

constructor TVDeviceGroup.Create(name: string;tag:Integer);
begin
  DevicesTx := TStringList.Create;
  DevicesTx.OwnsObjects := true;
  DevicesRx := TStringList.Create;
  DevicesRx.OwnsObjects := true;
  Gname := name;
  Tag:=tag;
end;

destructor TVDeviceGroup.Destroy;
begin
  DevicesTx.Free;
  DevicesRx.Free
end;

procedure TVDeviceGroup.Add(Dname: string; Dv: TVDevice);
var
  index: Integer;
begin
  if Dv.Typee = 'Tx' then
  begin
    index := DevicesTx.IndexOf(Dname);
    if index >= 0 then
    begin
      DevicesTx.BeginUpdate;
      DevicesTx.Delete(index);
      DevicesTx.EndUpdate;
    end;
    DevicesTx.AddObject(Dname, Dv);
  end
  else if Dv.Typee = 'Rx' then
  begin
    index := DevicesRx.IndexOf(Dname);
    if index >= 0 then // 烧掉原有的
    begin
      DevicesRx.BeginUpdate;
      DevicesRx.Delete(index);
      DevicesRx.EndUpdate;
    end;
    DevicesRx.AddObject(Dname, Dv);
  end;
end;

procedure TVDeviceGroup.Clear();
begin
  DevicesRx.Clear;
  DevicesTx.Clear;
end;

procedure TVDeviceGroup.ParserUpdate_KP();
begin

end;

initialization

DeviceList := TVDeviceGroup.Create('',24);

finalization

DeviceList.Free;

end.

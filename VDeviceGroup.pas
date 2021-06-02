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
    Tag: Integer;
    DevicesTx: TStringList;
    DevicesRx: TStringList;
    FBuff: array of Byte;
  private
  protected
  public
    constructor Create(name: string; Tag: Integer);
    destructor Destroy;
    procedure Add(Dname: String; Dv: TVDevice);
    function get(Dname: String): TVDevice; overload;
    function get(id: Integer): TVDevice; overload;
    function GetTx(Id:Integer): TVDevice;
    procedure Clear();
    procedure ParserUpdate_KP();
  end;

var
  DeviceList: TVDeviceGroup;

implementation

{ TVDeviceGroup }

constructor TVDeviceGroup.Create(name: string; Tag: Integer);
begin
  DevicesTx := TStringList.Create;
  DevicesTx.OwnsObjects := true;
  DevicesRx := TStringList.Create;
  DevicesRx.OwnsObjects := true;
  Gname := name;
  Tag := Tag;
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
    if index >= 0 then // 已存在
    begin
      Exit;
      DevicesTx.BeginUpdate;
      DevicesTx.Delete(index);
      DevicesTx.EndUpdate;
    end;
    DevicesTx.AddObject(Dname, Dv);
  end
  else if Dv.Typee = 'Rx' then
  begin
    index := DevicesRx.IndexOf(Dname);
    if index >= 0 then // 已存在 烧掉原有的
    begin
      Exit;
      DevicesRx.BeginUpdate;
      DevicesRx.Delete(index);
      DevicesRx.EndUpdate;
    end;
    DevicesRx.AddObject(Dname, Dv);
  end;
end;

function TVDeviceGroup.get(Dname: string): TVDevice;
var
  i, index: Integer;
begin
  Result := nil;
  for i := 0 to DevicesRx.Count - 1 do
  begin
    index := DevicesRx.IndexOf(Dname);
    if index >= 0 then
    begin
      Result := TVDevice(DevicesRx.Objects[index]);
      break;
    end;
  end;
  if Result <> nil then
    Exit;
  for i := 0 to DevicesTx.Count - 1 do
  begin
    index := DevicesTx.IndexOf(Dname);
    if index >= 0 then
    begin
      Result := TVDevice(DevicesTx.Objects[index]);
      break;
    end;
  end;
end;

function TVDeviceGroup.get(id: Integer): TVDevice;
var
  i, index: Integer;
begin
  Result := nil;

  for i := 0 to DevicesTx.Count - 1 do
  begin
    Result := TVDevice(DevicesTx.Objects[i]);
    if Result.id = IntToStr(id) then
    begin

      break;
    end;
  end;

  if Result <> nil then
    Exit;

  for i := 0 to DevicesRx.Count - 1 do
  begin
    Result := TVDevice(DevicesRx.Objects[i]);
    if Result.id = IntToStr(id) then
    begin
      break;
    end;
  end;

end;

function TVDeviceGroup.GetTx(Id: Integer): TVDevice;
var
  i, index: Integer;
begin
  Result := nil;

  for i := 0 to DevicesTx.Count - 1 do
  begin
    Result := TVDevice(DevicesTx.Objects[i]);
    if Result.id = IntToStr(id) then
    begin
      break;
    end;
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

DeviceList := TVDeviceGroup.Create('', 24);

finalization

DeviceList.Free;

end.

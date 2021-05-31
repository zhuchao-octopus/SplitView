program SplitView;

uses
  Vcl.Forms,
  uSplitView in 'uSplitView.pas' {SplitViewForm},
  VDevice in 'VDevice.pas',
  VDeviceGroup in 'VDeviceGroup.pas',
  VPlace in 'VPlace.pas',
  VPlaceGroup in 'VPlaceGroup.pas',
  VScreen in 'VScreen.pas',
  VScreenGroup in 'VScreenGroup.pas',
  VUser in 'VUser.pas',
  VUserGroup in 'VUserGroup.pas',
  GlobalConst in 'PUBLIC\GlobalConst.pas',
  GlobalFunctions in 'PUBLIC\GlobalFunctions.pas',
  GlobalTypes in 'PUBLIC\GlobalTypes.pas',
  MyMessageQueue in 'PUBLIC\MyMessageQueue.pas',
  IP in 'PUBLIC\IP.pas',
  ueIPEdit in 'PUBLIC\ueIPEdit.pas',
  Unit200 in 'PUBLIC\Unit200.pas',
  ClientObject in 'PUBLIC\ClientObject.pas',
  Trash in 'PUBLIC\Trash.pas',
  Setting in 'Setting.pas' {frmSetting},
  Vcl.Themes,
  Vcl.Styles,
  DataEngine in 'Engine\DataEngine.pas';

{$R *.res}
begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  Application.CreateForm(TSplitViewForm, SplitViewForm);
  Application.CreateForm(TfrmSetting, frmSetting);
  Application.Run;
end.

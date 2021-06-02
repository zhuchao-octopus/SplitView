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
  DataEngine in 'Engine\DataEngine.pas',
  GSetting in 'GSetting.pas' {GSettingfrm},
  PasLibVlcClassUnit in 'LibVLC\PasLibVlcClassUnit.pas',
  PasLibVlcPlayerUnit in 'LibVLC\PasLibVlcPlayerUnit.pas',
  PasLibVlcUnit in 'LibVLC\PasLibVlcUnit.pas',
  SelectOutputDeviceFormUnit in 'LibVLC\SelectOutputDeviceFormUnit.pas' {SelectOutputDeviceForm},
  SetEqualizerPresetFormUnit in 'LibVLC\SetEqualizerPresetFormUnit.pas' {SetEqualizerPresetForm},
  VideoAdjustFormUnit in 'LibVLC\VideoAdjustFormUnit.pas' {VideoAdjustForm};

{$R *.res}
begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  TStyleManager.TrySetStyle('Windows10');
  Application.CreateForm(TSplitViewForm, SplitViewForm);
  Application.CreateForm(TfrmSetting, frmSetting);
  Application.CreateForm(TGSettingfrm, GSettingfrm);
  Application.CreateForm(TSelectOutputDeviceForm, SelectOutputDeviceForm);
  Application.CreateForm(TSetEqualizerPresetForm, SetEqualizerPresetForm);
  Application.CreateForm(TVideoAdjustForm, VideoAdjustForm);
  Application.Run;
end.

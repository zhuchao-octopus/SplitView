//---------------------------------------------------------------------------

// This software is Copyright (c) 2015 Embarcadero Technologies, Inc.
// You may only use this software if you are an authorized licensee
// of an Embarcadero developer tools product.
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------

program SplitView;

uses
  Vcl.Forms,
  uSplitView in 'uSplitView.pas' {SplitViewForm},
  Vcl.Themes,
  Vcl.Styles,
  GlobalConst in 'PUBLIC\GlobalConst.pas',
  GlobalFunctions in 'PUBLIC\GlobalFunctions.pas',
  GlobalTypes in 'PUBLIC\GlobalTypes.pas',
  MyMessageQueue in 'PUBLIC\MyMessageQueue.pas',
  Ping in 'PUBLIC\Ping.pas',
  User in 'PUBLIC\User.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'TSplitView Demo';
  Application.CreateForm(TSplitViewForm, SplitViewForm);
  Application.Run;
end.

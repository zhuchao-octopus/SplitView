unit Setting;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, VDevice,
  ClientObject, ip, Vcl.Samples.Spin, Vcl.Grids, VDeviceGroup, Vcl.ExtCtrls,
  PasLibVlcPlayerUnit, Vcl.Imaging.pngimage;

type
  TfrmSetting = class(TForm)
    PageControl1: TPageControl;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet8: TTabSheet;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    GroupBox2: TGroupBox;
    Button2: TButton;
    Button3: TButton;
    ListView1: TListView;
    ListView2: TListView;
    ListView3: TListView;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    ListView4: TListView;
    ListView5: TListView;
    ListView6: TListView;
    Button8: TButton;
    Button9: TButton;
    ListView7: TListView;
    ListView8: TListView;
    ListView9: TListView;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    GroupBox5: TGroupBox;
    StringGrid1: TStringGrid;
    Button19: TButton;
    Label12: TLabel;
    Edit6: TEdit;
    Button18: TButton;
    TabSheet1: TTabSheet;
    PasLibVlcPlayer1: TPasLibVlcPlayer;
    PR: TPanel;
    PlayBtn: TButton;
    PauseBtn: TButton;
    GetWidthBtn: TButton;
    GetHeightBtn: TButton;
    GetStateBtn: TButton;
    ResumeBtn: TButton;
    GetPosLenBtn: TButton;
    Scale10Btn: TButton;
    ScaleFitBtn: TButton;
    SnapShotBtn: TButton;
    NextFrameBtn: TButton;
    GetASpectRatioBtn: TButton;
    SetAsp11Btn: TButton;
    SetAsp43Btn: TButton;
    GetVolume: TButton;
    SetVolumeUp10: TButton;
    SetVolumeDo10: TButton;
    GetPlayRateBtn: TButton;
    SetPlayRate2xBtn: TButton;
    SetPlayRateHalfBtn: TButton;
    FullScreenYesBtn: TButton;
    DeInterlaceBtn: TButton;
    GetAudioChannel: TButton;
    SetAudioChannelLeft: TButton;
    SetAudioChannelRight: TButton;
    SetAudioChannelStereo: TButton;
    GetAudioOutListBtn: TButton;
    GetAudioOutDevEnumBtn: TButton;
    GetEqPreListBtn: TButton;
    SetEqualizerBtn: TButton;
    ChAudioOut: TButton;
    GetAudioTrackList: TButton;
    VideoAdjustBtn: TButton;
    Edit7: TEdit;
    Panel1: TPanel;
    Image1: TImage;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
    procedure Edit4KeyPress(Sender: TObject; var Key: Char);
    procedure Edit5KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ListView1DblClick(Sender: TObject);
    procedure ListView2DblClick(Sender: TObject);
    procedure ListView3DblClick(Sender: TObject);
    procedure ListView4DblClick(Sender: TObject);
    procedure ListView5DblClick(Sender: TObject);
    procedure ListView6DblClick(Sender: TObject);
    procedure ListView7DblClick(Sender: TObject);
    procedure ListView8DblClick(Sender: TObject);
    procedure ListView9DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button10Click(Sender: TObject);
    procedure TabSheet2Show(Sender: TObject);
    procedure TabSheet3Show(Sender: TObject);
    procedure TabSheet4Show(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button19Click(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure StringGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure PlayBtnClick(Sender: TObject);
    procedure PauseBtnClick(Sender: TObject);
    procedure ResumeBtnClick(Sender: TObject);
    procedure GetWidthBtnClick(Sender: TObject);
    procedure GetHeightBtnClick(Sender: TObject);
    procedure GetStateBtnClick(Sender: TObject);
    procedure GetPosLenBtnClick(Sender: TObject);
    procedure Scale10BtnClick(Sender: TObject);
    procedure ScaleFitBtnClick(Sender: TObject);
    procedure SnapShotBtnClick(Sender: TObject);
    procedure NextFrameBtnClick(Sender: TObject);
    procedure DeInterlaceBtnClick(Sender: TObject);
    procedure GetAudioOutListBtnClick(Sender: TObject);
    procedure GetAudioOutDevEnumBtnClick(Sender: TObject);
    procedure ChAudioOutClick(Sender: TObject);
    procedure GetAudioTrackListClick(Sender: TObject);
    procedure VideoAdjustBtnClick(Sender: TObject);
    procedure GetASpectRatioBtnClick(Sender: TObject);
    procedure SetAsp11BtnClick(Sender: TObject);
    procedure SetAsp43BtnClick(Sender: TObject);
    procedure GetVolumeClick(Sender: TObject);
    procedure SetVolumeUp10Click(Sender: TObject);
    procedure SetVolumeDo10Click(Sender: TObject);
    procedure GetPlayRateBtnClick(Sender: TObject);
    procedure SetPlayRate2xBtnClick(Sender: TObject);
    procedure SetPlayRateHalfBtnClick(Sender: TObject);
    procedure GetAudioChannelClick(Sender: TObject);
    procedure SetAudioChannelLeftClick(Sender: TObject);
    procedure SetAudioChannelRightClick(Sender: TObject);
    procedure SetAudioChannelStereoClick(Sender: TObject);
    procedure SetEqualizerBtnClick(Sender: TObject);
    procedure GetEqPreListBtnClick(Sender: TObject);
    procedure PasLibVlcPlayer1MediaPlayerEncounteredError(Sender: TObject);
    procedure PasLibVlcPlayer1MediaPlayerPlaying(Sender: TObject);
    procedure PasLibVlcPlayer1MediaPlayerStopped(Sender: TObject);
  private
    // FStr:String;
    { Private declarations }
    procedure TCPReadData(const data: String; id: Integer);
    procedure UpdateRxZx(ListView: TListView; b: Byte; ZXId: Integer);
    procedure UpdateTxZx(ListView: TListView; b: Byte; ZXId: Integer);
    function GetZX(ListView: TListView; var buf: array of Byte; offset: Integer): Integer;
    procedure SaveToFile(ListView: TListView; fileName: String);
    procedure LoadTXNameFromFile(ListView: TListView; fileName: String);
    procedure play(str: String);
    procedure play2();
  public
    { Public declarations }
    dv: TVDevice;
    tcp, udp: TClientObject;
    ipIP: TIP;
    TxName: TStringList;
    RxName: TStringList;

  end;

var
  frmSetting: TfrmSetting;

implementation

uses DataEngine, GlobalFunctions, Unit200, PasLibVlcUnit, SetEqualizerPresetFormUnit, SelectOutputDeviceFormUnit, PasLibVlcClassUnit, VideoAdjustFormUnit;
{$R *.dfm}

procedure TfrmSetting.SaveToFile(ListView: TListView; fileName: string);
var
  lList: TStrings;
  i: Integer;
begin
  lList := TStringList.Create;
  try
    for i := 0 to ListView.Items.Count - 1 do
      lList.add(ListView.Items[i].subitems.strings[0]);
    lList.SaveToFile(fileName);
  finally
    lList.Free;
  end;
end;

procedure TfrmSetting.Scale10BtnClick(Sender: TObject);
var
  sc: Single;
begin
  sc := PasLibVlcPlayer1.GetVideoScaleInPercent;
  if (sc < 1) then
    sc := 100;
  sc := sc - 10;
  if PasLibVlcPlayer1.IsPlay() then
    PasLibVlcPlayer1.SetVideoScaleInPercent(sc);

end;

procedure TfrmSetting.ScaleFitBtnClick(Sender: TObject);
begin
  if PasLibVlcPlayer1.IsPlay() then
    PasLibVlcPlayer1.SetVideoScaleInPercent(0);
end;

procedure TfrmSetting.SetAsp11BtnClick(Sender: TObject);
begin
  PasLibVlcPlayer1.SetVideoAspectRatio('1:1');
end;

procedure TfrmSetting.SetAsp43BtnClick(Sender: TObject);
begin
  PasLibVlcPlayer1.SetVideoAspectRatio('4:3');
end;

procedure TfrmSetting.SetAudioChannelLeftClick(Sender: TObject);
begin
  PasLibVlcPlayer1.SetAudioChannel(libvlc_AudioChannel_Left);
end;

procedure TfrmSetting.SetAudioChannelRightClick(Sender: TObject);
begin
  PasLibVlcPlayer1.SetAudioChannel(libvlc_AudioChannel_Right);
end;

procedure TfrmSetting.SetAudioChannelStereoClick(Sender: TObject);
begin
  PasLibVlcPlayer1.SetAudioChannel(libvlc_AudioChannel_Stereo);
end;

procedure TfrmSetting.SetEqualizerBtnClick(Sender: TObject);
var
  eqf: TSetEqualizerPresetForm;
  prl: TStringList;
begin
  prl := PasLibVlcPlayer1.EqualizerGetPresetList();
  eqf := TSetEqualizerPresetForm.Create(SELF);
  eqf.FVLC := PasLibVlcPlayer1.VLC;
  eqf.PresetListLB.Items.AddStrings(prl);
  if eqf.ShowModal = mrOK then
  begin
    if (eqf.PresetListLB.ItemIndex > -1) then
    begin
      PasLibVlcPlayer1.EqualizerSetPreset(Word(prl.Objects[eqf.PresetListLB.ItemIndex]));
    end;
  end;
  eqf.Free;
  prl.Free;

end;

procedure TfrmSetting.SetPlayRate2xBtnClick(Sender: TObject);
var
  newPlayRate: Integer;
begin
  newPlayRate := PasLibVlcPlayer1.GetPlayRate() * 2;
  if (newPlayRate > 400) then
    exit;
  PasLibVlcPlayer1.SetPlayRate(newPlayRate);
end;

procedure TfrmSetting.SetPlayRateHalfBtnClick(Sender: TObject);
var
  newPlayRate: Integer;
begin
  newPlayRate := PasLibVlcPlayer1.GetPlayRate() div 2;
  if (newPlayRate < 25) then
    exit;
  PasLibVlcPlayer1.SetPlayRate(newPlayRate);

end;

procedure TfrmSetting.SetVolumeDo10Click(Sender: TObject);
begin
  PasLibVlcPlayer1.SetAudioVolume(PasLibVlcPlayer1.GetAudioVolume() - 10);
end;

procedure TfrmSetting.SetVolumeUp10Click(Sender: TObject);
begin
  PasLibVlcPlayer1.SetAudioVolume(PasLibVlcPlayer1.GetAudioVolume() + 10);
end;

procedure TfrmSetting.SnapShotBtnClick(Sender: TObject);
begin
  PasLibVlcPlayer1.SnapShot(ChangeFileExt(Application.ExeName, '.png'));
end;

procedure TfrmSetting.StringGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  If not(Key in ['0' .. '9', #8]) then
  Begin
    Key := #0; // #0 表示没有输入
  End;
end;

procedure TfrmSetting.ListView1DblClick(Sender: TObject);
var
  ListItem: TListItem;
  Name: String;
  str: String;
begin
  ListItem := ListView1.Selected;
  if ListItem = nil then
    exit;
  Name := inputbox('设备名称修改', '请输入名称：', '主机');

  if Length(name) > 12 then
  begin
    Showmessage('名字过长，最好不要超过6个汉字的长度！！！');
    exit;
  end;
  ListItem.subitems.strings[0] := Name;

  str := 'astparam s txn1 ' + Name;
  str := str + ';astparam save';
  tcp.SetCallBack(TCPReadData);
  tcp.SetWork(str, 800);
end;

procedure TfrmSetting.ListView2DblClick(Sender: TObject);
var
  ListItem: TListItem;
  Name: String;
  str: String;
begin
  ListItem := ListView2.Selected;
  if ListItem = nil then
    exit;
  Name := inputbox('设备名称修改', '请输入名称：', '主机');

  if Length(name) > 12 then
  begin
    Showmessage('名字过长，最好不要超过6个汉字的长度！！！');
    exit;
  end;
  ListItem.subitems.strings[0] := Name;

  str := 'astparam s txn1 ' + Name;
  str := str + ';astparam save';
  tcp.SetCallBack(TCPReadData);
  tcp.SetWork(str, 800);
end;

procedure TfrmSetting.ListView3DblClick(Sender: TObject);
var
  ListItem: TListItem;
  Name: String;
  str: String;
begin
  ListItem := ListView3.Selected;
  if ListItem = nil then
    exit;
  Name := inputbox('设备名称修改', '请输入名称：', '主机');

  if Length(name) > 12 then
  begin
    Showmessage('名字过长，最好不要超过6个汉字的长度！！！');
    exit;
  end;
  ListItem.subitems.strings[0] := Name;

  str := 'astparam s txn1 ' + Name;
  str := str + ';astparam save';
  tcp.SetCallBack(TCPReadData);
  tcp.SetWork(str, 800);

end;

procedure TfrmSetting.ListView4DblClick(Sender: TObject);
var
  ListItem: TListItem;
  Name: String;
  str: String;
begin
  ListItem := ListView4.Selected;
  if ListItem = nil then
    exit;
  Name := inputbox('设备名称修改', '请输入名称：', '主机');

  if Length(name) > 12 then
  begin
    Showmessage('名字过长，最好不要超过6个汉字的长度！！！');
    exit;
  end;
  ListItem.subitems.strings[0] := Name;

  str := 'astparam s rxn1 ' + Name;
  str := str + ';astparam save';
  tcp.SetCallBack(TCPReadData);
  tcp.SetWork(str, 800);

end;

procedure TfrmSetting.ListView5DblClick(Sender: TObject);
var
  ListItem: TListItem;
  Name: String;
  str: String;
begin
  ListItem := ListView5.Selected;
  if ListItem = nil then
    exit;
  Name := inputbox('设备名称修改', '请输入名称：', '主机');

  if Length(name) > 12 then
  begin
    Showmessage('名字过长，最好不要超过6个汉字的长度！！！');
    exit;
  end;
  ListItem.subitems.strings[0] := Name;

  str := 'astparam s rxn1 ' + Name;
  str := str + ';astparam save';
  tcp.SetCallBack(TCPReadData);
  tcp.SetWork(str, 800);
end;

procedure TfrmSetting.ListView6DblClick(Sender: TObject);
var
  ListItem: TListItem;
  Name: String;
  str: String;
begin
  ListItem := ListView6.Selected;
  if ListItem = nil then
    exit;
  Name := inputbox('设备名称修改', '请输入名称：', '主机');

  if Length(name) > 12 then
  begin
    Showmessage('名字过长，最好不要超过6个汉字的长度！！！');
    exit;
  end;
  ListItem.subitems.strings[0] := Name;

  str := 'astparam s rxn1 ' + Name;
  str := str + ';astparam save';
  tcp.SetCallBack(TCPReadData);
  tcp.SetWork(str, 800);
end;

procedure TfrmSetting.ListView7DblClick(Sender: TObject);
var
  ListItem: TListItem;
  Name: String;
  str: String;
begin
  ListItem := ListView7.Selected;
  if ListItem = nil then
    exit;
  Name := inputbox('设备名称修改', '请输入名称：', '主机');

  if Length(name) > 12 then
  begin
    Showmessage('名字过长，最好不要超过6个汉字的长度！！！');
    exit;
  end;
  ListItem.subitems.strings[0] := Name;

  str := 'astparam s rxn1 ' + Name;
  str := str + ';astparam save';
  tcp.SetCallBack(TCPReadData);
  tcp.SetWork(str, 800);

end;

procedure TfrmSetting.ListView8DblClick(Sender: TObject);
var
  ListItem: TListItem;
  Name: String;
  str: String;
begin
  ListItem := ListView8.Selected;
  if ListItem = nil then
    exit;
  Name := inputbox('设备名称修改', '请输入名称：', '主机');

  if Length(name) > 12 then
  begin
    Showmessage('名字过长，最好不要超过6个汉字的长度！！！');
    exit;
  end;

  ListItem.subitems.strings[0] := Name;

  str := 'astparam s rxn1 ' + Name;
  str := str + ';astparam save';
  tcp.SetCallBack(TCPReadData);
  tcp.SetWork(str, 800);

end;

procedure TfrmSetting.ListView9DblClick(Sender: TObject);
var
  ListItem: TListItem;
  Name: String;
  str: String;
begin
  ListItem := ListView9.Selected;
  if ListItem = nil then
    exit;
  Name := inputbox('设备名称修改', '请输入名称：', '主机');

  if Length(name) > 12 then
  begin
    Showmessage('名字过长，最好不要超过6个汉字的长度！！！');
    exit;
  end;

  ListItem.subitems.strings[0] := Name;

  str := 'astparam s rxn1 ' + Name;
  str := str + ';astparam save';
  tcp.SetCallBack(TCPReadData);
  tcp.SetWork(str, 800);

end;

procedure TfrmSetting.LoadTXNameFromFile(ListView: TListView; fileName: string);
begin
  // if fileName = '' then
  // fileName:=  ExtractFilePath(Application.Exename) + '\'+'txName.dat';

end;

procedure TfrmSetting.NextFrameBtnClick(Sender: TObject);
begin
  PasLibVlcPlayer1.NextFrame();
end;

procedure TfrmSetting.PasLibVlcPlayer1MediaPlayerEncounteredError(Sender: TObject);
begin
  //if FileExists('logo.png') then
  //  play('logo.png');
  Panel1.Visible:=true;
end;

procedure TfrmSetting.PasLibVlcPlayer1MediaPlayerPlaying(Sender: TObject);
begin
  PlayBtn.Enabled := true;
  Panel1.Visible := false;
end;

procedure TfrmSetting.PasLibVlcPlayer1MediaPlayerStopped(Sender: TObject);
begin
Panel1.Visible:=true;
end;

procedure TfrmSetting.PauseBtnClick(Sender: TObject);
begin
  PasLibVlcPlayer1.Pause();
end;

procedure TfrmSetting.play2();
begin
  PlayBtnClick(nil);
end;

procedure TfrmSetting.play(str: string);
begin
  // PasLibVlcPlayer1.Play(TFileStream.Create(MrlEdit.Text, fmOpenRead), [libvlc_media_record_str('c:\Users\robert\Desktop\stream.mp4', '', '', 0, 0, 0, '', 0, 0, 0, TRUE)]);

  PasLibVlcPlayer1.play(str);
  // PasLibVlcPlayer1.MarqueeShowText('marquee test %H:%M:%S');
  edit7.Text:=str;
end;

procedure TfrmSetting.PlayBtnClick(Sender: TObject);
var
  // appl_path: string;
  // logo_path: string;
  logo_file_1: string;
  logo_file_2: string;
  s:String;
begin
  // PasLibVlcPlayer1.Play(TFileStream.Create(MrlEdit.Text, fmOpenRead), [libvlc_media_record_str('c:\Users\robert\Desktop\stream.mp4', '', '', 0, 0, 0, '', 0, 0, 0, TRUE)]);
  if dv.MainRTSP = '' then
    exit;

  //  s:= PasLibVlcPlayer1.GetMediaMrl;

  if (PasLibVlcPlayer1.IsPlay) then
    exit;

  PlayBtn.Enabled := false;
  PasLibVlcPlayer1.play(dv.SubRTSP);

  { appl_path := ExtractFilePath(Application.ExeName);
    if ((appl_path <> '') and (appl_path[Length(appl_path)] <> PathDelim)) then
    begin
    appl_path := appl_path + PathDelim;
    end;

    logo_path := appl_path + '..' + PathDelim + '..' + PathDelim + '..' + PathDelim + '..' + PathDelim;

    logo_file_1 := logo_path + 'logo.png';
    logo_file_2 := logo_path + 'logo.png';

    if (FileExists(logo_file_1) and FileExists(logo_file_2)) then
    begin
    PasLibVlcPlayer1.LogoShowFiles([logo_file_1, logo_file_2]);
    end; }

  // PasLibVlcPlayer1.MarqueeShowText('Loading %H:%M:%S');
  Edit7.Text:= dv.SubRTSP;
end;

procedure TfrmSetting.ResumeBtnClick(Sender: TObject);
begin
  PasLibVlcPlayer1.Resume();
end;

procedure TfrmSetting.Button10Click(Sender: TObject);
var
  i: Integer;
  ListItem: TListItem;

begin
  for i := 0 to ListView1.Items.Count - 1 do
  begin
    ListItem := ListView1.Items.Item[i];
    ListItem.Checked := false;
  end;
  for i := 0 to ListView2.Items.Count - 1 do
  begin
    ListItem := ListView2.Items.Item[i];
    ListItem.Checked := false;
  end;
  for i := 0 to ListView3.Items.Count - 1 do
  begin
    ListItem := ListView3.Items.Item[i];
    ListItem.Checked := false;
  end;
end;

procedure TfrmSetting.Button11Click(Sender: TObject);
var
  i: Integer;
  ListItem: TListItem;
begin
  for i := 0 to ListView1.Items.Count - 1 do
  begin
    ListItem := ListView1.Items.Item[i];
    ListItem.Checked := true;
  end;
  for i := 0 to ListView2.Items.Count - 1 do
  begin
    ListItem := ListView2.Items.Item[i];
    ListItem.Checked := true;
  end;
  for i := 0 to ListView3.Items.Count - 1 do
  begin
    ListItem := ListView3.Items.Item[i];
    ListItem.Checked := true;
  end;
end;

procedure TfrmSetting.Button12Click(Sender: TObject);
var
  i: Integer;
  ListItem: TListItem;
begin
  for i := 0 to ListView4.Items.Count - 1 do
  begin
    ListItem := ListView4.Items.Item[i];
    ListItem.Checked := false;
  end;
  for i := 0 to ListView5.Items.Count - 1 do
  begin
    ListItem := ListView5.Items.Item[i];
    ListItem.Checked := false;
  end;
  for i := 0 to ListView6.Items.Count - 1 do
  begin
    ListItem := ListView6.Items.Item[i];
    ListItem.Checked := false;
  end;
end;

procedure TfrmSetting.Button13Click(Sender: TObject);
var
  i: Integer;
  ListItem: TListItem;
begin
  for i := 0 to ListView4.Items.Count - 1 do
  begin
    ListItem := ListView4.Items.Item[i];
    ListItem.Checked := true;
  end;
  for i := 0 to ListView5.Items.Count - 1 do
  begin
    ListItem := ListView5.Items.Item[i];
    ListItem.Checked := true;
  end;
  for i := 0 to ListView6.Items.Count - 1 do
  begin
    ListItem := ListView6.Items.Item[i];
    ListItem.Checked := true;
  end;
end;

procedure TfrmSetting.Button14Click(Sender: TObject);
var
  i: Integer;
  ListItem: TListItem;
begin
  for i := 0 to ListView7.Items.Count - 1 do
  begin
    ListItem := ListView7.Items.Item[i];
    ListItem.Checked := false;
  end;
  for i := 0 to ListView8.Items.Count - 1 do
  begin
    ListItem := ListView8.Items.Item[i];
    ListItem.Checked := false;
  end;
  for i := 0 to ListView9.Items.Count - 1 do
  begin
    ListItem := ListView9.Items.Item[i];
    ListItem.Checked := false;
  end;
end;

procedure TfrmSetting.Button15Click(Sender: TObject);
var
  i: Integer;
  ListItem: TListItem;
begin
  for i := 0 to ListView7.Items.Count - 1 do
  begin
    ListItem := ListView7.Items.Item[i];
    ListItem.Checked := true;
  end;
  for i := 0 to ListView8.Items.Count - 1 do
  begin
    ListItem := ListView8.Items.Item[i];
    ListItem.Checked := true;
  end;
  for i := 0 to ListView9.Items.Count - 1 do
  begin
    ListItem := ListView9.Items.Item[i];
    ListItem.Checked := true;
  end;
end;

procedure TfrmSetting.Button18Click(Sender: TObject);
begin
  if (udp <> nil) then
  begin
    // udp.UDPSendHexStr('225.1.0.0', 3333, str);
    tcp.SetWork('astparam s kmoip_roaming_layout " "', 900);
    tcp.SetWork('astparam save;reboot', 900);
  end;
end;

procedure TfrmSetting.Button19Click(Sender: TObject);
var
  i, j, x, y, id: Integer;
  str, s: String;
  ldv: TVDevice;

begin
  // dv.x:=0;
  // dv.y:=0;
  str := ''; // dv.MAC+','+IntToStr(dv.x)+','+IntToStr(y);
  x := 0;
  y := 0;
  for i := 1 to StringGrid1.RowCount - 1 do
  begin
    for j := 1 to StringGrid1.ColCount - 1 do
    begin
      if Trim(StringGrid1.Cells[j, i]) = dv.id then
      begin
        x := j;
        y := i;
        break;
      end;
    end;
  end;

  if (x = 0) or (y = 0) then
  begin
    Showmessage('没有找到当前坐席的位置！！！');
    exit;
  end;

  for i := 1 to StringGrid1.RowCount - 1 do
  begin
    for j := 1 to StringGrid1.ColCount - 1 do
    begin
      s := Trim(StringGrid1.Cells[j, i]);
      if s = '' then
        Continue;

      try
        id := StrToInt(s);
      Except
        Continue;
      end;

      ldv := DeviceList.get(id);

      if ldv <> nil then
      begin
        if str <> '' then
          str := str + ':';
        str := str + ldv.MAC + ',' + IntToStr(j - x) + ',' + IntToStr(y - i);
        // break;
      end;
    end;
  end;

  if (str <> '') and (udp <> nil) then
  begin
    // udp.UDPSendHexStr('225.1.0.0', 3333, str);
    str := 'astparam s kmoip_roaming_layout ' + str;
    tcp.SetWork(str, 900);
    tcp.SetWork('astparam save;reboot', 900);
  end;
end;

procedure TfrmSetting.Button1Click(Sender: TObject);
var
  str: String;
  l: Integer;
  r: Boolean;
begin
  l := Length(Edit1.Text);
  if l > 10 then
  begin
    // showmessage('    名称的长度不能超过10个字符，汉字不能超过5个字！！！');
    // Exit;
  end;
  if tcp.Client.Connected then
  begin
    r := ipIP.parserIP(Trim(Edit3.Text));
    if not r then
    begin
      Showmessage('    无效的网络 IP 地址！！！');
      Edit3.SetFocus;
      exit;
    end;

    Edit5.Text := ipIP.ip1 + '.' + ipIP.ip2 + '.' + ipIP.ip3 + '.1';
    // e e_reconnect::4;astparam s reset_ch_on_boot n;astparam save
    // tcp.TCPSendStr('astparam s MY_IP' + trim(Edit1.Text) + #10#13);
    // tcp.TCPSendStr('astparam save' + #10#13);
    str := 'astparam s ip_mode static';
    str := str + ';astparam s ipaddr ' + Trim(Edit3.Text);
    str := str + ';astparam s netmask ' + Trim(Edit4.Text);
    str := str + ';astparam s gatewayip ' + Trim(Edit5.Text);

    str := str + ';astparam s ch_select ' + Trim(Edit2.Text);
    str := str + ';astparam s hostname_id ' + Trim(Edit2.Text);

    str := str + ';astparam s kmoip_ports all';
    str := str + ';astparam s reset_ch_on_boot n';
    str := str + ';ast_send_event -1 e_chg_hostname';
    str := str + ';astparam save;reboot';
    tcp.SetWork(str, 900);
  end;
end;

procedure TfrmSetting.Button2Click(Sender: TObject);
begin
  if tcp.Client.Connected then
  begin
    tcp.SetWork('e e_devfind_on');
  end;
end;

procedure TfrmSetting.Button3Click(Sender: TObject);
begin
  if tcp.Client.Connected then
  begin
    tcp.SetWork('e e_devfind_off');
  end;
end;

procedure TfrmSetting.Button4Click(Sender: TObject);
begin
  if tcp.Client.Connected then
  begin
    tcp.SetCallBack(TCPReadData);
    tcp.SetWork('astparam g pullperm', 100);
  end;
  // TCPReadData('astparam g pullperm FFFFFFFFFFFFFFFFFFFFFFFF', -1);
end;

procedure TfrmSetting.Button7Click(Sender: TObject);
begin
  if tcp.Client.Connected then
  begin
    tcp.SetCallBack(TCPReadData);
    tcp.SetWork('astparam g pushperm', 102);
  end;
  // TCPReadData('astparam g pushperm FFFFFFFFFFFFFFFFFFFFFFFF', -1);
end;

procedure TfrmSetting.Button9Click(Sender: TObject);
begin
  if tcp.Client.Connected then
  begin
    tcp.SetCallBack(TCPReadData);
    tcp.SetWork('astparam g getperm', 104);
  end;
  // TCPReadData('astparam g getperm FFFFFFFFFFFFFFFFFFFFFFFF', -1);
end;

procedure TfrmSetting.ChAudioOutClick(Sender: TObject);
var
  adLst: TStringList;
  chAdForm: TSelectOutputDeviceForm;
  newAudioDevice: string;
  selIdx: Integer;
begin
  chAdForm := TSelectOutputDeviceForm.Create(SELF);
  try
    chAdForm.OutputDevicesLB.Clear;
    adLst := PasLibVlcPlayer1.GetAudioOutputDeviceEnum(true);
    chAdForm.OutputDevicesLB.Items.AddStrings(adLst);
    chAdForm.OutputDevicesLB.ItemIndex := -1;
    for selIdx := 0 to chAdForm.OutputDevicesLB.Items.Count - 1 do
    begin
      newAudioDevice := chAdForm.OutputDevicesLB.Items.strings[selIdx];
      if PasLibVlcPlayer1.LastAudioOutputDeviceId = Copy(newAudioDevice, 1, Pos('|', newAudioDevice) - 1) then
      begin
        chAdForm.OutputDevicesLB.ItemIndex := selIdx;
        break;
      end;
    end;
    if (chAdForm.ShowModal = mrOK) then
    begin
      newAudioDevice := chAdForm.OutputDevicesLB.Items.strings[chAdForm.OutputDevicesLB.ItemIndex];
      newAudioDevice := Copy(newAudioDevice, 1, Pos('|', newAudioDevice) - 1);
      // LBAdd('Change Audio Device: ' + newAudioDevice);
      PasLibVlcPlayer1.SetAudioOutputDevice(newAudioDevice);
    end;
    adLst.Free;
  finally
    chAdForm.Free;
  end;

end;

procedure TfrmSetting.DeInterlaceBtnClick(Sender: TObject);
begin
  if (PasLibVlcPlayer1.DeInterlaceFilter = deOFF) then
  begin
    PasLibVlcPlayer1.DeinterlaceMode := dmX;
    PasLibVlcPlayer1.DeInterlaceFilter := deON;
    // LBAdd('DeInterlaceFilter = ON, ' + PasLibVlcPlayer1.DeinterlaceModeName);
  end
  else
  begin
    PasLibVlcPlayer1.DeInterlaceFilter := deOFF;
    // LBAdd('DeInterlaceFilter = OFF');
  end;
end;

procedure TfrmSetting.Button5Click(Sender: TObject);
var
  buff: array of Byte;
  str: string;

  lList: TStrings;
  i, n: Integer;
begin
  // SaveToFile(ListView1, ExtractFilePath(Application.Exename) + '\' + 'txName.dat');
  SetLength(buff, 12);
  n := GetZX(SELF.ListView1, buff, 11);
  n := n + GetZX(SELF.ListView2, buff, 7);
  n := n + GetZX(SELF.ListView3, buff, 3);

  str := BytestoHexString(buff, 12);
  // tcp.SetCallBack(TCPReadData);
  dv.TxPull := str;
  if tcp <> nil then
  begin
    tcp.SetWork('astparam s pullperm ' + str, 101);
    tcp.SetWork('astparam s pullnum ' + IntToStr(n), 101);
    tcp.SetWork('astparam save', 101);
  end;

  lList := TStringList.Create;
  try
    for i := 0 to ListView1.Items.Count - 1 do
      lList.add(ListView1.Items[i].subitems.strings[0]);
    for i := 0 to ListView2.Items.Count - 1 do
      lList.add(ListView2.Items[i].subitems.strings[0]);

    for i := 0 to ListView3.Items.Count - 1 do
      lList.add(ListView3.Items[i].subitems.strings[0]);

    lList.SaveToFile(ExtractFilePath(Application.ExeName) + '\' + 'txName.dat');
    dv.save;
  finally
    lList.Free;
  end;
end;

procedure TfrmSetting.Button6Click(Sender: TObject);
var
  buff: array of Byte;
  str: string;

  lList: TStrings;
  i, n: Integer;
begin
  // SaveToFile(ListView1, ExtractFilePath(Application.Exename) + '\' + 'RxName.dat');
  SetLength(buff, 12);
  n := GetZX(SELF.ListView4, buff, 11);
  n := n + GetZX(SELF.ListView5, buff, 7);
  n := n + GetZX(SELF.ListView6, buff, 3);

  str := BytestoHexString(buff, 12);
  // tcp.SetCallBack(TCPReadData);
  dv.Rxpush := str;
  if tcp <> nil then
  begin
    tcp.SetWork('astparam s pushperm ' + str, 103);
    tcp.SetWork('astparam s pushnum ' + IntToStr(n), 103);
    tcp.SetWork('astparam save', 103);
  end;

  lList := TStringList.Create;
  try
    for i := 0 to ListView4.Items.Count - 1 do
      lList.add(ListView4.Items[i].subitems.strings[0]);
    for i := 0 to ListView5.Items.Count - 1 do
      lList.add(ListView5.Items[i].subitems.strings[0]);

    for i := 0 to ListView6.Items.Count - 1 do
      lList.add(ListView6.Items[i].subitems.strings[0]);

    lList.SaveToFile(ExtractFilePath(Application.ExeName) + '\' + 'rxName.dat');
    dv.save;
  finally
    lList.Free;
  end;
end;

procedure TfrmSetting.Button8Click(Sender: TObject);
var
  buff: array of Byte;
  str: String;

  lList: TStrings;
  i, n: Integer;
begin
  // SaveToFile(ListView1, ExtractFilePath(Application.Exename) + '\' + 'RxName.dat');
  SetLength(buff, 12);
  n := GetZX(SELF.ListView7, buff, 11);
  n := n + GetZX(SELF.ListView8, buff, 7);
  n := n + GetZX(SELF.ListView9, buff, 3);

  str := BytestoHexString(buff, 12);
  // tcp.SetCallBack(TCPReadData);
  dv.Rxget := str;
  if tcp <> nil then
  begin
    tcp.SetWork('astparam s getperm ' + str, 105);
    tcp.SetWork('astparam s getnum ' + IntToStr(n), 105);
    tcp.SetWork('astparam save', 105);
  end;

  lList := TStringList.Create;
  try
    for i := 0 to ListView7.Items.Count - 1 do
      lList.add(ListView7.Items[i].subitems.strings[0]);

    for i := 0 to ListView8.Items.Count - 1 do
      lList.add(ListView8.Items[i].subitems.strings[0]);

    for i := 0 to ListView9.Items.Count - 1 do
      lList.add(ListView9.Items[i].subitems.strings[0]);

    lList.SaveToFile(ExtractFilePath(Application.ExeName) + '\' + 'rxName.dat');
    dv.save;
  finally
    lList.Free;
  end;
end;

procedure TfrmSetting.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if Length(Edit1.Text) > 6 then
  begin
    If (Key in ['0' .. '9', '.', #8]) then
    Begin
      Key := #0; // #0 表示没有输入
    End;
  end;
end;

procedure TfrmSetting.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  If not(Key in ['0' .. '9', '.', #8]) then
  Begin
    Key := #0; // #0 表示没有输入
  End;
end;

procedure TfrmSetting.Edit3KeyPress(Sender: TObject; var Key: Char);
begin
  If not(Key in ['0' .. '9', '.', #8]) then
  Begin
    Key := #0; // #0 表示没有输入
  End;
end;

procedure TfrmSetting.Edit4KeyPress(Sender: TObject; var Key: Char);
begin
  If not(Key in ['0' .. '9', '.', #8]) then
  Begin
    Key := #0; // #0 表示没有输入
  End;
end;

procedure TfrmSetting.Edit5KeyPress(Sender: TObject; var Key: Char);
begin
  If not(Key in ['0' .. '9', '.', #8]) then
  Begin
    Key := #0; // #0 表示没有输入
  End;
end;

procedure TfrmSetting.GetASpectRatioBtnClick(Sender: TObject);
var
  info: string;
  sar_num, sar_den: LongWord;
begin
  info := 'Aspect ratio = ' + PasLibVlcPlayer1.GetVideoAspectRatio();
  if (PasLibVlcPlayer1.GetVideoSampleAspectRatio(sar_num, sar_den)) then
  begin
    info := info + ', SampleAspectRatio = ' + IntToStr(sar_num) + ':' + IntToStr(sar_den);
  end;
  MessageDlg(info, mtInformation, [mbOK], 0);
end;

procedure TfrmSetting.GetAudioChannelClick(Sender: TObject);
var
  chname: string;
begin
  chname := 'Unknown';
  case PasLibVlcPlayer1.GetAudioChannel() of
    libvlc_AudioChannel_Error:
      chname := 'Error';
    libvlc_AudioChannel_NotAvail:
      chname := 'Not availiable';
    libvlc_AudioChannel_Stereo:
      chname := 'Stereo';
    libvlc_AudioChannel_RStereo:
      chname := 'RStereo';
    libvlc_AudioChannel_Left:
      chname := 'Left';
    libvlc_AudioChannel_Right:
      chname := 'Right';
    libvlc_AudioChannel_Dolbys:
      chname := 'Dolbys';
  end;
  MessageDlg(chname, mtInformation, [mbOK], 0);
end;

procedure TfrmSetting.GetAudioOutDevEnumBtnClick(Sender: TObject);
var
  ls1: TStringList;
  id1: Integer;
begin
  // LBAdd('GetAudioOutputDeviceEnum');
  ls1 := PasLibVlcPlayer1.GetAudioOutputDeviceEnum();
  for id1 := 0 to ls1.Count - 1 do
  begin
    // LBAdd('  ' + ls1.Strings[id1]);
  end;
  ls1.Free;

end;

procedure TfrmSetting.GetAudioOutListBtnClick(Sender: TObject);
var
  ls1: TStringList;
  ls2: TStringList;
  id1: Integer;
  id2: Integer;
begin
  // LBAdd('GetAudioOutputList');
  ls1 := PasLibVlcPlayer1.GetAudioOutputList();
  for id1 := 0 to ls1.Count - 1 do
  begin
    // LBAdd('  ' + ls1.Strings[id1]);
    ls2 := PasLibVlcPlayer1.GetAudioOutputDeviceList(ls1.strings[id1]);
    if (ls2.Count < 1) then
    begin
      // LBAdd('    no devices found');
    end;
    for id2 := 0 to ls2.Count - 1 do
    begin
      // LBAdd('    device: ' + ls2.Strings[id2]);
    end;
    ls2.Free;
  end;
  ls1.Free;

end;

procedure TfrmSetting.GetAudioTrackListClick(Sender: TObject);
var
  ls1: TStringList;
  id1: Integer;
begin
  // LBAdd('GetAudioTrackList');
  ls1 := PasLibVlcPlayer1.GetAudioTrackList();
  if (ls1.Count < 1) then
  begin
    // LBAdd('    no audio tracks found');
  end;
  for id1 := 0 to ls1.Count - 1 do
  begin
    // LBAdd('  audio track, ID: ' + IntToStr(Int64(ls1.Objects[id1])) + ' - ' + ls1.Strings[id1]);
  end;
  ls1.Free;

end;

procedure TfrmSetting.GetEqPreListBtnClick(Sender: TObject);
var
  ls1: TStringList;
  id1: Integer;
  ebc: Word;
begin
  // LBAdd('GetEqualizerPresetList');
  ls1 := PasLibVlcPlayer1.EqualizerGetPresetList();
  for id1 := 0 to ls1.Count - 1 do
  begin
    // LBAdd('  ' + IntToStr(Word(ls1.Objects[id1])) + ' - ' + ls1.Strings[id1]);
  end;
  ls1.Free;

  ebc := PasLibVlcPlayer1.EqualizerGetBandCount();

  // LBAdd('GetEqualizerBandCount = ' + IntToStr(ebc));

  // LBAdd('GetEqualizerBandFrequency');
  for id1 := 0 to ebc - 1 do
  begin
    // LBAdd('  ' + IntToStr(id1) + ' - ' + IntToStr(Round(PasLibVlcPlayer1.EqualizerGetBandFrequency(id1))));
  end;

end;

procedure TfrmSetting.GetHeightBtnClick(Sender: TObject);
begin
  MessageDlg('Video height = ' + IntToStr(PasLibVlcPlayer1.GetVideoHeight()), mtInformation, [mbOK], 0);
end;

procedure TfrmSetting.GetPlayRateBtnClick(Sender: TObject);
begin
  MessageDlg('Play rate = ' + IntToStr(PasLibVlcPlayer1.GetPlayRate()), mtInformation, [mbOK], 0);
end;

procedure TfrmSetting.GetPosLenBtnClick(Sender: TObject);
begin
  MessageDlg('Len = ' + IntToStr(PasLibVlcPlayer1.GetVideoLenInMs()) + ' ms, ' + 'Pos = ' + IntToStr(PasLibVlcPlayer1.GetVideoPosInMs()), mtInformation, [mbOK], 0);
end;

procedure TfrmSetting.GetStateBtnClick(Sender: TObject);
var
  stateName: string;
begin
  case PasLibVlcPlayer1.GetState() of
    plvPlayer_NothingSpecial:
      stateName := 'Idle';
    plvPlayer_Opening:
      stateName := 'Opening';
    plvPlayer_Buffering:
      stateName := 'Buffering';
    plvPlayer_Playing:
      stateName := 'Playing';
    plvPlayer_Paused:
      stateName := 'Paused';
    plvPlayer_Stopped:
      stateName := 'Stopped';
    plvPlayer_Ended:
      stateName := 'Ended';
    plvPlayer_Error:
      stateName := 'Error';
  else
    stateName := 'Unknown';
  end;
  MessageDlg('State = ' + stateName, mtInformation, [mbOK], 0);

end;

procedure TfrmSetting.GetVolumeClick(Sender: TObject);
begin
  MessageDlg('Volume level = ' + IntToStr(PasLibVlcPlayer1.GetAudioVolume()), mtInformation, [mbOK], 0);
end;

procedure TfrmSetting.GetWidthBtnClick(Sender: TObject);
begin
  MessageDlg('Video width = ' + IntToStr(PasLibVlcPlayer1.GetVideoWidth()), mtInformation, [mbOK], 0);
end;

function TfrmSetting.GetZX(ListView: TListView; var buf: array of Byte; offset: Integer): Integer;
var
  i: Integer;
  Item: TListItem;
  b: Byte;
  mask: Byte;
  // c:byte;
begin
  Result := 0;
  mask := $01;
  b := 0; // c:=0;
  for i := 0 to ListView.Items.Count - 1 do
  begin
    Item := ListView.Items.Item[i];
    if Item.Checked then
    begin
      b := b or mask;
      INC(Result);
    end;
    mask := mask shl 1;
    if (i mod 8) = 7 then
    begin
      buf[offset - (i div 8)] := b;
      b := 0;
      mask := $01;
      // c:=0;
    end;
  end;
end;

procedure TfrmSetting.UpdateTxZx(ListView: TListView; b: Byte; ZXId: Integer);
var
  Item: TListItem;
  i: Integer;
  mask, bb: Byte;
  Name: String;
begin
  mask := $80;
  for i := 0 to 7 do
  begin

    Item := ListView.Items.add;
    Item.caption := IntToStr(i + ZXId);

    name := '主机' + Item.caption;

    if (TxName.Count - 1) >= (i + ZXId) then
      name := TxName.strings[i + ZXId];

    Item.subitems.add(name);

    bb := b and mask;
    if bb = mask then
      Item.Checked := true
    else
      Item.Checked := false;

    mask := mask shr 1;
  end;
end;

procedure TfrmSetting.VideoAdjustBtnClick(Sender: TObject);
var
  vaForm: TVideoAdjustForm;
begin
  vaForm := TVideoAdjustForm.Create(SELF);
  try
    vaForm.ShowModal;
  finally
    vaForm.Free;
  end;
end;

procedure TfrmSetting.UpdateRxZx(ListView: TListView; b: Byte; ZXId: Integer);
var
  Item: TListItem;
  i: Integer;
  mask, bb: Byte;
  Name: String;
begin
  mask := $80;
  for i := 0 to 7 do
  begin

    Item := ListView.Items.add;
    Item.caption := IntToStr(i + ZXId);

    name := '坐席' + Item.caption;

    if (RxName.Count - 1) >= (i + ZXId) then
      name := RxName.strings[i + ZXId];

    Item.subitems.add(name);

    bb := b and mask;
    if bb = mask then
      Item.Checked := true
    else
      Item.Checked := false;

    mask := mask shr 1;
  end;
end;

procedure TfrmSetting.TabSheet2Show(Sender: TObject);
begin
  // if dv.TxPull <> '' then
  // TCPReadData('astparam g pullperm ' + dv.TxPull, -1);
end;

procedure TfrmSetting.TabSheet3Show(Sender: TObject);
begin
  // if dv.RxPush <> '' then
  // TCPReadData('astparam g pushperm ' + dv.RxPush, -1);
end;

procedure TfrmSetting.TabSheet4Show(Sender: TObject);
begin
  // if dv.Rxget <> '' then
  // TCPReadData('astparam g pullperm ' + dv.Rxget, -1);
end;

function ReverseWord(w: Word): Word;
asm
  {$IFDEF cpuX64}
  mov rax,rcx
  {$ENDIF}
  xchg   al,ah
end;

procedure TfrmSetting.TCPReadData(const data: string; id: Integer);
var
  str, s: String;
  SL: TStringList;
  buf: array of Byte;
  bc, i: Integer;
begin
  if Length(data) <= 2 then
    exit;
  SL := TStringList.Create;
  // if (id = 100) or (id = 0) then // astparam g pullperm
  // begin
  // end;
  if (id = -1) then
  begin
    str := StringReplace(data, '/', '', [rfReplaceAll]);
    str := StringReplace(str, '#', '', [rfReplaceAll]);
    str := Trim(str);
    if Pos('astparam g pullperm', str) > 0 then
    begin
      s := Copy(str, Pos('astparam g pullperm', str), Length(str));
      ExtractStrings([' '], [' '], PChar(s), SL);
      if SL.Count < 4 then
        exit;

      str := LowerCase(SL[3]);
      bc := Length(str) div 2;
      SetLength(buf, bc);
      i := HexToBin(PChar(str), @buf[0], bc);
      if i <> bc then
        exit;

      // MakeWord($CC,$DD),
      // ReverseWord(buf[0]); ReverseWord(buf[1]);ReverseWord(buf[2]);ReverseWord(buf[3]);
      ListView1.Clear;
      UpdateTxZx(SELF.ListView1, buf[0], 1);
      UpdateTxZx(SELF.ListView1, buf[1], 9);
      UpdateTxZx(SELF.ListView1, buf[2], 17);
      UpdateTxZx(SELF.ListView1, buf[3], 25);
      ListView2.Clear;
      UpdateTxZx(SELF.ListView2, buf[4], 33);
      UpdateTxZx(SELF.ListView2, buf[5], 41);
      UpdateTxZx(SELF.ListView2, buf[6], 49);
      UpdateTxZx(SELF.ListView2, buf[7], 57);
      ListView3.Clear;
      UpdateTxZx(SELF.ListView3, buf[8], 65);
      UpdateTxZx(SELF.ListView3, buf[9], 73);
      UpdateTxZx(SELF.ListView3, buf[10], 81);
      UpdateTxZx(SELF.ListView3, buf[11], 89);
      // ShowMessage(SL.Text);
      dv.TxPull := str;
      SL.Free;
    end;
    if Pos('astparam g pushperm', str) > 0 then
    begin
      delete(str, 1, Pos('astparam g pushperm', str) - 1);
      ExtractStrings([' '], [' '], PChar(str), SL);
      if SL.Count < 4 then
        exit;

      str := LowerCase(SL[3]);
      bc := Length(str) div 2;
      SetLength(buf, bc);
      i := HexToBin(PChar(str), @buf[0], bc);
      if i <> bc then
        exit;

      ListView4.Clear;
      UpdateRxZx(SELF.ListView4, buf[0], 1);
      UpdateRxZx(SELF.ListView4, buf[1], 9);
      UpdateRxZx(SELF.ListView4, buf[2], 17);
      UpdateRxZx(SELF.ListView4, buf[3], 25);

      ListView5.Clear;
      UpdateRxZx(SELF.ListView5, buf[4], 33);
      UpdateRxZx(SELF.ListView5, buf[5], 41);
      UpdateRxZx(SELF.ListView5, buf[6], 49);
      UpdateRxZx(SELF.ListView5, buf[7], 57);

      ListView6.Clear;
      UpdateRxZx(SELF.ListView6, buf[8], 65);
      UpdateRxZx(SELF.ListView6, buf[9], 73);
      UpdateRxZx(SELF.ListView6, buf[10], 81);
      UpdateRxZx(SELF.ListView6, buf[11], 89);
      // ShowMessage(SL.Text);
      dv.Rxpush := str;
      SL.Free;
    end;

    if Pos('astparam g getperm', str) > 0 then
    begin
      delete(str, 1, Pos('astparam g getperm', str) - 1);
      ExtractStrings([' '], [' '], PChar(str), SL);
      if SL.Count < 4 then
        exit;

      str := LowerCase(SL[3]);
      bc := Length(str) div 2;
      SetLength(buf, bc);
      i := HexToBin(PChar(str), @buf[0], bc);
      if i <> bc then
        exit;

      ListView7.Clear;
      UpdateRxZx(SELF.ListView7, buf[0], 1);
      UpdateRxZx(SELF.ListView7, buf[1], 9);
      UpdateRxZx(SELF.ListView7, buf[2], 17);
      UpdateRxZx(SELF.ListView7, buf[3], 25);

      ListView8.Clear;
      UpdateRxZx(SELF.ListView8, buf[4], 33);
      UpdateRxZx(SELF.ListView8, buf[5], 41);
      UpdateRxZx(SELF.ListView8, buf[6], 49);
      UpdateRxZx(SELF.ListView8, buf[7], 57);

      ListView9.Clear;
      UpdateRxZx(SELF.ListView9, buf[8], 65);
      UpdateRxZx(SELF.ListView9, buf[9], 73);
      UpdateRxZx(SELF.ListView9, buf[10], 81);
      UpdateRxZx(SELF.ListView9, buf[11], 89);
      // ShowMessage(SL.Text);
      dv.Rxget := str;
      SL.Free;
    end;
  end;
end;

procedure TfrmSetting.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // if tcp <> nil then
  // tcp.stop;
  PasLibVlcPlayer1.STOP();
  if dv <> nil then
    dv.save;
end;

procedure TfrmSetting.FormCreate(Sender: TObject);
var
  fileName: String;
  i: Integer;
begin
  fileName := ExtractFilePath(Application.ExeName) + '\' + 'txName.dat';
  TxName := TStringList.Create;
  RxName := TStringList.Create;
  if FileExists(fileName) then
    TxName.LoadFromFile(fileName);
  fileName := ExtractFilePath(Application.ExeName) + '\' + 'rxName.dat';
  if FileExists(fileName) then
    RxName.LoadFromFile(fileName);

  StringGrid1.ColWidths[0] := 25;
  for i := 1 to StringGrid1.RowCount - 1 do
  begin
    StringGrid1.Cells[0, i] := IntToStr(i);
  end;
  for i := 1 to StringGrid1.ColCount - 1 do
  begin
    StringGrid1.Cells[i, 0] := IntToStr(i);
  end;

  // SpinEdit5.MaxValue := StringGrid1.ColCount;
  // SpinEdit6.MaxValue := StringGrid1.RowCount;

end;

procedure TfrmSetting.FormDestroy(Sender: TObject);
begin
  TxName.Free;
  RxName.Free;
end;

procedure TfrmSetting.FormShow(Sender: TObject);
var
  i, j: Integer;
  ddv: TVDevice;
begin
  if dv <> nil then
  begin
    SELF.caption := '兆科音视频坐席管理设置' + ' : ' + dv.Name + ', ' + dv.ip;
    ipIP := TIP.Create(dv.ip);
    ipIP.parserIP(dv.ip);
    Edit1.Text := dv.Name;
    Edit2.Text := dv.id;
    Edit3.Text := dv.ip;
    Edit6.Text := dv.MAC;
    // edit4.Text:=
    Edit5.Text := ipIP.ip1 + '.' + ipIP.ip2 + '.' + ipIP.ip3 + '.1';

    if (dv.Typee = 'Rx') and (dv.SubRTSP = '') then
    begin
      if dv.TxvID <> '' then
      begin
        ddv := DeviceList.GetTx(StrToInt(dv.TxvID));
        if ddv <> nil then
        begin
          dv.SubRTSP := ddv.SubRTSP;
          dv.MainRTSP := ddv.MainRTSP;
        end;
      end;
    end;

    DataEngineManager.DoIt(play2);
    dv.load;

    if dv.TxPull <> '' then
      TCPReadData('astparam g pullperm ' + dv.TxPull, -1)
    else
    begin
      ListView1.Clear;
      ListView2.Clear;
      ListView3.Clear;
    end;
    if dv.Rxpush <> '' then
      TCPReadData('astparam g pushperm ' + dv.Rxpush, -1)
    else
    begin
      ListView4.Clear;
      ListView5.Clear;
      ListView6.Clear;
    end;
    if dv.Rxget <> '' then
    begin
      TCPReadData('astparam g getperm ' + dv.Rxget, -1)
    end
    else
    begin
      ListView7.Clear;
      ListView8.Clear;
      ListView9.Clear;
    end;
  end;

  for i := 1 to StringGrid1.RowCount - 1 do
  begin
    for j := 1 to StringGrid1.ColCount - 1 do
      StringGrid1.Cells[j, i] := '';
  end;
end;

end.

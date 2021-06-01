// ---------------------------------------------------------------------------

















// This software is Copyright (c) 2015 Embarcadero Technologies, Inc.
// You may only use this software if you are an authorized licensee
// of an Embarcadero developer tools product.
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

// ---------------------------------------------------------------------------

unit uSplitView;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.ImageList,
  System.Actions,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.WinXCtrls,
  Vcl.StdCtrls,
  Vcl.CategoryButtons,
  Vcl.Buttons,
  Vcl.ImgList,
  Vcl.Imaging.PngImage,
  Vcl.ComCtrls,
  Vcl.ActnList, IdTCPConnection, IdTCPClient, IdIPMCastBase, IdIPMCastClient,
  IdBaseComponent, IdComponent, IdUDPBase, IdUDPServer, Vcl.Samples.Spin,
  Vcl.Mask, IdGlobal, IdSocketHandle, VDeviceGroup, VDevice, Vcl.Tabs,
  IdAntiFreezeBase, IdAntiFreeze, DataEngine, ClientObject, inifiles, Vcl.XPMan,
  Vcl.Menus;

type
  TSplitViewForm = class(TForm)
    SV: TSplitView;
    Notebook1: TNotebook;
    Panel1: TPanel;
    Splitter1: TSplitter;
    ListView1: TListView;
    Panel3: TPanel;
    Memo1: TMemo;
    ListView2: TListView;
    IdTCPClient1: TIdTCPClient;
    Notebook2: TNotebook;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    TabSet1: TTabSet;
    Button3: TButton;
    GroupBox3: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label8: TLabel;
    ComboBox1: TComboBox;
    Edit6: TEdit;
    Edit7: TEdit;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label6: TLabel;
    Edit5: TEdit;
    Button5: TButton;
    Button4: TButton;
    StatusBar1: TStatusBar;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button2: TButton;
    Memo2: TMemo;
    ComboBox3: TComboBox;
    Timer1: TTimer;
    ComboBox2: TComboBox;
    Label9: TLabel;
    Button9: TButton;
    MessageTimer: TTimer;
    Panel2: TPanel;
    Splitter2: TSplitter;
    Timer3: TTimer;
    pnlToolbar: TPanel;
    lblTitle: TLabel;
    cbxVclStyles: TComboBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    ImageList1: TImageList;
    SpeedButton1: TSpeedButton;
    ImageList2: TImageList;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    ImageList3: TImageList;
    ImageList4: TImageList;

    procedure FormCreate(Sender: TObject);
    procedure cbxVclStylesChange(Sender: TObject);
    procedure catMenuItemsCategories0Items0Click(Sender: TObject);
    procedure catMenuItemsCategories0Items1Click(Sender: TObject);
    procedure catMenuItemsCategories0Items2Click(Sender: TObject);
    procedure catMenuItemsCategories0Items3Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure FormResize(Sender: TObject);
    procedure ListView2Click(Sender: TObject);
    procedure ListView1Click(Sender: TObject);
    procedure TabSet1Change(Sender: TObject; NewTab: Integer; var AllowChange: Boolean);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure IdTCPClient1Disconnected(Sender: TObject);
    procedure IdTCPClient1Connected(Sender: TObject);
    procedure IdTCPClient1Status(ASender: TObject; const AStatus: TIdStatus; const AStatusText: string);
    procedure Edit7KeyPress(Sender: TObject; var Key: Char);
    procedure Edit6KeyPress(Sender: TObject; var Key: Char);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
    procedure Edit5KeyPress(Sender: TObject; var Key: Char);
    procedure Edit4KeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ComboBox3KeyPress(Sender: TObject; var Key: Char);
    procedure ComboBox2Change(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure MessageTimerTimer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure ListView1DblClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ListView2DblClick(Sender: TObject);
    procedure ListView1Compare(Sender: TObject; Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
    procedure ListView2Compare(Sender: TObject; Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
    procedure ListView1ColumnClick(Sender: TObject; Column: TListColumn);
    procedure ListView2ColumnClick(Sender: TObject; Column: TListColumn);
    procedure SpeedButton1Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
  private
    procedure Log(const Msg: string);
    procedure SynchroPage(ItemIndex: Integer);
    procedure UpdateListView();
    procedure UpdateNetDeviceKP(Cmd: String);
    procedure UpdateLocalDevices(dv: TVDevice);
    procedure InitUDP_S_KP();

    function GetTCPConnection(Ip: String; Port: Integer): TClientObject;
    function GetUDPConnection(Ip: String; Port: Integer): TClientObject;
    procedure St(slot: Integer; Msg: String);
    function GetDevice(Name: String): TVDevice;
    procedure CheckItems(Lv: TListView; Item: TListItem; MultiSel: Boolean);

    procedure WMNCPaint(var Msg: TWMNCPaint); message WM_NCPAINT;
    procedure WMNCACTIVATE(var Msg: TWMNCActivate); message WM_NCACTIVATE;
    procedure DrawCaptionText();
  public
    // InitFlag:Boolean;
  end;

var
  SplitViewForm: TSplitViewForm;

  srx, stx: TVDevice;

  Sortf: Boolean;

implementation

uses
  Vcl.Themes, GlobalConst, GlobalFunctions, Unit200, Ip, MyMessageQueue, trash,
  Setting, GSetting;

{$R *.dfm}

procedure TSplitViewForm.DrawCaptionText;
//const
//  captionText = 'delphi.about.com';
//var
//  canvas: TCanvas;
begin
  {
  canvas := TCanvas.Create;
  try
    canvas.Handle := GetWindowDC(Self.Handle);


  finally
    ReleaseDC(Self.Handle, canvas.Handle);
    canvas.Free;
  end;
  }
end;

procedure TSplitViewForm.WMNCACTIVATE(var Msg: TWMNCActivate);
begin
  inherited;
  DrawCaptionText;
end;

procedure TSplitViewForm.WMNCPaint(var Msg: TWMNCPaint);
begin
  inherited;
  DrawCaptionText;
end;

procedure TSplitViewForm.CheckItems(Lv: TListView; Item: TListItem; MultiSel: Boolean);
var
  i: Integer;
begin

  if MultiSel = true then
    Exit;

  for i := 0 to Lv.items.count - 1 do
  begin
    if Lv.items.Item[i] <> Item then
      Lv.items.Item[i].Checked := false;
  end;
end;

procedure TSplitViewForm.InitUDP_S_KP();
var
  i: Integer;
  ClientObject: TClientObject;
begin
  for i := 0 to LocalIPList.count - 1 do
  begin
    ClientObject := GetUDPConnection(LocalIPList[i], 3334);
    if ClientObject <> nil then
    begin
      ClientObject.memo := Memo1;
      // ClientObject.uiLock := MessageCriticalSection;
    end;
  end;
end;

function TSplitViewForm.GetUDPConnection(Ip: String; Port: Integer): TClientObject;
var
  ClientObject: TClientObject;
begin
  Result := TClientObject(DataEngineManager.get(Ip + ':' + IntToStr(Port)));
  if Result <> nil then
    Exit;
  try
    ClientObject := TClientObject.Create(true);
    ClientObject.AssignUDP(nil, Ip, Port);
    // ClientObject.Client.tag := Integer(Pointer(TClientObject(ClientObject)));
    DataEngineManager.Add(Ip + ':' + IntToStr(Port), ClientObject);
  Except
    on e: Exception do
    begin
      St(1, '��ʼ��UDP ' + e.tostring);
      Exit;
    end;

  end;
  Result := ClientObject;
end;

function TSplitViewForm.GetTCPConnection(Ip: String; Port: Integer): TClientObject;
var
  obj: TObject;
begin
  obj := DataEngineManager.get(Ip + ':' + IntToStr(Port));
  if obj <> nil then
  begin
    Result := TClientObject(obj);
    if Result.checkStOK() then
      Exit
    else
      DataEngineManager.Del(Ip + ':' + IntToStr(Port));
  end;

  try
    IdTCPClient1.Host := Ip;
    IdTCPClient1.Port := Port;

    Result := TClientObject.Create(true); // ���������߳�
    Result.AssignTCPClient(IdTCPClient1);
    Result.Client.tag := Integer(Pointer(Result)); // ͨ�����Ա�����౾��
    DataEngineManager.Add(Ip + ':' + IntToStr(Port), Result);
    DataEngineManager.DoIt(Result.OpenTCP);
    St(2, '����������' + IntToStr(DataEngineManager.count()));
  Except
    on e: Exception do
    begin
      St(1, '��ʼ��TCP ' + e.tostring);
      Exit;
    end;

  end;

end;

procedure TSplitViewForm.FormClose(Sender: TObject; var Action: TCloseAction);

begin
  // if IdTCPClient1.connected then
  // IdTCPClient1.Disconnect;
  // for I := 0 to DeviceList.dev do
end;

procedure TSplitViewForm.FormCreate(Sender: TObject);
var
  StyleName, filename: string;
  S: string;
begin
  for StyleName in TStyleManager.StyleNames do
    cbxVclStyles.items.Add(StyleName);
  cbxVclStyles.ItemIndex := cbxVclStyles.items.IndexOf(TStyleManager.ActiveStyle.Name);

  GetBuildInfo(Application.ExeName, S);

  Caption := APPLICATION_TITLE_NAME + ' ' +
{$IFDEF CPUX64}'64'{$ELSE}'32'{$ENDIF} + ' bit' + ' v' + S;

  filename := ExtractFilePath(Application.ExeName) + '\' + 'zk.ini';
  ini := TInifile.Create(filename);

  SynchroPage(0);
  TabSet1.Tabs := Notebook2.Pages;
  /// ///////////////////////////////////////////////////////////////////////////

  Edit6.text := _GetComputerName();
  LocalIPList := GetIPList();
  ComboBox1.items.AddStrings(LocalIPList);
  if LocalIPList.count >= 0 then
    ComboBox1.ItemIndex := 0;

  /// ///////////////////////////////////////////////////////////////////////////
  // DataEngineManager.doIt(initUI);
  Timer3.Enabled := true;
end;

procedure TSplitViewForm.FormResize(Sender: TObject);
begin
  ListView1.Width := Panel2.Width div 2;
end;

procedure TSplitViewForm.IdTCPClient1Connected(Sender: TObject);
var
  tcp: TClientObject;
  str: String;
begin
  tcp := Pointer(TIdTCPClient(Sender).tag);
  str := tcp.Client.Host + ':' + IntToStr(tcp.Client.Port);
  // ComboBox3.items.Add(str); ����崻�
  St(1, 'TCP ���ӳɹ� --> ' + str);
end;

procedure TSplitViewForm.IdTCPClient1Disconnected(Sender: TObject);
var
  tcp: TClientObject;
begin
  tcp := Pointer(TIdTCPClient(Sender).tag);
  St(1, 'TCP ���ӶϿ�' + tcp.Client.Host + ':' + IntToStr(tcp.Client.Port));
end;

procedure TSplitViewForm.IdTCPClient1Status(ASender: TObject; const AStatus: TIdStatus; const AStatusText: string);
begin
  Log('TCP Status:' + AStatusText);
  St(1, 'TCP Status:' + AStatusText);
end;

procedure TSplitViewForm.UpdateLocalDevices(dv: TVDevice);
begin
  DeviceList.Add(dv.Name, dv);
  UpdateListView();
end;

procedure TSplitViewForm.UpdateListView();
var
  ListItem: TListItem;
  i, k: Integer;
  dv: TVDevice;
Label Lend;
begin
  if DeviceList.DevicesTx.count > 0 then
  begin
    for i := 0 to DeviceList.DevicesTx.count - 1 do
    begin
      dv := TVDevice(DeviceList.DevicesTx.Objects[i]);
      if dv = nil then
        Continue;
      if dv.Name = '' then
        Continue;
      if dv.b then
        Continue;

      with ListView2 do
      begin
        // J := ListView2.Items.count + 1;
        ListItem := items.Add;
        ListItem.Caption := dv.Name; // IntToStr(J);
        ListItem.ImageIndex := Random(1);
        // ListItem.subitems.Add(dv.Name);
        ListItem.subitems.Add(dv.ID);
        ListItem.subitems.Add(dv.Ip);
        ListItem.subitems.Add(dv.Port);
        ListItem.subitems.Add(dv.MAC);
        ListItem.subitems.Add(dv.typee);
        ListItem.subitems.Add(dv.St);
        dv.b := true;
      end;
    end;
  end;

  if DeviceList.DevicesRx.count > 0 then
  begin
    for i := 0 to DeviceList.DevicesRx.count - 1 do
    begin
      dv := TVDevice(DeviceList.DevicesRx.Objects[i]);
      if dv = nil then
        Continue;
      if dv.Name = '' then
        Continue;
      if dv.b then
        Continue;
      with ListView1 do
      begin
        // J := ListView1.Items.count + 1;
        ListItem := items.Add;
        ListItem.Caption := dv.Name; // IntToStr(J);
        ListItem.ImageIndex := Random(ImageList1.count - 1);
        // ListItem.subitems.Add(dv.Name);
        ListItem.subitems.Add(dv.ID);
        ListItem.subitems.Add(dv.Ip);
        ListItem.subitems.Add(dv.Port);
        ListItem.subitems.Add(dv.MAC);
        ListItem.subitems.Add(dv.typee);
        ListItem.subitems.Add(dv.St);
        ListItem.subitems.Add(dv.TxaID);
        ListItem.subitems.Add(dv.TxvID);
        dv.b := true;
      end;
    end;
  end;

Lend:
  StatusBar1.Panels[0].text := 'Rx : ' + IntToStr(DeviceList.DevicesRx.count) + '    Tx : ' + IntToStr(DeviceList.DevicesTx.count)
end;

procedure TSplitViewForm.UpdateNetDeviceKP(Cmd: String);
var
  Ip: String;
  Port, i: Integer;
  udp: TClientObject;
begin
  Ip := '225.1.0.0';
  Port := 3333;
  for i := 0 to LocalIPList.count - 1 do
  begin
    udp := GetUDPConnection(LocalIPList[i], 3334);
    if udp <> nil then
    begin
      udp.UDPSendHexStr(Ip, Port, Cmd);
    end;
  end;
end;

procedure TSplitViewForm.Button9Click(Sender: TObject);
var
  ClientObject: TClientObject;
begin
  if ComboBox2.ItemIndex <= 1 then
  begin
    // InitUDP(trim(ComboBox1.text), StrToInt(trim(Edit7.text)));
  end;
  if ComboBox2.ItemIndex > 1 then
  begin
    ClientObject := GetTCPConnection(trim(ComboBox3.text), StrToInt(trim(Edit5.text)));
    if ClientObject <> nil then
      ClientObject.Client.IOHandler.WriteLn('root' + #13#10);
  end;
end;

procedure TSplitViewForm.Button1Click(Sender: TObject);
var
  // tcp: TClientObject;
  udp: TClientObject;
  // txid:Integer;
  t, i: Integer;
  str: String;
  buff: array [0 .. 2] of byte;
begin
  if srx = nil then
    Exit;
  if stx = nil then
    Exit;

  t := StrToInt(stx.ID);

  { tcp := GetTCPConnection(trim(srx.Ip), 24);
    if tcp = nil then
    begin
    Showmessage('û�н�����Ч��TCP���ӡ�');
    Exit;
    end;

    if tcp.Client.connected then
    begin
    tcp.memo := Memo1;
    tcp.SetCallBack(nil);

    str := 'e e_reconnect::' + IntToStr(t) + ';astparam s reset_ch_on_boot n;astparam save';
    tcp.SetWork(str, 900);
    end
    else }
  begin
    // Showmessage('TCP ���Ӳ��ɹ���');
    // Ip := '225.1.0.0';
    // Port := 3333;
    buff[0] := $FF;
    buff[1] := StrToInt(srx.ID);
    buff[2] := t;
    Log('UDP:' + IntToStr(buff[0]) + ' RX:' + IntToStr(buff[1]) + ' TX:' + IntToStr(buff[2]));
    for i := 0 to LocalIPList.count - 1 do
    begin
      udp := GetUDPConnection(LocalIPList[i], 3334);
      if udp <> nil then
      begin
        udp.UDPSendHexStr('225.1.0.0', 3333, BuffToHexStr(buff));
      end;
    end;
  end;
end;

procedure TSplitViewForm.Button2Click(Sender: TObject);
var
  tcp: TClientObject;
  udp: TClientObject;
  // str: String;
  // i: Integer;
begin
  if ComboBox2.ItemIndex <= 1 then
  begin
    udp := GetUDPConnection(trim(ComboBox1.text), StrToInt(trim(Edit7.text)));
    udp.UDPSendHexStr(ComboBox3.text, StrToInt(trim(Edit5.text)), Memo2.text);
    // UDPSendData(trim(ComboBox1.text), StrToInt(trim(Edit7.text)),
    // ComboBox3.text, StrToInt(trim(Edit5.text)), Memo2.text);
  end;

  if ComboBox2.ItemIndex > 1 then
  begin
    tcp := GetTCPConnection(trim(ComboBox3.text), StrToInt(trim(Edit5.text)));
    tcp.memo := Memo1;
    if tcp = nil then
    begin
      Log('û�н������õ����ӣ���');
      Exit;
    end;

    if tcp.Client.connected then
    begin
      Log('TCP����IP:' + tcp.Client.Socket.Binding.Ip + ':' + IntToStr(tcp.Client.Socket.Binding.Port) + ' --> ' + tcp.Client.Host + ':' + IntToStr(tcp.Client.Port));
      Log(Memo2.text);
      Log('####################################');
      try
        tcp.addworks(Memo2.Lines, Random(20000));
      Except
        on e: Exception do
        begin
          Log(e.tostring);
        end;
      end;
    end
    else
    begin
      // Log('û�н������õ����ӣ���');
    end;
  end;
end;

procedure TSplitViewForm.Button3Click(Sender: TObject);
var
  sl: TStringList;
begin
  Memo1.Lines.Add(_GetComputerName());
  sl := GetIPList();
  Memo1.Lines.AddStrings(sl);
  sl.Free;
end;

procedure TSplitViewForm.Button4Click(Sender: TObject);
begin
  ListView2.items.Clear;
  DeviceList.DevicesTx.Clear;
  UpdateListView();
  UpdateNetDeviceKP('0x01 0x00 0x00 0x0d');
end;

procedure TSplitViewForm.Button5Click(Sender: TObject);
begin

  ListView1.items.Clear;
  DeviceList.DevicesRx.Clear;
  UpdateListView();
  UpdateNetDeviceKP('0x02 0x00 0x00 0x0d');
end;

procedure TSplitViewForm.Button6Click(Sender: TObject);
begin
  ListView1.items.Clear;
  ListView2.items.Clear;
  DeviceList.Clear;
  UpdateListView();
  // ListView1DblClick(nil);
end;

procedure TSplitViewForm.Button7Click(Sender: TObject);
begin
  Memo1.Clear;
end;

procedure TSplitViewForm.Button8Click(Sender: TObject);
begin
  ListView1.items.Clear;
  ListView2.items.Clear;
  DeviceList.Clear;
  UpdateListView();
  UpdateNetDeviceKP('0x00 x00 0x00');
end;

procedure TSplitViewForm.catMenuItemsCategories0Items0Click(Sender: TObject);
begin
  SynchroPage(0);
end;

procedure TSplitViewForm.catMenuItemsCategories0Items1Click(Sender: TObject);
begin
  SynchroPage(1);
end;

procedure TSplitViewForm.catMenuItemsCategories0Items2Click(Sender: TObject);
begin
  SynchroPage(2);
end;

procedure TSplitViewForm.catMenuItemsCategories0Items3Click(Sender: TObject);
begin
  SynchroPage(3);
end;

procedure TSplitViewForm.SynchroPage(ItemIndex: Integer);
begin
  Notebook1.PageIndex := ItemIndex;
end;

procedure TSplitViewForm.TabSet1Change(Sender: TObject; NewTab: Integer; var AllowChange: Boolean);
begin
  Notebook2.PageIndex := NewTab;
end;

procedure TSplitViewForm.Timer1Timer(Sender: TObject);
begin
  if DataEngineManager.Has(trim(ComboBox3.text) + ':' + trim(Edit5.text)) then
    Exit;
  // St(1, '');
end;

procedure TSplitViewForm.MessageTimerTimer(Sender: TObject);
var
  Msg: TMyMessage;
begin

  Msg := MQueue.get();
  if Msg <> nil then
  begin
    if Msg.ID = 200 then // TCP
    begin
      Memo1.Lines.Add(Msg.Msg);
    end;
    if Msg.ID = 100 then // UDP
    begin
      UpdateLocalDevices(TVDevice(Msg.obj));
    end;
  end;
end;

procedure TSplitViewForm.N1Click(Sender: TObject);
begin
  ListView1.viewStyle := vsIcon;
  ListView2.viewStyle := vsIcon;
  N4.Checked := false;
  N3.Checked := false;
  N2.Checked := false;
  N1.Checked := true;
end;

procedure TSplitViewForm.N2Click(Sender: TObject);
begin
  ListView1.viewStyle := vsSmallIcon;
  ListView2.viewStyle := vsSmallIcon;
  N2.Checked := true;
  N4.Checked := false;
  N3.Checked := false;
  N1.Checked := false;
end;

procedure TSplitViewForm.N3Click(Sender: TObject);
begin
  ListView1.viewStyle := vsList;
  ListView2.viewStyle := vsList;
  N3.Checked := true;
  N4.Checked := false;
  N2.Checked := false;
  N1.Checked := false;
end;

procedure TSplitViewForm.N4Click(Sender: TObject);
begin
  ListView1.viewStyle := vsReport;
  ListView2.viewStyle := vsReport;
  N4.Checked := true;
  N3.Checked := false;
  N2.Checked := false;
  N1.Checked := false;
end;

procedure TSplitViewForm.Timer3Timer(Sender: TObject);
begin
  Button4.Enabled := false;
  Button5.Enabled := false;
  Button8.Enabled := false;
  InitUDP_S_KP();
  UpdateNetDeviceKP('0x00 x00 0x00');
  Timer3.Enabled := false;
  Button4.Enabled := true;
  Button5.Enabled := true;
  Button8.Enabled := true;
end;

function TSplitViewForm.GetDevice(Name: String): TVDevice;
begin
  Result := DeviceList.get(Name);
end;

procedure TSplitViewForm.ListView1Click(Sender: TObject);
var
  ListItem: TListItem;
begin
  ListItem := ListView1.Selected;
  if ListItem = nil then
    Exit;
  srx := GetDevice(ListItem.Caption);

  if srx <> nil then
  begin
    Edit2.text := srx.Name;
    ComboBox3.text := srx.Ip;
  end;

  ListItem.Checked := true;
  CheckItems(ListView1, ListItem, false);
end;

procedure TSplitViewForm.ListView1ColumnClick(Sender: TObject; Column: TListColumn);
begin
  (Sender as TListView).CustomSort(nil, Column.Index);
  Sortf := not Sortf;
end;

procedure TSplitViewForm.ListView1Compare(Sender: TObject; Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
begin
  if Sortf then
  begin
    if Data = 0 then // ������������
      Compare := CompareStr(Item1.Caption, Item2.Caption)
    else // ������������
      Compare := CompareStr(Item1.subitems.Strings[Data - 1], Item2.subitems.Strings[Data - 1]);
  end
  else
  begin
    if Data = 0 then // ������������
      Compare := CompareStr(Item2.Caption, Item1.Caption)
    else // ������������
      Compare := CompareStr(Item2.subitems.Strings[Data - 1], Item1.subitems.Strings[Data - 1]);
  end;

end;

procedure TSplitViewForm.ListView1DblClick(Sender: TObject);
var
  ListItem: TListItem;
  dv: TVDevice;
begin
  ListItem := ListView1.Selected;
  if ListItem = nil then
    Exit;
  dv := GetDevice(ListItem.Caption);

  if (dv <> nil) then
  begin
    frmSetting.dv := dv;
    frmSetting.tcp := Self.GetTCPConnection(dv.Ip, 24);
    frmSetting.udp := Self.GetUDPConnection(trim(ComboBox1.text), 3334);
    if frmSetting.tcp <> nil then
    begin
      frmSetting.tcp.memo := Memo1;
      frmSetting.udp.memo := Memo1;
      frmSetting.TabSheet2.tabvisible := true;
      frmSetting.TabSheet3.tabvisible := true;
      frmSetting.TabSheet4.tabvisible := true;
      frmSetting.TabSheet5.tabvisible := true;
      frmSetting.TabSheet8.tabvisible := true;
      frmSetting.showmodal;
    end;
  end;
end;

procedure TSplitViewForm.ListView2Click(Sender: TObject);
var
  ListItem: TListItem;
begin
  ListItem := ListView2.Selected;
  if ListItem = nil then
    Exit;
  stx := GetDevice(ListItem.Caption);
  if stx <> nil then
  begin
    Edit1.text := stx.Name;
    ComboBox3.text := stx.Ip;
  end;

  ListItem.Checked := true;
  CheckItems(ListView2, ListItem, false);
end;

procedure TSplitViewForm.ListView2ColumnClick(Sender: TObject; Column: TListColumn);
begin
  (Sender as TListView).CustomSort(nil, Column.Index);
  Sortf := not Sortf;
end;

procedure TSplitViewForm.ListView2Compare(Sender: TObject; Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
begin
  if Sortf then
  begin
    if Data = 0 then // ������������
      Compare := CompareStr(Item1.Caption, Item2.Caption)
    else // ������������
      Compare := CompareStr(Item1.subitems.Strings[Data - 1], Item2.subitems.Strings[Data - 1]);
  end
  else
  begin
    if Data = 0 then // ������������
      Compare := CompareStr(Item2.Caption, Item1.Caption)
    else // ������������
      Compare := CompareStr(Item2.subitems.Strings[Data - 1], Item1.subitems.Strings[Data - 1]);
  end;

end;

procedure TSplitViewForm.ListView2DblClick(Sender: TObject);
var
  ListItem: TListItem;
  dv: TVDevice;
begin
  ListItem := ListView2.Selected;
  if ListItem = nil then
    Exit;
  dv := GetDevice(ListItem.Caption);

  if (dv <> nil) then
  begin
    frmSetting.dv := dv;
    frmSetting.tcp := Self.GetTCPConnection(dv.Ip, 24);
    if frmSetting.tcp <> nil then
    begin
      frmSetting.tcp.memo := Memo1;
      frmSetting.TabSheet2.tabvisible := false;
      frmSetting.TabSheet3.tabvisible := false;
      frmSetting.TabSheet4.tabvisible := false;
      frmSetting.TabSheet5.tabvisible := false;
      frmSetting.TabSheet8.tabvisible := true;
      frmSetting.showmodal;
    end;
  end;
end;

procedure TSplitViewForm.Log(const Msg: string);
begin
  if Memo1 <> nil then
  begin
    Memo1.Lines.Add(Msg);
    Memo1.Perform(WM_VSCROLL, SB_BOTTOM, 0);
  end;
end;

procedure TSplitViewForm.SpeedButton1Click(Sender: TObject);
begin
  // frmSetting.tcp := Self.GetTCPConnection(dv.Ip, 24);
  GSettingfrm.udp := Self.GetUDPConnection(trim(ComboBox1.text), 3334);
  if GSettingfrm.udp <> nil then
  begin
    // frmSetting.tcp.memo := Memo1;
    GSettingfrm.udp.memo := Memo1;
    GSettingfrm.showmodal;
  end;

end;

procedure TSplitViewForm.St(slot: Integer; Msg: String);
begin
  if StatusBar1 = nil then
    Exit;
  if Timer1 = nil then
    Exit;

  Timer1.Enabled := false;
  StatusBar1.Panels[slot].text := Msg;
  Timer1.Enabled := true;
end;

procedure TSplitViewForm.cbxVclStylesChange(Sender: TObject);

begin
  TStyleManager.SetStyle(cbxVclStyles.text);
end;

procedure TSplitViewForm.ComboBox2Change(Sender: TObject);
begin
  if ComboBox2.ItemIndex <= 1 then
  begin
    // InitUDP(trim(Combobox1.text),StrToInt(trim(Edit7.text)));
  end;
  if ComboBox2.ItemIndex = 2 then
  begin
    // InitTCP(ComboBox1.text, StrToInt(trim(Edit7.text)));
  end;

end;

procedure TSplitViewForm.ComboBox3KeyPress(Sender: TObject; var Key: Char);
begin
  If not(Key in ['0' .. '9', '.', #8]) then
  Begin
    Key := #0; // #0 ��ʾû������
  End;
end;

procedure TSplitViewForm.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    Edit2.SetFocus;
  If not(Key in ['0' .. '9', #8]) then
  Begin
    Key := #0; // #0 ��ʾû������
  End;
end;

procedure TSplitViewForm.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    Button1.SetFocus;
  If not(Key in ['0' .. '9', #8]) then
  Begin
    Key := #0; // #0 ��ʾû������
    // MessageBeep(MB_OK);
  End;
end;

procedure TSplitViewForm.Edit3KeyPress(Sender: TObject; var Key: Char);
begin
  If not(Key in ['0' .. '9', #8]) then
  Begin
    Key := #0; // #0 ��ʾû������
  End;
end;

procedure TSplitViewForm.Edit4KeyPress(Sender: TObject; var Key: Char);
begin
  If not(Key in ['0' .. '9', '.', #8]) then
  Begin
    Key := #0; // #0 ��ʾû������
  End;
end;

procedure TSplitViewForm.Edit5KeyPress(Sender: TObject; var Key: Char);
begin
  If not(Key in ['0' .. '9', #8]) then
  Begin
    Key := #0; // #0 ��ʾû������
  End;
end;

procedure TSplitViewForm.Edit6KeyPress(Sender: TObject; var Key: Char);
begin
  If not(Key in ['0' .. '9', #8]) then
  Begin
    Key := #0; // #0 ��ʾû������
  End;
end;

procedure TSplitViewForm.Edit7KeyPress(Sender: TObject; var Key: Char);
begin
  If not(Key in ['0' .. '9', #8]) then
  Begin
    Key := #0; // #0 ��ʾû������
  End;
end;

end.

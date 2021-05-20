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
  ueIPEdit, Vcl.Mask, IdGlobal, IdSocketHandle, VDeviceGroup, VDevice, Vcl.Tabs,
  IdAntiFreezeBase, IdAntiFreeze;

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
    IdUDPServer1: TIdUDPServer;
    IdTCPClient1: TIdTCPClient;
    Notebook2: TNotebook;
    cbxVclStyles: TComboBox;
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
    Label7: TLabel;
    Edit4: TEdit;
    Button2: TButton;
    Edit3: TEdit;
    Edit5: TEdit;
    Button5: TButton;
    Button4: TButton;
    StatusBar1: TStatusBar;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    IdAntiFreeze1: TIdAntiFreeze;

    procedure FormCreate(Sender: TObject);
    procedure cbxVclStylesChange(Sender: TObject);
    procedure catMenuItemsCategories0Items0Click(Sender: TObject);
    procedure catMenuItemsCategories0Items1Click(Sender: TObject);
    procedure catMenuItemsCategories0Items2Click(Sender: TObject);
    procedure catMenuItemsCategories0Items3Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure FormResize(Sender: TObject);

    procedure IdUDPServer1UDPRead(AThread: TIdUDPListenerThread;
      const AData: TIdBytes; ABinding: TIdSocketHandle);
    procedure ListView2Click(Sender: TObject);
    procedure ListView1Click(Sender: TObject);
    procedure TabSet1Change(Sender: TObject; NewTab: Integer;
      var AllowChange: Boolean);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure IdTCPClient1Disconnected(Sender: TObject);
    procedure IdTCPClient1Connected(Sender: TObject);
    procedure IdTCPClient1Status(ASender: TObject; const AStatus: TIdStatus;
      const AStatusText: string);
    procedure Edit7KeyPress(Sender: TObject; var Key: Char);
    procedure Edit6KeyPress(Sender: TObject; var Key: Char);
  private
    procedure Log(const Msg: string);
    procedure SynchroPage(ItemIndex: Integer);
    procedure UpdateListView();
    procedure UpdateNetDeviceKP(Cmd: String);
    procedure UpdateLocalDevices(dv: TVDevice);
  public
    DeviceList: TVDeviceGroup;
  end;

var
  SplitViewForm: TSplitViewForm;

implementation

uses
  Vcl.Themes, GlobalConst, GlobalFunctions, Unit200,IP;

{$R *.dfm}

procedure TSplitViewForm.FormCreate(Sender: TObject);
var
  StyleName: string;
  S: string;
  sl:TStringList;
begin
  //sl:=TStringList.Create;
  for StyleName in TStyleManager.StyleNames do
    cbxVclStyles.Items.Add(StyleName);
  cbxVclStyles.ItemIndex := cbxVclStyles.Items.IndexOf
    (TStyleManager.ActiveStyle.Name);

  GetBuildInfo(Application.ExeName, S);

  Caption := APPLICATION_TITLE_NAME + ' v' + S + ' - ' +
{$IFDEF CPUX64}'64'{$ELSE}'32'{$ENDIF} + ' bit';

  SynchroPage(0);
  TabSet1.Tabs := Notebook2.Pages;
  /// ///////////////////////////////////////////////////////////////////////////
  DeviceList := TVDeviceGroup.Create('');

  Edit6.text:= _GetComputerName();

  sl:= GetIPList();
  ComboBox1.Items.AddStrings(sl);
  if sl.Count >0 then
  ComboBox1.ItemIndex:=0;

  /// ///////////////////////////////////////////////////////////////////////////
  sl.Free;
end;

procedure TSplitViewForm.FormResize(Sender: TObject);
begin
  ListView1.width := Panel1.width div 2;
end;

procedure TSplitViewForm.IdTCPClient1Connected(Sender: TObject);
begin
   StatusBar1.Panels[0].text :='TCP 连接';
end;

procedure TSplitViewForm.IdTCPClient1Disconnected(Sender: TObject);
begin
    StatusBar1.Panels[0].text :='TCP 连接已经断开';
end;

procedure TSplitViewForm.IdTCPClient1Status(ASender: TObject;
  const AStatus: TIdStatus; const AStatusText: string);
begin
    StatusBar1.Panels[0].text :='TCP:'+AStatusText;
end;

procedure TSplitViewForm.IdUDPServer1UDPRead(AThread: TIdUDPListenerThread;
  const AData: TIdBytes; ABinding: TIdSocketHandle);
var
  sl: TStringList;
  dv: TVDevice;
begin
  sl := TStringList.Create;
  Memo1.Lines.Add(GetSystemDateTimeStr() + ' 接收到数据来自：' + ABinding.PeerIP + ':' +
    IntToStr(ABinding.PeerPort) + ':' + IntToStr(AThread.ThreadID));

  FormatBuff(AData, sl, 16);
  Memo1.Lines.AddStrings(sl);
  sl.Clear;
  sl.Free;

  UpdateLocalDevices(TVDevice.Create(ABinding.PeerIP,
    IntToStr(ABinding.PeerPort), AData));
end;

procedure TSplitViewForm.UpdateLocalDevices(dv: TVDevice);
begin
  DeviceList.Add(dv.Name, dv);
  UpdateListView();
end;

procedure TSplitViewForm.UpdateListView();
var
  ListItem: TListItem;
  i, J, k: Integer;
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
        J := ListView2.Items.count + 1;
        ListItem := Items.Add;
        ListItem.Caption := IntToStr(J);
        ListItem.subitems.Add(dv.Name);
        ListItem.subitems.Add(dv.ID);
        ListItem.subitems.Add(dv.IP);
        ListItem.subitems.Add(dv.port);
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
        J := ListView1.Items.count + 1;
        ListItem := Items.Add;
        ListItem.Caption := IntToStr(J);
        ListItem.subitems.Add(dv.Name);
        ListItem.subitems.Add(dv.ID);
        ListItem.subitems.Add(dv.IP);
        ListItem.subitems.Add(dv.port);
        ListItem.subitems.Add(dv.MAC);
        ListItem.subitems.Add(dv.typee);
        ListItem.subitems.Add(dv.St);
        dv.b := true;
      end;
    end;
  end;

Lend:
  StatusBar1.Panels[0].text := 'Rx : ' + IntToStr(DeviceList.DevicesRx.count) +
    '    Tx : ' + IntToStr(DeviceList.DevicesTx.count)
end;
procedure TSplitViewForm.UpdateNetDeviceKP(Cmd: String);
var
  IP, str1, str2: String;
  buf: TIdBytes;
  port: Integer;
  count: Integer;
begin
  IP := '225.1.0.0';
  port := 3333;
  str1 := FormatHexStr(trim(Cmd), count);
  SetLength(buf, count);
  str2 := HexStrToBuff(str1, buf, count);
  Log('发送UDP IP:' + IP + ':' + IntToStr(port) + ' --> ' + str2);

  IdUDPServer1.SendBuffer(IP, port, buf);
end;

procedure TSplitViewForm.Button2Click(Sender: TObject);
begin
  UpdateNetDeviceKP(Edit3.text);
end;

procedure TSplitViewForm.Button3Click(Sender: TObject);
var
   sl:TStringList;
begin
   Memo1.Lines.add(_GetComputerName());
   sl:= GetIPList();
   Memo1.Lines.AddStrings(sl);
   sl.Free;
end;

procedure TSplitViewForm.Button4Click(Sender: TObject);
begin
  ListView2.Items.Clear;
  DeviceList.devicesTx.Clear;
  UpdateListView();
  UpdateNetDeviceKP('0x01 0x00 0x00 0x0d');
end;

procedure TSplitViewForm.Button5Click(Sender: TObject);
begin
  ListView1.Items.Clear;
  DeviceList.devicesRx.Clear;
  UpdateListView();
  UpdateNetDeviceKP('0x02 0x00 0x00 0x0d');
end;

procedure TSplitViewForm.Button6Click(Sender: TObject);
begin
  ListView1.Items.Clear;
  ListView2.Items.Clear;
  DeviceList.Clear;
  UpdateListView();
end;

procedure TSplitViewForm.Button7Click(Sender: TObject);
begin
  Memo1.Clear;
end;

procedure TSplitViewForm.Button8Click(Sender: TObject);
begin
  ListView1.Items.Clear;
  ListView2.Items.Clear;
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

procedure TSplitViewForm.TabSet1Change(Sender: TObject; NewTab: Integer;
  var AllowChange: Boolean);
begin
  Notebook2.PageIndex := NewTab;
end;

procedure TSplitViewForm.ListView1Click(Sender: TObject);
var
  ListItem: TListItem;
  nanme: String;
  ID: String;
begin
  ListItem := ListView1.Selected;
  if ListItem = nil then
    Exit;
  nanme := ListItem.subitems.strings[1];
  ID := ListItem.subitems.strings[1];
  Edit2.text := ID;
end;

procedure TSplitViewForm.ListView2Click(Sender: TObject);
var
  ListItem: TListItem;
  nanme: String;
  ID: String;
begin
  ListItem := ListView2.Selected;
  if ListItem = nil then
    Exit;
  nanme := ListItem.subitems.strings[1];
  ID := ListItem.subitems.strings[1];
  Edit1.text := ID;
end;

procedure TSplitViewForm.Log(const Msg: string);
begin
  Memo1.Lines.Add(Msg);
end;

procedure TSplitViewForm.cbxVclStylesChange(Sender: TObject);
begin
  TStyleManager.SetStyle(cbxVclStyles.text);
end;

procedure TSplitViewForm.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    Edit2.SetFocus;
  If not(Key in ['0' .. '9', #8]) then
  Begin
    Key := #0; // #0 表示没有输入
  End;
end;

procedure TSplitViewForm.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    Button1.SetFocus;
  If not(Key in ['0' .. '9', #8]) then
  Begin
    Key := #0; // #0 表示没有输入
    // MessageBeep(MB_OK);
  End;
end;procedure TSplitViewForm.Edit6KeyPress(Sender: TObject; var Key: Char);
begin
  If not(Key in ['0' .. '9', #8]) then
  Begin
    Key := #0; // #0 表示没有输入
  End;
end;

procedure TSplitViewForm.Edit7KeyPress(Sender: TObject; var Key: Char);
begin
  If not(Key in ['0' .. '9', #8]) then
  Begin
    Key := #0; // #0 表示没有输入
  End;
end;

end.

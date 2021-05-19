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
  ueIPEdit, Vcl.Mask, IdGlobal, IdSocketHandle, VDeviceGroup, VDevice;

type
  TSplitViewForm = class(TForm)
    SV: TSplitView;
    Notebook1: TNotebook;
    Timer1: TTimer;
    Panel1: TPanel;
    Splitter1: TSplitter;
    ListView1: TListView;
    Panel3: TPanel;
    Memo1: TMemo;
    ListView2: TListView;
    cbxVclStyles: TComboBox;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    IdUDPServer1: TIdUDPServer;
    IdTCPClient1: TIdTCPClient;
    GroupBox2: TGroupBox;
    Button2: TButton;
    Label3: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    Button3: TButton;
    Button4: TButton;

    procedure FormCreate(Sender: TObject);
    procedure imgMenuClick(Sender: TObject);
    procedure cbxVclStylesChange(Sender: TObject);
    procedure catMenuItemsCategories0Items0Click(Sender: TObject);
    procedure catMenuItemsCategories0Items1Click(Sender: TObject);
    procedure catMenuItemsCategories0Items2Click(Sender: TObject);
    procedure catMenuItemsCategories0Items3Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure FormResize(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure IdUDPServer1UDPRead(AThread: TIdUDPListenerThread;
      const AData: TIdBytes; ABinding: TIdSocketHandle);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    procedure Log(const Msg: string);
    procedure SynchroPage(ItemIndex: Integer);
    procedure UpdateListView();

  public
    DeviceList: TVDeviceGroup;
  end;

var
  SplitViewForm: TSplitViewForm;

implementation

uses
  Vcl.Themes, GlobalConst, GlobalFunctions, Unit200;

{$R *.dfm}

procedure TSplitViewForm.FormCreate(Sender: TObject);
var
  StyleName: string;
  S: string;
begin
  for StyleName in TStyleManager.StyleNames do
    cbxVclStyles.Items.Add(StyleName);
  cbxVclStyles.ItemIndex := cbxVclStyles.Items.IndexOf
    (TStyleManager.ActiveStyle.Name);

  GetBuildInfo(Application.ExeName, S);

  Caption := APPLICATION_TITLE_NAME + ' v' + S + ' - ' +
{$IFDEF CPUX64}'64'{$ELSE}'32'{$ENDIF} + ' bit';

  SynchroPage(0);

  /// ///////////////////////////////////////////////////////////////////////////
  DeviceList := TVDeviceGroup.Create('');
end;

procedure TSplitViewForm.FormResize(Sender: TObject);
begin
  ListView1.width := Panel1.width div 2;
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
  // Memo1.Lines.Add(IdBytesToAnsiString((AData)));
  FormatBuff(AData, sl, 16);
  Memo1.Lines.AddStrings(sl);

  dv := TVDevice.Create();
  dv.port := IntToStr(ABinding.PeerPort);
  dv.SetBuffer(AData);
  DeviceList.Devices.addObject(dv.Name, dv);
  UpdateListView();
end;

procedure TSplitViewForm.UpdateListView();
var
  ListItem: TListItem;
  i: Integer;
  dv: TVDevice;
begin
  if DeviceList.Devices.count <= 0 then
    Exit;
  for i := 0 to DeviceList.Devices.count - 1 do
  begin
    dv := TVDevice(DeviceList.Devices.Objects[i]);
    if dv.typee = 'Tx' then
    begin

      with ListView2 do
      begin
        ListItem := Items.Add;
        ListItem.Caption := dv.Name;;
        ListItem.subitems.Add(dv.ID);
        ListItem.subitems.Add(dv.IP);
        ListItem.subitems.Add(dv.port);
        ListItem.subitems.Add(dv.MAC);
        ListItem.subitems.Add(dv.typee);
        ListItem.subitems.Add(dv.St);
      end;
    end;
    if dv.typee = 'Rx' then
    begin
      with ListView1 do
      begin
        ListItem := Items.Add;
        ListItem.Caption := dv.Name;;
        ListItem.subitems.Add(dv.ID);
        ListItem.subitems.Add(dv.IP);
        ListItem.subitems.Add(dv.port);
        ListItem.subitems.Add(dv.MAC);
        ListItem.subitems.Add(dv.typee);
        ListItem.subitems.Add(dv.St);
      end;
      // ListView1.update;
    end;
  end;

end;

procedure TSplitViewForm.cbxVclStylesChange(Sender: TObject);
begin
  TStyleManager.SetStyle(cbxVclStyles.Text);
end;

procedure TSplitViewForm.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    Edit2.SetFocus;
  If not(Key in ['0' .. '9', #8]) then
  Begin
    Key := #0; // #0 表示没有输入
    // MessageBeep(MB_OK);
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
end;

procedure TSplitViewForm.imgMenuClick(Sender: TObject);
begin
  if SV.Opened then
    SV.Close
  else
    SV.Open;
end;

procedure TSplitViewForm.Button2Click(Sender: TObject);
var
  IP, str: String;
  buf: TIdBytes;
begin
  IP := Edit4.Text;
  SetLength(buf, 4);
  str := FormatHexStrToByte(trim(Edit3.Text), buf);
  IdUDPServer1.SendBuffer(IP, 3333, buf);
end;

procedure TSplitViewForm.Button3Click(Sender: TObject);
begin
  UpdateListView();
end;

procedure TSplitViewForm.Button4Click(Sender: TObject);
var
  ListItem: TListItem;
  i: Integer;
begin
  i := ListView1.Items.count;
  with ListView1 do
  begin
    ListItem := Items.Add;
    ListItem.Caption := IntToStr(i);
    ListItem.subitems.Add('第 ' + IntToStr(i) + ' 行');
    ListItem.subitems.Add('第三列内容');
  end;
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

procedure TSplitViewForm.Timer1Timer(Sender: TObject);
var
  str: String;
begin
  // str:=GetSystemDateTimeStr();
  // statusbar1.panels[0].text:=str;
end;

procedure TSplitViewForm.Log(const Msg: string);
begin

end;

end.

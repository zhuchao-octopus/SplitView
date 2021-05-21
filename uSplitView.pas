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
  IdAntiFreezeBase, IdAntiFreeze, DataEngine, ClientObject;

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
    Edit5: TEdit;
    Button5: TButton;
    Button4: TButton;
    StatusBar1: TStatusBar;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    IdAntiFreeze1: TIdAntiFreeze;
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

  public
    // InitFlag:Boolean;
  end;

var
  SplitViewForm: TSplitViewForm;

implementation

uses
  Vcl.Themes, GlobalConst, GlobalFunctions, Unit200, Ip, MyMessageQueue,trash;

{$R *.dfm}

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
      St(1, '初始化UDP ' + e.tostring);
      Exit;
    end;

  end;
  Result := ClientObject;
end;

function TSplitViewForm.GetTCPConnection(Ip: String; Port: Integer): TClientObject;
var
  ClientObject: TClientObject;
begin

  Result := TClientObject(DataEngineManager.get(Ip + ':' + IntToStr(Port)));
  if Result <> nil then
  begin
    DataEngineManager.DoIt(ClientObject.Execute);
    Exit;
  end;

  try
    ClientObject := TClientObject.Create(False);
    IdTCPClient1.Host := Ip;
    IdTCPClient1.Port := Port;
    ClientObject.AssignTCPClient(IdTCPClient1);
    ClientObject.Client.tag := Integer(Pointer(TClientObject(ClientObject)));
    DataEngineManager.Add(Ip + ':' + IntToStr(Port), ClientObject);
    DataEngineManager.DoIt(ClientObject.Execute);
  Except
    on e: Exception do
    begin
      St(1, '初始化TCP ' + e.tostring);
      Exit;
    end;

  end;
  Result := ClientObject;
end;

procedure TSplitViewForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if IdTCPClient1.connected then
    IdTCPClient1.Disconnect;
end;

procedure TSplitViewForm.FormCreate(Sender: TObject);
var
  StyleName: string;
  S: string;
begin
  for StyleName in TStyleManager.StyleNames do
    cbxVclStyles.Items.Add(StyleName);
  cbxVclStyles.ItemIndex := cbxVclStyles.Items.IndexOf(TStyleManager.ActiveStyle.Name);

  GetBuildInfo(Application.ExeName, S);

  Caption := APPLICATION_TITLE_NAME + ' v' + S + ' - ' +
{$IFDEF CPUX64}'64'{$ELSE}'32'{$ENDIF} + ' bit';

  SynchroPage(0);
  TabSet1.Tabs := Notebook2.Pages;
  /// ///////////////////////////////////////////////////////////////////////////

  Edit6.text := _GetComputerName();
  LocalIPList := GetIPList();
  ComboBox1.Items.AddStrings(LocalIPList);
  if LocalIPList.count >= 0 then
    ComboBox1.ItemIndex := 0;


  /// ///////////////////////////////////////////////////////////////////////////
  // DataEngineManager.doIt(initUI);
  Timer3.Enabled := true;
end;

procedure TSplitViewForm.FormResize(Sender: TObject);
begin
  ListView1.width := Panel1.width div 2;
end;

procedure TSplitViewForm.IdTCPClient1Connected(Sender: TObject);
var
  tcp: TClientObject;
  str: String;
begin
  tcp := Pointer(TIdTCPClient(Sender).tag);
  str := tcp.Client.Host + ':' + IntToStr(tcp.Client.Port);
  // ComboBox3.items.Add(str);
  St(1, 'TCP 连接成功 --> ' + str);
end;

procedure TSplitViewForm.IdTCPClient1Disconnected(Sender: TObject);
var
  tcp: TClientObject;
begin
  tcp := Pointer(TIdTCPClient(Sender).tag);
  St(1, 'TCP 连接断开' + tcp.Client.Host + ':' + IntToStr(tcp.Client.Port));
end;

procedure TSplitViewForm.IdTCPClient1Status(ASender: TObject; const AStatus: TIdStatus; const AStatusText: string);
begin
  Log('TCP Status:' + AStatusText);
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
        J := ListView1.Items.count + 1;
        ListItem := Items.Add;
        ListItem.Caption := IntToStr(J);
        ListItem.subitems.Add(dv.Name);
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
  tcp: TClientObject;
begin
  if ComboBox2.ItemIndex <= 1 then
  begin
    //InitUDP(trim(ComboBox1.text), StrToInt(trim(Edit7.text)));
  end;
  if ComboBox2.ItemIndex > 1 then
  begin
    tcp := GetTCPConnection(trim(ComboBox3.text), StrToInt(trim(Edit5.text)));
  end;
end;

procedure TSplitViewForm.Button2Click(Sender: TObject);
var
  tcp: TClientObject;
  udp: TClientObject;
begin
  if ComboBox2.ItemIndex <= 1 then
  begin
    udp := GetTCPConnection(trim(ComboBox1.text), StrToInt(trim(Edit7.text)));
    udp.UDPSendHexStr(ComboBox3.text, StrToInt(trim(Edit5.text)), Memo2.text);
    // UDPSendData(trim(ComboBox1.text), StrToInt(trim(Edit7.text)),
    // ComboBox3.text, StrToInt(trim(Edit5.text)), Memo2.text);
  end;
  if ComboBox2.ItemIndex > 1 then
  begin
    tcp := GetTCPConnection(trim(ComboBox3.text), StrToInt(trim(Edit5.text)));
    if tcp = nil then
    begin
      Log('没有建立可用的连接！！');
      Exit;
    end;

    if tcp.Client.connected then
    begin
      Log('TCP发送IP:' + tcp.Client.Socket.Binding.Ip + ':' + IntToStr(tcp.Client.Socket.Binding.Port) + ' --> ' + tcp.Client.Host + ':' + IntToStr(tcp.Client.Port));
      Log(Memo2.text);
      try
        tcp.Client.IOHandler.WriteLn(Memo2.text);
      Except
        on e: Exception do
        begin
          Log(e.tostring);
        end;
      end;
    end
    else
    begin
      // Log('没有建立可用的连接！！');
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
  ListView2.Items.Clear;
  DeviceList.DevicesTx.Clear;
  UpdateListView();
  UpdateNetDeviceKP('0x01 0x00 0x00 0x0d');
end;

procedure TSplitViewForm.Button5Click(Sender: TObject);
begin

  ListView1.Items.Clear;
  DeviceList.DevicesRx.Clear;
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

procedure TSplitViewForm.TabSet1Change(Sender: TObject; NewTab: Integer; var AllowChange: Boolean);
begin
  Notebook2.PageIndex := NewTab;
end;

procedure TSplitViewForm.Timer1Timer(Sender: TObject);
begin
  if DataEngineManager.Has(trim(ComboBox3.text) + trim(Edit5.text)) then
    Exit;
  St(1, '没有TCP连接');
end;

procedure TSplitViewForm.MessageTimerTimer(Sender: TObject);
var
  Msg: TMyMessage;
begin

  Msg := MQueue.get();
  if Msg <> nil then
  begin
    if Msg.ID = 200 then //TCP
    begin
      Memo1.Lines.Add(Msg.Msg);
    end;
    if Msg.ID = 100 then //UDP
    begin
      UpdateLocalDevices(TVDevice(Msg.obj));
    end;
  end;
end;

procedure TSplitViewForm.Timer3Timer(Sender: TObject);
begin
  Button4.Enabled := False;
  Button5.Enabled := False;
  Button8.Enabled := False;
  InitUDP_S_KP();
  UpdateNetDeviceKP('0x00 x00 0x00');
  Timer3.Enabled := False;
  Button4.Enabled := true;
  Button5.Enabled := true;
  Button8.Enabled := true;
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
  nanme := ListItem.subitems.Strings[1];
  ID := ListItem.subitems.Strings[1];
  Edit2.text := ID;
  ComboBox3.text := ListItem.subitems.Strings[2];
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
  nanme := ListItem.subitems.Strings[1];
  ID := ListItem.subitems.Strings[1];
  Edit1.text := ID;
  ComboBox3.text := ListItem.subitems.Strings[2];
end;

procedure TSplitViewForm.Log(const Msg: string);
begin
  Memo1.Lines.Add(Msg);
end;

procedure TSplitViewForm.St(slot: Integer; Msg: String);
begin
  Timer1.Enabled := False;
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
    Key := #0; // #0 表示没有输入
  End;
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
end;

procedure TSplitViewForm.Edit3KeyPress(Sender: TObject; var Key: Char);
begin
  If not(Key in ['0' .. '9', #8]) then
  Begin
    Key := #0; // #0 表示没有输入
  End;
end;

procedure TSplitViewForm.Edit4KeyPress(Sender: TObject; var Key: Char);
begin
  If not(Key in ['0' .. '9', '.', #8]) then
  Begin
    Key := #0; // #0 表示没有输入
  End;
end;

procedure TSplitViewForm.Edit5KeyPress(Sender: TObject; var Key: Char);
begin
  If not(Key in ['0' .. '9', #8]) then
  Begin
    Key := #0; // #0 表示没有输入
  End;
end;

procedure TSplitViewForm.Edit6KeyPress(Sender: TObject; var Key: Char);
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

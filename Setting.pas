unit Setting;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, VDevice,
  ClientObject, ip, Vcl.Samples.Spin, Vcl.Grids, VDeviceGroup;

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
    Label6: TLabel;
    GroupBox3: TGroupBox;
    Label7: TLabel;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    Button16: TButton;
    GroupBox4: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    SpinEdit3: TSpinEdit;
    SpinEdit4: TSpinEdit;
    Button17: TButton;
    GroupBox5: TGroupBox;
    StringGrid1: TStringGrid;
    Button19: TButton;
    Label12: TLabel;
    Edit6: TEdit;
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
    procedure Button16Click(Sender: TObject);
    procedure Button19Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
  private
    // FStr:String;
    { Private declarations }
    procedure TCPReadData(const data: String; id: Integer);
    procedure UpdateRxZx(ListView: TListView; b: Byte; ZXId: Integer);
    procedure UpdateTxZx(ListView: TListView; b: Byte; ZXId: Integer);
    function GetZX(ListView: TListView; var buf: array of Byte; offset: Integer): Integer;
    procedure SaveToFile(ListView: TListView; fileName: String);
    procedure LoadTXNameFromFile(ListView: TListView; fileName: String);
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

uses ObjManager, GlobalFunctions, Unit200;
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

procedure TfrmSetting.ListView1DblClick(Sender: TObject);
var
  ListItem: TListItem;
  Name: String;
  str: String;
begin
  ListItem := ListView1.Selected;
  if ListItem = nil then
    Exit;
  Name := inputbox('设备名称修改', '请输入名称：', '主机');

  if Length(name) > 12 then
  begin
    Showmessage('名字过长，最好不要超过6个汉字的长度！！！');
    Exit;
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
    Exit;
  Name := inputbox('设备名称修改', '请输入名称：', '主机');

  if Length(name) > 12 then
  begin
    Showmessage('名字过长，最好不要超过6个汉字的长度！！！');
    Exit;
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
    Exit;
  Name := inputbox('设备名称修改', '请输入名称：', '主机');

  if Length(name) > 12 then
  begin
    Showmessage('名字过长，最好不要超过6个汉字的长度！！！');
    Exit;
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
    Exit;
  Name := inputbox('设备名称修改', '请输入名称：', '主机');

  if Length(name) > 12 then
  begin
    Showmessage('名字过长，最好不要超过6个汉字的长度！！！');
    Exit;
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
    Exit;
  Name := inputbox('设备名称修改', '请输入名称：', '主机');

  if Length(name) > 12 then
  begin
    Showmessage('名字过长，最好不要超过6个汉字的长度！！！');
    Exit;
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
    Exit;
  Name := inputbox('设备名称修改', '请输入名称：', '主机');

  if Length(name) > 12 then
  begin
    Showmessage('名字过长，最好不要超过6个汉字的长度！！！');
    Exit;
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
    Exit;
  Name := inputbox('设备名称修改', '请输入名称：', '主机');

  if Length(name) > 12 then
  begin
    Showmessage('名字过长，最好不要超过6个汉字的长度！！！');
    Exit;
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
    Exit;
  Name := inputbox('设备名称修改', '请输入名称：', '主机');

  if Length(name) > 12 then
  begin
    Showmessage('名字过长，最好不要超过6个汉字的长度！！！');
    Exit;
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
    Exit;
  Name := inputbox('设备名称修改', '请输入名称：', '主机');

  if Length(name) > 12 then
  begin
    Showmessage('名字过长，最好不要超过6个汉字的长度！！！');
    Exit;
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

procedure TfrmSetting.Button16Click(Sender: TObject);
var
  buff: array [0 .. 2] of Byte;
begin
  buff[0] := $Fc;
  buff[1] := StrToInt(dv.id);
  buff[2] := SpinEdit1.Value shl 4 + SpinEdit2.Value;
  // Log('UDP:' + IntToStr(buff[0]) + ' RX:' + IntToStr(buff[1]) + ' TX:' + IntToStr(buff[2]));

  if udp <> nil then
  begin
    udp.UDPSendHexStr('225.1.0.0', 3333, BuffToHexStr(buff));
  end;

end;

procedure TfrmSetting.Button17Click(Sender: TObject);
var
  buff: array [0 .. 2] of Byte;
begin
  buff[0] := $FD;
  buff[1] := StrToInt(dv.id);
  buff[2] := SpinEdit3.Value shl 4 + SpinEdit4.Value;
  // Log('UDP:' + IntToStr(buff[0]) + ' RX:' + IntToStr(buff[1]) + ' TX:' + IntToStr(buff[2]));

  if udp <> nil then
  begin
    udp.UDPSendHexStr('225.1.0.0', 3333, BuffToHexStr(buff));
  end;

end;

procedure TfrmSetting.Button19Click(Sender: TObject);
var
  i, j, x, y: Integer;
  str: String;
  ldv: TVDevice;

begin
  // dv.x:=0;
  // dv.y:=0;
  str := ''; // dv.MAC+','+IntToStr(dv.x)+','+IntToStr(y);
  x := 0;
  y := 0;
  for i := 1 to StringGrid1.RowCount do
  begin
    for j := 1 to StringGrid1.ColCount do
    begin
      if Trim(StringGrid1.Cells[j, i]) = dv.id then
      begin
        x := i;
        y := j;
        break;
      end;
    end;
  end;

  if (x = 0) or (y = 0) then
  begin
    Showmessage('没有找到当前坐席的位置！！！');
    Exit;
  end;

  for i := 1 to StringGrid1.RowCount do
  begin
    for j := 1 to StringGrid1.ColCount do
    begin
      ldv := DeviceList.get(Trim(StringGrid1.Cells[j, i]));
      if ldv <> nil then
      begin
        if str <> '' then
          str := str + ':';
        str := str + ldv.MAC + ',' + IntToStr(i - x) + ',' + IntToStr(j - y);
      end;
    end;
  end;

  if (str <> '') and (udp <> nil) then
  begin
    udp.UDPSendHexStr('225.1.0.0', 3333, str);
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
      Exit;
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

procedure TfrmSetting.Button5Click(Sender: TObject);
var
  buff: array of Byte;
  str: string;

  lList: TStrings;
  i, n: Integer;
begin
  // SaveToFile(ListView1, ExtractFilePath(Application.Exename) + '\' + 'txName.dat');
  SetLength(buff, 12);
  n := GetZX(Self.ListView1, buff, 11);
  n := n + GetZX(Self.ListView2, buff, 7);
  n := n + GetZX(Self.ListView3, buff, 3);

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

    lList.SaveToFile(ExtractFilePath(Application.Exename) + '\' + 'txName.dat');
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
  n := GetZX(Self.ListView4, buff, 11);
  n := n + GetZX(Self.ListView5, buff, 7);
  n := n + GetZX(Self.ListView6, buff, 3);

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

    lList.SaveToFile(ExtractFilePath(Application.Exename) + '\' + 'rxName.dat');
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
  n := GetZX(Self.ListView7, buff, 11);
  n := n + GetZX(Self.ListView8, buff, 7);
  n := n + GetZX(Self.ListView9, buff, 3);

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

    lList.SaveToFile(ExtractFilePath(Application.Exename) + '\' + 'rxName.dat');
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

function ReverseWord(w: word): word;
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
    Exit;
  SL := TStringList.Create;
  // if (id = 100) or (id = 0) then // astparam g pullperm
  // begin
  // end;
  if (id = -1) then
  begin
    str := StringReplace(data, '/', '', [rfReplaceAll]);
    str := StringReplace(str, '#', '', [rfReplaceAll]);
    str := Trim(str);
    if pos('astparam g pullperm', str) > 0 then
    begin
      s := copy(str, pos('astparam g pullperm', str), Length(str));
      ExtractStrings([' '], [' '], PChar(s), SL);
      if SL.Count < 4 then
        Exit;

      str := LowerCase(SL[3]);
      bc := Length(str) div 2;
      SetLength(buf, bc);
      i := HexToBin(PChar(str), @buf[0], bc);
      if i <> bc then
        Exit;

      // MakeWord($CC,$DD),
      // ReverseWord(buf[0]); ReverseWord(buf[1]);ReverseWord(buf[2]);ReverseWord(buf[3]);
      ListView1.Clear;
      UpdateTxZx(Self.ListView1, buf[0], 1);
      UpdateTxZx(Self.ListView1, buf[1], 9);
      UpdateTxZx(Self.ListView1, buf[2], 17);
      UpdateTxZx(Self.ListView1, buf[3], 25);
      ListView2.Clear;
      UpdateTxZx(Self.ListView2, buf[4], 33);
      UpdateTxZx(Self.ListView2, buf[5], 41);
      UpdateTxZx(Self.ListView2, buf[6], 49);
      UpdateTxZx(Self.ListView2, buf[7], 57);
      ListView3.Clear;
      UpdateTxZx(Self.ListView3, buf[8], 65);
      UpdateTxZx(Self.ListView3, buf[9], 73);
      UpdateTxZx(Self.ListView3, buf[10], 81);
      UpdateTxZx(Self.ListView3, buf[11], 89);
      // ShowMessage(SL.Text);
      dv.TxPull := str;
      SL.Free;
    end;
    if pos('astparam g pushperm', str) > 0 then
    begin
      delete(str, 1, pos('astparam g pushperm', str) - 1);
      ExtractStrings([' '], [' '], PChar(str), SL);
      if SL.Count < 4 then
        Exit;

      str := LowerCase(SL[3]);
      bc := Length(str) div 2;
      SetLength(buf, bc);
      i := HexToBin(PChar(str), @buf[0], bc);
      if i <> bc then
        Exit;

      ListView4.Clear;
      UpdateRxZx(Self.ListView4, buf[0], 1);
      UpdateRxZx(Self.ListView4, buf[1], 9);
      UpdateRxZx(Self.ListView4, buf[2], 17);
      UpdateRxZx(Self.ListView4, buf[3], 25);

      ListView5.Clear;
      UpdateRxZx(Self.ListView5, buf[4], 33);
      UpdateRxZx(Self.ListView5, buf[5], 41);
      UpdateRxZx(Self.ListView5, buf[6], 49);
      UpdateRxZx(Self.ListView5, buf[7], 57);

      ListView6.Clear;
      UpdateRxZx(Self.ListView6, buf[8], 65);
      UpdateRxZx(Self.ListView6, buf[9], 73);
      UpdateRxZx(Self.ListView6, buf[10], 81);
      UpdateRxZx(Self.ListView6, buf[11], 89);
      // ShowMessage(SL.Text);
      dv.Rxpush := str;
      SL.Free;
    end;

    if pos('astparam g getperm', str) > 0 then
    begin
      delete(str, 1, pos('astparam g getperm', str) - 1);
      ExtractStrings([' '], [' '], PChar(str), SL);
      if SL.Count < 4 then
        Exit;

      str := LowerCase(SL[3]);
      bc := Length(str) div 2;
      SetLength(buf, bc);
      i := HexToBin(PChar(str), @buf[0], bc);
      if i <> bc then
        Exit;

      ListView7.Clear;
      UpdateRxZx(Self.ListView7, buf[0], 1);
      UpdateRxZx(Self.ListView7, buf[1], 9);
      UpdateRxZx(Self.ListView7, buf[2], 17);
      UpdateRxZx(Self.ListView7, buf[3], 25);

      ListView8.Clear;
      UpdateRxZx(Self.ListView8, buf[4], 33);
      UpdateRxZx(Self.ListView8, buf[5], 41);
      UpdateRxZx(Self.ListView8, buf[6], 49);
      UpdateRxZx(Self.ListView8, buf[7], 57);

      ListView9.Clear;
      UpdateRxZx(Self.ListView9, buf[8], 65);
      UpdateRxZx(Self.ListView9, buf[9], 73);
      UpdateRxZx(Self.ListView9, buf[10], 81);
      UpdateRxZx(Self.ListView9, buf[11], 89);
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
end;

procedure TfrmSetting.FormCreate(Sender: TObject);
var
  fileName: String;
  i: Integer;
begin
  fileName := ExtractFilePath(Application.Exename) + '\' + 'txName.dat';
  TxName := TStringList.Create;
  RxName := TStringList.Create;
  if FileExists(fileName) then
    TxName.LoadFromFile(fileName);
  fileName := ExtractFilePath(Application.Exename) + '\' + 'rxName.dat';
  if FileExists(fileName) then
    RxName.LoadFromFile(fileName);

  StringGrid1.ColWidths[0] := 25;
  for i := 1 to StringGrid1.RowCount do
  begin
    StringGrid1.Cells[0, i] := IntToStr(i);
  end;
  for i := 1 to StringGrid1.ColCount do
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
begin
  if dv <> nil then
  begin
    Self.caption := '兆科音视频坐席管理设置' + ' : ' + dv.Name + ', ' + dv.ip;
    ipIP := TIP.Create(dv.ip);
    ipIP.parserIP(dv.ip);
    Edit1.Text := dv.Name;
    Edit2.Text := dv.id;
    Edit3.Text := dv.ip;
    Edit6.Text := dv.MAC;
    // edit4.Text:=
    Edit5.Text := ipIP.ip1 + '.' + ipIP.ip2 + '.' + ipIP.ip3 + '.1';
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
end;

end.

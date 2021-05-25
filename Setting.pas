unit Setting;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, VDevice,
  ClientObject;

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
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
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
  private
    // FStr:String;
    { Private declarations }
    procedure TCPReadData(const data: String; id: Integer);
    procedure UpdateZX(ListView: TListView; b: Byte; ZXId: Integer);
    procedure GetZX(ListView: TListView; var buf: array of Byte; offset: Integer);
  public
    { Public declarations }
    dv: TVDevice;
    tcp: TClientObject;

  end;

var
  frmSetting: TfrmSetting;

implementation

uses ObjManager, GlobalFunctions;
{$R *.dfm}

procedure TfrmSetting.Button1Click(Sender: TObject);
begin
  if tcp.Client.Connected then
  begin
    tcp.TCPSendStr('root' + #10#13);
    tcp.TCPSendStr('astparam s MY_IP' + trim(Edit1.Text) + #10#13);
    tcp.TCPSendStr('astparam save' + #10#13);
  end;
end;

procedure TfrmSetting.Button2Click(Sender: TObject);
begin
  if tcp.Client.Connected then
  begin
    tcp.TCPSendStr('root' + #10#13);
    tcp.TCPSendStr('e e_devfind_on' + #10#13);
  end;
end;

procedure TfrmSetting.Button3Click(Sender: TObject);
begin
  if tcp.Client.Connected then
  begin
    tcp.TCPSendStr('root' + #10#13);
    tcp.TCPSendStr('e e_devfind_off' + #10#13);
  end;
end;

procedure TfrmSetting.Button4Click(Sender: TObject);
begin
  { if tcp.Client.Connected then
    begin
    tcp.SetCallBack(TCPReadData);
    tcp.SetWork('astparam g pullperm', 100);
    end; }
  TCPReadData('astparam g pullperm FFFFFFFFFFFFFFFFFFFFFFFF', -1);
end;

procedure TfrmSetting.Button5Click(Sender: TObject);
var
  buff: array of Byte;
  str: string;
begin
  SetLength(buff, 12);
  GetZX(Self.ListView1, buff, 0);
  GetZX(Self.ListView2, buff, 4);
  GetZX(Self.ListView3, buff, 8);

  str := BytestoHexString(buff, 12);
  // tcp.SetCallBack(TCPReadData);
  if tcp <> nil then
  begin
    tcp.SetWork('astparam s pullperm ' + str, 101);
    tcp.SetWork('astparam save', 101);
  end;
end;

procedure TfrmSetting.Button6Click(Sender: TObject);
var
  buff: array of Byte;
  str: string;
begin
  SetLength(buff, 12);
  GetZX(Self.ListView4, buff, 0);
  GetZX(Self.ListView5, buff, 4);
  GetZX(Self.ListView6, buff, 8);

  str := BytestoHexString(buff, 12);
  // tcp.SetCallBack(TCPReadData);
  if tcp <> nil then
  begin
    tcp.SetWork('astparam s pushperm ' + str, 102);
    tcp.SetWork('astparam save', 102);
  end;

end;

procedure TfrmSetting.Button7Click(Sender: TObject);
begin
  { if tcp.Client.Connected then
    begin
    tcp.SetCallBack(TCPReadData);
    tcp.SetWork('astparam g pullperm', 100);
    end; }
  TCPReadData('astparam g pushperm FFFFFFFFFFFFFFFFFFFFFFFF', -1);
end;

procedure TfrmSetting.Button8Click(Sender: TObject);
var
  buff: array of Byte;
  str: string;
begin
  SetLength(buff, 12);
  GetZX(Self.ListView7, buff, 0);
  GetZX(Self.ListView8, buff, 4);
  GetZX(Self.ListView9, buff, 8);

  str := BytestoHexString(buff, 12);
  // tcp.SetCallBack(TCPReadData);
  if tcp <> nil then
  begin
    tcp.SetWork('astparam s getperm ' + str, 103);
    tcp.SetWork('astparam save', 103);
  end;

end;

procedure TfrmSetting.Button9Click(Sender: TObject);
begin
{ if tcp.Client.Connected then
    begin
    tcp.SetCallBack(TCPReadData);
    tcp.SetWork('astparam g pullperm', 100);
    end; }
  TCPReadData('astparam g getperm FFFFFFFFFFFFFFFFFFFFFFFF', -1);
end;

procedure TfrmSetting.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  If not(Key in ['0' .. '9', '.', #8]) then
  Begin
    Key := #0; // #0 表示没有输入
  End;
end;

procedure TfrmSetting.GetZX(ListView: TListView; var buf: array of Byte; offset: Integer);
var
  i, j: Integer;
  Item: TListItem;
  b: Byte;
  mask: Byte;
  // c:byte;
begin
  mask := $80;
  b := 0; // c:=0;
  for i := 0 to ListView.Items.Count - 1 do
  begin
    Item := ListView.Items.Item[i];
    if Item.Checked then
      b := b or mask;
    mask := mask shr 1;
    if (i mod 8) = 7 then
    begin
      buf[i div 8 + offset] := b;
      b := 0;
      mask := $80;
      // c:=0;
    end;
  end;
end;

procedure TfrmSetting.UpdateZX(ListView: TListView; b: Byte; ZXId: Integer);
var
  Item: TListItem;
  i: Integer;
  mask, bb: Byte;
begin
  mask := $80;
  for i := 0 to 7 do
  begin
    mask := mask shr i;
    Item := ListView.Items.Add;
    Item.Caption := inttostr(i + ZXId);
    Item.SubItems.Add('坐席' + Item.Caption);
    bb := b and mask;
    if bb = mask then
      Item.Checked := true;

  end;
end;

procedure TfrmSetting.TCPReadData(const data: string; id: Integer);
var
  str: String;
  SL: TStringList;
  buf: array of Byte;
  bc, i: Integer;
begin
  SL := TStringList.Create;
  if (id = 100) or (id = 0) then // astparam g pullperm
  begin
  end;
  if (id = -1) then
  begin
    if pos('astparam g pullperm', data) > 0 then
    begin
      ExtractStrings([' '], [], PChar(data), SL);
      str := LowerCase(SL[SL.Count - 1]);
      bc := Length(str) div 2;
      SetLength(buf, bc);

      HexToBin(PChar(str), @buf[0], bc);

      UpdateZX(Self.ListView1, buf[0], 0);
      UpdateZX(Self.ListView1, buf[1], 8);
      UpdateZX(Self.ListView1, buf[2], 16);
      UpdateZX(Self.ListView1, buf[3], 24);

      UpdateZX(Self.ListView2, buf[4], 32);
      UpdateZX(Self.ListView2, buf[5], 40);
      UpdateZX(Self.ListView2, buf[6], 48);
      UpdateZX(Self.ListView2, buf[7], 56);

      UpdateZX(Self.ListView3, buf[8], 64);
      UpdateZX(Self.ListView3, buf[9], 72);
      UpdateZX(Self.ListView3, buf[10], 80);
      UpdateZX(Self.ListView3, buf[11], 88);
      // ShowMessage(SL.Text);
      SL.Free;
    end;
     if pos('astparam g pushperm', data) > 0 then
    begin
      ExtractStrings([' '], [], PChar(data), SL);
      str := LowerCase(SL[SL.Count - 1]);
      bc := Length(str) div 2;
      SetLength(buf, bc);

      HexToBin(PChar(str), @buf[0], bc);

      UpdateZX(Self.ListView4, buf[0], 0);
      UpdateZX(Self.ListView4, buf[1], 8);
      UpdateZX(Self.ListView4, buf[2], 16);
      UpdateZX(Self.ListView4, buf[3], 24);

      UpdateZX(Self.ListView5, buf[4], 32);
      UpdateZX(Self.ListView5, buf[5], 40);
      UpdateZX(Self.ListView5, buf[6], 48);
      UpdateZX(Self.ListView5, buf[7], 56);

      UpdateZX(Self.ListView6, buf[8], 64);
      UpdateZX(Self.ListView6, buf[9], 72);
      UpdateZX(Self.ListView6, buf[10], 80);
      UpdateZX(Self.ListView6, buf[11], 88);
      // ShowMessage(SL.Text);
      SL.Free;
    end;

     if pos('astparam g getperm', data) > 0 then
    begin
      ExtractStrings([' '], [], PChar(data), SL);
      str := LowerCase(SL[SL.Count - 1]);
      bc := Length(str) div 2;
      SetLength(buf, bc);

      HexToBin(PChar(str), @buf[0], bc);

      UpdateZX(Self.ListView7, buf[0], 0);
      UpdateZX(Self.ListView7, buf[1], 8);
      UpdateZX(Self.ListView7, buf[2], 16);
      UpdateZX(Self.ListView7, buf[3], 24);

      UpdateZX(Self.ListView8, buf[4], 32);
      UpdateZX(Self.ListView8, buf[5], 40);
      UpdateZX(Self.ListView8, buf[6], 48);
      UpdateZX(Self.ListView8, buf[7], 56);

      UpdateZX(Self.ListView9, buf[8], 64);
      UpdateZX(Self.ListView9, buf[9], 72);
      UpdateZX(Self.ListView9, buf[10], 80);
      UpdateZX(Self.ListView9, buf[11], 88);
      // ShowMessage(SL.Text);
      SL.Free;
    end;
  end;
end;

procedure TfrmSetting.FormShow(Sender: TObject);
begin
  if dv <> nil then
  begin
    Self.Caption := '兆科音视频坐席管理设置' + ' : ' + dv.name + ', ' + dv.ip;
    Edit1.Text := dv.ip;

  end;
end;

end.

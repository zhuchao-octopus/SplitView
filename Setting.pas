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
    TabSheet5: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
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
    Memo1: TMemo;
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    // FStr:String;
    { Private declarations }
    procedure TCPReadData(const data: String; id: Integer);
  public
    { Public declarations }
    dv: TVDevice;
    tcp: TClientObject;

  end;

var
  frmSetting: TfrmSetting;

implementation

uses ObjManager;
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
  if tcp.Client.Connected then
  begin
    tcp.SetCallBack(TCPReadData);
    tcp.SetWork('astparam g pullperm', 100);
  end;
end;

procedure TfrmSetting.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  If not(Key in ['0' .. '9', '.', #8]) then
  Begin
    Key := #0; // #0 表示没有输入
  End;
end;

procedure TfrmSetting.TCPReadData(const data: string; id: Integer);
var
  str: String;
  SL:   TStringList;
  Buf: array of byte;
begin
   SL   :=   TStringList.Create;
  if (id = 100) or (id = 0) then // astparam g pullperm
  begin
    // memo1.Lines.Add(data+ ' id:=' +inttostr(id));
    str := str + data;
  end;
  if (id = -1) then
  begin
    if pos('astparam g pullperm', data) > 0 then
    begin
        ExtractStrings([ ' '],   [],   PChar(data),   SL);

        SetLength(Buf,24);
        HexToBin(PAnsiChar(SL[sl.Count-1]), @Buf[0],24);
        ShowMessage(SL.Text);
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

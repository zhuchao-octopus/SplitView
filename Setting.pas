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
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
    procedure TCPReadData(const data:String);
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
    //tcp.SetCallBack(TCPReadData);
    tcp.TCPSendStr('root' + #10#13);
    tcp.TCPSendStr('astparam g pullperm' + #10#13);
  end;
end;

procedure TfrmSetting.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  If not(Key in ['0' .. '9', '.', #8]) then
  Begin
    Key := #0; // #0 表示没有输入
  End;
end;
procedure TfrmSetting.TCPReadData(const data: string);
begin

end;
procedure TfrmSetting.FormShow(Sender: TObject);
begin
  if dv <> nil then
  begin
    Self.Caption := '兆科音视频坐席管理设置' + ' : ' + dv.name + ', ' + dv.ip;
    edit1.Text:=dv.IP;

  end;
end;

end.

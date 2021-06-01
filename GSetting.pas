unit GSetting;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, VDevice,
  ClientObject, Vcl.Samples.Spin, Vcl.Grids, VDeviceGroup;

type
  TGSettingfrm = class(TForm)
    GroupBox5: TGroupBox;
    StringGrid1: TStringGrid;
    GroupBox3: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    Button16: TButton;
    Button19: TButton;
    procedure Button16Click(Sender: TObject);
    procedure StringGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure Button19Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    //dv: TVDevice;
    udp: TClientObject;
  end;

var
  GSettingfrm: TGSettingfrm;

implementation

uses ObjManager, GlobalFunctions, Unit200;
{$R *.dfm}

procedure TGSettingfrm.Button16Click(Sender: TObject);
//var
//  buff: array [0 .. 2] of Byte;
//  str: String;
begin
  {buff[0] := $FC;
  buff[1] := StrToInt(dv.id);
  buff[2] := SpinEdit1.Value shl 4 + SpinEdit2.Value;
  // Log('UDP:' + IntToStr(buff[0]) + ' RX:' + IntToStr(buff[1]) + ' TX:' + IntToStr(buff[2]));
  str := BuffToHexStr(buff);
  if udp <> nil then
  begin
    udp.Log('UDP:' + str);
    udp.UDPSendHexStr('225.1.0.0', 3333, str);
  end;}
  StringGrid1.RowCount := SpinEdit1.Value;
  StringGrid1.ColCount := SpinEdit2.Value;
end;

procedure TGSettingfrm.Button19Click(Sender: TObject);
var
  buff: array [0 .. 2] of Byte;
  s, str: String;
  i, j, id: Integer;
begin
  buff[0] := $FD;
  //buff[1] := StrToInt(dv.id);
  // buff[2] := SpinEdit3.Value shl 4 + SpinEdit4.Value;

  for i := 0 to StringGrid1.RowCount - 1 do
  begin
    for j := 0 to StringGrid1.ColCount - 1 do
    begin
      s := Trim(StringGrid1.Cells[j, i]);
      if s = '' then
        Continue;

      try
        id := StrToInt(s);
      Except
        Continue;
      end;

      buff[0] := $FD;
      buff[1] := id;
      buff[2] := i shl 4 + j;
      //str := BuffToHexStr(buff);
      str := 'FD '+IntToStr(id)+  Format('0x%.02x ', [buff[2]]);
      if udp <> nil then
      begin
        //udp.Log('UDP:' + str);
        udp.UDPSendHexStr('225.1.0.0', 3333, str);
      end;


      buff[0] := $FC;
      buff[1] := id;
      buff[2] := StringGrid1.RowCount  shl 4 + StringGrid1.ColCount;
      str := 'FC '+IntToStr(id)+ Format('0x%.02x ', [buff[2]]);//BuffToHexStr(buff);
      if udp <> nil then
      begin
        //udp.Log('UDP:' + str);
        udp.UDPSendHexStr('225.1.0.0', 3333, str);
      end;

    end;
  end;

end;

procedure TGSettingfrm.StringGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  If not(Key in ['0' .. '9', #8]) then
  Begin
    Key := #0; // #0 表示没有输入
  End;
end;

end.

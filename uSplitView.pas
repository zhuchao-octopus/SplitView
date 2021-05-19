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
  IdBaseComponent, IdComponent, IdUDPBase, IdUDPServer;

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
    IdIPMCastClient1: TIdIPMCastClient;
    IdTCPClient1: TIdTCPClient;

    procedure FormCreate(Sender: TObject);
    procedure imgMenuClick(Sender: TObject);
    procedure cbxVclStylesChange(Sender: TObject);
    procedure catMenuItemsCategories0Items0Click(Sender: TObject);
    procedure catMenuItemsCategories0Items1Click(Sender: TObject);
    procedure catMenuItemsCategories0Items2Click(Sender: TObject);
    procedure catMenuItemsCategories0Items3Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    procedure Log(const Msg: string);
    procedure SynchroPage(ItemIndex: Integer);
  public
  end;

var
  SplitViewForm: TSplitViewForm;

implementation

uses
  Vcl.Themes, GlobalConst, GlobalFunctions;

{$R *.dfm}

procedure TSplitViewForm.FormCreate(Sender: TObject);
var
  StyleName: string;
  S: string;
begin
  for StyleName in TStyleManager.StyleNames do
    cbxVclStyles.Items.Add(StyleName);
  cbxVclStyles.ItemIndex := cbxVclStyles.Items.IndexOf(TStyleManager.ActiveStyle.Name);

  GetBuildInfo(Application.ExeName, S);

  Caption := APPLICATION_TITLE_NAME + ' v' + S + ' - ' + {$IFDEF CPUX64}'64'{$ELSE}'32'{$ENDIF} + ' bit';

  SynchroPage(0);
end;

procedure TSplitViewForm.FormResize(Sender: TObject);
begin
    ListView1.width:=panel1.width div 2;
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

procedure TSplitViewForm.SpeedButton1Click(Sender: TObject);
begin
ListView1.Clear;
ListView1.Columns.Clear;
ListView1.Columns.Add;
ListView1.Columns.Add;
ListView1.Columns.Add;
ListView1.Columns.Items[0].Caption:='id';
ListView1.Columns.Items[1].Caption:='type';
ListView1.Columns.Items[2].Caption:='title';
ListView1.Columns.Items[2].Width:=300;
//Listview1.ViewStyle:=vsreport;
//Listview1.GridLines:=true;
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
 str:String;
begin
  //str:=GetSystemDateTimeStr();
  //statusbar1.panels[0].text:=str;
end;

procedure TSplitViewForm.Log(const Msg: string);
begin

end;

end.

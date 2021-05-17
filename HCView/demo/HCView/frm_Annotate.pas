unit frm_Annotate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, HCAnnotateData, StdCtrls;

type
  TfrmAnnotate = class(TForm)
    edtTitle: TEdit;
    mmoText: TMemo;
    btnOK: TButton;
    lbl1: TLabel;
    lbl2: TLabel;
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SetAnnotate(const AAnnotate: THCDataAnnotate);
  end;

var
  frmAnnotate: TfrmAnnotate;

implementation

{$R *.dfm}

procedure TfrmAnnotate.btnOKClick(Sender: TObject);
begin
  Self.ModalResult := mrOk;
end;

procedure TfrmAnnotate.SetAnnotate(const AAnnotate: THCDataAnnotate);
begin
  if Assigned(AAnnotate) then
  begin
    btnOK.Caption := '�޸�';
    edtTitle.Text := AAnnotate.Title;
    mmoText.Text := AAnnotate.Text;
    Caption := '��ע���-' + IntToStr(AAnnotate.ID);
    Self.ShowModal;
    if Self.ModalResult = mrOk then
    begin
      AAnnotate.Title := edtTitle.Text;
      AAnnotate.Text := mmoText.Text;
    end;
  end
  else
  begin
    btnOK.Caption := 'ȷ��';
    Caption := '�½���ע';
    edtTitle.Clear;
    mmoText.Clear;
    Self.ShowModal;
  end;
end;

end.

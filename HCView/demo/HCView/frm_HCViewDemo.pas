unit frm_HCViewDemo;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Messages, Forms, Dialogs, StdCtrls,
  ComCtrls, Menus, ImgList, ToolWin, XPMan, HCCommon, HCRichData, HCItem,
  HCCustomData, HCViewTool, HCParaStyle, HCTextStyle, ExtCtrls, ActnList,
  Printers, Clipbrd, HCRuler, System.Actions,
  System.ImageList;

type
  TfrmHCViewDemo = class(TForm)
    il1: TImageList;
    tlbTool: TToolBar;
    btnOpen: TToolButton;
    btnSymmetryMargin: TToolButton;
    btnAlignLeft: TToolButton;
    btnAlignCenter: TToolButton;
    btnAlignRight: TToolButton;
    btnAlignJustify: TToolButton;
    btnAlignScatter: TToolButton;
    mm1: TMainMenu;
    mniN1: TMenuItem;
    mniOpen: TMenuItem;
    mniSave: TMenuItem;
    mniSaveAs: TMenuItem;
    btnBold: TToolButton;
    btn2: TToolButton;
    btnSave: TToolButton;
    btnItalic: TToolButton;
    btnUnderLine: TToolButton;
    btnStrikeOut: TToolButton;
    btnSuperScript: TToolButton;
    btnSubScript: TToolButton;
    btnprint: TToolButton;
    mniN3: TMenuItem;
    mniCopy: TMenuItem;
    mniPaste: TMenuItem;
    mniCut: TMenuItem;
    mniN5: TMenuItem;
    pmHCView: TPopupMenu;
    mniN6: TMenuItem;
    mniN7: TMenuItem;
    mniN8: TMenuItem;
    mniTable: TMenuItem;
    mniN9: TMenuItem;
    statbar: TStatusBar;
    mniN12: TMenuItem;
    mniN13: TMenuItem;
    mniN14: TMenuItem;
    mniN15: TMenuItem;
    mniC1: TMenuItem;
    btnLineSpace: TToolButton;
    pmLineSpace: TPopupMenu;
    mniLS100: TMenuItem;
    mniLS150: TMenuItem;
    mniLS200: TMenuItem;
    mniDisBorder: TMenuItem;
    mniInsertRowTop: TMenuItem;
    mniInsertRowBottom: TMenuItem;
    mniInsertColLeft: TMenuItem;
    mniInsertColRight: TMenuItem;
    mniDeleteCurRow: TMenuItem;
    mniDeleteCurCol: TMenuItem;
    mniN25: TMenuItem;
    mniPara: TMenuItem;
    mniN27: TMenuItem;
    mniN28: TMenuItem;
    mniN29: TMenuItem;
    mniN30: TMenuItem;
    mniN31: TMenuItem;
    mniN32: TMenuItem;
    actlst: TActionList;
    btnNew: TToolButton;
    mnigif1: TMenuItem;
    mniN4: TMenuItem;
    mniMerge: TMenuItem;
    mniN10: TMenuItem;
    mniN11: TMenuItem;
    mniN16: TMenuItem;
    mniInsertTable: TMenuItem;
    btnUndo: TToolButton;
    btnRedo: TToolButton;
    mniEdit1: TMenuItem;
    mniLSFix: TMenuItem;
    mniN19: TMenuItem;
    mniCombobox1: TMenuItem;
    mniN23: TMenuItem;
    mniN24: TMenuItem;
    mniN33: TMenuItem;
    mniN34: TMenuItem;
    mniN35: TMenuItem;
    mniN36: TMenuItem;
    mniN37: TMenuItem;
    mniTableProperty: TMenuItem;
    mniN38: TMenuItem;
    mniFloatLine: TMenuItem;
    mniN40: TMenuItem;
    actSearch: TAction;
    mniN42: TMenuItem;
    actCut: TAction;
    actCopy: TAction;
    actPaste: TAction;
    mniControlItem: TMenuItem;
    mniBorder: TMenuItem;
    mniLS115: TMenuItem;
    mniN44: TMenuItem;
    mniRadioButton1: TMenuItem;
    mniSplitRow: TMenuItem;
    mniSplitCol: TMenuItem;
    mniN47: TMenuItem;
    mniN45: TMenuItem;
    mniN46: TMenuItem;
    mniN2: TMenuItem;
    mniN17: TMenuItem;
    mniHyperLink: TMenuItem;
    mniExplore: TMenuItem;
    btnLeftIndent: TToolButton;
    btnRightIndent: TToolButton;
    mniModAnnotate: TMenuItem;
    mniDelAnnotate: TMenuItem;
    mniN18: TMenuItem;
    mniViewFilm: TMenuItem;
    mniViewPage: TMenuItem;
    mniN20: TMenuItem;
    mniAlignTopLeft: TMenuItem;
    mniAlignTopCenter: TMenuItem;
    mniAlignTopRight: TMenuItem;
    mniAlignCenterLeft: TMenuItem;
    mniAlignCenterCenter: TMenuItem;
    mniAlignCenterRight: TMenuItem;
    mniAlignBottomLeft: TMenuItem;
    mniAlignBottomCenter: TMenuItem;
    mniAlignBottomRight: TMenuItem;
    mniFloatBarCode: TMenuItem;
    mniViewText: TMenuItem;
    ToolButton2: TToolButton;
    ToolButton1: TToolButton;
    Panel1: TPanel;
    cbbZoom: TComboBox;
    cbbFont: TComboBox;
    cbbFontSize: TComboBox;
    cbbBackColor: TColorBox;
    cbbFontColor: TColorBox;
    N1: TMenuItem;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAlignLeftClick(Sender: TObject);
    procedure btnSymmetryMarginClick(Sender: TObject);
    procedure btnBoldClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbbFontChange(Sender: TObject);
    procedure cbbFontColorChange(Sender: TObject);
    procedure cbbBackColorChange(Sender: TObject);
    procedure cbbFontSizeChange(Sender: TObject);
    procedure mniN5Click(Sender: TObject);
    procedure pmHCViewPopup(Sender: TObject);
    procedure btnprintClick(Sender: TObject);
    procedure cbbZoomChange(Sender: TObject);
    procedure mniN9Click(Sender: TObject);
    procedure mniN14Click(Sender: TObject);
    procedure mniC1Click(Sender: TObject);
    procedure mniLS100Click(Sender: TObject);
    procedure mniDisBorderClick(Sender: TObject);
    procedure mniInsertRowTopClick(Sender: TObject);
    procedure mniInsertRowBottomClick(Sender: TObject);
    procedure mniInsertColLeftClick(Sender: TObject);
    procedure mniInsertColRightClick(Sender: TObject);
    procedure mniDeleteCurRowClick(Sender: TObject);
    procedure mniDeleteCurColClick(Sender: TObject);
    procedure mniParaClick(Sender: TObject);
    procedure mniSaveAsClick(Sender: TObject);
    procedure mniSaveClick(Sender: TObject);
    procedure mniOpenClick(Sender: TObject);
    procedure mniN27Click(Sender: TObject);
    procedure mniN28Click(Sender: TObject);
    procedure mniN30Click(Sender: TObject);
    procedure mniN31Click(Sender: TObject);
    procedure mniN32Click(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure mnigif1Click(Sender: TObject);
    procedure mniN4Click(Sender: TObject);
    procedure mniMergeClick(Sender: TObject);
    procedure mniInsertTableClick(Sender: TObject);
    procedure btnUndoClick(Sender: TObject);
    procedure btnRedoClick(Sender: TObject);
    procedure mniEdit1Click(Sender: TObject);
    procedure mniN19Click(Sender: TObject);
    procedure mniCombobox1Click(Sender: TObject);
    procedure mniN23Click(Sender: TObject);
    procedure mniN33Click(Sender: TObject);
    procedure mniN34Click(Sender: TObject);
    procedure mniN36Click(Sender: TObject);
    procedure mniN37Click(Sender: TObject);
    procedure mniTablePropertyClick(Sender: TObject);
    procedure mniFloatLineClick(Sender: TObject);
    procedure actSearchExecute(Sender: TObject);
    procedure mniN42Click(Sender: TObject);
    procedure actCutExecute(Sender: TObject);
    procedure actCopyExecute(Sender: TObject);
    procedure actPasteExecute(Sender: TObject);
    procedure mniControlItemClick(Sender: TObject);
    procedure mniBorderClick(Sender: TObject);
    procedure mniN44Click(Sender: TObject);
    procedure mniRadioButton1Click(Sender: TObject);
    procedure mniSplitRowClick(Sender: TObject);
    procedure mniSplitColClick(Sender: TObject);
    procedure mniN45Click(Sender: TObject);
    procedure mniN46Click(Sender: TObject);
    procedure pmLineSpacePopup(Sender: TObject);
    procedure mniN2Click(Sender: TObject);
    procedure mniN17Click(Sender: TObject);
    procedure mniHyperLinkClick(Sender: TObject);
    procedure mniExploreClick(Sender: TObject);
    procedure mniModAnnotateClick(Sender: TObject);
    procedure mniDelAnnotateClick(Sender: TObject);
    procedure mniViewFilmClick(Sender: TObject);
    procedure mniViewPageClick(Sender: TObject);
    procedure mniAlignTopLeftClick(Sender: TObject);
    procedure mniFloatBarCodeClick(Sender: TObject);
    procedure mniViewTextClick(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    FHRuler: THCHorizontalRuler;
    FVRuler: THCVerticalRuler;
    FHCView: THCViewTool;
    procedure SnapScreen(a, b, c, d: Integer; Apath: string);
    procedure CopyScreenToBmp(var Image: TImage);
    procedure SetFileName(const AFileName: string);
    function SaveFile: Boolean;
    procedure GetPagesAndActive;
    procedure DoCaretChange(Sender: TObject);
    procedure DoZoomChanged(Sender: TObject);
    procedure DoVerScroll(Sender: TObject);
    procedure DoHorScroll(Sender: TObject);
    procedure DoViewResize(Sender: TObject);
    procedure DoCurParaNoChange(Sender: TObject);
    procedure DoActivePageChange(Sender: TObject);
    procedure CurTextStyleChange(const ANewStyleNo: Integer);
    procedure CurParaStyleChange(const ANewStyleNo: Integer);
    procedure DoComboboxPopupItem(Sender: TObject);
    procedure MyAppMsg(var Msg: TMsg; var Handled: Boolean);
  public
    { Public declarations }
    // StkObj: TStockObject;
    FilePath: String;
  end;

var
  frmHCViewDemo: TfrmHCViewDemo;
  // savePath: String;
  OnMessage: TMessageEvent;

Const
  FILEEXTNAME: String = HC_EXT;

implementation

uses
  frm_InsertTable, frm_PageSet, HCStyle, HCRectItem, HCTableItem, HCTextItem,
  HCDrawItem, HCExpressItem, HCLineItem, HCCheckBoxItem, HCEditItem, HCImageItem,
  HCGifItem, HCComboboxItem, HCQRCodeItem, HCBarCodeItem, HCFractionItem, HCFloatLineItem,
  HCDateTimePicker, HCSupSubScriptItem, HCRadioGroup, frm_Paragraph, frm_TableProperty,
  frm_SearchAndReplace, frm_PrintView, frm_ControlItemProperty, frm_Annotate,
  frm_TableBorderBackColor, HCFloatBarCodeItem,
  SUnit2;

{$R *.dfm}

function GetVersionInfo: string;
const
  SNotAvailable = 'Value Not Available';
var
  vFilePath: string;
  vLanguageID: string;
  vCodePage: string;
  vTranslationLength: Cardinal;
  vTranslationTable: Pointer;
  vInfoSize, vTemp, vLen: DWord;
  vInfoBuf: Pointer;
  vCompanyName, vFileDescription, vFileVersion, vInternalName, vLegalCopyright: string;
  vLegalTradeMarks, vOriginalFilename, vProductName, vProductVersion, vComments: string;
  vValue: PChar;
  vLookupString: string;
  vPathStz: array [0 .. MAX_PATH] of Char;
begin
  Result := '';
  GetModuleFileName(HInstance, vPathStz, SizeOf(vPathStz));
  vFilePath := vPathStz;

  vInfoSize := GetFileVersionInfoSize(PChar(vFilePath), vTemp);

  if vInfoSize > 0 then
  begin
    vInfoBuf := AllocMem(vInfoSize);
    try
      GetFileVersionInfo(PChar(vFilePath), 0, vInfoSize, vInfoBuf);

      if VerQueryValue(vInfoBuf, '\VarFileInfo\Translation', vTranslationTable, vTranslationLength) then
      begin
        vCodePage := Format('%.4x', [HiWord(PLongInt(vTranslationTable)^)]);
        vLanguageID := Format('%.4x', [LoWord(PLongInt(vTranslationTable)^)]);
      end;

      vLookupString := 'StringFileInfo\' + vLanguageID + vCodePage + '\';

      if VerQueryValue(vInfoBuf, PChar(vLookupString + 'CompanyName'), Pointer(vValue), vLen) then
        vCompanyName := vValue;
      if VerQueryValue(vInfoBuf, PChar(vLookupString + 'FileDescription'), Pointer(vValue), vLen) then
        vFileDescription := vValue;
      if VerQueryValue(vInfoBuf, PChar(vLookupString + 'FileVersion'), Pointer(vValue), vLen) then
        vFileVersion := vValue;
      if VerQueryValue(vInfoBuf, PChar(vLookupString + 'InternalName'), Pointer(vValue), vLen) then
        vInternalName := vValue;
      if VerQueryValue(vInfoBuf, PChar(vLookupString + 'LegalCopyright'), Pointer(vValue), vLen) then
        vLegalCopyright := vValue;
      if VerQueryValue(vInfoBuf, PChar(vLookupString + 'LegalTrademarks'), Pointer(vValue), vLen) then
        vLegalTradeMarks := vValue;
      if VerQueryValue(vInfoBuf, PChar(vLookupString + 'OriginalFilename'), Pointer(vValue), vLen) then
        vOriginalFilename := vValue;
      if VerQueryValue(vInfoBuf, PChar(vLookupString + 'ProductName'), Pointer(vValue), vLen) then
        vProductName := vValue;
      if VerQueryValue(vInfoBuf, PChar(vLookupString + 'ProductVersion'), Pointer(vValue), vLen) then
        vProductVersion := vValue;
      if VerQueryValue(vInfoBuf, PChar(vLookupString + 'Comments'), Pointer(vValue), vLen) then
        vComments := vValue;
    finally
      FreeMem(vInfoBuf, vInfoSize);
    end;
  end
  else
  begin
    vCompanyName := SNotAvailable;
    vFileDescription := SNotAvailable;
    vFileVersion := SNotAvailable;
    vInternalName := SNotAvailable;
    vLegalCopyright := SNotAvailable;
    vLegalTradeMarks := SNotAvailable;
    vOriginalFilename := SNotAvailable;
    vProductName := SNotAvailable;
    vProductVersion := SNotAvailable;
    vComments := SNotAvailable;
  end;
  Result := vFileVersion;
end;

procedure TfrmHCViewDemo.MyAppMsg(var Msg: tagMSG; var Handled: Boolean);
var
  keyState: TKeyBoardState;
begin

  case Msg.message of
    WM_KEYDOWN:
      begin
        if (Msg.WParam = VK_ESCAPE) then
        begin
          if SForm2 <> nil then
          begin
            if SForm2.Active then
            begin
              SForm2.close;
              WindowState := wsNormal;
              show();
            end;
          end;
        end;
      end; // WM_KEYDOWN:begin

    WM_KEYUP:
      begin
      end;
  end; // case   msg.message   of
end;

procedure TfrmHCViewDemo.CopyScreenToBmp(var Image: TImage);
var
  Bmp: Tbitmap;
  Canvas: TCanvas;
  DC: HDC;
begin
  Bmp := Tbitmap.Create; // ????????BITMAP??????????
  Bmp.Width := screen.Width; // ??????????????????????????
  Bmp.Height := screen.Height;
  DC := GetDC(0); // ?????????? DC
  Canvas := TCanvas.Create; // ????????CANVAS????
  Canvas.Handle := DC; // ??????????????
  // ????????????????BITMAP??
  Bmp.Canvas.CopyRect(Rect(0, 0, screen.Width, screen.Height), Canvas, Rect(0, 0, screen.Width, screen.Height));
  Canvas.Free; // ????CANVAS????
  ReleaseDC(0, DC); // ????DC

  Image.picture.Bitmap := Bmp; // ????????????????IMAGE????
  Image.Width := Bmp.Width; // ????Image????????????????????????????
  Image.Height := Bmp.Height;
  Bmp.Free; // ????bitmap
end;

procedure TfrmHCViewDemo.SnapScreen(a, b, c, d: Integer; Apath: string); // ????????????,??????????????
var
  bmpscreen: Tbitmap;
  FullscreenCanvas: TCanvas;
  DC: HDC;
  sourceRect, destRect: TRect;
begin
  DC := GetDC(0);
  FullscreenCanvas := TCanvas.Create;
  FullscreenCanvas.Handle := DC;
  bmpscreen := Tbitmap.Create;
  bmpscreen.Width := c - a;
  bmpscreen.Height := d - b;
  sourceRect := Rect(0, 0, c - a, d - b);
  destRect := Rect(a, b, c, d);
  bmpscreen.Canvas.CopyRect(sourceRect, FullscreenCanvas, destRect);
  bmpscreen.SaveToFile(Apath);
  FullscreenCanvas.Free;
  bmpscreen.Free;
  ReleaseDC(0, DC);
end;

procedure TfrmHCViewDemo.Timer1Timer(Sender: TObject);
begin
  statbar.Panels[1].Text := '';
end;

procedure TfrmHCViewDemo.ToolButton2Click(Sender: TObject);
begin
  // toolbutton2.Enabled :=true;
  if SForm2 = nil then
    SForm2 := TSForm2.Create(self);
  WindowState := wsMinimized; // ??????????????
  hide; // ????????????
  sleep(100);

  CopyScreenToBmp(SForm2.Image1); // ??????????????form2????image1
  if SForm2.ShowModal = mrOk then // ??form2??????????????
  begin
    WindowState := wsNormal; // ????????????
    show;
    FHCView.Paste;
  end
  else
  begin
    WindowState := wsNormal;
    show();
  end;
  // PostMessage(hwnd,WM_SYSCOMMAND, SC_MINIMIZE,0); //??????
  // PostMessage(hwnd,WM_SYSCOMMAND, SC_MAXIMIZE,0);//??????
end;

procedure TfrmHCViewDemo.btnSymmetryMarginClick(Sender: TObject);
begin
  FHCView.SymmetryMargin := not FHCView.SymmetryMargin;
end;

procedure TfrmHCViewDemo.cbbFontSizeChange(Sender: TObject);
begin
  FHCView.ApplyTextFontSize(GetFontSize(cbbFontSize.Text));
  if not FHCView.Focused then
    FHCView.SetFocus;
end;

procedure TfrmHCViewDemo.cbbZoomChange(Sender: TObject);
begin
  FHCView.Zoom := StrToIntDef(cbbZoom.Text, 100) / 100;
end;

procedure TfrmHCViewDemo.cbbBackColorChange(Sender: TObject);
begin
  FHCView.ApplyTextBackColor(cbbBackColor.Selected);
end;

procedure TfrmHCViewDemo.cbbFontChange(Sender: TObject);
begin
  FHCView.ApplyTextFontName(cbbFont.Text);
  if not FHCView.Focused then
    FHCView.SetFocus;
end;

procedure TfrmHCViewDemo.cbbFontColorChange(Sender: TObject);
begin
  FHCView.ApplyTextColor(cbbFontColor.Selected);
  if not FHCView.Focused then
    FHCView.SetFocus;
end;

procedure TfrmHCViewDemo.DoActivePageChange(Sender: TObject);
begin
  FHRuler.Reset;
  FVRuler.Reset;
end;

procedure TfrmHCViewDemo.DoCaretChange(Sender: TObject);
begin
  GetPagesAndActive;

  CurTextStyleChange(FHCView.CurStyleNo);
  CurParaStyleChange(FHCView.CurParaNo);
  btnSymmetryMargin.Down := FHCView.SymmetryMargin;
end;

procedure TfrmHCViewDemo.DoComboboxPopupItem(Sender: TObject);
// var
// vCombobox: THCComboboxItem;
begin
  if Sender is THCComboboxItem then
  begin
    if (Sender as THCComboboxItem).Items.Count > 20 then
      (Sender as THCComboboxItem).Items.Clear;

    (Sender as THCComboboxItem).Items.Add('????' + IntToStr((Sender as THCComboboxItem).Items.Count - 1));
  end;
end;

procedure TfrmHCViewDemo.DoCurParaNoChange(Sender: TObject);
begin
  FHRuler.Reset;
end;

procedure TfrmHCViewDemo.DoHorScroll(Sender: TObject);
begin
  FHRuler.Reset;
end;

procedure TfrmHCViewDemo.CurParaStyleChange(const ANewStyleNo: Integer);
var
  vAlignHorz: TParaAlignHorz;
begin
  if ANewStyleNo >= 0 then
  begin
    vAlignHorz := FHCView.Style.ParaStyles[ANewStyleNo].AlignHorz;

    btnAlignLeft.Down := vAlignHorz = TParaAlignHorz.pahLeft;
    btnAlignRight.Down := vAlignHorz = TParaAlignHorz.pahRight;
    btnAlignCenter.Down := vAlignHorz = TParaAlignHorz.pahCenter;
    btnAlignJustify.Down := vAlignHorz = TParaAlignHorz.pahJustify;
    btnAlignScatter.Down := vAlignHorz = TParaAlignHorz.pahScatter;
  end;
end;

procedure TfrmHCViewDemo.CurTextStyleChange(const ANewStyleNo: Integer);
begin
  if ANewStyleNo >= 0 then
  begin
    cbbFont.ItemIndex := cbbFont.Items.IndexOf(FHCView.Style.TextStyles[ANewStyleNo].Family);
    cbbFontSize.ItemIndex := cbbFontSize.Items.IndexOf(GetFontSizeStr(FHCView.Style.TextStyles[ANewStyleNo].Size));
    btnBold.Down := tsBold in FHCView.Style.TextStyles[ANewStyleNo].FontStyles;
    btnItalic.Down := tsItalic in FHCView.Style.TextStyles[ANewStyleNo].FontStyles;
    btnUnderLine.Down := tsUnderline in FHCView.Style.TextStyles[ANewStyleNo].FontStyles;
    btnStrikeOut.Down := tsStrikeOut in FHCView.Style.TextStyles[ANewStyleNo].FontStyles;
    btnSuperScript.Down := tsSuperscript in FHCView.Style.TextStyles[ANewStyleNo].FontStyles;
    btnSubScript.Down := tsSubscript in FHCView.Style.TextStyles[ANewStyleNo].FontStyles;
  end
  else
  begin
    btnBold.Down := False;
    btnItalic.Down := False;
    btnUnderLine.Down := False;
    btnStrikeOut.Down := False;
    btnSuperScript.Down := False;
    btnSubScript.Down := False;
  end;
end;

procedure TfrmHCViewDemo.DoVerScroll(Sender: TObject);
begin
  GetPagesAndActive;
  FVRuler.Reset;
end;

procedure TfrmHCViewDemo.DoViewResize(Sender: TObject);
begin
  try
    FHRuler.Reset;
    FVRuler.Reset;
  finally
  end;
end;

procedure TfrmHCViewDemo.DoZoomChanged(Sender: TObject);
var
  vZoom: string;
  vIndex: Integer;
begin
  vZoom := IntToStr(Round(FHCView.Zoom * 100));
  vIndex := cbbZoom.Items.IndexOf(vZoom);
  if vIndex < 0 then
  begin
    cbbZoom.Items[cbbZoom.Items.Count - 1] := vZoom;
    vIndex := cbbZoom.Items.Count - 1;
  end;

  cbbZoom.ItemIndex := vIndex;
end;

procedure TfrmHCViewDemo.btnBoldClick(Sender: TObject);
begin
  case (Sender as TToolButton).Tag of
    0:
      FHCView.ApplyTextStyle(THCFontStyle.tsBold);
    1:
      FHCView.ApplyTextStyle(THCFontStyle.tsItalic);
    2:
      FHCView.ApplyTextStyle(THCFontStyle.tsUnderline);
    3:
      FHCView.ApplyTextStyle(THCFontStyle.tsStrikeOut);
    4:
      FHCView.ApplyTextStyle(THCFontStyle.tsSuperscript);
    5:
      FHCView.ApplyTextStyle(THCFontStyle.tsSubscript);
  end;
end;

procedure TfrmHCViewDemo.btnNewClick(Sender: TObject);
begin
  if FHCView.IsChanged then
  begin
    if MessageDlg('??????????????', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      if not SaveFile then
        Exit;
    end;
  end;
  FHCView.fileName := '';
  FHCView.Clear;
end;

procedure TfrmHCViewDemo.btnprintClick(Sender: TObject);
var
  vPrintDlg: TPrintDialog;
begin
  vPrintDlg := TPrintDialog.Create(nil);
  try
    // vPrintDlg.MaxPage := FHCView.PageCount;  // pdf????????????????????????
    if vPrintDlg.Execute then
      FHCView.Print(Printer.Printers[Printer.PrinterIndex]);
  finally
    FreeAndNil(vPrintDlg);
  end;
end;

procedure TfrmHCViewDemo.actCopyExecute(Sender: TObject);
begin
  FHCView.Copy;
end;

procedure TfrmHCViewDemo.actCutExecute(Sender: TObject);
begin
  FHCView.Cut;
end;

procedure TfrmHCViewDemo.actPasteExecute(Sender: TObject);
begin
  FHCView.Paste;
end;

procedure TfrmHCViewDemo.actSearchExecute(Sender: TObject);
begin
  if not Assigned(frmSearchAndReplace) then
  begin
    frmSearchAndReplace := TfrmSearchAndReplace.Create(self);
    frmSearchAndReplace.SetHCView(FHCView)
  end;
  frmSearchAndReplace.ShowSearch;
end;

procedure TfrmHCViewDemo.btnUndoClick(Sender: TObject);
begin
  FHCView.Undo;
end;

procedure TfrmHCViewDemo.btnRedoClick(Sender: TObject);
begin
  FHCView.Redo;
end;

procedure TfrmHCViewDemo.btnAlignLeftClick(Sender: TObject);
begin
  case (Sender as TToolButton).Tag of
    0:
      FHCView.ApplyParaAlignHorz(TParaAlignHorz.pahLeft);
    1:
      FHCView.ApplyParaAlignHorz(TParaAlignHorz.pahCenter);
    2:
      FHCView.ApplyParaAlignHorz(TParaAlignHorz.pahRight);
    3:
      FHCView.ApplyParaAlignHorz(TParaAlignHorz.pahJustify); // ????
    4:
      FHCView.ApplyParaAlignHorz(TParaAlignHorz.pahScatter); // ????
    5:
      FHCView.ApplyParaLeftIndent;
    6:
      FHCView.ApplyParaLeftIndent(False);
  end;
end;

procedure TfrmHCViewDemo.FormCreate(Sender: TObject);
begin

  FHCView := THCViewTool.Create(self);
  FHCView.OnCaretChange := DoCaretChange;
  FHCView.OnZoomChanged := DoZoomChanged;

  FHCView.OnVerScroll := DoVerScroll;
  FHCView.OnHorScroll := DoHorScroll;
  FHCView.OnViewResize := DoViewResize;
  FHCView.OnSectionCurParaNoChange := DoCurParaNoChange;
  FHCView.OnSectionActivePageChange := DoActivePageChange;
  FHCView.Parent := self;
  FHCView.Align := alClient;
  FHCView.PopupMenu := pmHCView;
  //
  FHRuler := THCHorizontalRuler.Create(self);
  FHRuler.Color := FHCView.Color;
  FHRuler.Parent := self;
  FHRuler.Align := alBottom;
  FHRuler.Align := alTop;
  FHRuler.View := FHCView;
  //
  FVRuler := THCVerticalRuler.Create(self);
  FVRuler.Color := FHCView.Color;
  FVRuler.Parent := self;
  FVRuler.Align := alLeft;
  FVRuler.View := FHCView;

  FHCView.ViewModel := THCViewModel.hvmPage;
  FHRuler.Visible := False;
  FVRuler.Visible := False;
end;

procedure TfrmHCViewDemo.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FHRuler);
  FreeAndNil(FVRuler);
  FreeAndNil(FHCView);

  if Assigned(frmSearchAndReplace) then
    FreeAndNil(frmSearchAndReplace);
end;

procedure TfrmHCViewDemo.FormShow(Sender: TObject);
var
  vExt: String;
  fName: String;
begin
  cbbFont.Items := screen.Fonts;
  cbbFont.ItemIndex := cbbFont.Items.IndexOf('????');
  // SendMessage(cbbFont.Handle, CB_SETDROPPEDWIDTH, 200, 0);
  FHCView.SetFocus;
  fName := '';
  statbar.Panels[1].Text := '';
  if FilePath <> '' then
  begin
    vExt := LowerCase(ExtractFileExt(fName));
    // Caption := 'HCViewDemo ' + GetVersionInfo;
    if vExt <> FILEEXTNAME then
      fName := FilePath + FILEEXTNAME;
  end;

  if FileExists(fName) then
  begin
    if (fName <> FHCView.fileName) then
    begin // ????????
      Caption := '????????' + '  ' + ExtractFileName(fName);
      vExt := LowerCase(ExtractFileExt(fName)); // ????
      if vExt = HC_EXT then
        FHCView.LoadFromFile(fName)
      else if vExt = '.xml' then
        FHCView.LoadFromXml(Caption)
      else
        FHCView.LoadFromDocumentFile(fName, vExt);
      statbar.Panels[1].Text := '';
      SetFileName(fName);
    end;
  end
  else // ??????????????????????
  begin
    FHCView.Clear; // ????
    statbar.Panels[2].Text := '';
    Caption := '????????';
    if DirectoryExists(ExtractFilePath(fName)) then
    begin // ??????????????????????????????
      SetFileName(fName);
      Caption := '????????' + '  ' + ExtractFileName(fName);
    end;
  end;
  OnMessage := Application.OnMessage;
  Application.OnMessage := self.MyAppMsg;
end;

procedure TfrmHCViewDemo.GetPagesAndActive;
begin
  statbar.Panels[0].Text := '????' + IntToStr(FHCView.PagePreviewFirst + 1) + '?? ????' + IntToStr(FHCView.ActivePageIndex + 1) + '?? ??' + IntToStr(FHCView.PageCount) + '??';
end;

procedure TfrmHCViewDemo.mniC1Click(Sender: TObject);
var
  vCheckBox: THCCheckBoxItem;
  vS: string;
begin
  vS := '??????';
  if InputQuery('??????', '????', vS) then
  begin
    vCheckBox := THCCheckBoxItem.Create(FHCView.ActiveSectionTopLevelData, vS, False);
    FHCView.InsertItem(vCheckBox);
  end;
end;

procedure TfrmHCViewDemo.mniCombobox1Click(Sender: TObject);
var
  vCombobox: THCComboboxItem;
  vS: string;
begin
  vS := '??????';
  if InputQuery('??????', '????????', vS) then
  begin
    vCombobox := THCComboboxItem.Create(FHCView.ActiveSectionTopLevelData, vS);
    vCombobox.Items.Add('????1');
    vCombobox.Items.Add('????2');
    vCombobox.Items.Add('????3');
    vCombobox.OnPopupItem := DoComboboxPopupItem;
    // vCombobox.ItemIndex := 0;
    FHCView.InsertItem(vCombobox);
  end;
end;

procedure TfrmHCViewDemo.mniLS100Click(Sender: TObject);
begin
  if Sender is TMenuItem then
  begin
    case (Sender as TMenuItem).Tag of
      0:
        FHCView.ApplyParaLineSpace(TParaLineSpaceMode.pls100); // ????
      1:
        FHCView.ApplyParaLineSpace(TParaLineSpaceMode.pls115); // 1.15??
      2:
        FHCView.ApplyParaLineSpace(TParaLineSpaceMode.pls150); // 1.5??
      3:
        FHCView.ApplyParaLineSpace(TParaLineSpaceMode.pls200); // ????
      4:
        FHCView.ApplyParaLineSpace(TParaLineSpaceMode.plsFix); // ??????
    end;
  end;
end;

procedure TfrmHCViewDemo.mniMergeClick(Sender: TObject);
begin
  FHCView.MergeTableSelectCells;
end;

procedure TfrmHCViewDemo.mniModAnnotateClick(Sender: TObject);
var
  vFrmAnnotate: TfrmAnnotate;
begin
  vFrmAnnotate := TfrmAnnotate.Create(self);
  try
    vFrmAnnotate.SetAnnotate(FHCView.AnnotatePre.ActiveAnnotate);
  finally
    FreeAndNil(vFrmAnnotate);
  end;
end;

procedure TfrmHCViewDemo.mniN14Click(Sender: TObject);
begin
  FHCView.InsertLine(1);
end;

procedure TfrmHCViewDemo.mniN17Click(Sender: TObject);
begin
  FHCView.InsertDomain(nil);
end;

procedure TfrmHCViewDemo.mniN19Click(Sender: TObject);
var
  vExpressItem: THCExpressItem;
begin
  vExpressItem := THCExpressItem.Create(FHCView.ActiveSectionTopLevelData, '12', '5-6', '2017-6-3', '28-30');
  FHCView.InsertItem(vExpressItem);
end;

procedure TfrmHCViewDemo.mniDisBorderClick(Sender: TObject);
var
  vTable: THCTableItem;
begin
  if FHCView.ActiveSection.ActiveData.GetActiveItem is THCTableItem then
  begin
    vTable := FHCView.ActiveSection.ActiveData.GetActiveItem as THCTableItem;
    vTable.BorderVisible := not vTable.BorderVisible;
    FHCView.UpdateView;
  end;
end;

procedure TfrmHCViewDemo.mniEdit1Click(Sender: TObject);
var
  vEdit: THCEditItem;
  vS: string;
begin
  vS := '????';
  if InputQuery('??????', '????????', vS) then
  begin
    vEdit := THCEditItem.Create(FHCView.ActiveSectionTopLevelData, vS);
    FHCView.InsertItem(vEdit);
  end;
end;

procedure TfrmHCViewDemo.mniExploreClick(Sender: TObject);
var
  vDlg: TSaveDialog;
  vExt: string;
begin
  vDlg := TSaveDialog.Create(self);
  try
    vDlg.Filter := 'pdf????|*.pdf' + '|htm????|*.html';
    vDlg.Execute;
    if vDlg.fileName <> '' then
    begin
      vExt := '';
      case vDlg.FilterIndex of
        1:
          vExt := '.pdf';
        2:
          vExt := '.html';
      else
        Exit;
      end;

      if ExtractFileExt(vDlg.fileName) <> vExt then // ????????????
        vDlg.fileName := vDlg.fileName + vExt;

      case vDlg.FilterIndex of
        1:
          FHCView.SaveToPDF(vDlg.fileName);
        2:
          FHCView.SaveToHtml(vDlg.fileName, False);
      end;
    end;
  finally
    vDlg.Free;
  end;
end;

procedure TfrmHCViewDemo.mnigif1Click(Sender: TObject);
var
  vOpenDlg: TOpenDialog;
  vGifItem: THCGifItem;
begin
  vOpenDlg := TOpenDialog.Create(self);
  try
    vOpenDlg.Filter := '????????|*.gif';
    if vOpenDlg.Execute then
    begin
      if vOpenDlg.fileName <> '' then
      begin
        vGifItem := THCGifItem.Create(FHCView.ActiveSectionTopLevelData);
        vGifItem.LoadFromFile(vOpenDlg.fileName);
        Application.ProcessMessages; // ??????????????????????????????????Mousemove??Mouseup????
        FHCView.InsertItem(vGifItem);
      end;
    end;
  finally
    FreeAndNil(vOpenDlg);
  end;
end;

procedure TfrmHCViewDemo.mniHyperLinkClick(Sender: TObject);
var
  vTopData: THCCustomData;
  vTextItem: THCTextItem;
begin
  vTopData := FHCView.ActiveSectionTopLevelData;
  vTextItem := vTopData.CreateDefaultTextItem as THCTextItem;
  vTextItem.Text := '????????';
  vTextItem.HyperLink := 'www.baidu.com';
  FHCView.InsertItem(vTextItem);
end;

procedure TfrmHCViewDemo.mniInsertRowTopClick(Sender: TObject);
begin
  FHCView.ActiveTableInsertRowBefor(1);
end;

procedure TfrmHCViewDemo.mniInsertRowBottomClick(Sender: TObject);
begin
  FHCView.ActiveTableInsertRowAfter(1);
end;

procedure TfrmHCViewDemo.mniInsertColLeftClick(Sender: TObject);
begin
  FHCView.ActiveTableInsertColBefor(1);
end;

procedure TfrmHCViewDemo.mniInsertColRightClick(Sender: TObject);
begin
  FHCView.ActiveTableInsertColAfter(1);
end;

procedure TfrmHCViewDemo.mniDeleteCurRowClick(Sender: TObject);
begin
  FHCView.ActiveTableDeleteCurRow;
end;

procedure TfrmHCViewDemo.mniDelAnnotateClick(Sender: TObject);
begin
  FHCView.AnnotatePre.DeleteDataAnnotateByDraw(FHCView.AnnotatePre.ActiveDrawAnnotateIndex);
end;

procedure TfrmHCViewDemo.mniDeleteCurColClick(Sender: TObject);
begin
  FHCView.ActiveTableDeleteCurCol;
end;

procedure TfrmHCViewDemo.mniN23Click(Sender: TObject);
var
  vQRCode: THCQRCodeItem;
  vS: string;
begin
  vS := InputBox('??????', '????', 'HCView??????DelphiZXingQRCode??????????');
  vQRCode := THCQRCodeItem.Create(FHCView.ActiveSectionTopLevelData, vS);
  FHCView.InsertItem(vQRCode);
end;

procedure TfrmHCViewDemo.mniParaClick(Sender: TObject);
var
  vFrmParagraph: TfrmParagraph;
begin
  vFrmParagraph := TfrmParagraph.Create(self);
  try
    vFrmParagraph.SetView(FHCView);
  finally
    FreeAndNil(vFrmParagraph);
  end;
end;

procedure TfrmHCViewDemo.mniN27Click(Sender: TObject);
begin
  FHCView.InsertPageBreak;
end;

procedure TfrmHCViewDemo.mniN28Click(Sender: TObject);
begin
  FHCView.InsertSectionBreak;
end;

procedure TfrmHCViewDemo.mniN2Click(Sender: TObject);
var
  vFrmAnnotate: TfrmAnnotate;
begin
  if not FHCView.ActiveSection.SelectExists then
    Exit;

  vFrmAnnotate := TfrmAnnotate.Create(self);
  try
    vFrmAnnotate.SetAnnotate(nil);
    if vFrmAnnotate.ModalResult = mrOk then
      FHCView.InsertAnnotate(vFrmAnnotate.edtTitle.Text, vFrmAnnotate.mmoText.Text);
  finally
    FreeAndNil(vFrmAnnotate);
  end;
end;

procedure TfrmHCViewDemo.mniInsertTableClick(Sender: TObject);
var
  vFrmInsertTable: TfrmInsertTable;
begin
  vFrmInsertTable := TfrmInsertTable.Create(self);
  try
    vFrmInsertTable.ShowModal;
    if vFrmInsertTable.ModalResult = mrOk then
    begin
      FHCView.InsertTable(StrToInt(vFrmInsertTable.edtRows.Text), StrToInt(vFrmInsertTable.edtCols.Text));
    end;
  finally
    FreeAndNil(vFrmInsertTable);
  end;
end;

procedure TfrmHCViewDemo.mniN30Click(Sender: TObject);
begin
  FHCView.DeleteSelected;
end;

procedure TfrmHCViewDemo.mniN31Click(Sender: TObject);
begin
  FHCView.DeleteActiveSection;
end;

procedure TfrmHCViewDemo.mniN32Click(Sender: TObject);
var
  vMemory: TMemoryStream;
  vOpenDlg: TOpenDialog;
begin
  vOpenDlg := TOpenDialog.Create(self);
  try
    vOpenDlg.Filter := '????|*' + HC_EXT;
    if vOpenDlg.Execute then
    begin
      if vOpenDlg.fileName <> '' then
      begin
        vMemory := TMemoryStream.Create;
        try
          vMemory.LoadFromFile(vOpenDlg.fileName);
          FHCView.InsertStream(vMemory);
        finally
          FreeAndNil(vMemory);
        end;
      end;
    end;
  finally
    FreeAndNil(vOpenDlg);
  end;
end;

procedure TfrmHCViewDemo.mniN33Click(Sender: TObject);
var
  vHCBarCode: THCBarCodeItem;
  vS: string;
begin
  vS := InputBox('??????', '????', 'HC-' + FormatDateTime('YYYYMMDD', Now));
  vHCBarCode := THCBarCodeItem.Create(FHCView.ActiveSectionTopLevelData, vS);
  FHCView.InsertItem(vHCBarCode);
end;

procedure TfrmHCViewDemo.mniN34Click(Sender: TObject);
var
  vFractionItem: THCFractionItem;
begin
  vFractionItem := THCFractionItem.Create(FHCView.ActiveSectionTopLevelData, '12', '2018');
  // vFractionItem.LineHide := True;
  FHCView.InsertItem(vFractionItem);
end;

procedure TfrmHCViewDemo.mniN36Click(Sender: TObject);
begin
  FHCView.PrintCurPageByActiveLine('', False, False);
end;

procedure TfrmHCViewDemo.mniN37Click(Sender: TObject);
begin
  FHCView.PrintCurPageSelected('', False, False);
end;

procedure TfrmHCViewDemo.mniFloatBarCodeClick(Sender: TObject);
var
  vFloatBarCodeItem: THCFloatBarCodeItem;
begin
  vFloatBarCodeItem := THCFloatBarCodeItem.Create(FHCView.ActiveSection.ActiveData);
  FHCView.InsertFloatItem(vFloatBarCodeItem);
end;

procedure TfrmHCViewDemo.mniFloatLineClick(Sender: TObject);
var
  vFloatLineItem: THCFloatLineItem;
begin
  vFloatLineItem := THCFloatLineItem.Create(FHCView.ActiveSection.ActiveData);
  FHCView.InsertFloatItem(vFloatLineItem);
end;

procedure TfrmHCViewDemo.mniN42Click(Sender: TObject);
var
  vFrmPrintView: TfrmPrintView;
begin
  vFrmPrintView := TfrmPrintView.Create(self);
  try
    vFrmPrintView.SetView(FHCView);
  finally
    FreeAndNil(vFrmPrintView);
  end;
end;

procedure TfrmHCViewDemo.mniAlignTopLeftClick(Sender: TObject);
begin
  case (Sender as TMenuItem).Tag of
    0:
      FHCView.ApplyTableCellAlign(THCContentAlign.tcaTopLeft);
    1:
      FHCView.ApplyTableCellAlign(THCContentAlign.tcaTopCenter);
    2:
      FHCView.ApplyTableCellAlign(THCContentAlign.tcaTopRight);
    3:
      FHCView.ApplyTableCellAlign(THCContentAlign.tcaCenterLeft);
    4:
      FHCView.ApplyTableCellAlign(THCContentAlign.tcaCenterCenter);
    5:
      FHCView.ApplyTableCellAlign(THCContentAlign.tcaCenterRight);
    6:
      FHCView.ApplyTableCellAlign(THCContentAlign.tcaBottomLeft);
    7:
      FHCView.ApplyTableCellAlign(THCContentAlign.tcaBottomCenter);
    8:
      FHCView.ApplyTableCellAlign(THCContentAlign.tcaBottomRight);
  end;
end;

procedure TfrmHCViewDemo.mniBorderClick(Sender: TObject);
var
  vFrmBorderBackColor: TfrmBorderBackColor;
begin
  vFrmBorderBackColor := TfrmBorderBackColor.Create(self);
  try
    vFrmBorderBackColor.SetView(FHCView);
  finally
    FreeAndNil(vFrmBorderBackColor);
  end;
end;

procedure TfrmHCViewDemo.mniN44Click(Sender: TObject);
var
  vHCDateTimePicker: THCDateTimePicker;
begin
  vHCDateTimePicker := THCDateTimePicker.Create(FHCView.ActiveSectionTopLevelData, Now);
  FHCView.InsertItem(vHCDateTimePicker);
end;

procedure TfrmHCViewDemo.mniN45Click(Sender: TObject);
var
  vSupSubScriptItem: THCSupSubScriptItem;
begin
  vSupSubScriptItem := THCSupSubScriptItem.Create(FHCView.ActiveSectionTopLevelData, '20g', '????');
  FHCView.InsertItem(vSupSubScriptItem);
end;

procedure TfrmHCViewDemo.mniN46Click(Sender: TObject);
begin
  btnprintClick(Sender);
end;

procedure TfrmHCViewDemo.mniSplitRowClick(Sender: TObject);
begin
  FHCView.ActiveTableSplitCurRow;
end;

procedure TfrmHCViewDemo.mniSplitColClick(Sender: TObject);
begin
  FHCView.ActiveTableSplitCurCol;
end;

procedure TfrmHCViewDemo.mniN4Click(Sender: TObject);
var
  vText: string;
begin
  vText := InputBox('????????', '', '');
  if vText <> '' then
    FHCView.InsertText(vText);
end;

procedure TfrmHCViewDemo.mniN5Click(Sender: TObject);
var
  vFrmPageSet: TFrmPageSet;
begin
  vFrmPageSet := TFrmPageSet.Create(self);
  try
    vFrmPageSet.SetView(FHCView);
  finally
    FreeAndNil(vFrmPageSet);
  end;
end;

procedure TfrmHCViewDemo.mniN9Click(Sender: TObject);
var
  vOpenDlg: TOpenDialog;
  vImageItem: THCImageItem;
  vTopData: THCRichData;
begin
  vOpenDlg := TOpenDialog.Create(self);
  try
    vOpenDlg.Filter := '????????|*.bmp; *.jpg; *.jpeg; *.png|Windows Bitmap|*.bmp|JPEG ????|*.jpg; *.jpge|??????????????|*.png';
    if vOpenDlg.Execute then
    begin
      if vOpenDlg.fileName <> '' then
      begin
        vTopData := FHCView.ActiveSectionTopLevelData as THCRichData;
        vImageItem := THCImageItem.Create(vTopData);
        vImageItem.LoadGraphicFile(vOpenDlg.fileName);
        vImageItem.RestrainSize(vTopData.Width, vImageItem.Height);
        Application.ProcessMessages; // ??????????????????????????????????Mousemove??Mouseup????
        FHCView.InsertItem(vImageItem);
      end;
    end;
  finally
    FreeAndNil(vOpenDlg);
  end;
end;

procedure TfrmHCViewDemo.mniOpenClick(Sender: TObject);
var
  vOpenDlg: TOpenDialog;
  vExt: string;
begin
  vOpenDlg := TOpenDialog.Create(self);
  try
    vOpenDlg.Filter := '??????????|*' + HC_EXT + '; *.xml; *.docx|HCView (*.hcf)|*' + HC_EXT + '|HCView xml (*.xml)|*.xml|Word 2007 Document (*.docx)|*.docx';
    if vOpenDlg.Execute then
    begin
      if vOpenDlg.fileName <> '' then
      begin
        Application.ProcessMessages; // ??????????????????????????????????Mousemove??Mouseup????
        vExt := LowerCase(ExtractFileExt(vOpenDlg.fileName)); // ????
        if vExt = HC_EXT then
          FHCView.LoadFromFile(vOpenDlg.fileName)
        else if vExt = '.xml' then
          FHCView.LoadFromXml(vOpenDlg.fileName)
        else
          FHCView.LoadFromDocumentFile(vOpenDlg.fileName, vExt);
      end;
    end;
  finally
    FreeAndNil(vOpenDlg);
  end;
end;

procedure TfrmHCViewDemo.mniControlItemClick(Sender: TObject);
var
  vFrmControlItemProperty: TfrmControlItemProperty;
begin
  vFrmControlItemProperty := TfrmControlItemProperty.Create(nil);
  try
    vFrmControlItemProperty.SetView(FHCView);
  finally
    FreeAndNil(vFrmControlItemProperty);
  end;
end;

procedure TfrmHCViewDemo.mniRadioButton1Click(Sender: TObject);
var
  vHCRadioGroup: THCRadioGroup;
begin
  vHCRadioGroup := THCRadioGroup.Create(FHCView.ActiveSectionTopLevelData);
  vHCRadioGroup.AddItem('????1');
  vHCRadioGroup.AddItem('????2');
  vHCRadioGroup.AddItem('????3');
  FHCView.InsertItem(vHCRadioGroup);
end;

procedure TfrmHCViewDemo.mniSaveAsClick(Sender: TObject);
var
  vDlg: TSaveDialog;
  vExt: string;
begin
  vDlg := TSaveDialog.Create(self);
  try
    vDlg.Filter := 'HCView|*' + HC_EXT + '|HCView xml|*.xml|Word 2007 Document (*.docx)|*.docx';
    vDlg.Execute;
    if vDlg.fileName <> '' then
    begin
      vExt := '';
      case vDlg.FilterIndex of
        1:
          vExt := HC_EXT;
        2:
          vExt := '.xml';
        3:
          vExt := '.docx';
      else
        Exit;
      end;

      if ExtractFileExt(vDlg.fileName) <> vExt then // ????????????
        vDlg.fileName := vDlg.fileName + vExt;

      case vDlg.FilterIndex of
        1: // .hcf
          begin
            FHCView.SaveToFile(vDlg.fileName);
            SetFileName(vDlg.fileName);
          end;

        2:
          FHCView.SaveToXML(vDlg.fileName, TEncoding.UTF8); // xml

        3:
          FHCView.SaveToDocumentFile(vDlg.fileName, vExt)
      end;
    end;
  finally
    vDlg.Free;
  end;
end;

procedure TfrmHCViewDemo.mniSaveClick(Sender: TObject);
begin
  if SaveFile then
    statbar.Panels[1].Text := '????????' // ShowMessage('??????????');
  else
    statbar.Panels[1].Text := '????????';
end;

procedure TfrmHCViewDemo.mniTablePropertyClick(Sender: TObject);
var
  vFrmTableProperty: TFrmTableProperty;
begin
  vFrmTableProperty := TFrmTableProperty.Create(self);
  try
    vFrmTableProperty.SetView(FHCView);
  finally
    FreeAndNil(vFrmTableProperty);
  end;
end;

procedure TfrmHCViewDemo.mniViewFilmClick(Sender: TObject);
begin
  FHCView.ViewModel := THCViewModel.hvmFilm;
  FHRuler.Visible := True;
  FVRuler.Visible := True;
end;

procedure TfrmHCViewDemo.mniViewPageClick(Sender: TObject);
begin
  FHCView.ViewModel := THCViewModel.hvmPage;
  FHRuler.Visible := False;
  FVRuler.Visible := False;
end;

procedure TfrmHCViewDemo.mniViewTextClick(Sender: TObject);
begin
  FHCView.ViewModel := THCViewModel.hvmEdit;
  FHRuler.Visible := False;
  FVRuler.Visible := False;
end;

procedure TfrmHCViewDemo.N1Click(Sender: TObject);
begin
  FHCView.InsertText(FormatDateTime('yyy-MM-dd hh:nn:ss', Now));
end;

procedure TfrmHCViewDemo.pmLineSpacePopup(Sender: TObject);
begin
  case FHCView.Style.ParaStyles[FHCView.CurParaNo].LineSpaceMode of
    pls100:
      mniLS100.Checked := True;
    pls115:
      mniLS115.Checked := True;
    pls150:
      mniLS150.Checked := True;
    pls200:
      mniLS200.Checked := True;
    plsFix:
      mniLSFix.Checked := True;
  end;
end;

procedure TfrmHCViewDemo.pmHCViewPopup(Sender: TObject);
var
  i: Integer;
  vActiveItem, vTopItem: THCCustomItem;
  vTableItem: THCTableItem;
  vActiveData, vTopData: THCCustomData;
begin
  if FHCView.AnnotatePre.ActiveDrawAnnotateIndex >= 0 then // ??????????????????????
  begin
    for i := 0 to pmHCView.Items.Count - 1 do
      pmHCView.Items[i].Visible := False;

    mniModAnnotate.Visible := True;
    mniDelAnnotate.Visible := True;
    Exit;
  end
  else
  begin
    for i := 0 to pmHCView.Items.Count - 1 do
      pmHCView.Items[i].Visible := True;

    mniModAnnotate.Visible := False;
    mniDelAnnotate.Visible := False;
  end;

  vActiveData := FHCView.ActiveSection.ActiveData;
  vActiveItem := vActiveData.GetActiveItem;

  // if vActiveItem = nil then Exit;

  vTopData := nil;
  vTopItem := vActiveItem;

  while vTopItem is THCCustomRectItem do
  begin
    if (vTopItem as THCCustomRectItem).GetTopLevelData <> nil then
    begin
      if vTopData <> nil then
      begin
        vActiveData := vTopData;
        vActiveItem := vTopItem;
      end;

      vTopData := (vTopItem as THCCustomRectItem).GetTopLevelData;
      vTopItem := vTopData.GetActiveItem;
    end
    else
      Break;
  end;

  if vTopData = nil then
    vTopData := vActiveData;

  mniTable.Visible := vActiveItem.StyleNo = THCStyle.Table;
  if mniTable.Visible then
  begin
    vTableItem := vActiveItem as THCTableItem;
    mniInsertRowTop.Enabled := vTableItem.GetEditCell <> nil;
    mniInsertRowBottom.Enabled := mniInsertRowTop.Enabled;
    mniInsertColLeft.Enabled := mniInsertRowTop.Enabled;
    mniInsertColRight.Enabled := mniInsertRowTop.Enabled;
    mniSplitRow.Enabled := mniInsertRowTop.Enabled;
    mniSplitCol.Enabled := mniInsertRowTop.Enabled;

    mniDeleteCurRow.Enabled := vTableItem.CurRowCanDelete;
    mniDeleteCurCol.Enabled := vTableItem.CurColCanDelete;
    mniMerge.Enabled := vTableItem.SelectedCellCanMerge;

    if vTableItem.BorderVisible then
      mniDisBorder.Caption := '????????'
    else
      mniDisBorder.Caption := '????????';
  end;
  actCut.Enabled := (not FHCView.ActiveSection.ReadOnly) and vTopData.SelectExists;
  actCopy.Enabled := actCut.Enabled;
  actPaste.Enabled := (not FHCView.ActiveSection.ReadOnly); // ??????
  if actPaste.Enabled then
  begin
    if (vTopItem is THCEditItem) and not(vTopItem as THCEditItem).IsSelectComplate then
      actPaste.Enabled := Clipboard.HasFormat(CF_TEXT) or Clipboard.HasFormat(CF_UNICODETEXT)
    else
    begin
      actPaste.Enabled := (Clipboard.HasFormat(HC_FILEFORMAT) or Clipboard.HasFormat(CF_TEXT) or Clipboard.HasFormat(CF_UNICODETEXT) or Clipboard.HasFormat(CF_BITMAP));
    end;
  end;

  mniControlItem.Visible := (not FHCView.ActiveSection.ReadOnly) and (not vTopData.SelectExists) and (vTopItem is THCControlItem) and vTopItem.Active;
  if mniControlItem.Visible then
    mniControlItem.Caption := '????(' + (vTopItem as THCControlItem).ClassName + ')';
end;

function TfrmHCViewDemo.SaveFile: Boolean;
var
  vDlg: TSaveDialog;
begin
  Result := False;

  if FHCView.fileName <> '' then
  begin
    FHCView.SaveToFile(FHCView.fileName);
    FHCView.IsChanged := False;
    Result := True;
  end
  else
  begin
    vDlg := TSaveDialog.Create(self);
    try
      vDlg.Filter := 'HCView (*.hcf)|*' + HC_EXT + '|HCView xml (*.xml)|*.xml|Word 2007 Document (*.docx)|*.docx';
      vDlg.Execute;
      if vDlg.fileName <> '' then
      begin
        case vDlg.FilterIndex of
          1:
            begin
              if ExtractFileExt(vDlg.fileName) <> HC_EXT then
                vDlg.fileName := vDlg.fileName + HC_EXT;

              FHCView.SaveToFile(vDlg.fileName);
              FHCView.IsChanged := False;
              Result := True;
              SetFileName(vDlg.fileName);
            end;

          2:
            begin
              if LowerCase(ExtractFileExt(vDlg.fileName)) <> '.xml' then
                vDlg.fileName := vDlg.fileName + '.xml';

              FHCView.SaveToXML(vDlg.fileName, TEncoding.Unicode);
              FHCView.IsChanged := False;
              Result := True;
            end;

          3: // .docx
            begin
              if LowerCase(ExtractFileExt(vDlg.fileName)) <> HC_EXT_DOCX then
                vDlg.fileName := vDlg.fileName + HC_EXT_DOCX;

              FHCView.SaveToDocumentFile(vDlg.fileName, HC_EXT_DOCX);
              FHCView.IsChanged := False;
              Result := True;
            end;
        end;
      end;
    finally
      vDlg.Free;
    end;
  end;
end;

procedure TfrmHCViewDemo.SetFileName(const AFileName: string);
begin
  FHCView.fileName := AFileName;
  statbar.Panels[2].Text := FHCView.fileName;
end;

end.

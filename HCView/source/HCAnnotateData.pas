{*******************************************************}
{                                                       }
{               HCView V1.1  ���ߣ���ͨ                 }
{                                                       }
{      ��������ѭBSDЭ�飬����Լ���QQȺ 649023932      }
{            ����ȡ����ļ������� 2018-12-3             }
{                                                       }
{            ֧����ע���ܵ��ĵ��������Ԫ             }
{                                                       }
{*******************************************************}

unit HCAnnotateData;

interface

uses
  Windows, Classes, Controls, Graphics, SysUtils, Generics.Collections, HCCustomData,
  HCRichData, HCItem, HCStyle, HCParaStyle, HCTextStyle, HCTextItem, HCRectItem,
  HCCommon, HCList;

type
  THCDataAnnotate = class(TSelectInfo)  // Data��ע��Ϣ
  private
    FID, FStartDrawItemNo, FEndDrawItemNo: Integer;
    FTitle, FText: string;
  public
    procedure Initialize; override;
    procedure CopyRange(const ASrc: TSelectInfo);
    procedure SaveToStream(const AStream: TStream);
    procedure LoadFromStream(const AStream: TStream; const AFileVersion: Word);
    property ID: Integer read FID write FID;
    property StartDrawItemNo: Integer read FStartDrawItemNo write FStartDrawItemNo;
    property EndDrawItemNo: Integer read FEndDrawItemNo write FEndDrawItemNo;
    property Title: string read FTitle write FTitle;
    property Text: string read FText write FText;
  end;

  THCDataAnnotates = class(TObjectList<THCDataAnnotate>)
  private
    FOnInsertAnnotate, FOnRemoveAnnotate: TNotifyEvent;
  protected
    procedure Notify(const Value: THCDataAnnotate; Action: TCollectionNotification); override;
  public
    procedure DeleteByID(const AID: Integer);
    procedure NewDataAnnotate(const ASelectInfo: TSelectInfo; const ATitle, AText: string);
    property OnInsertAnnotate: TNotifyEvent read FOnInsertAnnotate write FOnInsertAnnotate;
    property OnRemoveAnnotate: TNotifyEvent read FOnRemoveAnnotate write FOnRemoveAnnotate;
  end;

  THCAnnotateMark = (amFirst, amNormal, amLast, amBoth);
  THCDrawItemAnnotate = class(TObject)  // DrawItemע����ʱ��Ӧ������Ϣ
  public
    DrawRect: TRect;
    Mark: THCAnnotateMark;
    DataAnnotate: THCDataAnnotate;

    function First: Boolean;
    function Last: Boolean;
  end;

  THCDrawItemAnnotates = class(TObjectList<THCDrawItemAnnotate>)  // ĳDrawItem��Ӧ��������ע��Ϣ
  public
    procedure NewDrawAnnotate(const ARect: TRect; const AMark: THCAnnotateMark;
      const ADataAnnotate: THCDataAnnotate);
  end;

  TDataDrawItemAnnotateEvent = procedure(const AData: THCCustomData; const ADrawItemNo: Integer;
    const ADrawRect: TRect; const ADataAnnotate: THCDataAnnotate) of object;
  TDataAnnotateEvent = procedure(const AData: THCCustomData; const ADataAnnotate: THCDataAnnotate) of object;

  THCAnnotateData = class(THCRichData)  // ֧����ע���ܵ�Data��
  private
    FDataAnnotates: THCDataAnnotates;
    FHotAnnotate, FActiveAnnotate: THCDataAnnotate;  // ��ǰ������ע����ǰ�������ע
    FDrawItemAnnotates: THCDrawItemAnnotates;
    FOnDrawItemAnnotate: TDataDrawItemAnnotateEvent;
    FOnInsertAnnotate, FOnRemoveAnnotate: TDataAnnotateEvent;

    /// <summary> ��ȡָ����DrawItem��������ע�Լ��ڸ���ע�е����� </summary>
    /// <param name="ADrawItemNo"></param>
    /// <param name="ACanvas">Ӧ����DrawItem��ʽ��Canvas</param>
    /// <returns></returns>
    function DrawItemOfAnnotate(const ADrawItemNo: Integer;
      const ACanvas: TCanvas; const ADrawRect: TRect): Boolean;

    /// <summary> ָ��DrawItem��Χ�ڵ���ע��ȡ���Ե�DrawItem��Χ </summary>
    /// <param name="AFirstDrawItemNo">��ʼDrawItem</param>
    /// <param name="ALastDrawItemNo">����DrawItem</param>
    procedure CheckAnnotateRange(const AFirstDrawItemNo, ALastDrawItemNo: Integer);  // ������PaintData�ﴦ��ģ�Ӧ�������ݱ䶯��ʹ���ã�������ӿ�PaintData��Ч��

    function GetDrawItemFirstDataAnnotateAt(const ADrawItemNo, X, Y: Integer): THCDataAnnotate;
  protected
    procedure DoLoadFromStream(const AStream: TStream; const AStyle: THCStyle;
      const AFileVersion: Word); override;
    procedure DoItemAction(const AItemNo, AOffset: Integer; const AAction: THCAction); override;
    procedure DoDrawItemPaintContent(const AData: THCCustomData; const AItemNo, ADrawItemNo: Integer;
      const ADrawRect, AClearRect: TRect; const ADrawText: string;
      const ADataDrawLeft, ADataDrawRight, ADataDrawBottom, ADataScreenTop, ADataScreenBottom: Integer;
      const ACanvas: TCanvas; const APaintInfo: TPaintInfo); override;
    procedure DoInsertAnnotate(Sender: TObject);
    procedure DoRemoveAnnotate(Sender: TObject);
  public
    constructor Create(const AStyle: THCStyle); override;
    destructor Destroy; override;

    procedure GetCaretInfo(const AItemNo, AOffset: Integer; var ACaretInfo: THCCaretInfo); override;
    procedure PaintData(const ADataDrawLeft, ADataDrawTop, ADataDrawRight, ADataDrawBottom,
      ADataScreenTop, ADataScreenBottom, AVOffset, AFirstDItemNo, ALastDItemNo: Integer;
      const ACanvas: TCanvas; const APaintInfo: TPaintInfo); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure InitializeField; override;
    procedure Clear; override;
    procedure SaveToStream(const AStream: TStream); override;

    function InsertAnnotate(const ATitle, AText: string): Boolean;
    property DataAnnotates: THCDataAnnotates read FDataAnnotates;
    property HotAnnotate: THCDataAnnotate read FHotAnnotate;
    property ActiveAnnotate: THCDataAnnotate read FActiveAnnotate;
    property OnDrawItemAnnotate: TDataDrawItemAnnotateEvent read FOnDrawItemAnnotate write FOnDrawItemAnnotate;
    property OnInsertAnnotate: TDataAnnotateEvent read FOnInsertAnnotate write FOnInsertAnnotate;
    property OnRemoveAnnotate: TDataAnnotateEvent read FOnRemoveAnnotate write FOnRemoveAnnotate;
  end;

implementation

{ THCAnnotateData }

procedure THCAnnotateData.CheckAnnotateRange(const AFirstDrawItemNo, ALastDrawItemNo: Integer);
var
  i, vFirstNo, vLastNo: Integer;
  vDataAnnotate: THCDataAnnotate;
  vDrawRect: TRect;
  vRectItem: THCCustomRectItem;
begin
  if AFirstDrawItemNo < 0 then Exit;

  vFirstNo := Self.DrawItems[AFirstDrawItemNo].ItemNo;
  vLastNo := Self.DrawItems[ALastDrawItemNo].ItemNo;

  for i := 0 to FDataAnnotates.Count - 1 do
  begin
    vDataAnnotate := FDataAnnotates[i];

    if vDataAnnotate.EndItemNo < vFirstNo then  // δ���뱾�β��ҷ�Χ
      Continue;

    if vDataAnnotate.StartItemNo > vLastNo then  // �������β��ҵķ�Χ
      Break;

    vDataAnnotate.StartDrawItemNo :=
      Self.GetDrawItemNoByOffset(vDataAnnotate.StartItemNo, vDataAnnotate.StartItemOffset);
    vDataAnnotate.EndDrawItemNo :=
      Self.GetDrawItemNoByOffset(vDataAnnotate.EndItemNo, vDataAnnotate.EndItemOffset);
    if vDataAnnotate.EndItemOffset = Self.DrawItems[vDataAnnotate.EndDrawItemNo].CharOffs then  // ����ڽ�������ǰ�棬����һ��
      vDataAnnotate.EndDrawItemNo := vDataAnnotate.EndDrawItemNo - 1;
  end;

  {for i := AFirstDrawItemNo to ALastDrawItemNo do
  begin
    vDrawRect := DrawItems[i].Rect;
    if vDrawRect.Top > AFmtBottom then
      Break;

    if GetDrawItemStyle(i) < THCStyle.Null then
    begin
      vRectItem := Items[DrawItems[i].ItemNo] as THCCustomRectItem;

      vLineSpace := GetLineSpace(i);
      InflateRect(vDrawRect, 0, -vLineSpace div 2);  // ��ȥ�м�ྻRect�������ݵ���ʾ����

      if vRectItem.JustifySplit then  // ��ɢռ�ռ�
      begin
        vAlignHorz := Style.ParaStyles[vRectItem.ParaNo].AlignHorz;
        if ((vAlignHorz = pahJustify) and (not IsLineLastDrawItem(i)))  // ���˶����Ҳ��Ƕ����
          or (vAlignHorz = pahScatter)  // ��ɢ����
        then
          vDrawRect.Inflate(-(vDrawRect.Width - vRectItem.Width) div 2, 0)
        else
          vDrawRect.Right := vDrawRect.Left + vRectItem.Width;
      end;

      case Style.ParaStyles[vRectItem.ParaNo].AlignVert of  // ��ֱ���뷽ʽ
        pavCenter: InflateRect(vDrawRect, 0, -(vDrawRect.Height - vRectItem.Height) div 2);
        pavTop: ;
      else
        vDrawRect.Top := vDrawRect.Bottom - vRectItem.Height;
      end;

      vRectItem.CheckAnnotate(vDrawRect.Left + AHorzOffset, vDrawRect.Top + AVertOffset,
        Min(vRectItem.Height, AFmtBottom - vDrawRect.Top));
    end
    else
    if DrawItems[i].Rect.Bottom > AFmtTop then  // DrawItem��ʽ��������Ҫ�жϵĸ�ʽ��������
    begin
      if DrawItemBelongAnnotate(i, vDrawRect) then
      begin
        vDrawRect.Offset(AHorzOffset, AVertOffset);
        FOnAnnotateDrawItem(Self, i, vDrawRect);
      end;
    end;
  end; }
end;

procedure THCAnnotateData.Clear;
begin
  FDataAnnotates.Clear;
  inherited Clear;
end;

constructor THCAnnotateData.Create(const AStyle: THCStyle);
begin
  FDataAnnotates := THCDataAnnotates.Create;
  FDataAnnotates.OnInsertAnnotate := DoInsertAnnotate;
  FDataAnnotates.OnRemoveAnnotate := DoRemoveAnnotate;
  FDrawItemAnnotates := THCDrawItemAnnotates.Create;
  inherited Create(AStyle);
  FHotAnnotate := nil;
  FActiveAnnotate := nil;
end;

destructor THCAnnotateData.Destroy;
begin
  FreeAndNil(FDataAnnotates);
  FreeAndNil(FDrawItemAnnotates);
  inherited Destroy;
end;

procedure THCAnnotateData.DoDrawItemPaintContent(const AData: THCCustomData;
  const AItemNo, ADrawItemNo: Integer; const ADrawRect, AClearRect: TRect;
  const ADrawText: string; const ADataDrawLeft, ADataDrawRight, ADataDrawBottom,
  ADataScreenTop, ADataScreenBottom: Integer; const ACanvas: TCanvas;
  const APaintInfo: TPaintInfo);
var
  i: Integer;
  vActive: Boolean;
  vDrawAnnotate: THCDrawItemAnnotate;
begin
  if Assigned(FOnDrawItemAnnotate) and DrawItemOfAnnotate(ADrawItemNo, ACanvas, AClearRect) then  // ��ǰDrawItem��ĳ��ע�е�һ����
  begin
    for i := 0 to FDrawItemAnnotates.Count - 1 do  // ��DrawItem������ע��Ϣ
    begin
      vDrawAnnotate := FDrawItemAnnotates[i];

      if not APaintInfo.Print then
      begin
        vActive := vDrawAnnotate.DataAnnotate.Equals(FHotAnnotate) or
          vDrawAnnotate.DataAnnotate.Equals(FActiveAnnotate);

        if vActive then
          ACanvas.Brush.Color := AnnotateBKActiveColor
        else
          ACanvas.Brush.Color := AnnotateBKColor;

        ACanvas.FillRect(vDrawAnnotate.DrawRect);
      end;

      if vDrawAnnotate.First then  // ����עͷ [
      begin
        ACanvas.Pen.Color := clRed;
        ACanvas.MoveTo(vDrawAnnotate.DrawRect.Left + 2, vDrawAnnotate.DrawRect.Top - 2);
        ACanvas.LineTo(vDrawAnnotate.DrawRect.Left, vDrawAnnotate.DrawRect.Top);
        ACanvas.LineTo(vDrawAnnotate.DrawRect.Left, vDrawAnnotate.DrawRect.Bottom);
        ACanvas.LineTo(vDrawAnnotate.DrawRect.Left + 2, vDrawAnnotate.DrawRect.Bottom + 2);
      end;

      if vDrawAnnotate.Last then  // ����עβ ]
      begin
        ACanvas.Pen.Color := clRed;
        ACanvas.MoveTo(vDrawAnnotate.DrawRect.Right - 2, vDrawAnnotate.DrawRect.Top - 2);
        ACanvas.LineTo(vDrawAnnotate.DrawRect.Right, vDrawAnnotate.DrawRect.Top);
        ACanvas.LineTo(vDrawAnnotate.DrawRect.Right, vDrawAnnotate.DrawRect.Bottom);
        ACanvas.LineTo(vDrawAnnotate.DrawRect.Right - 2, vDrawAnnotate.DrawRect.Bottom + 2);

        FOnDrawItemAnnotate(AData, ADrawItemNo, vDrawAnnotate.DrawRect, vDrawAnnotate.DataAnnotate);
      end;
    end;
  end;

  inherited DoDrawItemPaintContent(AData, AItemNo, ADrawItemNo, ADrawRect, AClearRect,
    ADrawText, ADataDrawLeft, ADataDrawRight, ADataDrawBottom, ADataScreenTop,
    ADataScreenBottom, ACanvas, APaintInfo);
end;

procedure THCAnnotateData.DoInsertAnnotate(Sender: TObject);
begin
  Style.UpdateInfoRePaint;
  if Assigned(FOnInsertAnnotate) then
    FOnInsertAnnotate(Self, THCDataAnnotate(Sender));
end;

procedure THCAnnotateData.DoItemAction(const AItemNo, AOffset: Integer;
  const AAction: THCAction);

  procedure _AnnotateRemove;
  begin

  end;

  {$REGION '�����ַ�'}
  procedure _AnnotateInsertChar;
  var
    i: Integer;
    vDataAnn: THCDataAnnotate;
  begin
    for i := FDataAnnotates.Count - 1 downto 0 do
    begin
      if FDataAnnotates[i].StartItemNo > AItemNo then  // �䶯�ڴ���ע֮ǰ
        Continue;
      if FDataAnnotates[i].EndItemNo < AItemNo then  // �䶯�ڴ���ע֮��
        Break;

      vDataAnn := FDataAnnotates[i];

      if vDataAnn.StartItemNo = AItemNo then  // ����ע��ʼItem
      begin
        if vDataAnn.EndItemNo = AItemNo then  // ͬʱҲ����ע����Item(��ע��ͬһ��Item��)
        begin
          if AOffset <= vDataAnn.StartItemOffset then  // ����ע��ʼǰ��
          begin
            vDataAnn.StartItemOffset := vDataAnn.StartItemOffset + 1;
            vDataAnn.EndItemOffset := vDataAnn.EndItemOffset + 1;
          end
          else  // AOffset > vDataAnn.StartItemOffset
          if AOffset <= vDataAnn.EndItemOffset then  // ����ע�м�
            vDataAnn.EndItemOffset := vDataAnn.EndItemOffset + 1;

          if vDataAnn.StartItemOffset = vDataAnn.EndItemOffset then  // ɾ��û��
            FDataAnnotates.Delete(i);
        end
        else  // ��ע��ʼ�ͽ�������ͬһ��Item
        begin
          if AOffset <= vDataAnn.StartItemOffset then  // ����ע��ʼǰ��
            vDataAnn.StartItemOffset := vDataAnn.StartItemOffset + 1;
        end;
      end
      else
      if vDataAnn.EndItemNo = AItemNo then  // ����ע����Item
      begin
        if AOffset <= vDataAnn.EndItemOffset then  // ����ע�м�
          vDataAnn.EndItemOffset := vDataAnn.EndItemOffset + 1;
      end;
    end;
  end;
  {$ENDREGION}

  {$REGION 'Backspace��ɾ�����ַ�'}
  procedure _AnnotateBackChar;
  var
    i: Integer;
    vDataAnn: THCDataAnnotate;
  begin
    for i := FDataAnnotates.Count - 1 downto 0 do
    begin
      if FDataAnnotates[i].StartItemNo > AItemNo then  // �䶯�ڴ���ע֮ǰ
        Continue;
      if FDataAnnotates[i].EndItemNo < AItemNo then  // �䶯�ڴ���ע֮��
        Break;

      vDataAnn := FDataAnnotates[i];

      if vDataAnn.StartItemNo = AItemNo then  // ����ע��ʼItem
      begin
        if vDataAnn.EndItemNo = AItemNo then  // ͬʱҲ����ע����Item(��ע��ͬһ��Item��)
        begin
          if (AOffset > vDataAnn.StartItemOffset)  // ����ע��ʼ����
            and (AOffset <= vDataAnn.EndItemOffset)  // ����ע�м�
          then
            vDataAnn.EndItemOffset := vDataAnn.EndItemOffset - 1
          else
          if (AOffset <= vDataAnn.StartItemOffset) then  // ����ע���ڵ�Item��עλ��ǰ��ɾ��
          begin
            vDataAnn.StartItemOffset := vDataAnn.StartItemOffset - 1;
            vDataAnn.EndItemOffset := vDataAnn.EndItemOffset - 1
          end;

          if vDataAnn.StartItemOffset = vDataAnn.EndItemOffset then  // ɾ��û��
            FDataAnnotates.Delete(i);
        end
        else  // ��ע��ʼ�ͽ�������ͬһ��Item
        begin
          if AOffset >= vDataAnn.StartItemOffset then  // ����ע��ʼ����
            vDataAnn.StartItemOffset := vDataAnn.StartItemOffset - 1;
        end;
      end
      else
      if vDataAnn.EndItemNo = AItemNo then  // ����ע����Item
      begin
        if AOffset <= vDataAnn.EndItemOffset then  // ����ע�м�
          vDataAnn.EndItemOffset := vDataAnn.EndItemOffset - 1;
      end;
    end;
  end;
  {$ENDREGION}

  {$REGION 'Delete��ɾ�����ַ�'}
  procedure _AnnotateDeleteChar;
  var
    i: Integer;
    vDataAnn: THCDataAnnotate;
  begin
    for i := FDataAnnotates.Count - 1 downto 0 do
    begin
      if FDataAnnotates[i].StartItemNo > AItemNo then  // �䶯�ڴ���ע֮ǰ
        Continue;
      if FDataAnnotates[i].EndItemNo < AItemNo then  // �䶯�ڴ���ע֮��
        Break;

      vDataAnn := FDataAnnotates[i];

      if vDataAnn.StartItemNo = AItemNo then  // ����ע��ʼItem
      begin
        if vDataAnn.EndItemNo = AItemNo then  // ͬʱҲ����ע����Item(��ע��ͬһ��Item��)
        begin
          if AOffset <= vDataAnn.StartItemOffset then  // ����ע��ʼǰ��
          begin
            vDataAnn.StartItemOffset := vDataAnn.StartItemOffset - 1;
            vDataAnn.EndItemOffset := vDataAnn.EndItemOffset - 1;
          end
          else  // AOffset > vDataAnn.StartItemOffset
          if AOffset <= vDataAnn.EndItemOffset then  // ����ע�м�
            vDataAnn.EndItemOffset := vDataAnn.EndItemOffset - 1;

          if vDataAnn.StartItemOffset = vDataAnn.EndItemOffset then  // ɾ��û��
            FDataAnnotates.Delete(i);
        end
        else  // ��ע��ʼ�ͽ�������ͬһ��Item
        begin
          if AOffset <= vDataAnn.StartItemOffset then  // ����ע��ʼǰ��
            vDataAnn.StartItemOffset := vDataAnn.StartItemOffset - 1;
        end;
      end
      else
      if vDataAnn.EndItemNo = AItemNo then  // ����ע����Item
      begin
        if AOffset <= vDataAnn.EndItemOffset then  // ����ע�м�
          vDataAnn.EndItemOffset := vDataAnn.EndItemOffset - 1;
      end;
    end;
  end;
  {$ENDREGION}

begin
  case AAction of
    actDeleteItem: _AnnotateRemove;
    actInsertText: _AnnotateInsertChar;
    actBackDeleteText: _AnnotateBackChar;
    actDeleteText: _AnnotateDeleteChar;
  end;
end;

procedure THCAnnotateData.DoRemoveAnnotate(Sender: TObject);
begin
  Style.UpdateInfoRePaint;
  if Assigned(FOnRemoveAnnotate) then
    FOnRemoveAnnotate(Self, THCDataAnnotate(Sender));
end;

function THCAnnotateData.DrawItemOfAnnotate(const ADrawItemNo: Integer;
  const ACanvas: TCanvas; const ADrawRect: TRect): Boolean;
var
  i, vItemNo: Integer;
  vDataAnnotate: THCDataAnnotate;
begin
  Result := False;
  if FDataAnnotates.Count = 0 then Exit;

  vItemNo := Self.DrawItems[ADrawItemNo].ItemNo;
  if vItemNo < FDataAnnotates.First.StartItemNo then Exit;
  if vItemNo > FDataAnnotates.Last.EndItemNo then Exit;

  FDrawItemAnnotates.Clear;
  for i := 0 to FDataAnnotates.Count - 1 do
  begin
    vDataAnnotate := FDataAnnotates[i];

    if vDataAnnotate.EndItemNo < vItemNo then  // δ���뱾�β��ҷ�Χ
      Continue;

    if vDataAnnotate.StartItemNo > vItemNo then  // �������β��ҵķ�Χ
      Break;

    if ADrawItemNo = vDataAnnotate.StartDrawItemNo then
    begin
      if ADrawItemNo = vDataAnnotate.EndDrawItemNo then  // ��ǰDrawItem������ע��ʼ������ע����
      begin
        FDrawItemAnnotates.NewDrawAnnotate(
          Rect(ADrawRect.Left + GetDrawItemOffsetWidth(ADrawItemNo, vDataAnnotate.StartItemOffset - Self.DrawItems[ADrawItemNo].CharOffs + 1, ACanvas),
            ADrawRect.Top,
            ADrawRect.Left + GetDrawItemOffsetWidth(ADrawItemNo, vDataAnnotate.EndItemOffset - Self.DrawItems[ADrawItemNo].CharOffs + 1, ACanvas),
            ADrawRect.Bottom),
          amBoth, vDataAnnotate);
      end
      else  // ������עͷ
      begin
        FDrawItemAnnotates.NewDrawAnnotate(
          Rect(ADrawRect.Left + GetDrawItemOffsetWidth(ADrawItemNo, vDataAnnotate.StartItemOffset - Self.DrawItems[ADrawItemNo].CharOffs + 1, ACanvas),
            ADrawRect.Top, ADrawRect.Right, ADrawRect.Bottom),
          amFirst, vDataAnnotate);
      end;

      Result := True;
    end
    else
    if ADrawItemNo = vDataAnnotate.EndDrawItemNo then  // ��ǰDrawItem����ע����
    begin
      FDrawItemAnnotates.NewDrawAnnotate(
        Rect(ADrawRect.Left, ADrawRect.Top,
          ADrawRect.Left + GetDrawItemOffsetWidth(ADrawItemNo, vDataAnnotate.EndItemOffset - Self.DrawItems[ADrawItemNo].CharOffs + 1, ACanvas),
          ADrawRect.Bottom),
        amLast, vDataAnnotate);

      Result := True;
    end
    else
    if (ADrawItemNo > vDataAnnotate.StartDrawItemNo) and (ADrawItemNo < vDataAnnotate.EndDrawItemNo) then  // ��ǰDrawItem����ע��Χ��
    begin
      FDrawItemAnnotates.NewDrawAnnotate(ADrawRect, amNormal, vDataAnnotate);
      Result := True;
    end;
  end;
end;

procedure THCAnnotateData.GetCaretInfo(const AItemNo, AOffset: Integer;
  var ACaretInfo: THCCaretInfo);
var
  vDataAnnotate: THCDataAnnotate;
  vCaretDrawItemNo: Integer;
begin
  inherited GetCaretInfo(AItemNo, AOffset, ACaretInfo);

  if (not Style.UpdateInfo.DragingSelected) and SelectExists then  // ����ק����ѡ��
  begin
    if SelectInSameItem and (Items[SelectInfo.StartItemNo].StyleNo < THCStyle.Null) then  // RectItem���Լ������˹����ʾ���

    else
      ACaretInfo.Visible := False;
  end;

  if CaretDrawItemNo < 0 then
  begin
    if Style.UpdateInfo.DragingSelected then
      vCaretDrawItemNo := GetDrawItemNoByOffset(Self.MouseMoveItemNo, Self.MouseMoveItemOffset)
    else
      vCaretDrawItemNo := GetDrawItemNoByOffset(SelectInfo.StartItemNo, SelectInfo.StartItemOffset);
  end
  else
    vCaretDrawItemNo := CaretDrawItemNo;

  if Style.UpdateInfo.DragingSelected then
  begin
    vDataAnnotate := GetDrawItemFirstDataAnnotateAt(vCaretDrawItemNo,
      GetDrawItemOffsetWidth(vCaretDrawItemNo,
        Self.MouseMoveItemOffset - DrawItems[vCaretDrawItemNo].CharOffs + 1),
      DrawItems[vCaretDrawItemNo].Rect.Top + 1);
  end
  else
  begin
    vDataAnnotate := GetDrawItemFirstDataAnnotateAt(vCaretDrawItemNo,
      GetDrawItemOffsetWidth(vCaretDrawItemNo,
        SelectInfo.StartItemOffset - DrawItems[vCaretDrawItemNo].CharOffs + 1),
      DrawItems[vCaretDrawItemNo].Rect.Top + 1);
  end;

  if FActiveAnnotate <> vDataAnnotate then
  begin
    FActiveAnnotate := vDataAnnotate;
    Style.UpdateInfoRePaint;
  end;
end;

function THCAnnotateData.GetDrawItemFirstDataAnnotateAt(
  const ADrawItemNo, X, Y: Integer): THCDataAnnotate;
var
  i, vStyleNo: Integer;
  vPt: TPoint;
begin
  Result := nil;

  vStyleNo := GetDrawItemStyle(ADrawItemNo);
  if vStyleNo > THCStyle.Null then
    Style.ApplyTempStyle(vStyleNo);

  if DrawItemOfAnnotate(ADrawItemNo, Style.TempCanvas, DrawItems[ADrawItemNo].Rect) then
  begin
    vPt := Point(X, Y);
    for i := 0 to FDrawItemAnnotates.Count - 1 do
    begin
      if PtInRect(FDrawItemAnnotates[i].DrawRect, vPt) then
      begin
        Result := FDrawItemAnnotates[i].DataAnnotate;
        Break;  // ��ֻȡһ��
      end;
    end;
  end;
end;

procedure THCAnnotateData.InitializeField;
begin
  inherited InitializeField;
  FHotAnnotate := nil;
  FActiveAnnotate := nil;
end;

function THCAnnotateData.InsertAnnotate(const ATitle, AText: string): Boolean;
var
  vTopData: THCCustomData;
begin
  Result := False;
  if not CanEdit then Exit;
  if not Self.SelectExists then Exit;

  vTopData := GetTopLevelData;
  if (vTopData is THCAnnotateData) and (vTopData <> Self) then
    (vTopData as THCAnnotateData).InsertAnnotate(ATitle, AText)
  else
    FDataAnnotates.NewDataAnnotate(SelectInfo, ATitle, AText);
end;

procedure THCAnnotateData.DoLoadFromStream(const AStream: TStream;
  const AStyle: THCStyle; const AFileVersion: Word);
var
  vAnnCount: Word;
  i: Integer;
  vAnn: THCDataAnnotate;
begin
  inherited DoLoadFromStream(AStream, AStyle, AFileVersion);
  if AFileVersion > 22 then
  begin
    AStream.ReadBuffer(vAnnCount, SizeOf(vAnnCount));
    if vAnnCount > 0 then
    begin
      for i := 0 to vAnnCount - 1 do
      begin
        vAnn := THCDataAnnotate.Create;
        vAnn.LoadFromStream(AStream, AFileVersion);
        FDataAnnotates.Add(vAnn);
      end;
    end;
  end;
end;

procedure THCAnnotateData.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  vDataAnnotate: THCDataAnnotate;
begin
  inherited MouseMove(Shift, X, Y);

  vDataAnnotate := GetDrawItemFirstDataAnnotateAt(MouseMoveDrawItemNo, X, Y);

  if FHotAnnotate <> vDataAnnotate then
  begin
    FHotAnnotate := vDataAnnotate;
    Style.UpdateInfoRePaint;
  end;
end;

procedure THCAnnotateData.PaintData(const ADataDrawLeft, ADataDrawTop, ADataDrawRight,
  ADataDrawBottom, ADataScreenTop, ADataScreenBottom, AVOffset, AFirstDItemNo,
  ALastDItemNo: Integer; const ACanvas: TCanvas; const APaintInfo: TPaintInfo);
begin
  CheckAnnotateRange(AFirstDItemNo, ALastDItemNo);  // ָ��DrawItem��Χ�ڵ���ע��ȡ���Ե�DrawItem��Χ
  inherited PaintData(ADataDrawLeft, ADataDrawTop, ADataDrawRight, ADataDrawBottom,
    ADataScreenTop, ADataScreenBottom, AVOffset, AFirstDItemNo, ALastDItemNo, ACanvas, APaintInfo);

  FDrawItemAnnotates.Clear;
end;

procedure THCAnnotateData.SaveToStream(const AStream: TStream);
var
  vAnnCount: Word;
  i: Integer;
begin
  inherited SaveToStream(AStream);
  // ����ע
  vAnnCount := FDataAnnotates.Count;
  AStream.WriteBuffer(vAnnCount, SizeOf(vAnnCount));  // ����
  for i := 0 to vAnnCount - 1 do
    FDataAnnotates[i].SaveToStream(AStream);
end;

{ THCDataAnnotate }

procedure THCDataAnnotate.CopyRange(const ASrc: TSelectInfo);
begin
  Self.StartItemNo := ASrc.StartItemNo;
  Self.StartItemOffset := ASrc.StartItemOffset;
  Self.EndItemNo := ASrc.EndItemNo;
  Self.EndItemOffset := ASrc.EndItemOffset;
end;

procedure THCDataAnnotate.Initialize;
begin
  inherited Initialize;
  FID := -1;
end;

procedure THCDataAnnotate.LoadFromStream(const AStream: TStream;
  const AFileVersion: Word);
begin
  AStream.ReadBuffer(FID, SizeOf(FID));
  Self.StartItemNo := FID;
  AStream.ReadBuffer(FID, SizeOf(FID));
  Self.StartItemOffset := FID;
  AStream.ReadBuffer(FID, SizeOf(FID));
  Self.EndItemNo := FID;
  AStream.ReadBuffer(FID, SizeOf(FID));
  Self.EndItemOffset := FID;
  AStream.ReadBuffer(FID, SizeOf(FID));

  HCLoadTextFromStream(AStream, FTitle, AFileVersion);
  HCLoadTextFromStream(AStream, FText, AFileVersion);
end;

procedure THCDataAnnotate.SaveToStream(const AStream: TStream);
begin
  AStream.WriteBuffer(Self.StartItemNo, SizeOf(Self.StartItemNo));
  AStream.WriteBuffer(Self.StartItemOffset, SizeOf(Self.StartItemOffset));
  AStream.WriteBuffer(Self.EndItemNo, SizeOf(Self.EndItemNo));
  AStream.WriteBuffer(Self.EndItemOffset, SizeOf(Self.EndItemOffset));
  AStream.WriteBuffer(FID, SizeOf(FID));

  HCSaveTextToStream(AStream, FTitle);
  HCSaveTextToStream(AStream, FText);
end;

{ THCDataAnnotates }

procedure THCDataAnnotates.DeleteByID(const AID: Integer);
var
  i: Integer;
begin
  for i := 0 to Self.Count - 1 do
  begin
    if Items[i].ID = AID then
    begin
      Self.Delete(i);
      Break;
    end;
  end;
end;

procedure THCDataAnnotates.NewDataAnnotate(const ASelectInfo: TSelectInfo;
  const ATitle, AText: string);
var
  vDataAnnotate: THCDataAnnotate;
begin
  vDataAnnotate := THCDataAnnotate.Create;
  vDataAnnotate.CopyRange(ASelectInfo);
  vDataAnnotate.Title := ATitle;
  vDataAnnotate.Text := AText;
  vDataAnnotate.ID := Self.Add(vDataAnnotate);
end;

procedure THCDataAnnotates.Notify(const Value: THCDataAnnotate;
  Action: TCollectionNotification);
begin
  if Action = cnAdded then
  begin
    if Assigned(FOnInsertAnnotate) then
      FOnInsertAnnotate(Value);
  end
  else
  if Action = cnRemoved then
  begin
    if Assigned(FOnRemoveAnnotate) then
      FOnRemoveAnnotate(Value);
  end;

  inherited Notify(Value, Action);
end;

{ THCDrawItemAnnotate }

function THCDrawItemAnnotate.First: Boolean;
begin
  Result := (Mark = amFirst) or (Mark = amBoth);
end;

function THCDrawItemAnnotate.Last: Boolean;
begin
  Result := (Mark = amLast) or (Mark = amBoth);
end;

{ THCDrawItemAnnotates }

procedure THCDrawItemAnnotates.NewDrawAnnotate(const ARect: TRect;
  const AMark: THCAnnotateMark; const ADataAnnotate: THCDataAnnotate);
var
  vDrawItemAnnotate: THCDrawItemAnnotate;
begin
  vDrawItemAnnotate := THCDrawItemAnnotate.Create;
  vDrawItemAnnotate.DrawRect := ARect;
  vDrawItemAnnotate.Mark := AMark;
  vDrawItemAnnotate.DataAnnotate := ADataAnnotate;
  Self.Add(vDrawItemAnnotate);
end;

end.

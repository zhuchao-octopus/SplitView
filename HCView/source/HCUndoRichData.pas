{*******************************************************}
{                                                       }
{               HCView V1.1  ���ߣ���ͨ                 }
{                                                       }
{      ��������ѭBSDЭ�飬����Լ���QQȺ 649023932      }
{            ����ȡ����ļ������� 2018-5-4              }
{                                                       }
{             �ĵ��������ָ���ز�����Ԫ                }
{                                                       }
{*******************************************************}

unit HCUndoRichData;

interface

uses
  System.Classes, HCCommon, HCUndo, HCCustomRichData, HCItem, HCStyle;

type
  THCUndoRichData = class(THCCustomRichData)
  private
    FFormatFirstItemNo, FFormatLastItemNo, FUndoGroupCount, FItemCount: Integer;
    procedure DoUndoRedo(const AUndo: THCCustomUndo);
  public
    constructor Create(const AStyle: THCStyle); override;
    procedure Undo(const AUndo: THCCustomUndo); override;
    procedure Redo(const ARedo: THCCustomUndo); override;
  end;

implementation

uses
  HCRectItem;

{ THCUndoRichData }

constructor THCUndoRichData.Create(const AStyle: THCStyle);
begin
  inherited Create(AStyle);
  FUndoGroupCount := 0;
  FItemCount := 0;
end;

procedure THCUndoRichData.DoUndoRedo(const AUndo: THCCustomUndo);
var
  vCaretItemNo, vCaretOffset: Integer;

  procedure DoUndoRedoAction(const AAction: THCCustomUndoAction;
    const AIsUndo: Boolean);

    procedure UndoRedoDeleteText;
    var
      vAction: THCTextUndoAction;
      vText: string;
      vLen: Integer;
    begin
      vAction := AAction as THCTextUndoAction;
      vCaretItemNo := vAction.ItemNo;
      vLen := Length(vAction.Text);
      vText := Items[vAction.ItemNo].Text;
      if AIsUndo then
      begin
        Insert(vAction.Text, vText, vAction.Offset);
        vCaretOffset := vAction.Offset;
      end
      else
      begin
        Delete(vText, vAction.Offset, vLen);
        vCaretOffset := vAction.Offset - vLen;
      end;

      Items[vAction.ItemNo].Text := vText;
    end;

    procedure UndoRedoInsertText;
    var
      vAction: THCTextUndoAction;
      vText: string;
      vLen: Integer;
    begin
      vAction := AAction as THCTextUndoAction;
      vCaretItemNo := vAction.ItemNo;
      vText := Items[vAction.ItemNo].Text;;
      vLen := Length(vAction.Text);

      if AIsUndo then
      begin
        Delete(vText, vAction.Offset, vLen);
        vCaretOffset := vAction.Offset - 1;
      end
      else
      begin
        Insert(vAction.Text, vText, vAction.Offset);
        vCaretOffset := vAction.Offset + vLen - 1;
      end;

      Items[vAction.ItemNo].Text := vText;
    end;

    procedure UndoRedoDeleteItem;
    var
      vAction: THCItemUndoAction;
      vItem: THCCustomItem;
    begin
      vAction := AAction as THCItemUndoAction;
      vCaretItemNo := vAction.ItemNo;

      if AIsUndo then  // ����
      begin
        vItem := LoadItemFromStreamAlone(vAction.ItemStream);
        Items.Insert(vAction.ItemNo, vItem);
        Inc(FItemCount);

        vCaretOffset := vAction.Offset;
      end
      else  // ����
      begin
        Items.Delete(vAction.ItemNo);
        Dec(FItemCount);

        if vCaretItemNo > 0 then
        begin
          Dec(vCaretItemNo);

          if Items[vCaretItemNo].StyleNo > THCStyle.Null then
            vCaretOffset := Items[vCaretItemNo].Length
          else
            vCaretOffset := OffsetAfter;
        end
        else
          vCaretOffset := 0;
      end;
    end;

    procedure UndoRedoInsertItem;
    var
      vAction: THCItemUndoAction;
      vItem: THCCustomItem;
    begin
      vAction := AAction as THCItemUndoAction;
      vCaretItemNo := vAction.ItemNo;

      if AIsUndo then  // ����
      begin
        Items.Delete(vAction.ItemNo);
        Dec(FItemCount);

        if vCaretItemNo > 0 then
        begin
          Dec(vCaretItemNo);
          if Items[vCaretItemNo].StyleNo > THCStyle.Null then
            vCaretOffset := Items[vCaretItemNo].Length
          else
            vCaretOffset := OffsetAfter;
        end
        else
          vCaretOffset := 0;
      end
      else  // ����
      begin
        vItem := LoadItemFromStreamAlone(vAction.ItemStream);
        Items.Insert(vAction.ItemNo, vItem);
        Inc(FItemCount);

        vCaretItemNo := vAction.ItemNo;
        if Items[vCaretItemNo].StyleNo > THCStyle.Null then
          vCaretOffset := Items[vCaretItemNo].Length
        else
          vCaretOffset := OffsetAfter;
      end;
    end;

    procedure UndoRedoItemProperty;
    var
      vAction: THCItemPropertyUndoAction;
      vItem: THCCustomItem;
    begin
      vAction := AAction as THCItemPropertyUndoAction;
      vCaretItemNo := vAction.ItemNo;
      vCaretOffset := vAction.Offset;

      case vAction.ItemProperty of
        uipStyleNo: ;
        uipParaNo: ;

        uipParaFirst:
          begin
            vItem := Items[vAction.ItemNo];
            if AIsUndo then
              vItem.ParaFirst := (vAction as THCItemParaFirstUndoAction).OldParaFirst
            else
              vItem.ParaFirst := (vAction as THCItemParaFirstUndoAction).NewParaFirst;
          end;
      end;
    end;

    procedure UndoRedoItemSelf;
    var
      vAction: THCItemSelfUndoAction;
    begin
      vAction := AAction as THCItemSelfUndoAction;
      vCaretItemNo := vAction.ItemNo;
      vCaretOffset := vAction.Offset;
      if AUndo.IsUndo then
        Items[vCaretItemNo].Undo(vAction.&Object)
      else
        Items[vCaretItemNo].Redo(vAction.&Object);
    end;

  begin
    case AAction.Tag of
      uatDeleteText: UndoRedoDeleteText;
      uatInsertText: UndoRedoInsertText;
      uatDeleteItem: UndoRedoDeleteItem;
      uatInsertItem: UndoRedoInsertItem;
      uatItemProperty: UndoRedoItemProperty;
      //uatItemMirror: UndoRedoItemMirror;
      uatItemSelf: UndoRedoItemSelf;
    end;
  end;

  function GetActionAffect(const AAction: THCCustomUndoAction): Integer;
  begin
    Result := AAction.ItemNo;
    case AAction.Tag of
      uatDeleteItem:
        begin
          if AUndo.IsUndo and (Result > 0) then
            Dec(Result);
        end;

      uatInsertItem:
        begin
          if (not AUndo.IsUndo) and (Result > Items.Count - 1) then
            Dec(Result);
        end;
    end;
  end;

var
  i: Integer;
begin
  if AUndo is THCUndoGroupEnd then  // �����(��Actions)
  begin
    if AUndo.IsUndo then  // �鳷��(��Action)
    begin
      if FUndoGroupCount = 0 then  // �鳷����ʼ
      begin
        FFormatFirstItemNo := (AUndo as THCUndoGroupEnd).ItemNo;
        FFormatLastItemNo := FFormatFirstItemNo;
        FormatItemPrepare(FFormatFirstItemNo, FFormatLastItemNo);

        SelectInfo.Initialize;
        Self.InitializeField;
        FItemCount := 0;
      end;

      Inc(FUndoGroupCount);  // �����鳷������
    end
    else  // ��ָ�����
    begin
      Dec(FUndoGroupCount);  // ������ָ�����

      if FUndoGroupCount = 0 then  // ��ָ�����
      begin
        ReFormatData_(FFormatFirstItemNo, FFormatLastItemNo + FItemCount, FItemCount);

        SelectInfo.StartItemNo := (AUndo as THCUndoGroupEnd).ItemNo;
        SelectInfo.StartItemOffset := (AUndo as THCUndoGroupEnd).Offset;

        Style.UpdateInfoReCaret;
        Style.UpdateInfoRePaint;
      end;
    end;
  end
  else
  if AUndo is THCUndoGroupStart then  // �鿪ʼ
  begin
    if AUndo.IsUndo then  // �鳷��(��Action)
    begin
      Dec(FUndoGroupCount);  // ���ٳ�������

      if FUndoGroupCount = 0 then  // �鳷������
      begin
        ReFormatData_(FFormatFirstItemNo, FFormatLastItemNo + FItemCount, FItemCount);

        SelectInfo.StartItemNo := (AUndo as THCUndoGroupStart).ItemNo;
        SelectInfo.StartItemOffset := (AUndo as THCUndoGroupStart).Offset;

        Style.UpdateInfoReCaret;
        Style.UpdateInfoRePaint;
      end;
    end
    else  // ��ָ�(��Action)
    begin
      if FUndoGroupCount = 0 then  // ��ָ���ʼ
      begin
        FFormatFirstItemNo := (AUndo as THCUndoGroupStart).ItemNo;
        FFormatLastItemNo := FFormatFirstItemNo;
        FormatItemPrepare(FFormatFirstItemNo, FFormatLastItemNo);

        SelectInfo.Initialize;
        Self.InitializeField;
        FItemCount := 0;
      end;

      Inc(FUndoGroupCount);  // ������ָ�����
    end;
  end;

  if AUndo.Actions.Count = 0 then Exit;  // �������û��Action���ɴ˴�����

  if FUndoGroupCount = 0 then
  begin
    SelectInfo.Initialize;
    Self.InitializeField;
    FItemCount := 0;

    if AUndo.Actions.First.ItemNo > AUndo.Actions.Last.ItemNo then
    begin
      FFormatFirstItemNo := GetParaFirstItemNo(GetActionAffect(AUndo.Actions.Last));
      FFormatLastItemNo := GetParaLastItemNo(GetActionAffect(AUndo.Actions.First));
      if FFormatLastItemNo > Items.Count - 1 then
        FFormatLastItemNo := Items.Count - 1;
    end
    else
    begin
      FFormatFirstItemNo := GetParaFirstItemNo(GetActionAffect(AUndo.Actions.First));
      FFormatLastItemNo := GetParaLastItemNo(GetActionAffect(AUndo.Actions.Last));
    end;

    FormatItemPrepare(FFormatFirstItemNo, FFormatLastItemNo);
  end;

  if AUndo.IsUndo then  // ����
  begin
    for i := AUndo.Actions.Count - 1 downto 0 do
      DoUndoRedoAction(AUndo.Actions[i], True);
  end
  else  // ����
  begin
    for i := 0 to AUndo.Actions.Count - 1 do
      DoUndoRedoAction(AUndo.Actions[i], False);
  end;

  //if Items.Count = 0 then
  //  DrawItems.Clear;  // ���ں���յ�Group�������м价�ڻ������Item�����

  if FUndoGroupCount = 0 then
  begin
    ReFormatData_(FFormatFirstItemNo, FFormatLastItemNo + FItemCount, FItemCount);

    SelectInfo.StartItemNo := vCaretItemNo;
    SelectInfo.StartItemOffset := vCaretOffset;

    Style.UpdateInfoReCaret;
    Style.UpdateInfoRePaint;
  end;
end;

procedure THCUndoRichData.Redo(const ARedo: THCCustomUndo);
begin
  DoUndoRedo(ARedo);
end;

procedure THCUndoRichData.Undo(const AUndo: THCCustomUndo);
begin
  DoUndoRedo(AUndo);
end;

end.

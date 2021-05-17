{*******************************************************}
{                                                       }
{               HCView V1.1  ���ߣ���ͨ                 }
{                                                       }
{      ��������ѭBSDЭ�飬����Լ���QQȺ 649023932      }
{            ����ȡ����ļ������� 2018-5-4              }
{                                                       }
{             �ĵ��ڸ�������������Ԫ                }
{                                                       }
{*******************************************************}

{******************* �����޸�˵�� ***********************
201807311101 �����ײ������ݺ�����ƣ�����ʱ��û�иı�ItemNo��Offset�����¹�겻���»ص�����
}

unit HCCustomRichData;

interface

uses
  Windows, Classes, Types, Controls, Graphics, SysUtils, HCCustomData, HCStyle,
  HCItem, HCDrawItem, HCTextStyle, HCParaStyle, HCStyleMatch, HCCommon, HCRectItem,
  HCTextItem, HCUndo;

type
  TInsertProc = reference to function(const AItem: THCCustomItem): Boolean;

  TDrawItemPaintEvent = procedure(const AData: THCCustomData;
    const ADrawItemNo: Integer; const ADrawRect: TRect; const ADataDrawLeft,
    ADataDrawBottom, ADataScreenTop, ADataScreenBottom: Integer;
    const ACanvas: TCanvas; const APaintInfo: TPaintInfo) of object;

  TItemMouseEvent = procedure(const AData: THCCustomData; const AItemNo: Integer;
    Button: TMouseButton; Shift: TShiftState; X, Y: Integer) of object;

  TDataItemEvent = procedure(const AData: THCCustomData; const AItemNo: Integer) of object;

  THCCustomRichData = class(THCCustomData)
  strict private
    FWidth: Cardinal;
    /// <summary> ����������(���ļ��Ի���˫���ļ���ᴥ��MouseMouse��MouseUp) </summary>
    FMouseLBDowning,
    /// <summary> ���˫��(����˫���Զ�ѡ�У��������ѡ�е�����) </summary>
    FMouseLBDouble,
    FMouseDownReCaret,
    FMouseMoveRestrain  // ��������Item��Χ��MouseMove����ͨ��Լ�������ҵ���
      : Boolean;

    FMouseDownX, FMouseDownY: Integer;

    FMouseDownItemNo,
    FMouseDownItemOffset,
    FMouseMoveItemNo,
    FMouseMoveItemOffset,

    FSelectSeekNo,
    FSelectSeekOffset  // ѡ�в���ʱ���α�
      : Integer;

    FReadOnly,
    FSelecting, FDraging: Boolean;

    FOnItemResized: TDataItemEvent;
    FOnInsertItem: TItemNotifyEvent;
    FOnItemMouseDown, FOnItemMouseUp: TItemMouseEvent;
    FOnDrawItemPaintBefor, FOnDrawItemPaintAfter: TDrawItemPaintEvent;
    FOnCreateItem: TNotifyEvent;  // �½���Item(Ŀǰ��Ҫ��Ϊ�˴��ֺ����������뷨����Ӣ��ʱ�ۼ��Ĵ���)

    procedure FormatData(const AStartItemNo, ALastItemNo: Integer);

    /// <summary> ��ʼ��Ϊֻ��һ����Item��Data</summary>
    procedure SetEmptyData;

    /// <summary> Dataֻ�п���Itemʱ����Item(�����滻��ǰ����Item�����) </summary>
    function EmptyDataInsertItem(const AItem: THCCustomItem): Boolean;

    /// <summary> Ϊ����������С��д����ظ����룬ʹ����������������֧��D7 </summary>
    function TableInsertRC(const AProc: TInsertProc): Boolean;

    procedure InitializeMouseField;

    /// <summary> ������ɺ�������λ���Ƿ���ѡ�з�Χ��ʼ </summary>
    function IsSelectSeekStart: Boolean;

    { �����ָ���ط���+ }
    procedure Undo_StartGroup(const AItemNo, AOffset: Integer);
    procedure Undo_EndGroup(const AItemNo, AOffset: Integer);
    procedure Undo_StartRecord;
    /// <summary> ɾ��Text </summary>
    /// <param name="AItemNo">��������ʱ��ItemNo</param>
    /// <param name="AOffset">ɾ������ʼλ��</param>
    /// <param name="AText"></param>
    procedure Undo_DeleteText(const AItemNo, AOffset: Integer; const AText: string);
    procedure Undo_InsertText(const AItemNo, AOffset: Integer; const AText: string);

    /// <summary> ɾ��ָ����Item </summary>
    /// <param name="AItemNo">��������ʱ��ItemNo</param>
    /// <param name="AOffset">��������ʱ��Offset</param>
    procedure Undo_DeleteItem(const AItemNo, AOffset: Integer);

    /// <summary> ����Item��ָ��λ�� </summary>
    /// <param name="AItemNo">��������ʱ��ItemNo</param>
    /// <param name="AOffset">��������ʱ��Offset</param>
    procedure Undo_InsertItem(const AItemNo, AOffset: Integer);
    procedure Undo_ItemParaFirst(const AItemNo, AOffset: Integer; const ANewParaFirst: Boolean);

    procedure Undo_ItemSelf(const AItemNo, AOffset: Integer);
    { �����ָ���ط���- }
  protected
    function CreateItemByStyle(const AStyleNo: Integer): THCCustomItem; virtual;

    // <summary> ���ù��λ�õ�ָ����Item����� </summary>
    procedure ReSetSelectAndCaret(const AItemNo: Integer); overload;

    /// <summary> ���ù��λ�õ�ָ����Itemָ��λ�� </summary>
    /// <param name="AItemNo">ָ��ItemNo</param>
    /// <param name="AOffset">ָ��λ��</param>
    /// <param name="ANextWhenMid">�����λ��ǰ���DrawItem���÷��У�True��һ��DrawItemǰ�棬Falseǰһ������</param>
    procedure ReSetSelectAndCaret(const AItemNo, AOffset: Integer;
      const ANextWhenMid: Boolean = False); overload;

    /// <summary> ��ǰItem��Ӧ�ĸ�ʽ����ʼItem�ͽ���Item(�����һ��Item) </summary>
    /// <param name="AFirstItemNo">��ʼItemNo</param>
    /// <param name="ALastItemNo">����ItemNo</param>
    procedure GetReformatItemRange(var AFirstItemNo, ALastItemNo: Integer); overload;

    /// <summary> ָ��Item��Ӧ�ĸ�ʽ����ʼItem�ͽ���Item(�����һ��Item) </summary>
    /// <param name="AFirstItemNo">��ʼItemNo</param>
    /// <param name="ALastItemNo">����ItemNo</param>
    procedure GetReformatItemRange(var AFirstItemNo, ALastItemNo: Integer; const AItemNo, AItemOffset: Integer); overload;

    /// <summary>
    /// �ϲ�2���ı�Item
    /// </summary>
    /// <param name="ADestItem">�ϲ����Item</param>
    /// <param name="ASrcItem">ԴItem</param>
    /// <returns>True:�ϲ��ɹ���False���ܺϲ�</returns>
    function MergeItemText(const ADestItem, ASrcItem: THCCustomItem): Boolean; virtual;

    procedure DoDrawItemPaintBefor(const AData: THCCustomData; const ADrawItemNo: Integer;
      const ADrawRect: TRect; const ADataDrawLeft, ADataDrawBottom, ADataScreenTop,
      ADataScreenBottom: Integer; const ACanvas: TCanvas; const APaintInfo: TPaintInfo); override;
    procedure DoDrawItemPaintAfter(const AData: THCCustomData; const ADrawItemNo: Integer;
      const ADrawRect: TRect; const ADataDrawLeft, ADataDrawBottom, ADataScreenTop,
      ADataScreenBottom: Integer; const ACanvas: TCanvas; const APaintInfo: TPaintInfo); override;

    function CanDeleteItem(const AItemNo: Integer): Boolean; virtual;

    /// <summary> ���ڴ���������Items�󣬼�鲻�ϸ��Item��ɾ�� </summary>
    function CheckInsertItemCount(const AStartNo, AEndNo: Integer): Integer; virtual;

    procedure DoItemInsert(const AItem: THCCustomItem); virtual;
    procedure DoItemMouseLeave(const AItemNo: Integer); virtual;
    procedure DoItemMouseEnter(const AItemNo: Integer); virtual;
    procedure DoItemResized(const AItemNo: Integer);
    function DoInsertText(const AText: string): Boolean;
    function GetWidth: Cardinal; virtual;
    procedure SetWidth(const Value: Cardinal);
    function GetHeight: Cardinal; virtual;
    procedure SetReadOnly(const Value: Boolean); virtual;

    /// <summary> ׼����ʽ������ </summary>
    /// <param name="AStartItemNo">��ʼ��ʽ����Item</param>
    /// <param name="APrioDItemNo">��һ��Item�����һ��DrawItemNo</param>
    /// <param name="APos">��ʼ��ʽ��λ��</param>
    procedure _FormatReadyParam(const AStartItemNo: Integer;
      var APrioDrawItemNo: Integer; var APos: TPoint); virtual;

    // Format�������ʽ��Item��ReFormat�����ʽ����Ժ���Item��DrawItem�Ĺ�������
    procedure ReFormatData_(const AStartItemNo: Integer; const ALastItemNo: Integer = -1;
      const AExtraItemCount: Integer = 0); virtual;

    { �Ƿ��������ָ� }
    function EnableUndo: Boolean; virtual;

    // Item��������Ͷ�ȡ�¼�
    procedure SaveItemToStreamAlone(const AItem: THCCustomItem; const AStream: TStream);
    function LoadItemFromStreamAlone(const AStream: TStream): THCCustomItem;

    function CalcContentHeight: Integer;
  public
    constructor Create(const AStyle: THCStyle); override;

    procedure Clear; override;
    // ѡ������Ӧ����ʽ
    function ApplySelectTextStyle(const AMatchStyle: THCStyleMatch): Integer; override;
    function ApplySelectParaStyle(const AMatchStyle: THCParaMatch): Integer; override;

    function DisSelect: Boolean; override;

    /// <summary> ɾ��ѡ������(�ڲ��Ѿ��ж����Ƿ���ѡ��) </summary>
    /// <returns>True:��ѡ����ɾ���ɹ�</returns>
    function DeleteSelected: Boolean; override;

    /// <summary> �ڹ�괦����Item </summary>
    /// <param name="AItem"></param>
    /// <returns></returns>
    function InsertItem(const AItem: THCCustomItem): Boolean; overload; virtual;

    /// <summary> ��ָ����λ�ò���Item </summary>
    /// <param name="AIndex">����λ��</param>
    /// <param name="AItem">�����Item</param>
    /// <param name="AOffsetBefor">����ʱ��ԭλ��Itemǰ��(True)�����(False)</param>
    /// <returns></returns>
    function InsertItem(const AIndex: Integer; const AItem: THCCustomItem;
      const AOffsetBefor: Boolean = True): Boolean; overload; virtual;

    procedure KillFocus; virtual;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); virtual;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
    procedure MouseLeave; virtual;

    // Key����0��ʾ�˼�����Dataû�����κ�����
    procedure KeyPress(var Key: Char); virtual;

    // Key����0��ʾ�˼�����Dataû�����κ�����
    procedure KeyDown(var Key: Word; Shift: TShiftState); virtual;

    // Key����0��ʾ�˼�����Dataû�����κ�����
    procedure KeyUp(var Key: Word; Shift: TShiftState); virtual;

    procedure Undo(const AUndo: THCCustomUndo); virtual;
    procedure Redo(const ARedo: THCCustomUndo); virtual;

    /// <summary> ��ʼ������ֶκͱ��� </summary>
    procedure InitializeField; override;
    procedure LoadFromStream(const AStream: TStream; const AStyle: THCStyle;
      const AFileVersion: Word); override;
    function InsertStream(const AStream: TStream; const AStyle: THCStyle;
      const AFileVersion: Word): Boolean; override;
    //
    procedure DblClick(X, Y: Integer);
    function CanEdit: Boolean;
    procedure DeleteItems(const AStartNo: Integer; const AEndNo: Integer = -1);

    /// <summary> ���Data����ǰ </summary>
    /// <param name="ASrcData">ԴData</param>
    procedure AddData(const ASrcData: THCCustomData);

    /// <summary> �ڹ�괦���� </summary>
    function InsertBreak: Boolean;

    /// <summary> �ڹ�괦�����ַ���(�ɴ��س����з�) </summary>
    function InsertText(const AText: string): Boolean;

    /// <summary> �ڹ�괦����ָ�����еı�� </summary>
    function InsertTable(const ARowCount, AColCount: Integer): Boolean;

    /// <summary> �ڹ�괦����ֱ�� </summary>
    function InsertLine(const ALineHeight: Integer): Boolean;

    function TableInsertRowAfter(const ARowCount: Byte): Boolean;
    function TableInsertRowBefor(const ARowCount: Byte): Boolean;
    function ActiveTableDeleteCurRow: Boolean;
    function ActiveTableSplitCurRow: Boolean;
    function ActiveTableSplitCurCol: Boolean;
    function TableInsertColAfter(const AColCount: Byte): Boolean;
    function TableInsertColBefor(const AColCount: Byte): Boolean;
    function ActiveTableDeleteCurCol: Boolean;
    function MergeTableSelectCells: Boolean;

    // Format�������ʽ��Item��ReFormat�������ʽ����Ժ���Item��DrawItem�Ĺ�������
    // Ŀǰ����Ԫ�����ˣ���Ҫ�ŵ�CellData����
    procedure ReFormat(const AStartItemNo: Integer);

    /// <summary> ���¸�ʽ����ǰItem(���ڽ��޸ĵ�ǰItem���Ի�����) </summary>
    procedure ReFormatActiveItem;
    function GetTopLevelItem: THCCustomItem;
    function GetTopLevelDrawItem: THCCustomDrawItem;
    function GetActiveDrawItemCoord: TPoint;

    /// <summary> ȡ������(����ҳü��ҳ�š������л�ʱԭ�����ȡ��) </summary>
    procedure DisActive;

    function GetHint: string;

    /// <summary> ���ص�ǰ��괦�Ķ���Data </summary>
    function GetTopLevelData: THCCustomRichData;

    /// <summary> ����ָ��λ�ô��Ķ���Data </summary>
    function GetTopLevelDataAt(const X, Y: Integer): THCCustomRichData;

    property MouseDownItemNo: Integer read FMouseDownItemNo;
    property MouseDownItemOffset: Integer read FMouseDownItemOffset;
    property MouseMoveItemNo: Integer read FMouseMoveItemNo;
    property MouseMoveItemOffset: Integer read FMouseMoveItemOffset;
    property MouseMoveRestrain: Boolean read FMouseMoveRestrain;

    property Width: Cardinal read GetWidth write SetWidth;
    property Height: Cardinal read GetHeight;  // ʵ�����ݵĸ�
    property ReadOnly: Boolean read FReadOnly write SetReadOnly;
    property Selecting: Boolean read FSelecting;
    property OnInsertItem: TItemNotifyEvent read FOnInsertItem write FOnInsertItem;
    property OnItemResized: TDataItemEvent read FOnItemResized write FOnItemResized;
    property OnItemMouseDown: TItemMouseEvent read FOnItemMouseDown write FOnItemMouseDown;
    property OnItemMouseUp: TItemMouseEvent read FOnItemMouseUp write FOnItemMouseUp;
    property OnDrawItemPaintBefor: TDrawItemPaintEvent read FOnDrawItemPaintBefor write FOnDrawItemPaintBefor;
    property OnDrawItemPaintAfter: TDrawItemPaintEvent read FOnDrawItemPaintAfter write FOnDrawItemPaintAfter;
    property OnCreateItem: TNotifyEvent read FOnCreateItem write FOnCreateItem;
  end;

implementation

uses
  HCTableItem, HCImageItem, HCCheckBoxItem, HCTabItem, HCLineItem, HCExpressItem,
  HCPageBreakItem, HCGifItem, HCEditItem, HCComboboxItem, HCQRCodeItem, HCBarCodeItem,
  HCFractionItem, HCDateTimePicker, HCRadioGroup;

{ THCCustomRichData }

constructor THCCustomRichData.Create(const AStyle: THCStyle);
begin
  inherited Create(AStyle);
  Items.OnItemInsert := DoItemInsert;
  FReadOnly := False;
  InitializeField;
  SetEmptyData;
end;

function THCCustomRichData.CreateItemByStyle(
  const AStyleNo: Integer): THCCustomItem;
begin
  Result := nil;
  if AStyleNo < THCStyle.Null then
  begin
    case AStyleNo of
      THCStyle.Image: Result := THCImageItem.Create(Self, 0, 0);
      THCStyle.Table: Result := THCTableItem.Create(Self, 1, 1, 1);
      THCStyle.Tab: Result := TTabItem.Create(Self, 0, 0);
      THCStyle.Line: Result := TLineItem.Create(Self, 1, 1);
      THCStyle.Express: Result := THCExpressItem.Create(Self, '', '', '', '');
      // RsVector
      THCStyle.Domain: Result := CreateDefaultDomainItem;
      THCStyle.PageBreak: Result := TPageBreakItem.Create(Self, 0, 1);
      THCStyle.CheckBox: Result := THCCheckBoxItem.Create(Self, '��ѡ��', False);
      THCStyle.Gif: Result := THCGifItem.Create(Self, 1, 1);
      THCStyle.Edit: Result := THCEditItem.Create(Self, '');
      THCStyle.Combobox: Result := THCComboboxItem.Create(Self, '');
      THCStyle.QRCode: Result := THCQRCodeItem.Create(Self, '');
      THCStyle.BarCode: Result := THCBarCodeItem.Create(Self, '');
      THCStyle.Fraction: Result := THCFractionItem.Create(Self, '', '');
      THCStyle.DateTimePicker: Result := THCDateTimePicker.Create(Self, Now);
      THCStyle.RadioGroup: Result := THCRadioGroup.Create(Self);
    else
      raise Exception.Create('δ�ҵ����� ' + IntToStr(AStyleNo) + ' ��Ӧ�Ĵ���Item���룡');
    end;
  end
  else
  begin
    Result := CreateDefaultTextItem;
    Result.StyleNo := AStyleNo;
  end;
end;

procedure THCCustomRichData.DblClick(X, Y: Integer);
var
  i, vItemNo, vItemOffset, vDrawItemNo, vX, vY, vStartOffset, vEndOffset: Integer;
  vRestrain: Boolean;
  vText: string;
  vPosType: TCharType;
begin
  FMouseLBDouble := True;

  GetItemAt(X, Y, vItemNo, vItemOffset, vDrawItemNo, vRestrain);
  if vItemNo < 0 then Exit;

  if Items[vItemNo].StyleNo < THCStyle.Null then
  begin
    CoordToItemOffset(X, Y, vItemNo, vItemOffset, vX, vY);
    Items[vItemNo].DblClick(vX, vY);
  end
  else  // TextItem˫��ʱ���ݹ�괦���ݣ�ѡ�з�Χ
  if Items[vItemNo].Length > 0 then
  begin
    vText := GetDrawItemText(vDrawItemNo);  // DrawItem��Ӧ���ı�
    vItemOffset := vItemOffset - DrawItems[vDrawItemNo].CharOffs + 1;  // ӳ�䵽DrawItem��

    if vItemOffset > 0 then  // ��괦��Char����
      vPosType := GetCharType(Word(vText[vItemOffset]))
    else
      vPosType := GetCharType(Word(vText[1]));

    vStartOffset := 0;
    for i := vItemOffset - 1 downto 1 do  // ��ǰ��Char���Ͳ�һ����λ��
    begin
      if GetCharType(Word(vText[i])) <> vPosType then
      begin
        vStartOffset := i;
        Break;
      end;
    end;

    vEndOffset := Length(vText);
    for i := vItemOffset + 1 to Length(vText) do  // ������Char���Ͳ�һ����λ��
    begin
      if GetCharType(Word(vText[i])) <> vPosType then
      begin
        vEndOffset := i - 1;
        Break;
      end;
    end;

    Self.SelectInfo.StartItemNo := vItemNo;
    Self.SelectInfo.StartItemOffset := vStartOffset + DrawItems[vDrawItemNo].CharOffs - 1;

    if vStartOffset <> vEndOffset then  // ��ѡ�е��ı�
    begin
      Self.SelectInfo.EndItemNo := vItemNo;
      Self.SelectInfo.EndItemOffset := vEndOffset + DrawItems[vDrawItemNo].CharOffs - 1;

      MatchItemSelectState;
    end;
  end;

  Style.UpdateInfoRePaint;
  Style.UpdateInfoReCaret(False);
end;

procedure THCCustomRichData.DeleteItems(const AStartNo: Integer; const AEndNo: Integer = -1);
var
  {vStartNo, }vEndNo, vDelCount: Integer;
  vItem: THCCustomItem;
begin
  InitializeField;
  DisSelect;  // ��ֹɾ����ԭѡ��ItemNo������

  // ��Ŀǰ����DeleteItems���Ǵ�0��ʼ��ʽ�������Դ˴���ʽ����ش�����ʱע�͵�
  {if AStartNo > 0 then  // ��ɾ����ǰһ����ʼ��ʽ��
    vStartNo := AStartNo - 1
  else
    vStartNo := 0;}

  if AEndNo < 0 then
    vEndNo := AStartNo
  else
    vEndNo := AEndNo;

  vDelCount := vEndNo - AStartNo + 1;
  //FormatItemPrepare(vStartNo, vEndNo);
  Items.DeleteRange(AStartNo, vDelCount);
  //ReFormatData_(vStartNo, vEndNo - vDelCount, -vDelCount);
  if Items.Count = 0 then  // ɾ��û��
  begin
    vItem := CreateDefaultTextItem;
    vItem.ParaFirst := True;
    Items.Add(vItem);  // ��ʹ��InsertText��Ϊ�����䴥��ReFormatʱ��Ϊû�и�ʽ��������ȡ������Ӧ��DrawItem
  end
  else  // ɾ�����˻���
  if (AStartNo > 0) and (not Items[AStartNo].ParaFirst) then  // ɾ��λ�õ�Item���Ƕ��ף��ж��Ƿ��ܺϲ���ǰһ��
  begin
    if Items[AStartNo - 1].CanConcatItems(Items[AStartNo]) then
    begin
      //vItem := Items[AStartNo - 1];
      Items[AStartNo - 1].Text := Items[AStartNo - 1].Text + Items[AStartNo].Text;
      Items.Delete(AStartNo);
    end;
  end;
end;

function THCCustomRichData.DeleteSelected: Boolean;
var
  vDelCount, vFormatFirstItemNo, vFormatLastItemNo,
  vLen, vParaFirstItemNo, vParaLastItemNo: Integer;
  vStartItem, vEndItem, vNewItem: THCCustomItem;

  {$REGION 'ɾ��ȫѡ�еĵ���Item'}
  function DeleteItemSelectComplate: Boolean;
  begin
    Result := False;
    if CanDeleteItem(SelectInfo.StartItemNo) then  // ����ɾ��
    begin
      Undo_DeleteItem(SelectInfo.StartItemNo, 0);
      Items.Delete(SelectInfo.StartItemNo);

      Inc(vDelCount);
      if (SelectInfo.StartItemNo > vFormatFirstItemNo)
        and (SelectInfo.StartItemNo < vFormatLastItemNo)
      then  // ȫѡ�е�Item����ʼ��ʽ���ͽ�����ʽ���м�
      begin
        vLen := Items[SelectInfo.StartItemNo - 1].Length;
        if MergeItemText(Items[SelectInfo.StartItemNo - 1], Items[SelectInfo.StartItemNo]) then  // ɾ��λ��ǰ��ɺϲ�
        begin
          Items.Delete(SelectInfo.StartItemNo);
          Inc(vDelCount);

          SelectInfo.StartItemNo := SelectInfo.StartItemNo - 1;
          SelectInfo.StartItemOffset := vLen;
        end
        else  // ɾ��λ��ǰ���ܺϲ��������Ϊǰһ������
        begin
          SelectInfo.StartItemNo := SelectInfo.StartItemNo - 1;
          SelectInfo.StartItemOffset := GetItemAfterOffset(SelectInfo.StartItemNo);
        end;
      end
      else
      if SelectInfo.StartItemNo = vParaFirstItemNo then  // �ε�һ��ItemNo
      begin
        if vParaFirstItemNo = vParaLastItemNo then  // �ξ�һ��Itemȫɾ���ˣ������Item
        begin
          vNewItem := CreateDefaultTextItem;
          vNewItem.ParaFirst := True;
          Items.Insert(SelectInfo.StartItemNo, vNewItem);
          Undo_InsertItem(SelectInfo.StartItemNo, 0);

          SelectInfo.StartItemOffset := 0;
          Dec(vDelCount);
        end
        else
        begin
          SelectInfo.StartItemOffset := 0;
          Items[SelectInfo.StartItemNo].ParaFirst := True;
        end;
      end
      else
      if SelectInfo.StartItemNo = vParaLastItemNo then  // �����һ��ItemNo
      begin
        {if vParaFirstItemNo = vParaLastItemNo then  // �ξ�һ��Itemȫɾ����,�����ߵ������
        begin
          vItem := CreateDefaultTextItem;
          vItem.ParaFirst := True;
          Items.Insert(SelectInfo.StartItemNo, vItem);
          SelectInfo.StartItemOffset := 0;
          Dec(vDelCount);
        end
        else}
        begin
          SelectInfo.StartItemNo := SelectInfo.StartItemNo - 1;
          SelectInfo.StartItemOffset := Items[SelectInfo.StartItemNo].Length;
        end;
      end
      else  // ȫѡ�е�Item����ʼ��ʽ���������ʽ�����ڶ���
      begin
        if SelectInfo.StartItemNo > 0 then
        begin
          vLen := Items[SelectInfo.StartItemNo - 1].Length;
          if MergeItemText(Items[SelectInfo.StartItemNo - 1], Items[SelectInfo.StartItemNo]) then
          begin
            Items.Delete(SelectInfo.StartItemNo);
            Inc(vDelCount);
            SelectInfo.StartItemOffset := vLen;
          end;
          
          SelectInfo.StartItemNo := SelectInfo.StartItemNo - 1;
        end;
      end;
    end;
    Result := True;
  end;
  {$ENDREGION}

var
  i: Integer;
  vText: string;
  vSelectSeekStart,   // ѡ�з�Χ�α���ѡ����ʼ
  vSelStartComplate,  // ѡ�з�Χ�ڵ���ʼItemȫѡ����
  vSelEndComplate,    // ѡ�з�Χ�ڵĽ���Itemȫѡ����
  vSelStartParaFirst  // ѡ����ʼ�Ƕ���
    : Boolean;
begin
  Result := False;

  if not CanEdit then Exit;

  if SelectExists then
  begin
    vSelectSeekStart := IsSelectSeekStart;

    vDelCount := 0;
    Self.InitializeField;  // ɾ����ԭ��괦�����Ѿ�û����

    if (SelectInfo.EndItemNo < 0)
      and (Items[SelectInfo.StartItemNo].StyleNo < THCStyle.Null)
    then  // ѡ���������RectItem�ڲ�
    begin
      // ����䶯������RectItem�Ŀ�ȱ仯������Ҫ��ʽ���������һ��Item
      GetReformatItemRange(vFormatFirstItemNo, vFormatLastItemNo);
      FormatItemPrepare(vFormatFirstItemNo, vFormatLastItemNo);

      if (Items[SelectInfo.StartItemNo] as THCCustomRectItem).IsSelectComplateTheory then  // ����ȫѡ��
      begin
        Undo_StartRecord;
        GetParaItemRang(SelectInfo.StartItemNo, vParaFirstItemNo, vParaLastItemNo);
        Result := DeleteItemSelectComplate;
      end
      else
        Result := (Items[SelectInfo.StartItemNo] as THCCustomRectItem).DeleteSelected;

      ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo - vDelCount, -vDelCount);
    end
    else  // ѡ�в��Ƿ�����RectItem�ڲ�
    begin
      vEndItem := Items[SelectInfo.EndItemNo];  // ѡ�н���Item
      if SelectInfo.EndItemNo = SelectInfo.StartItemNo then  // ѡ������ͬһ��Item
      begin
        Undo_StartRecord;

        GetParaItemRang(SelectInfo.StartItemNo, vParaFirstItemNo, vParaLastItemNo);
        GetReformatItemRange(vFormatFirstItemNo, vFormatLastItemNo);
        FormatItemPrepare(vFormatFirstItemNo, vFormatLastItemNo);

        if vEndItem.IsSelectComplate then  // ��TextItemȫѡ����
          Result := DeleteItemSelectComplate
        else  // Item����ѡ��
        begin
          if vEndItem.StyleNo < THCStyle.Null then  // ͬһ��RectItem  ����ǰѡ�е�һ���֣�
            (vEndItem as THCCustomRectItem).DeleteSelected
          else  // ͬһ��TextItem
          begin
            vText := vEndItem.Text;
            Undo_DeleteText(SelectInfo.StartItemNo, SelectInfo.StartItemOffset + 1,
              Copy(vText, SelectInfo.StartItemOffset + 1, SelectInfo.EndItemOffset - SelectInfo.StartItemOffset));
            Delete(vText, SelectInfo.StartItemOffset + 1, SelectInfo.EndItemOffset - SelectInfo.StartItemOffset);
            vEndItem.Text := vText;
          end;
        end;

        ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo - vDelCount, -vDelCount);
      end
      else  // ѡ�з����ڲ�ͬItem����ʼ(�����Ƕ���)ȫѡ�н�βûȫѡ����ʼûȫѡ��βȫѡ����ʼ��β��ûȫѡ
      begin
        vFormatFirstItemNo := GetParaFirstItemNo(SelectInfo.StartItemNo);  // ȡ�ε�һ��Ϊ��ʼ
        vFormatLastItemNo := GetParaLastItemNo(SelectInfo.EndItemNo);  // ȡ�����һ��Ϊ������������ע������

        FormatItemPrepare(vFormatFirstItemNo, vFormatLastItemNo);

        vSelStartParaFirst := Items[SelectInfo.StartItemNo].ParaFirst;
        vSelStartComplate := Items[SelectInfo.StartItemNo].IsSelectComplate;  // ��ʼ�Ƿ�ȫѡ
        vSelEndComplate := Items[SelectInfo.EndItemNo].IsSelectComplate;  // ��β�Ƿ�ȫѡ

        {vSelectRangComplate :=  // ѡ�з�Χ�ڵ�Item����ȫѡ����
          (SelectInfo.StartItemOffset = 0)
           and ( ( (vItem.StyleNo < THCStyle.RsNull)
                     and (SelectInfo.EndItemOffset = OffsetAfter)
                 )
               or ( (vItem.StyleNo > THCStyle.RsNull)
                     and (SelectInfo.EndItemOffset = vItem.Length)
                  )
               );}

        Undo_StartRecord;

        // �ȴ���ѡ�н���Item
        if vEndItem.StyleNo < THCStyle.Null then  // RectItem
        begin
          if vSelEndComplate then  // ѡ��������棬��ȫѡ  SelectInfo.EndItemOffset = OffsetAfter
          begin
            if CanDeleteItem(SelectInfo.EndItemNo) then  // ����ɾ��
            begin
              Undo_DeleteItem(SelectInfo.EndItemNo, OffsetAfter);
              Items.Delete(SelectInfo.EndItemNo);

              Inc(vDelCount);
            end;
          end
          else
          if SelectInfo.EndItemOffset = OffsetInner then  // ������
            (vEndItem as THCCustomRectItem).DeleteSelected;
        end
        else  // TextItem
        begin
          if vSelEndComplate then  // ��ѡ���ı�Item������� SelectInfo.EndItemOffset = vEndItem.Length
          begin
            if CanDeleteItem(SelectInfo.EndItemNo) then  // ����ɾ��
            begin
              Undo_DeleteItem(SelectInfo.EndItemNo, vEndItem.Length);
              Items.Delete(SelectInfo.EndItemNo);
              Inc(vDelCount);
            end;
          end
          else  // �ı��Ҳ���ѡ�н���Item���
          begin
            Undo_DeleteText(SelectInfo.EndItemNo, 1, Copy(vEndItem.Text, 1, SelectInfo.EndItemOffset));
            // ����Item���µ�����
            vText := (vEndItem as THCTextItem).GetTextPart(SelectInfo.EndItemOffset + 1,
              vEndItem.Length - SelectInfo.EndItemOffset);
            vEndItem.Text := vText;
          end;
        end;

        // ɾ��ѡ����ʼItem��һ��������Item��һ��
        for i := SelectInfo.EndItemNo - 1 downto SelectInfo.StartItemNo + 1 do
        begin
          if CanDeleteItem(i) then  // ����ɾ��
          begin
            Undo_DeleteItem(i, 0);
            Items.Delete(i);

            Inc(vDelCount);
          end;
        end;

        vStartItem := Items[SelectInfo.StartItemNo];  // ѡ����ʼItem
        if vStartItem.StyleNo < THCStyle.Null then  // ��ʼ��RectItem
        begin
          if SelectInfo.StartItemOffset = OffsetBefor then  // ����ǰ
          begin
            if CanDeleteItem(SelectInfo.StartItemNo) then  // ����ɾ��
            begin
              Undo_DeleteItem(SelectInfo.StartItemNo, 0);
              Items.Delete(SelectInfo.StartItemNo);
              Inc(vDelCount);
            end;
            if SelectInfo.StartItemNo > vFormatFirstItemNo then
              SelectInfo.StartItemNo := SelectInfo.StartItemNo - 1;
          end
          else
          if SelectInfo.StartItemOffset = OffsetInner then  // ������
            (vStartItem as THCCustomRectItem).DeleteSelected;
        end
        else  // ѡ����ʼ��TextItem
        begin
          if vSelStartComplate then  // ����ǰ��ʼȫѡ�� SelectInfo.StartItemOffset = 0
          begin
            if CanDeleteItem(SelectInfo.StartItemNo) then  // ����ɾ��
            begin
              Undo_DeleteItem(SelectInfo.StartItemNo, 0);
              Items.Delete(SelectInfo.StartItemNo);
              Inc(vDelCount);
            end;
          end
          else
          //if SelectInfo.StartItemOffset < vStartItem.Length then  // ���м�(�����ж��˰ɣ�)
          begin
            Undo_DeleteText(SelectInfo.StartItemNo, SelectInfo.StartItemOffset + 1,
              Copy(vStartItem.Text, SelectInfo.StartItemOffset + 1, vStartItem.Length - SelectInfo.StartItemOffset));
            vText := (vStartItem as THCTextItem).GetTextPart(1, SelectInfo.StartItemOffset);
            vStartItem.Text := vText;  // ��ʼ���µ�����
          end;
        end;

        if vSelStartComplate and vSelEndComplate then  // ѡ�е�Item��ɾ����
        begin
          if SelectInfo.StartItemNo = vFormatFirstItemNo then  // ѡ����ʼ�ڶ���ǰ
          begin
            if SelectInfo.EndItemNo = vFormatLastItemNo then  // ѡ�н����ڵ�ǰ�λ����ĳ�����(��������ȫɾ����)���������
            begin
              vNewItem := CreateDefaultTextItem;
              vNewItem.ParaFirst := True;
              Items.Insert(SelectInfo.StartItemNo, vNewItem);
              Undo_InsertItem(SelectInfo.StartItemNo, vNewItem.Length);

              Dec(vDelCount);
            end
            else  // ѡ�н������ڶ����
              Items[SelectInfo.EndItemNo - vDelCount + 1].ParaFirst := True;  // ѡ�н���λ�ú���ĳ�Ϊ����
          end
          else
          if SelectInfo.EndItemNo = vFormatLastItemNo then  // �����ڶ����
          begin
            SelectInfo.StartItemNo := SelectInfo.StartItemNo - 1;
            SelectInfo.StartItemOffset := GetItemAfterOffset(SelectInfo.StartItemNo);
          end
          else  // ѡ����ʼ����ʼ���м䣬ѡ�н����ڽ������м�
          begin
            vLen := Items[SelectInfo.StartItemNo - 1].Length;
            if MergeItemText(Items[SelectInfo.StartItemNo - 1], Items[SelectInfo.EndItemNo - vDelCount + 1]) then  // ��ʼǰ��ͽ�������ɺϲ�
            begin
              Undo_InsertText(SelectInfo.StartItemNo - 1,
                Items[SelectInfo.StartItemNo - 1].Length - Items[SelectInfo.EndItemNo - vDelCount + 1].Length + 1,
                Items[SelectInfo.EndItemNo - vDelCount + 1].Text);

              SelectInfo.StartItemNo := SelectInfo.StartItemNo - 1;
              SelectInfo.StartItemOffset := vLen;

              Undo_DeleteItem(SelectInfo.EndItemNo - vDelCount + 1, 0);
              Items.Delete(SelectInfo.EndItemNo - vDelCount + 1);
              Inc(vDelCount);
            end
            else  // ��ʼǰ��ͽ������治�ܺϲ������ѡ����ʼ�ͽ�������ͬһ��
            begin
              if Items[SelectInfo.EndItemNo - vDelCount + 1].ParaFirst then
              begin
                Undo_ItemParaFirst(SelectInfo.EndItemNo - vDelCount + 1, 0, False);
                Items[SelectInfo.EndItemNo - vDelCount + 1].ParaFirst := False;  // �ϲ����ɹ��Ͱ���
              end;
            end;
          end;
        end
        else  // ѡ�з�Χ�ڵ�Itemû��ɾ����
        begin
          if vSelStartComplate then  // ��ʼɾ������
          begin
            if Items[SelectInfo.EndItemNo - vDelCount].ParaFirst <> vSelStartParaFirst then
            begin
              Undo_ItemParaFirst(SelectInfo.EndItemNo - vDelCount, 0, vSelStartParaFirst);
              Items[SelectInfo.EndItemNo - vDelCount].ParaFirst := vSelStartParaFirst
            end;
          end
          else
          if not vSelEndComplate then  // ��ʼ�ͽ�����û��ɾ����
          begin
            if MergeItemText(Items[SelectInfo.StartItemNo], Items[SelectInfo.EndItemNo - vDelCount])
            then  // ѡ����ʼ������λ�õ�Item�ϲ��ɹ�
            begin
              Undo_InsertText(SelectInfo.StartItemNo,
                Items[SelectInfo.StartItemNo].Length - Items[SelectInfo.EndItemNo - vDelCount].Length + 1,
                Items[SelectInfo.EndItemNo - vDelCount].Text);

              Undo_DeleteItem(SelectInfo.EndItemNo - vDelCount, 0);
              Items.Delete(SelectInfo.EndItemNo - vDelCount);
              Inc(vDelCount);
            end
            else  // ѡ����ʼ������λ�õ�Item���ܺϲ�
            begin
              if SelectInfo.EndItemNo <> vFormatLastItemNo then  // ѡ�н������Ƕ����һ��
              begin
                if Items[SelectInfo.EndItemNo - vDelCount].ParaFirst then
                begin
                  Undo_ItemParaFirst(SelectInfo.EndItemNo - vDelCount, 0, False);
                  Items[SelectInfo.EndItemNo - vDelCount].ParaFirst := False;  // �ϲ����ɹ��Ͱ���
                end;
              end;
            end;
          end;
        end;

        ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo - vDelCount, -vDelCount);
      end;

      for i := SelectInfo.StartItemNo to SelectInfo.EndItemNo - vDelCount do  // ������ɾ����ȡ��ѡ��״̬
        Items[i].DisSelect;

      SelectInfo.EndItemNo := -1;
      SelectInfo.EndItemOffset := -1;
    end;

    Style.UpdateInfoRePaint;
    Style.UpdateInfoReCaret;

    inherited DeleteSelected;

    ReSetSelectAndCaret(SelectInfo.StartItemNo, SelectInfo.StartItemOffset, not vSelectSeekStart);
    Result := True;
  end;
end;

procedure THCCustomRichData.DisActive;
var
  vItem: THCCustomItem;
begin
  Self.InitializeField;

  if Items.Count > 0 then  // ҳü��Ԫ�ؼ�����л������Ĳ�����
  begin
    vItem := GetCurItem;
    if vItem <> nil then
      vItem.Active := False;
  end;
end;

function THCCustomRichData.DisSelect: Boolean;
begin
  Result := inherited DisSelect;
  if Result then
  begin
    // ��ק���ʱ���
    FDraging := False;  // ��ק���
    //FMouseLBDowning := False;  // ��갴����ѡ���������ʱ����ѡ�У������ܸ�FMouseLBDowning״̬
    FSelecting := False;  // ׼����ѡ
    // Self.Initialize;  ����ᵼ��Mouse�¼��е�FMouseLBDowning�����Ա�ȡ����
    Style.UpdateInfoRePaint;
  end;

  Style.UpdateInfoReCaret;  // ѡ����ʼ��Ϣ������Ϊ-1
end;

procedure THCCustomRichData.Undo_DeleteText(const AItemNo, AOffset: Integer;
  const AText: string);
var
  vUndo: THCUndo;
  vTextAction: THCTextUndoAction;
begin
  if EnableUndo then
  begin
    vUndo := GetUndoList.Last;
    if vUndo <> nil then
    begin
      vTextAction := vUndo.ActionAppend(uatDeleteText, AItemNo, AOffset) as THCTextUndoAction;
      vTextAction.Text := AText;
    end;
  end;
end;

procedure THCCustomRichData.Undo_EndGroup(const AItemNo, AOffset: Integer);
begin
  if EnableUndo then
    GetUndoList.EndUndoGroup(AItemNo, AOffset);
end;

procedure THCCustomRichData.Undo_InsertText(const AItemNo, AOffset: Integer;
  const AText: string);
var
  vUndo: THCUndo;
  vTextAction: THCTextUndoAction;
begin
  if EnableUndo then
  begin
    vUndo := GetUndoList.Last;
    if vUndo <> nil then
    begin
      vTextAction := vUndo.ActionAppend(uatInsertText, AItemNo, AOffset) as THCTextUndoAction;
      vTextAction.Text := AText;
    end;
  end;
end;

procedure THCCustomRichData.Undo_ItemParaFirst(const AItemNo, AOffset: Integer;
  const ANewParaFirst: Boolean);
var
  vUndo: THCUndo;
  vItemAction: THCItemParaFirstUndoAction;
begin
  if EnableUndo then
  begin
    vUndo := GetUndoList.Last;
    if vUndo <> nil then
    begin
      vItemAction := THCItemParaFirstUndoAction.Create;
      vItemAction.ItemNo := AItemNo;
      vItemAction.Offset := AOffset;
      vItemAction.OldParaFirst := Items[AItemNo].ParaFirst;
      vItemAction.NewParaFirst := ANewParaFirst;

      vUndo.Actions.Add(vItemAction);
    end;
  end;
end;

procedure THCCustomRichData.Undo_ItemSelf(const AItemNo, AOffset: Integer);
var
  vUndo: THCUndo;
begin
  if EnableUndo then
  begin
    vUndo := GetUndoList.Last;
    if vUndo <> nil then
      vUndo.ActionAppend(uatItemSelf, AItemNo, AOffset);
  end;
end;

procedure THCCustomRichData.Undo_StartGroup(const AItemNo, AOffset: Integer);
begin
  if EnableUndo then
    GetUndoList.BeginUndoGroup(AItemNo, AOffset);
end;

procedure THCCustomRichData.Undo_StartRecord;
begin
  if EnableUndo then
    GetUndoList.NewUndo;
end;

procedure THCCustomRichData.DoDrawItemPaintAfter(const AData: THCCustomData;
  const ADrawItemNo: Integer; const ADrawRect: TRect; const ADataDrawLeft,
  ADataDrawBottom, ADataScreenTop, ADataScreenBottom: Integer;
  const ACanvas: TCanvas; const APaintInfo: TPaintInfo);
begin
  inherited DoDrawItemPaintAfter(AData, ADrawItemNo, ADrawRect, ADataDrawLeft,
    ADataDrawBottom, ADataScreenTop, ADataScreenBottom, ACanvas, APaintInfo);

  if Assigned(FOnDrawItemPaintAfter) then
  begin
    FOnDrawItemPaintAfter(AData, ADrawItemNo, ADrawRect, ADataDrawLeft,
      ADataDrawBottom, ADataScreenTop, ADataScreenBottom, ACanvas, APaintInfo);
  end;
end;

procedure THCCustomRichData.DoDrawItemPaintBefor(const AData: THCCustomData;
  const ADrawItemNo: Integer; const ADrawRect: TRect; const ADataDrawLeft,
  ADataDrawBottom, ADataScreenTop, ADataScreenBottom: Integer;
  const ACanvas: TCanvas; const APaintInfo: TPaintInfo);
begin
  inherited DoDrawItemPaintBefor(AData, ADrawItemNo, ADrawRect, ADataDrawLeft,
    ADataDrawBottom, ADataScreenTop, ADataScreenBottom, ACanvas, APaintInfo);

  if Assigned(FOnDrawItemPaintBefor) then
  begin
    FOnDrawItemPaintBefor(AData, ADrawItemNo, ADrawRect, ADataDrawLeft,
      ADataDrawBottom, ADataScreenTop, ADataScreenBottom, ACanvas, APaintInfo);
  end;
end;

function THCCustomRichData.DoInsertText(const AText: string): Boolean;
var
  vCarteItemNo, vFormatFirstItemNo, vFormatLastItemNo: Integer;
  vNewItem: THCCustomItem;

  {$REGION ' DoTextItemInsert ���ı�Itemǰ����м�����ı� '}
  function DoTextItemInsert: Boolean;
  var
    vTextItem: THCTextItem;
    vS: string;
    vLen: Integer;
  begin
    Result := False;

    vTextItem := Items[vCarteItemNo] as THCTextItem;

    if vTextItem.StyleNo = Self.Style.CurStyleNo then  // ��ǰ��ʽ�Ͳ���λ��TextItem��ʽ��ͬ
    begin
      if vTextItem.CanAccept(SelectInfo.StartItemOffset) then  // TextItem��ƫ��λ�ÿɽ�������
      begin
        Undo_StartRecord;
        Undo_InsertText(vCarteItemNo, SelectInfo.StartItemOffset + 1, AText);

        GetReformatItemRange(vFormatFirstItemNo, vFormatLastItemNo);
        FormatItemPrepare(vFormatFirstItemNo, vFormatLastItemNo);

        if SelectInfo.StartItemOffset = 0 then  // ����ǰ�����
        begin
          vTextItem.Text := AText + vTextItem.Text;
          vLen := Length(AText);
        end
        else
        if SelectInfo.StartItemOffset = vTextItem.Length then  // ��TextItem������
        begin
          vTextItem.Text := vTextItem.Text + AText;
          vLen := vTextItem.Length;
        end
        else  // ��Item�м�
        begin
          vLen := SelectInfo.StartItemOffset + Length(AText);
          vS := vTextItem.Text;
          Insert(AText, vS, SelectInfo.StartItemOffset + 1);
          vTextItem.Text := vS;
        end;

        ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo);

        ReSetSelectAndCaret(vCarteItemNo, vLen);

        Result := True;
      end
      else  // ��λ�ò��ɽ�������
      begin
        if (SelectInfo.StartItemOffset = 0)
          or (SelectInfo.StartItemOffset = vTextItem.Length)   // ����β���ɽ���ʱ�����뵽ǰ��λ��
        then
        begin
          vNewItem := CreateDefaultTextItem;
          vNewItem.Text := AText;

          if SelectInfo.StartItemOffset = 0 then
            Result := InsertItem(vCarteItemNo, vNewItem, True)
          else
            Result := InsertItem(vCarteItemNo + 1, vNewItem, False);
        end;
      end;
    end
    else  // ����λ��TextItem��ʽ�͵�ǰ��ʽ��ͬ����TextItemͷ���С�βûѡ�У���Ӧ��������ʽ��������ʽ����
    begin
      vNewItem := CreateDefaultTextItem;
      vNewItem.Text := AText;
      Result := InsertItem(vNewItem);
    end;
  end;
  {$ENDREGION}

var
  vCarteItem: THCCustomItem;
  vRectItem: THCCustomRectItem;
begin
  Result := False;
  if AText <> '' then
  begin
    vCarteItemNo := GetCurItemNo;
    vCarteItem := Items[vCarteItemNo];

    if vCarteItem.StyleNo < THCStyle.Null then  // ��ǰλ���� RectItem
    begin
      if SelectInfo.StartItemOffset = OffsetInner then  // ��������������
      begin
        Undo_StartRecord;
        Undo_ItemSelf(SelectInfo.StartItemNo, OffsetInner);

        vRectItem := vCarteItem as THCCustomRectItem;
        Result := vRectItem.InsertText(AText);
        if vRectItem.SizeChanged then
        begin
          vRectItem.SizeChanged := False;
          GetReformatItemRange(vFormatFirstItemNo, vFormatLastItemNo);
          FormatItemPrepare(vFormatFirstItemNo, vFormatLastItemNo);
          ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo);
        end;
      end
      else  // ������ǰ
      if SelectInfo.StartItemOffset = OffsetAfter then  // �������������
      begin
        if (vCarteItemNo < Items.Count - 1)
          and (Items[vCarteItemNo + 1].StyleNo > THCStyle.Null)
          and (not Items[vCarteItemNo + 1].ParaFirst)
        then  // ��һ����TextItem�Ҳ��Ƕ��ף���ϲ�����һ����ʼ
        begin
          Inc(vCarteItemNo);
          SelectInfo.StartItemNo := vCarteItemNo;
          SelectInfo.StartItemOffset := 0;
          Self.Style.CurStyleNo := Items[vCarteItemNo].StyleNo;
          Result := DoTextItemInsert;  // ����һ��TextItemǰ�����
        end
        else  // ������һ������RectItem��ǰ�Ƕ�β
        begin
          vNewItem := CreateDefaultTextItem;
          vNewItem.Text := AText;
          SelectInfo.StartItemNo := vCarteItemNo + 1;
          Result := InsertItem(SelectInfo.StartItemNo, vNewItem, False);  // ������RectItem�м����
        end;
      end
      else  // ����ǰ��������
      begin
        if (vCarteItemNo > 0)
          and (Items[vCarteItemNo - 1].StyleNo > THCStyle.Null)
          and (not Items[vCarteItemNo].ParaFirst)
        then  // ǰһ����TextItem����ǰ���Ƕ��ף��ϲ���ǰһ��β
        begin
          Dec(vCarteItemNo);
          SelectInfo.StartItemNo := vCarteItemNo;
          SelectInfo.StartItemOffset := Items[vCarteItemNo].Length;
          Self.Style.CurStyleNo := Items[vCarteItemNo].StyleNo;
          Result := DoTextItemInsert  // ��ǰһ���������
        end
        else  // ��ǰ��ǰһ������RectItem
        begin
          vNewItem := CreateDefaultTextItem;
          vNewItem.Text := AText;
          Result := InsertItem(SelectInfo.StartItemNo, vNewItem, True);  // ������RectItem�м����
        end;
      end;
    end
    else
      Result := DoTextItemInsert;
  end
  else
    Result := InsertBreak;  // �յİ��س����д���
end;

procedure THCCustomRichData.DoItemInsert(const AItem: THCCustomItem);
begin
  if Assigned(FOnInsertItem) then
    FOnInsertItem(AItem);
end;

procedure THCCustomRichData.DoItemMouseEnter(const AItemNo: Integer);
begin
  Items[AItemNo].MouseEnter;
end;

procedure THCCustomRichData.DoItemMouseLeave(const AItemNo: Integer);
begin
  Items[AItemNo].MouseLeave;
end;

procedure THCCustomRichData.DoItemResized(const AItemNo: Integer);
begin
  if Assigned(FOnItemResized) then
    FOnItemResized(Self, AItemNo);
end;

function THCCustomRichData.EmptyDataInsertItem(const AItem: THCCustomItem): Boolean;
begin
  Result := False;

  if (AItem.StyleNo > THCStyle.Null) and (AItem.Text = '') then Exit;

  Undo_DeleteItem(0, 0);
  Items.Clear;
  DrawItems.Clear;
  AItem.ParaFirst := True;
  Items.Add(AItem);
  Undo_InsertItem(0, 0);

  // ��FormatItemPrepare��ReFormatData_���ǵ�һ����DrawItemΪ-1��
  // ����FormatDataʱ_FormatItemToDrawItems��Inc��
  FormatData(0, 0);
  ReSetSelectAndCaret(0);
  Result := True;
end;

function THCCustomRichData.EnableUndo: Boolean;
begin
  Result := Style.EnableUndo;
end;

procedure THCCustomRichData.Redo(const ARedo: THCCustomUndo);
begin
end;

procedure THCCustomRichData.ReFormat(const AStartItemNo: Integer);
begin
  if AStartItemNo > 0 then
  begin
    FormatItemPrepare(AStartItemNo, Items.Count - 1);
    FormatData(AStartItemNo, Items.Count - 1);
    DrawItems.DeleteFormatMark;
  end
  else  // ��0��ʼ�������ڴ����ⲿ�����ṩ�ķ���(���ڲ�����)�����Item�仯��û����Item��Ӧ��DrawItem�����
  begin
    DrawItems.Clear;
    FormatData(0, Items.Count - 1);
  end;
end;

procedure THCCustomRichData.ReFormatActiveItem;
var
  vFormatFirstItemNo, vFormatLastItemNo: Integer;
begin
  if SelectInfo.StartItemNo >= 0 then
  begin
    GetReformatItemRange(vFormatFirstItemNo, vFormatLastItemNo);
    FormatItemPrepare(vFormatFirstItemNo, vFormatLastItemNo);
    ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo);

    Style.UpdateInfoRePaint;
    Style.UpdateInfoReCaret;
  end;
end;

procedure THCCustomRichData.FormatData(const AStartItemNo, ALastItemNo: Integer);
var
  i, vPrioDrawItemNo: Integer;
  vPos: TPoint;
begin
  _FormatReadyParam(AStartItemNo, vPrioDrawItemNo, vPos);  // ��ʽ����ʼDrawItem��ź�λ��

  for i := AStartItemNo to ALastItemNo do  // ��ʽ��
    _FormatItemToDrawItems(i, 1, FWidth, vPos, vPrioDrawItemNo);
end;

procedure THCCustomRichData.Clear;
var
  i: Integer;
begin
  if Items.Count > 0 then
  begin
    Undo_StartRecord;
    for i := Items.Count - 1 to 0 do
      Undo_DeleteItem(i, 0);
  end;

  InitializeField;

  inherited Clear;
  SetEmptyData;
end;

function THCCustomRichData.GetTopLevelDrawItem: THCCustomDrawItem;
var
  vItem: THCCustomItem;
begin
  Result := nil;
  vItem := GetCurItem;
  if vItem.StyleNo < THCStyle.Null then
    Result := (vItem as THCCustomRectItem).GetActiveDrawItem;

  if Result = nil then
    Result := GetCurDrawItem;
end;

function THCCustomRichData.GetActiveDrawItemCoord: TPoint;
var
  vItem: THCCustomItem;
  vDrawItem: THCCustomDrawItem;
  vPt: TPoint;
begin
  Result := Point(0, 0);
  vPt := Point(0, 0);
  vDrawItem := GetCurDrawItem;
  if vDrawItem <> nil then
  begin
    Result := vDrawItem.Rect.TopLeft;

    vItem := GetCurItem;
    if vItem.StyleNo < THCStyle.Null then
      vPt := (vItem as THCCustomRectItem).GetActiveDrawItemCoord;

    Result.X := Result.X + vPt.X;
    Result.Y := Result.Y + vPt.Y;
  end;
end;

function THCCustomRichData.GetTopLevelItem: THCCustomItem;
begin
  Result := GetCurItem;
  if (Result <> nil) and (Result.StyleNo < THCStyle.Null) then
    Result := (Result as THCCustomRectItem).GetActiveItem;
end;

function THCCustomRichData.GetHeight: Cardinal;
begin
  Result := CalcContentHeight;
end;

function THCCustomRichData.GetHint: string;
begin
  if (not FMouseMoveRestrain) and (FMouseMoveItemNo >= 0) then
    Result := Items[FMouseMoveItemNo].GetHint
  else
    Result := '';
end;

procedure THCCustomRichData.GetReformatItemRange(var AFirstItemNo,
  ALastItemNo: Integer; const AItemNo, AItemOffset: Integer);
//var
//  vDrawItemNo, vParaFirstDItemNo: Integer;
begin
  // ����ʼΪTextItem��ͬһ�к�����RectItemʱ���༭TextItem���ʽ�����ܻὫRectItem�ֵ���һ�У�
  // ���Բ���ֱ�� FormatItemPrepare(SelectInfo.StartItemNo)�������Ϊ��ʽ����Χ̫С��
  // û�н���FiniLine�����иߣ����ԴӶ����������ʼ

  // ���Item�ֶ��У��ڷ���ʼλ�����޸ģ�����ʼλ�ø�ʽ��ʱ����ʼλ�ú�ǰ���ԭ��
  // ���ɢ�����˿�ȣ�����Ӧ�ô���ʼλ����������ItemNo��ʼ��ʽ����������ʼλ�ø�ʽ��ʱ
  // ��ǰ��Item����һ�η�ɢ���ӵĿ�ȣ�������ʼλ�ø�ʽ����Ȳ���ȷ����ɷ��в�׼ȷ
  // ��������ƣ���֧�����ݸ�ʽ��ʱָ��ItemNo��Offset��
  //
  // �����ʽ��λ������������ItemB��ʼ����һ�н�������һItemA���������ı�ʱ�ɺ�ItemA�ϲ���
  // ��Ҫ��ItemA��ʼ��ʽ��
  if (AItemNo > 0)
    and DrawItems[Items[AItemNo].FirstDItemNo].LineFirst
    and (AItemOffset = 0)
    //and ((Items[AItemNo].StyleNo < THCStyle.RsNull) or (AItemOffset = 0))
  then  // �ڿ�ͷ
  begin
    if not Items[AItemNo].ParaFirst then  // ���Ƕ���
      AFirstItemNo := GetLineFirstItemNo(AItemNo - 1, Items[AItemNo - 1].Length)
    else  // �Ƕ���
      AFirstItemNo := AItemNo;
  end
  else
    AFirstItemNo := GetLineFirstItemNo(AItemNo, 0);  // ȡ�е�һ��DrawItem��Ӧ��ItemNo

  ALastItemNo := GetParaLastItemNo(AItemNo);
end;

function THCCustomRichData.GetTopLevelData: THCCustomRichData;
begin
  Result := nil;
  if (SelectInfo.StartItemNo >= 0) and (SelectInfo.EndItemNo < 0) then
  begin
    if (Items[SelectInfo.StartItemNo].StyleNo < THCStyle.Null)
      and (SelectInfo.StartItemOffset = OffsetInner)
    then
      Result := (Items[SelectInfo.StartItemNo] as THCCustomRectItem).GetActiveData as THCCustomRichData;
  end;
  if Result = nil then
    Result := Self;
end;

function THCCustomRichData.GetTopLevelDataAt(const X,
  Y: Integer): THCCustomRichData;
var
  vItemNo, vOffset, vDrawItemNo, vX, vY: Integer;
  vRestrain: Boolean;
begin
  Result := nil;
  GetItemAt(X, Y, vItemNo, vOffset, vDrawItemNo, vRestrain);
  if (not vRestrain) and (vItemNo >= 0) then
  begin
    if Items[vItemNo].StyleNo < THCStyle.Null then
    begin
      CoordToItemOffset(X, Y, vItemNo, vOffset, vX, vY);
      Result := (Items[vItemNo] as THCCustomRectItem).GetTopLevelDataAt(vX, vY) as THCCustomRichData;
    end;
  end;
  if Result = nil then
    Result := Self;
end;

procedure THCCustomRichData.GetReformatItemRange(var AFirstItemNo,
  ALastItemNo: Integer);
begin
  GetReformatItemRange(AFirstItemNo, ALastItemNo, SelectInfo.StartItemNo, SelectInfo.StartItemOffset);
end;

function THCCustomRichData.GetWidth: Cardinal;
begin
  Result := FWidth;
end;

function THCCustomRichData.ActiveTableDeleteCurCol: Boolean;
begin
  if not CanEdit then Exit(False);

  Result := TableInsertRC(function(const AItem: THCCustomItem): Boolean
    begin
      Result := (AItem as THCTableItem).DeleteCurCol;
    end);
end;

function THCCustomRichData.ActiveTableDeleteCurRow: Boolean;
begin
  if not CanEdit then Exit(False);

  Result := TableInsertRC(function(const AItem: THCCustomItem): Boolean
    begin
      Result := (AItem as THCTableItem).DeleteCurRow;
    end);
end;

function THCCustomRichData.ActiveTableSplitCurCol: Boolean;
begin
  if not CanEdit then Exit(False);

  Result := TableInsertRC(function(const AItem: THCCustomItem): Boolean
    begin
      Result := (AItem as THCTableItem).SplitCurCol;
    end);
end;

function THCCustomRichData.ActiveTableSplitCurRow: Boolean;
begin
  if not CanEdit then Exit(False);

  Result := TableInsertRC(function(const AItem: THCCustomItem): Boolean
    begin
      Result := (AItem as THCTableItem).SplitCurRow;
    end);
end;

procedure THCCustomRichData.AddData(const ASrcData: THCCustomData);
var
  i, vAddStartNo: Integer;
  vItem: THCCustomItem;
begin
  Self.InitializeField;

  if Self.Items.Last.CanConcatItems(ASrcData.Items.First) then
  begin
    Self.Items.Last.Text := Self.Items.Last.Text + ASrcData.Items.First.Text;
    vAddStartNo := 1;
  end
  else
    vAddStartNo := 0;

  for i := vAddStartNo to ASrcData.Items.Count - 1 do
  begin
    if (ASrcData.Items[i].StyleNo < THCStyle.Null)
      or ((ASrcData.Items[i].StyleNo > THCStyle.Null) and (ASrcData.Items[i].Text <> ''))
    then
    begin
      vItem := CreateItemByStyle(ASrcData.Items[i].StyleNo);
      vItem.Assign(ASrcData.Items[i]);
      //vItem.ParaFirst := False;  // ��Ҫ���Ǻϲ�
      vItem.Active := False;
      vItem.DisSelect;
      Self.Items.Add(vItem);
    end;
  end;
end;

function THCCustomRichData.ApplySelectParaStyle(
  const AMatchStyle: THCParaMatch): Integer;
var
  vFirstNo, vLastNo: Integer;

  procedure DoApplyParaStyle(const AItemNo: Integer);
  var
    i, vParaNo: Integer;
  begin
    if GetItemStyle(AItemNo) < THCStyle.Null then  // ��ǰ��RectItem
      (Items[AItemNo] as THCCustomRectItem).ApplySelectParaStyle(Self.Style, AMatchStyle)
    else
    begin
      GetParaItemRang(AItemNo, vFirstNo, vLastNo);
      vParaNo := AMatchStyle.GetMatchParaNo(Self.Style, GetItemParaStyle(AItemNo));
      if GetItemParaStyle(vFirstNo) <> vParaNo then
      begin
        for i := vFirstNo to vLastNo do
          Items[i].ParaNo := vParaNo;
      end;
    end;
  end;

  procedure ApplyParaSelectedRangStyle;
  var
    i: Integer;
  begin
    // �ȴ�����ʼλ�����ڵĶΣ��Ա�������ʱ����ѭ������
    GetParaItemRang(SelectInfo.StartItemNo, vFirstNo, vLastNo);
    DoApplyParaStyle(SelectInfo.StartItemNo);

    i := vLastNo + 1; // �ӵ�ǰ�ε���һ��item��ʼ
    while i <= SelectInfo.EndItemNo do  // С�ڽ���λ��
    begin
      if Items[i].ParaFirst then
        DoApplyParaStyle(i);
      Inc(i);
    end;
  end;

var
  vFormatFirstItemNo, vFormatLastItemNo: Integer;
begin
  if SelectInfo.StartItemNo < 0 then Exit;

  //GetReformatItemRange(vFormatFirstItemNo, vFormatLastItemNo);
  vFormatFirstItemNo := GetParaFirstItemNo(SelectInfo.StartItemNo);

  if SelectInfo.EndItemNo >= 0 then  // ��ѡ������
  begin
    vFormatLastItemNo := GetParaLastItemNo(SelectInfo.EndItemNo);
    FormatItemPrepare(vFormatFirstItemNo, vFormatLastItemNo);
    ApplyParaSelectedRangStyle;
    ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo);
  end
  else  // û��ѡ������
  begin
    vFormatLastItemNo := GetParaLastItemNo(SelectInfo.StartItemNo);
    FormatItemPrepare(vFormatFirstItemNo, vFormatLastItemNo);
    DoApplyParaStyle(SelectInfo.StartItemNo);  // Ӧ����ʽ
    ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo);
  end;
  Style.UpdateInfoRePaint;
  Style.UpdateInfoReCaret;
end;

function THCCustomRichData.ApplySelectTextStyle(
  const AMatchStyle: THCStyleMatch): Integer;

  {$REGION ' MergeItemToPrio ��ǰItem�ɹ��ϲ���ͬ��ǰһ��Item '}
  function MergeItemToPrio(const AItemNo: Integer): Boolean;
  begin
    Result := (AItemNo > 0) and (not Items[AItemNo].ParaFirst)
              and MergeItemText(Items[AItemNo - 1], Items[AItemNo]);
  end;
  {$ENDREGION}

  {$REGION ' MergeItemToNext ͬ�κ�һ��Item�ɹ��ϲ�����ǰItem '}
  function MergeItemToNext(const AItemNo: Integer): Boolean;
  begin
    Result := (AItemNo < Items.Count - 1) and (not Items[AItemNo + 1].ParaFirst)
              and MergeItemText(Items[AItemNo], Items[AItemNo + 1]);
  end;
  {$ENDREGION}

var
  vStyleNo, vExtraCount, vLen: Integer;
  vItem: THCCustomItem;
  vText, vSelText: string;

  {$REGION 'ApplySameItemѡ����ͬһ��Item'}
  procedure ApplySameItem(const AItemNo: Integer);
  var
    vsBefor: string;
    vSelItem, vAfterItem: THCCustomItem;
  begin
    vItem := Items[AItemNo];
    if vItem.StyleNo < THCStyle.Null then  // ���ı�
    begin
      (vItem as THCCustomRectItem).ApplySelectTextStyle(Style, AMatchStyle);
      {Rect����ʱ�Ȳ�����
      if AMatchStyle is TTextStyleMatch then
      begin
        if (AMatchStyle as TTextStyleMatch).FontStyle = TFontStyleEx.tsCustom then
          DoApplyCustomStyle(vItem);
      end;}
    end
    else  // �ı�
    begin
      vStyleNo := AMatchStyle.GetMatchStyleNo(Style, vItem.StyleNo);
      if vItem.IsSelectComplate then  // Itemȫ����ѡ����
      begin
        vItem.StyleNo := vStyleNo;  // ֱ���޸���ʽ���
        if MergeItemToNext(AItemNo) then  // ��һ��Item�ϲ�����ǰItem
        begin
          Items.Delete(AItemNo + 1);
          Dec(vExtraCount);
        end;
        if AItemNo > 0 then  // ��ǰ�ϲ�
        begin
          vLen := Items[AItemNo - 1].Length;
          if MergeItemToPrio(AItemNo) then  // ��ǰItem�ϲ�����һ��Item(�������ϲ��ˣ�vItem�Ѿ�ʧЧ������ֱ��ʹ����)
          begin
            Items.Delete(AItemNo);
            Dec(vExtraCount);
            SelectInfo.StartItemNo := SelectInfo.StartItemNo - 1;
            SelectInfo.StartItemOffset := vLen;
            SelectInfo.EndItemNo := SelectInfo.StartItemNo;
            SelectInfo.EndItemOffset := vLen + SelectInfo.EndItemOffset;
          end;
        end;
      end
      else  // Itemһ���ֱ�ѡ��
      begin
        vText := vItem.Text;
        vSelText := Copy(vText, SelectInfo.StartItemOffset + 1,  // ѡ�е��ı�
          SelectInfo.EndItemOffset - SelectInfo.StartItemOffset);
        vsBefor := Copy(vText, 1, SelectInfo.StartItemOffset);  // ǰ�벿���ı�
        vAfterItem := Items[AItemNo].BreakByOffset(SelectInfo.EndItemOffset);  // ��벿�ֶ�Ӧ��Item
        if vAfterItem <> nil then  // ѡ�����λ�ò���Item����򴴽�����Ķ���Item
        begin
          Items.Insert(AItemNo + 1, vAfterItem);
          Inc(vExtraCount);
        end;

        if vsBefor <> '' then  // ѡ����ʼλ�ò���Item�ʼ������ǰ�벿�֣�����Item����ѡ�в���
        begin
          vItem.Text := vsBefor;  // ����ǰ�벿���ı�

          // ����ѡ���ı���Ӧ��Item
          vSelItem := CreateDefaultTextItem;
          vSelItem.ParaNo := vItem.ParaNo;
          vSelItem.StyleNo := vStyleNo;
          vSelItem.Text := vSelText;

          if vAfterItem <> nil then  // �к�벿�֣��м��������ʽ��ǰ��϶����ܺϲ�
          begin
            Items.Insert(AItemNo + 1, vSelItem);
            Inc(vExtraCount);
          end
          else  // û�к�벿�֣�˵��ѡ����Ҫ�ͺ����жϺϲ�
          begin
            if (AItemNo < Items.Count - 1)
              and (not Items[AItemNo + 1].ParaFirst)
              and MergeItemText(vSelItem, Items[AItemNo + 1])
            then
            begin
              Items[AItemNo + 1].Text := vSelText + Items[AItemNo + 1].Text;
              SelectInfo.StartItemNo := AItemNo + 1;
              SelectInfo.StartItemOffset := 0;
              SelectInfo.EndItemNo := AItemNo + 1;
              SelectInfo.EndItemOffset := Length(vSelText);

              Exit;
            end;
            Items.Insert(AItemNo + 1, vSelItem);
            Inc(vExtraCount);
          end;

          SelectInfo.StartItemNo := AItemNo + 1;
          SelectInfo.StartItemOffset := 0;
          SelectInfo.EndItemNo := AItemNo + 1;
          SelectInfo.EndItemOffset := Length(vSelText);
        end
        else  // ѡ����ʼλ����Item�ʼ
        begin
          //vItem.Text := vSelText;  // BreakByOffset�Ѿ�����ѡ�в����ı�
          vItem.StyleNo := vStyleNo;

          if MergeItemToPrio(AItemNo) then // ��ǰItem�ϲ�����һ��Item
          begin
            Items.Delete(AItemNo);
            Dec(vExtraCount);

            SelectInfo.StartItemNo := SelectInfo.StartItemNo - 1;
            vLen := Items[SelectInfo.StartItemNo].Length;
            SelectInfo.StartItemOffset := vLen - Length(vSelText);
            SelectInfo.EndItemNo := SelectInfo.StartItemNo;
            SelectInfo.EndItemOffset := vLen;
          end;
        end;
      end;
    end;
  end;
  {$ENDREGION}

  {$REGION 'ApplyStartItemѡ���ڲ�ͬItem�У�����ѡ����ʼItem'}
  procedure ApplyRangeStartItem(const AItemNo: Integer);
  var
    vAfterItem: THCCustomItem;
  begin
    vItem := Items[AItemNo];
    if vItem.StyleNo < THCStyle.Null then  // ���ı�
      (vItem as THCCustomRectItem).ApplySelectTextStyle(Style, AMatchStyle)
    else  // �ı�
    begin
      vStyleNo := AMatchStyle.GetMatchStyleNo(Style, vItem.StyleNo);

      if vItem.StyleNo <> vStyleNo then
      begin
        if vItem.IsSelectComplate then  // Itemȫѡ����
          vItem.StyleNo := vStyleNo
        else  // Item����ѡ��
        begin
          vAfterItem := Items[AItemNo].BreakByOffset(SelectInfo.StartItemOffset);  // ��벿�ֶ�Ӧ��Item
          vAfterItem.StyleNo := vStyleNo;
          Items.Insert(AItemNo + 1, vAfterItem);
          Inc(vExtraCount);

          SelectInfo.StartItemNo := SelectInfo.StartItemNo + 1;
          SelectInfo.StartItemOffset := 0;
          SelectInfo.EndItemNo := SelectInfo.EndItemNo + 1;
        end;
      end;
    end;
  end;
  {$ENDREGION}

  {$REGION 'ApplyEndItemѡ���ڲ�ͬItem�У�����ѡ�н���Item'}
  procedure ApplyRangeEndItem(const AItemNo: Integer);
  var
    vBeforItem: THCCustomItem;
  begin
    vItem := Items[AItemNo];
    if vItem.StyleNo < THCStyle.Null then  // ���ı�
      (vItem as THCCustomRectItem).ApplySelectTextStyle(Style, AMatchStyle)
    else  // �ı�
    begin
      vStyleNo := AMatchStyle.GetMatchStyleNo(Style, vItem.StyleNo);

      if vItem.StyleNo <> vStyleNo then
      begin
        if vItem.IsSelectComplate then  // Itemȫѡ����
          vItem.StyleNo := vStyleNo
        else  // Item����ѡ����
        begin
          vText := vItem.Text;
          vSelText := Copy(vText, 1, SelectInfo.EndItemOffset); // ѡ�е��ı�
          Delete(vText, 1, SelectInfo.EndItemOffset);
          vItem.Text := vText;

          vBeforItem := CreateDefaultTextItem;
          vBeforItem.ParaNo := vItem.ParaNo;
          vBeforItem.StyleNo := vStyleNo;
          vBeforItem.Text := vSelText;  // ����ǰ�벿���ı���Ӧ��Item
          vBeforItem.ParaFirst := vItem.ParaFirst;
          vItem.ParaFirst := False;

          Items.Insert(AItemNo, vBeforItem);
          Inc(vExtraCount);
        end;
      end;
    end;
  end;
  {$ENDREGION}

  {$REGION 'ApplyNorItemѡ���ڲ�ͬItem�������м�Item'}
  procedure ApplyRangeNorItem(const AItemNo: Integer);
  begin
    vItem := Items[AItemNo];
    if vItem.StyleNo < THCStyle.Null then  // ���ı�
      (vItem as THCCustomRectItem).ApplySelectTextStyle(Style, AMatchStyle)
    else  // �ı�
      vItem.StyleNo := AMatchStyle.GetMatchStyleNo(Style, vItem.StyleNo);
  end;
  {$ENDREGION}

var
  i, vFormatFirstItemNo, vFormatLastItemNo, vMStart, vMEnd: Integer;
begin
  Self.InitializeField;
  vExtraCount := 0;

  GetReformatItemRange(vFormatFirstItemNo, vFormatLastItemNo);
  if not SelectExists then  // û��ѡ��
  begin
    if Style.CurStyleNo > THCStyle.Null then  // (�ݴ�)���ڲ�֧���ı���ʽ��RectItem�ϣ����֧�ֵ�����ϸ�ֵStyle.CurStyleNoΪȷ�����ı���ʽ
    begin
      AMatchStyle.Append := not AMatchStyle.StyleHasMatch(Style, Style.CurStyleNo);  // ���ݵ�ǰ�ж��������ʽ���Ǽ�����ʽ
      Style.CurStyleNo := AMatchStyle.GetMatchStyleNo(Style, Style.CurStyleNo);

      Style.UpdateInfoRePaint;
      if Items[SelectInfo.StartItemNo].Length = 0 then  // ���У��ı䵱ǰ��괦��ʽ
      begin
        FormatItemPrepare(vFormatFirstItemNo, vFormatLastItemNo);
        Items[SelectInfo.StartItemNo].StyleNo := Style.CurStyleNo;
        ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo);
        Style.UpdateInfoReCaret;
      end
      else  // ���ǿ���
      begin
        if Items[SelectInfo.StartItemNo] is THCTextRectItem then
        begin
          FormatItemPrepare(vFormatFirstItemNo, vFormatLastItemNo);
          (Items[SelectInfo.StartItemNo] as THCTextRectItem).TextStyleNo := Style.CurStyleNo;
          ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo);
        end;

        Style.UpdateInfoReCaret(False);
      end;
    end;

    Exit;
  end;

  if SelectInfo.EndItemNo < 0 then  // û������ѡ������
  begin
    if Items[SelectInfo.StartItemNo].StyleNo < THCStyle.Null then
    begin
      // ����ı������RectItem��ȱ仯������Ҫ��ʽ�������һ��Item
      FormatItemPrepare(vFormatFirstItemNo, vFormatLastItemNo);
      (Items[SelectInfo.StartItemNo] as THCCustomRectItem).ApplySelectTextStyle(Style, AMatchStyle);
      ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo);
    end;
  end
  else  // ������ѡ������
  begin
    vFormatLastItemNo := GetParaLastItemNo(SelectInfo.EndItemNo);
    FormatItemPrepare(vFormatFirstItemNo, vFormatLastItemNo);

    for i := SelectInfo.StartItemNo to SelectInfo.EndItemNo do
    begin
      if Items[i].StyleNo > THCStyle.Null then
      begin
        AMatchStyle.Append := not AMatchStyle.StyleHasMatch(Style, Items[i].StyleNo);  // ���ݵ�һ���ж��������ʽ���Ǽ�����ʽ
        Break;
      end
      else
      if Items[i] is THCTextRectItem then
      begin
        AMatchStyle.Append := not AMatchStyle.StyleHasMatch(Style, (Items[i] as THCTextRectItem).TextStyleNo);  // ���ݵ�һ���ж��������ʽ���Ǽ�����ʽ
        Break;
      end;
    end;

    if SelectInfo.StartItemNo = SelectInfo.EndItemNo then  // ѡ�з�����ͬһItem��
      ApplySameItem(SelectInfo.StartItemNo)
    else  // ѡ�з����ڲ�ͬ��Item�������ȴ���ѡ�з�Χ����ʽ�ı䣬�ٴ���ϲ����ٴ���ѡ������ȫ������ѡ��״̬
    begin
      ApplyRangeEndItem(SelectInfo.EndItemNo);
      for i := SelectInfo.EndItemNo - 1 downto SelectInfo.StartItemNo + 1 do
        ApplyRangeNorItem(i);  // ����ÿһ��Item����ʽ
      ApplyRangeStartItem(SelectInfo.StartItemNo);

      { ��ʽ�仯�󣬴Ӻ���ǰ����ѡ�з�Χ�ڱ仯��ĺϲ� }
      //if (SelectInfo.EndItemNo < Items.Count - 1) and (not Items[SelectInfo.EndItemNo + 1].ParaFirst) then  // ѡ����������һ�����Ƕ���
      if SelectInfo.EndItemNo < vFormatLastItemNo + vExtraCount then  // ѡ����������һ�����Ƕ���
      begin
        if MergeItemToNext(SelectInfo.EndItemNo) then
        begin
          Items.Delete(SelectInfo.EndItemNo + 1);
          Dec(vExtraCount);
        end;
      end;

      for i := SelectInfo.EndItemNo downto SelectInfo.StartItemNo + 1 do
      begin
        vLen := Items[i - 1].Length;
        if MergeItemToPrio(i) then  // �ϲ���ǰһ��
        begin
          Items.Delete(i);
          Dec(vExtraCount);

          if i = SelectInfo.EndItemNo then  // ֻ�ںϲ���ѡ�����Item�żӳ�ƫ��
            SelectInfo.EndItemOffset := SelectInfo.EndItemOffset + vLen;
          SelectInfo.EndItemNo := SelectInfo.EndItemNo - 1;
        end;
      end;

      // ��ʼ��Χ
      if (SelectInfo.StartItemNo > 0) and (not Items[SelectInfo.StartItemNo].ParaFirst) then  // ѡ����ǰ�治�Ƕεĵ�һ��Item
      begin
        vLen := Items[SelectInfo.StartItemNo - 1].Length;
        if MergeItemToPrio(SelectInfo.StartItemNo) then  // �ϲ���ǰһ��
        begin
          Items.Delete(SelectInfo.StartItemNo);
          Dec(vExtraCount);

          SelectInfo.StartItemNo := SelectInfo.StartItemNo - 1;
          SelectInfo.StartItemOffset := vLen;
          SelectInfo.EndItemNo := SelectInfo.EndItemNo - 1;
          if SelectInfo.StartItemNo = SelectInfo.EndItemNo then  // ѡ�еĶ��ϲ���һ����
            SelectInfo.EndItemOffset := SelectInfo.EndItemOffset + vLen;
        end;
      end;
    end;

    ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo + vExtraCount, vExtraCount);
  end;

  MatchItemSelectState;

  Style.UpdateInfoRePaint;
  Style.UpdateInfoReCaret;
end;

function THCCustomRichData.CalcContentHeight: Integer;
begin
  if DrawItems.Count > 0 then
    Result := DrawItems[DrawItems.Count - 1].Rect.Bottom - DrawItems[0].Rect.Top
  else
    Result := 0;
end;

function THCCustomRichData.CanDeleteItem(const AItemNo: Integer): Boolean;
begin
  Result := CanEdit;
end;

function THCCustomRichData.CanEdit: Boolean;
begin
  Result := not FReadOnly;
  if not Result then
    Beep; //MessageBeep(MB_OK);
end;

function THCCustomRichData.CheckInsertItemCount(const AStartNo,
  AEndNo: Integer): Integer;
begin
  Result := AEndNo - AStartNo + 1;  // Ĭ��ԭ������
end;

procedure THCCustomRichData.InitializeField;
begin
  InitializeMouseField;
  inherited InitializeField;
end;

procedure THCCustomRichData.InitializeMouseField;
begin
  FMouseLBDowning := False;
  FMouseDownItemNo := -1;
  FMouseDownItemOffset := -1;
  FMouseMoveItemNo := -1;
  FMouseMoveItemOffset := -1;
  FMouseMoveRestrain := False;
  FSelecting := False;
  FDraging := False;
end;

function THCCustomRichData.InsertBreak: Boolean;
var
  vKey: Word;
begin
  Result := False;
  if not CanEdit then Exit;

  vKey := VK_RETURN;
  KeyDown(vKey, []);
  InitializeMouseField;  // 201807311101
  Result := True;
end;

function THCCustomRichData.InsertItem(const AIndex: Integer;
  const AItem: THCCustomItem; const AOffsetBefor: Boolean = True): Boolean;
var
  vFormatFirstItemNo, vFormatLastItemNo, vInsPos, vIncCount: Integer;
  vMerged: Boolean;
begin
  Result := False;

  if not CanEdit then Exit;

  //-------- ��ָ����Index������Item --------//

  //DeleteSelection;  // �������ѡ����������ôɾ����AIndex��Խ�磬���Ե��ô˷���ǰ��Ҫ����δѡ��״̬
  AItem.ParaNo := Style.CurParaNo;
  {if AItem is THCTextItem then  // ����TextItem Item����ʱ����õ�ǰ��ʽ��
  begin
    if Style.CurStyleNo > THCStyle.RsNull then  // ��RectItem�����ǰ�����TextItem
      AItem.StyleNo := Style.CurStyleNo
    else
      AItem.StyleNo := 0;
  end;}

  if IsEmptyData then
  begin
    Undo_StartRecord;
    Result := EmptyDataInsertItem(AItem);
    Exit;
  end;

  {˵����������λ�ò������һ���Ҳ���λ���Ƕ���ʼ����ô����������һ�������룬
   Ҳ������Ҫ����һ����ǰҳ���룬��ʱ��AItem��ParaFirst����Ϊ�ж�����}

  vIncCount := 0;
  Undo_StartRecord;
  if AItem.StyleNo < THCStyle.Null then  // ����RectItem
  begin
    vInsPos := AIndex;
    if AIndex < Items.Count then  // ������������һ��Item
    begin
      if AOffsetBefor then  // ��ԭλ��Itemǰ�����
      begin
        GetReformatItemRange(vFormatFirstItemNo, vFormatLastItemNo, AIndex, 0);
        FormatItemPrepare(vFormatFirstItemNo, vFormatLastItemNo);
        {if not AItem.ParaFirst then  // û�����Ƿ����ʼ�����ݻ�������Ӧ
        begin
          AItem.ParaFirst := Items[AIndex].ParaFirst;
          if Items[AIndex].ParaFirst then  // ��һ�ο�ʼ��Ϊ�ǿ�ʼ�����Ҫ����Ϊһ��ȥ�����жϼ���
          begin
            Undo_ItemParaFirst(AIndex, 0, False);
            Items[AIndex].ParaFirst := False;
          end;
        end;}

        if (Items[AIndex].StyleNo > THCStyle.Null) and (Items[AIndex].Text = '') then  // ����λ�ô��ǿ��У��滻��ǰ
        begin
          AItem.ParaFirst := True;
          Undo_DeleteItem(AIndex, 0);
          Items.Delete(AIndex);
          Dec(vIncCount);
        end
        else  // ����λ�ò��ǿ���
        if not AItem.ParaFirst then  // û�����Ƿ����ʼ�����ݻ�������Ӧ
        begin
          AItem.ParaFirst := Items[AIndex].ParaFirst;
          if Items[AIndex].ParaFirst then  // ��һ�ο�ʼ��Ϊ�ǿ�ʼ�����Ҫ����Ϊһ��ȥ�����жϼ���
          begin
            Undo_ItemParaFirst(AIndex, 0, False);
            Items[AIndex].ParaFirst := False;
          end;
        end;
      end
      else  // ��ĳItem�������
      begin
        if (AIndex > 0)
          and (Items[AIndex - 1].StyleNo > THCStyle.Null)
          and (Items[AIndex - 1].Text = '')
        then  // ����λ�ô�ǰһ���ǿ��У��滻��ǰ
        begin
          GetReformatItemRange(vFormatFirstItemNo, vFormatLastItemNo, AIndex - 1, 0);
          FormatItemPrepare(vFormatFirstItemNo, vFormatLastItemNo);

          AItem.ParaFirst := True;
          Undo_DeleteItem(AIndex - 1, 0);
          Items.Delete(AIndex - 1);
          Dec(vIncCount);
          Dec(vInsPos);
        end
        else  // ����λ��ǰһ�����ǿ���
        begin
          GetReformatItemRange(vFormatFirstItemNo, vFormatLastItemNo, AIndex, 0);
          FormatItemPrepare(vFormatFirstItemNo, vFormatLastItemNo);
        end;
      end;
    end
    else  // ��ĩβ���һ����Item
    begin
      vFormatFirstItemNo := AIndex - 1;
      vFormatLastItemNo := AIndex - 1;
      FormatItemPrepare(vFormatFirstItemNo, vFormatLastItemNo);

      if (not AItem.ParaFirst)  // ���벻������һ��
        and (Items[AIndex - 1].StyleNo > THCStyle.Null)  // ǰ����TextItem
        and (Items[AIndex - 1].Text = '')  // ����
      then  // ����λ�ô��ǿ��У��滻��ǰ
      begin
        AItem.ParaFirst := True;
        Undo_DeleteItem(AIndex - 1, 0);
        Items.Delete(AIndex - 1);
        Dec(vIncCount);
        Dec(vInsPos);
      end;
    end;

    Items.Insert(vInsPos, AItem);
    Undo_InsertItem(vInsPos, OffsetAfter);
    Inc(vIncCount);

    ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo + vIncCount, vIncCount);
    ReSetSelectAndCaret(vInsPos);
  end
  else  // �����ı�Item
  begin
    vMerged := False;

    if AIndex > 0 then  // �����ڵ�һ��λ��
    begin
      if AIndex < Items.Count then
      begin
        if not Items[AIndex].ParaFirst then
          GetReformatItemRange(vFormatFirstItemNo, vFormatLastItemNo, AIndex - 1, 0)
        else
          GetReformatItemRange(vFormatFirstItemNo, vFormatLastItemNo, AIndex, 0);
      end
      else  // �������׷��
        GetReformatItemRange(vFormatFirstItemNo, vFormatLastItemNo, AIndex - 1, 0)
    end
    else
      GetReformatItemRange(vFormatFirstItemNo, vFormatLastItemNo, 0, 0);

    FormatItemPrepare(vFormatFirstItemNo, vFormatLastItemNo);

    if not AItem.ParaFirst then  // �²���Ĳ�����һ�Σ��жϺ͵�ǰλ�õĹ�ϵ
    begin
      // ��2��Item�м����һ��Item����Ҫͬʱ�жϺ�ǰ���ܷ�ϲ�
      if AOffsetBefor then  // ��Itemǰ�����
      begin
        if (AIndex < Items.Count) and (Items[AIndex].CanConcatItems(AItem)) then  // ���жϺ͵�ǰλ�ô��ܷ�ϲ�
        begin
          Undo_InsertText(AIndex, 1, AItem.Text);  // 201806261644
          Items[AIndex].Text := AItem.Text + Items[AIndex].Text;

          ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo, 0);
          ReSetSelectAndCaret(AIndex);

          vMerged := True;
        end
        else
        if (not Items[AIndex].ParaFirst) and (AIndex > 0) and Items[AIndex - 1].CanConcatItems(AItem) then   // ���жϺ�ǰһ���ܷ�ϲ�
        begin
          Undo_InsertText(AIndex - 1, Items[AIndex - 1].Length + 1, AItem.Text);  // 201806261650
          Items[AIndex - 1].Text := Items[AIndex - 1].Text + AItem.Text;

          ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo, 0);
          ReSetSelectAndCaret(AIndex - 1);

          vMerged := True;
        end;
      end
      else  // ��Item�������
      begin
        if (AIndex > 0) and Items[AIndex - 1].CanConcatItems(AItem) then   // ���жϺ�ǰһ���ܷ�ϲ�
        begin
          Undo_InsertText(AIndex - 1, Items[AIndex - 1].Length + 1, AItem.Text);  // 201806261650
          Items[AIndex - 1].Text := Items[AIndex - 1].Text + AItem.Text;

          ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo, 0);
          ReSetSelectAndCaret(AIndex - 1);

          vMerged := True;
        end
        else
        if (AIndex < Items.Count) and (not Items[AIndex].ParaFirst) and (Items[AIndex].CanConcatItems(AItem)) then  // ���жϺ͵�ǰλ�ô��ܷ�ϲ�
        begin
          Undo_InsertText(AIndex, 1, AItem.Text);  // 201806261644
          Items[AIndex].Text := AItem.Text + Items[AIndex].Text;

          ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo, 0);
          ReSetSelectAndCaret(AIndex, AItem.Length);

          vMerged := True;
        end;
      end;
    end;

    if not vMerged then  // ���ܺͲ���λ��ǰ������λ�ô���Item�ϲ�
    begin
      if AOffsetBefor and (not AItem.ParaFirst) then  // ��ԭλ��Itemǰ����룬��û�����Ƿ����ʼ�����ݻ�������Ӧ
      begin
        AItem.ParaFirst := Items[AIndex].ParaFirst;
        if Items[AIndex].ParaFirst then  // ��һ�ο�ʼ��Ϊ�ǿ�ʼ�����Ҫ����Ϊһ��ȥ�����жϼ���
        begin
          Undo_ItemParaFirst(AIndex, 0, False);
          Items[AIndex].ParaFirst := False;
        end;
      end;

      Items.Insert(AIndex, AItem);
      Undo_InsertItem(AIndex, 0);
      ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo + 1, 1);

      ReSetSelectAndCaret(AIndex);
    end;
  end;

  Result := True;
end;

function THCCustomRichData.InsertLine(const ALineHeight: Integer): Boolean;
var
  vItem: TLineItem;
  vData: THCCustomRichData;
begin
  Result := False;

  if not CanEdit then Exit;

  vData := GetTopLevelData;
  vItem := TLineItem.Create(vData, vData.Width, 21);
  vItem.LineHeght := ALineHeight;

  Result := InsertItem(vItem);
  InitializeMouseField;  // 201807311101
end;

function THCCustomRichData.TableInsertColAfter(const AColCount: Byte): Boolean;
begin
  if not CanEdit then Exit(False);

  Result := TableInsertRC(function(const AItem: THCCustomItem): Boolean
    begin
      Result := (AItem as THCTableItem).InsertColAfter(AColCount);
    end);
end;

function THCCustomRichData.TableInsertColBefor(const AColCount: Byte): Boolean;
begin
  if not CanEdit then Exit(False);

  Result := TableInsertRC(function(const AItem: THCCustomItem): Boolean
    begin
      Result := (AItem as THCTableItem).InsertColBefor(AColCount);
    end);
end;

function THCCustomRichData.TableInsertRC(const AProc: TInsertProc): Boolean;
var
  vCurItemNo, vFormatFirstItemNo, vFormatLastItemNo: Integer;
begin
  Result := False;
  vCurItemNo := GetCurItemNo;
  if Items[vCurItemNo] is THCTableItem then
  begin
    GetReformatItemRange(vFormatFirstItemNo, vFormatLastItemNo, vCurItemNo, 0);
    FormatItemPrepare(vFormatFirstItemNo, vFormatLastItemNo);
    Result := AProc(Items[vCurItemNo]);
    if Result then
    begin
      ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo, 0);
      Style.UpdateInfoRePaint;
      Style.UpdateInfoReCaret;
    end;

    InitializeMouseField;  // 201807311101
  end;
end;

function THCCustomRichData.TableInsertRowAfter(const ARowCount: Byte): Boolean;
begin
  if not CanEdit then Exit(False);

  Result := TableInsertRC(function(const AItem: THCCustomItem): Boolean
    begin
      Result := (AItem as THCTableItem).InsertRowAfter(ARowCount);
    end);
end;

function THCCustomRichData.TableInsertRowBefor(const ARowCount: Byte): Boolean;
begin
  if not CanEdit then Exit(False);

  Result := TableInsertRC(function(const AItem: THCCustomItem): Boolean
    begin
      Result := (AItem as THCTableItem).InsertRowBefor(ARowCount);
    end);
end;

procedure THCCustomRichData.Undo(const AUndo: THCCustomUndo);
begin
end;

procedure THCCustomRichData.Undo_DeleteItem(const AItemNo, AOffset: Integer);
var
  vUndo: THCUndo;
  vUndoList: THCUndoList;
  vItemAction: THCItemUndoAction;
begin
  if EnableUndo then
  begin
    vUndoList := GetUndoList;
    vUndo := vUndoList.Last;
    if vUndo <> nil then
    begin
      vItemAction := vUndo.ActionAppend(uatDeleteItem, AItemNo, AOffset) as THCItemUndoAction;
      SaveItemToStreamAlone(Items[AItemNo], vItemAction.ItemStream);
    end;
  end;
end;

procedure THCCustomRichData.Undo_InsertItem(const AItemNo, AOffset: Integer);
var
  vUndo: THCUndo;
  vItemAction: THCItemUndoAction;
begin
  if EnableUndo then
  begin
    vUndo := GetUndoList.Last;
    if vUndo <> nil then
    begin
      vItemAction := vUndo.ActionAppend(uatInsertItem, AItemNo, AOffset) as THCItemUndoAction;
      SaveItemToStreamAlone(Items[AItemNo], vItemAction.ItemStream);
    end;
  end;
end;

function THCCustomRichData.InsertStream(const AStream: TStream;
  const AStyle: THCStyle; const AFileVersion: Word): Boolean;
var
  vInsPos, vFormatFirstItemNo, vFormatLastItemNo: Integer;
  vItem, vAfterItem: THCCustomItem;
  i, vItemCount, vStyleNo, vOffsetStart, vInsetLastNo, vCaretOffse: Integer;
  vInsertBefor: Boolean;
  vDataSize: Int64;
begin
  Result := False;

  if not CanEdit then Exit;

  vAfterItem := nil;
  vInsertBefor := False;

  Undo_StartGroup(SelectInfo.StartItemNo, SelectInfo.StartItemOffset);
  try
    if Items.Count = 0 then  // ��
      vInsPos := 0
    else  // ������
    begin
      DeleteSelected;
      // ȷ������λ��
      vInsPos := SelectInfo.StartItemNo;
      if Items[vInsPos].StyleNo < THCStyle.Null then  // RectItem
      begin
        if SelectInfo.StartItemOffset = OffsetInner then  // ����
        begin
          GetReformatItemRange(vFormatFirstItemNo, vFormatLastItemNo, SelectInfo.StartItemNo, OffsetInner);
          FormatItemPrepare(vFormatFirstItemNo, vFormatLastItemNo);
          Undo_StartRecord;
          Undo_ItemSelf(SelectInfo.StartItemNo, SelectInfo.StartItemOffset);
          Result := (Items[vInsPos] as THCCustomRectItem).InsertStream(AStream, AStyle, AFileVersion);
          ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo);

          Exit;
        end
        else
        if SelectInfo.StartItemOffset = OffsetBefor then  // ��ǰ
          vInsertBefor := True
        else  // ���
          vInsPos := vInsPos + 1;
      end
      else  // TextItem
      begin
        // ���жϹ���Ƿ�����󣬷�ֹ��ItemʱSelectInfo.StartItemOffset = 0����ǰ����
        if SelectInfo.StartItemOffset = Items[vInsPos].Length then  // ���
          vInsPos := vInsPos + 1
        else
        if SelectInfo.StartItemOffset = 0 then  // ��ǰ
          vInsertBefor := Items[vInsPos].Length <> 0
        else  // ����
        begin
          Undo_StartRecord;
          Undo_DeleteText(vInsPos, 1, Copy(Items[vInsPos].Text, 1, SelectInfo.StartItemOffset));

          vAfterItem := Items[vInsPos].BreakByOffset(SelectInfo.StartItemOffset);  // ��벿�ֶ�Ӧ��Item
          vInsPos := vInsPos + 1;
        end;
      end;
    end;

    AStream.ReadBuffer(vDataSize, SizeOf(vDataSize));
    if vDataSize = 0 then Exit;

    AStream.ReadBuffer(vItemCount, SizeOf(vItemCount));
    if vItemCount = 0 then Exit;

    // ��Ϊ����ĵ�һ�����ܺͲ���λ��ǰһ���ϲ�������λ�ÿ��������ף�����Ҫ�Ӳ���λ��
    // ����һ����ʼ��ʽ����Ϊ�򵥴���ֱ��ʹ�ö��ף����Ż�Ϊ��һ����
    //GetParaItemRang(SelectInfo.StartItemNo, vFormatFirstItemNo, vFormatLastItemNo);

    GetReformatItemRange(vFormatFirstItemNo, vFormatLastItemNo);

    // �����ʽ����ʼ������ItemNo
    if Items.Count > 0 then  // ����Empty
      FormatItemPrepare(vFormatFirstItemNo, vFormatLastItemNo)
    else
    begin
      vFormatFirstItemNo := 0;
      vFormatLastItemNo := -1;
    end;

    Undo_StartRecord;
    for i := 0 to vItemCount - 1 do
    begin
      AStream.ReadBuffer(vStyleNo, SizeOf(vStyleNo));
      vItem := CreateItemByStyle(vStyleNo);
      if vStyleNo < THCStyle.Null then
        Undo_ItemSelf(i, 0);
      vItem.LoadFromStream(AStream, AStyle, AFileVersion);
      if AStyle <> nil then  // ����ʽ��
      begin
        if vItem.StyleNo > THCStyle.Null then
          vItem.StyleNo := Style.GetStyleNo(AStyle.TextStyles[vItem.StyleNo], True);
        vItem.ParaNo := Style.GetParaNo(AStyle.ParaStyles[vItem.ParaNo], True);
      end
      else  // ����ʽ��
      begin
        if vItem.StyleNo > THCStyle.Null then
          vItem.StyleNo := Style.CurStyleNo;
        vItem.ParaNo := Style.CurParaNo;
      end;

      if i = 0 then  // ����ĵ�һ��Item
      begin
        if vInsertBefor then  // ��һ����ĳItem��ǰ�����(ճ��)
        begin
          vItem.ParaFirst := Items[vInsPos].ParaFirst;

          if Items[vInsPos].ParaFirst then
          begin
            Undo_ItemParaFirst(vInsPos, 0, False);
            Items[vInsPos].ParaFirst := False;
          end;
        end
        else
          vItem.ParaFirst := False
      end;

      Items.Insert(vInsPos + i, vItem);
      Undo_InsertItem(vInsPos + i, 0);
    end;

    vItemCount := CheckInsertItemCount(vInsPos, vInsPos + vItemCount - 1);  // �������Item�Ƿ�ϸ�ɾ�����ϸ�

    vInsetLastNo := vInsPos + vItemCount - 1;  // ��������һ��Item
    vCaretOffse := GetItemAfterOffset(vInsetLastNo);  // ���һ��Item����

    if vAfterItem <> nil then  // �����������Item�м䣬ԭItem����ֳ�2��
    begin
      if MergeItemText(Items[vInsetLastNo], vAfterItem) then  // �������һ���ͺ�벿���ܺϲ�
      begin
        Undo_InsertText(vInsetLastNo, Items[vInsetLastNo].Length - vAfterItem.Length + 1, vAfterItem.Text);

        FreeAndNil(vAfterItem);
      end
      else  // �������һ���ͺ�벿�ֲ��ܺϲ�
      begin
        Items.Insert(vInsetLastNo + 1, vAfterItem);
        Undo_InsertItem(vInsetLastNo + 1, 0);

        Inc(vItemCount);
      end;
    end;

    if {(vInsPos > vFormatFirstItemNo) and} (vInsPos > 0) then  // �ڸ�ʽ����ʼλ�ú�����Ҳ��ǵ�0��λ��
    begin
      if Items[vInsPos - 1].Length = 0 then  // ����λ��ǰ���ǿ���Item
      begin
        Undo_ItemParaFirst(vInsPos, 0, Items[vInsPos - 1].ParaFirst);
        Items[vInsPos].ParaFirst := Items[vInsPos - 1].ParaFirst;

        Undo_DeleteItem(vInsPos - 1, 0);
        Items.Delete(vInsPos - 1);  // ɾ������

        Dec(vItemCount);
        Dec(vInsetLastNo);
      end
      else  // ����λ��ǰ�治�ǿ���Item
      begin
        vOffsetStart := Items[vInsPos - 1].Length;
        if (not Items[vInsPos].ParaFirst)
          and MergeItemText(Items[vInsPos - 1], Items[vInsPos])
        then  // ����ĺ�ǰ��ĺϲ�
        begin
          Undo_InsertText(vInsPos - 1, Items[vInsPos - 1].Length + 1, Items[vInsPos].Text);
          Undo_DeleteItem(vInsPos, 0);

          if vItemCount = 1 then
            vCaretOffse := vOffsetStart + vCaretOffse;

          Items.Delete(vInsPos);
          Dec(vItemCount);
          Dec(vInsetLastNo);
        end;
      end;

      if (vInsetLastNo < Items.Count - 1)  // �������Item�ͺ�����ܺϲ�
        and (not Items[vInsetLastNo + 1].ParaFirst)
        and MergeItemText(Items[vInsetLastNo], Items[vInsetLastNo + 1])
      then
      begin
        Undo_DeleteItem(vInsetLastNo + 1, 0);

        Items.Delete(vInsetLastNo + 1);
        Dec(vItemCount);
      end;
    end
    else  // ���ʼ��0��λ�ô�����
    //if (vInsetLastNo < Items.Count - 1) then
    begin
      if MergeItemText(Items[vInsetLastNo], Items[vInsetLastNo + 1 {vInsPos + vItemCount}]) then  // ���ԺͲ���ǰ0λ�õĺϲ�
      begin
        Undo_DeleteItem(vInsPos + vItemCount, 0);

        Items.Delete(vInsPos + vItemCount);
        Dec(vItemCount);
      end;
    end;

    ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo + vItemCount, vItemCount);

    ReSetSelectAndCaret(vInsetLastNo, vCaretOffse);  // ѡ�в����������Itemλ��
  finally
    Undo_EndGroup(SelectInfo.StartItemNo, SelectInfo.StartItemOffset);
  end;

  InitializeMouseField;  // 201807311101

  Style.UpdateInfoRePaint;
  Style.UpdateInfoReCaret;
  Style.UpdateInfoReScroll;
end;

function THCCustomRichData.InsertItem(const AItem: THCCustomItem): Boolean;
var
  vCurItemNo: Integer;
  vFormatFirstItemNo, vFormatLastItemNo: Integer;
  vText, vsBefor, vsAfter: string;
  vAfterItem: THCCustomItem;
begin
  Result := False;

  if not CanEdit then Exit;

  DeleteSelected;

  AItem.ParaNo := Style.CurParaNo;
  {if AItem is THCTextItem then  // item����ʱ����õ�ǰ��ʽ��
  begin
    if Style.CurStyleNo > THCStyle.RsNull then  // ��RectItem�����ǰ�����TextItem
      AItem.StyleNo := Style.CurStyleNo
    else
      AItem.StyleNo := 0;
  end;}

  if IsEmptyData then
  begin
    Undo_StartRecord;
    Result := EmptyDataInsertItem(AItem);
    Exit;
  end;
  vCurItemNo := GetCurItemNo;

  if Items[vCurItemNo].StyleNo < THCStyle.Null then  // ��ǰλ���� RectItem
  begin
    if SelectInfo.StartItemOffset = OffsetInner then  // ��������
    begin
      GetReformatItemRange(vFormatFirstItemNo, vFormatLastItemNo);
      FormatItemPrepare(vFormatFirstItemNo, vFormatLastItemNo);

      Undo_StartRecord;
      Undo_ItemSelf(vCurItemNo, OffsetInner);
      Result := (Items[vCurItemNo] as THCCustomRectItem).InsertItem(AItem);
      if Result then
        ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo, 0);
    end
    else  // ��ǰor���
    begin
      if SelectInfo.StartItemOffset = OffsetBefor then  // ��ǰ
        Result := InsertItem(SelectInfo.StartItemNo, AItem)
      else  // ���
        Result := InsertItem(SelectInfo.StartItemNo + 1, AItem, False);
    end;
  end
  else  // ��ǰλ����TextItem
  begin
    // ���ж��Ƿ��ں��棬�������ڿ��в���ʱ�Ӻ�����룬�������ɿ�������ѹ
    if (SelectInfo.StartItemOffset = Items[vCurItemNo].Length) then  // ��TextItem������
      Result := InsertItem(SelectInfo.StartItemNo + 1, AItem, False)
    else
    if SelectInfo.StartItemOffset = 0 then  // ����ǰ�����
      Result := InsertItem(SelectInfo.StartItemNo, AItem)
    else  // ��Item�м�
    begin
      GetReformatItemRange(vFormatFirstItemNo, vFormatLastItemNo);
      FormatItemPrepare(vFormatFirstItemNo, vFormatLastItemNo);

      vText := Items[vCurItemNo].Text;
      vsBefor := Copy(vText, 1, SelectInfo.StartItemOffset);  // ǰ�벿���ı�
      vsAfter := Copy(vText, SelectInfo.StartItemOffset + 1, Items[vCurItemNo].Length
        - SelectInfo.StartItemOffset);  // ��벿���ı�

      Undo_StartRecord;
      if Items[vCurItemNo].CanConcatItems(AItem) then  // �ܺϲ�
      begin
        if AItem.ParaFirst then  // �¶�
        begin
          Undo_DeleteText(vCurItemNo, SelectInfo.StartItemOffset + 1, vsAfter);
          Items[vCurItemNo].Text := vsBefor;
          AItem.Text := AItem.Text + vsAfter;

          vCurItemNo := vCurItemNo + 1;
          Items.Insert(vCurItemNo, AItem);
          Undo_InsertItem(vCurItemNo, 0);

          ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo, 1);
          ReSetSelectAndCaret(vCurItemNo);
        end
        else  // ͬһ���в���
        begin
          Undo_InsertText(vCurItemNo, SelectInfo.StartItemOffset + 1, AItem.Text);
          vsBefor := vsBefor + AItem.Text;
          Items[vCurItemNo].Text := vsBefor + vsAfter;

          ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo, 0);
          SelectInfo.StartItemNo := vCurItemNo;
          SelectInfo.StartItemOffset := Length(vsBefor);
          //CaretDrawItemNo := GetItemLastDrawItemNo(vCurItemNo);
        end;
      end
      else  // ���ܺϲ�
      begin
        Undo_DeleteText(vCurItemNo, SelectInfo.StartItemOffset + 1, vsAfter);
        vAfterItem := Items[vCurItemNo].BreakByOffset(SelectInfo.StartItemOffset);  // ��벿�ֶ�Ӧ��Item

        // �����벿�ֶ�Ӧ��Item
        vCurItemNo := vCurItemNo + 1;
        Items.Insert(vCurItemNo, vAfterItem);
        Undo_InsertItem(vCurItemNo, 0);
        // ������Item
        Items.Insert(vCurItemNo, AItem);
        Undo_InsertItem(vCurItemNo, 0);

        ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo + 2, 2);
        ReSetSelectAndCaret(vCurItemNo);
      end;

      Result := True;
    end;
  end;
end;

function THCCustomRichData.InsertTable(const ARowCount,
  AColCount: Integer): Boolean;
var
  vItem: THCCustomItem;
  vTopData: THCCustomRichData;
begin
  Result := False;

  if not CanEdit then Exit;

  vTopData := GetTopLevelData;

  vItem := THCTableItem.Create(vTopData, ARowCount, AColCount, vTopData.Width);
  Result := InsertItem(vItem);
  InitializeMouseField;  // 201807311101
end;

function THCCustomRichData.InsertText(const AText: string): Boolean;
var
  vPCharStart, vPCharEnd, vPtr: PChar;
  vParaFirst: Boolean;
  vS: string;
  vTextItem: THCCustomItem;
begin
  Result := False;

  if not CanEdit then Exit;

  DeleteSelected;

  vParaFirst := False;
  vPCharStart := PChar(AText);
  vPCharEnd := vPCharStart + Length(AText);
  if vPCharStart = vPCharEnd then Exit;
  vPtr := vPCharStart;
  while vPtr < vPCharEnd do
  begin
    case vPtr^ of
      #13:
        begin
          System.SetString(vS, vPCharStart, vPtr - vPCharStart);

          if vParaFirst then
          begin
            vTextItem := CreateDefaultTextItem;
            vTextItem.ParaFirst := True;
            vTextItem.Text := vS;
            Result := InsertItem(vTextItem);
          end
          else
            Result := DoInsertText(vS);

          vParaFirst := True;

          Inc(vPtr);
          vPCharStart := vPtr;
          Continue;
        end;

      #10:
        begin
          Inc(vPtr);
          vPCharStart := vPtr;
          Continue;
        end;
    end;

    Inc(vPtr);
  end;

  System.SetString(vS, vPCharStart, vPtr - vPCharStart);

  Result := DoInsertText(vS);

  InitializeMouseField;  // 201807311101

  Style.UpdateInfoRePaint;
  Style.UpdateInfoReCaret;
  Style.UpdateInfoReScroll;
end;

function THCCustomRichData.IsSelectSeekStart: Boolean;
begin
  Result := (FSelectSeekNo = SelectInfo.StartItemNo) and
    (FSelectSeekOffset = SelectInfo.StartItemOffset);
end;

procedure THCCustomRichData.KeyDown(var Key: Word; Shift: TShiftState);

  {$REGION 'CheckSelectEndEff �ж�ѡ������Ƿ����ʼ��ͬһλ�ã�����ȡ��ѡ��'}
  procedure CheckSelectEndEff;
  begin
    if (SelectInfo.StartItemNo = SelectInfo.EndItemNo)
      and (SelectInfo.StartItemOffset = SelectInfo.EndItemOffset)
    then
    begin
      Items[SelectInfo.EndItemNo].DisSelect;

      SelectInfo.EndItemNo := -1;
      SelectInfo.EndItemOffset := -1;
    end;
  end;
  {$ENDREGION}

  procedure SetSelectSeekStart;
  begin
    FSelectSeekNo := SelectInfo.StartItemNo;
    FSelectSeekOffset := SelectInfo.StartItemOffset;
  end;

  procedure SetSelectSeekEnd;
  begin
    FSelectSeekNo := SelectInfo.EndItemNo;
    FSelectSeekOffset := SelectInfo.EndItemOffset;
  end;

var
  vCurItem: THCCustomItem;
  vParaFirstItemNo, vParaLastItemNo: Integer;
  vFormatFirstItemNo, vFormatLastItemNo: Integer;
  vSelectExist: Boolean;

  {$REGION ' TABKeyDown ���� '}
  procedure TABKeyDown;
  var
    vTabItem: TTabItem;
  begin
    vTabItem := TTabItem.Create(Self);
    if vCurItem.StyleNo < THCStyle.Null then  // ��ǰ��RectItem
    begin
      if SelectInfo.StartItemOffset = OffsetInner then // ������
      begin
        if (vCurItem as THCCustomRectItem).WantKeyDown(Key, Shift) then  // ����˼�
        begin
          GetReformatItemRange(vFormatFirstItemNo, vFormatLastItemNo);
          FormatItemPrepare(vFormatFirstItemNo, vFormatLastItemNo);
          (vCurItem as THCCustomRectItem).KeyDown(Key, Shift);
          ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo);
        end;

        Exit;
      end;
    end;

    Self.InsertItem(vTabItem);
  end;
  {$ENDREGION}

  {$REGION ' LeftKeyDown ����� '}
  procedure LeftKeyDown;

    procedure SelectPrio(var AItemNo, AOffset: Integer);
    begin
      if AOffset > 0 then  // ƫ�Ʋ����ʼ����ǰItem��ǰ
      begin
        if Items[AItemNo].StyleNo > THCStyle.Null then
          AOffset := AOffset - 1
        else
          AOffset := OffsetBefor;
      end
      else
      if AItemNo > 0then  // ���ͷ����ǰһ�����
      begin
        Items[AItemNo].DisSelect;
        AItemNo := AItemNo - 1;
        if Items[AItemNo].StyleNo < THCStyle.Null then
          AOffset := OffsetBefor
        else
          AOffset := Items[AItemNo].Length - 1;  // ������1��ǰ��
      end;
    end;

    procedure SelectStartItemPrio;
    var
      vItemNo, vOffset: Integer;
    begin
      vItemNo := SelectInfo.StartItemNo;
      vOffset := SelectInfo.StartItemOffset;
      SelectPrio(vItemNo, vOffset);
      SelectInfo.StartItemNo := vItemNo;
      SelectInfo.StartItemOffset := vOffset;
    end;

    procedure SelectEndItemPrio;
    var
      vItemNo, vOffset: Integer;
    begin
      vItemNo := SelectInfo.EndItemNo;
      vOffset := SelectInfo.EndItemOffset;
      SelectPrio(vItemNo, vOffset);
      SelectInfo.EndItemNo := vItemNo;
      SelectInfo.EndItemOffset := vOffset;
    end;

  var
    vNewCaretDrawItemNo: Integer;
  begin
    if Shift = [ssShift] then  // Shift+�����ѡ��
    begin
      if SelectInfo.EndItemNo >= 0 then  // ��ѡ������
      begin
        if IsSelectSeekStart then  // �α���ѡ����ʼ
        begin
          SelectStartItemPrio;
          SetSelectSeekStart;
        end
        else  // �α���ѡ�н���
        begin
          SelectEndItemPrio;
          SetSelectSeekEnd;
        end;
      end
      else  // û��ѡ��
      begin
        if (SelectInfo.StartItemNo > 0) and (SelectInfo.StartItemOffset = 0) then  // ��Item��ǰ����ǰ
        begin
          SelectInfo.StartItemNo := SelectInfo.StartItemNo - 1;
          SelectInfo.StartItemOffset := GetItemAfterOffset(SelectInfo.StartItemNo);
        end;

        SelectInfo.EndItemNo := SelectInfo.StartItemNo;
        SelectInfo.EndItemOffset := SelectInfo.StartItemOffset;

        SelectStartItemPrio;
        SetSelectSeekStart;
      end;

      CheckSelectEndEff;
      MatchItemSelectState;
      Style.UpdateInfoRePaint;
    end
    else  // û�а���Shift
    begin
      if vSelectExist then  // ��ѡ������
      begin
        SelectInfo.EndItemNo := -1;
        SelectInfo.EndItemOffset := -1;
      end
      else  // ��ѡ������
      begin
        if SelectInfo.StartItemOffset <> 0 then  // ����Item�ʼ
          SelectInfo.StartItemOffset := SelectInfo.StartItemOffset - 1
        else  // ��Item�ʼ�����
        begin
          if SelectInfo.StartItemNo > 0 then  // ���ǵ�һ��Item���ʼ����ǰ���ƶ�
          begin
            SelectInfo.StartItemNo := SelectInfo.StartItemNo - 1;  // ��һ��
            SelectInfo.StartItemOffset := GetItemAfterOffset(SelectInfo.StartItemNo);

            if not DrawItems[Items[SelectInfo.StartItemNo + 1].FirstDItemNo].LineFirst then  // �ƶ�ǰItem��������ʼ
            begin
              KeyDown(Key, Shift);
              Exit;
            end;
          end
          else  // �ڵ�һ��Item�����水�������
            Key := 0;
        end;
      end;

      if Key <> 0 then
      begin
        vNewCaretDrawItemNo := GetDrawItemNoByOffset(SelectInfo.StartItemNo, SelectInfo.StartItemOffset);
        if vNewCaretDrawItemNo <> CaretDrawItemNo then  // ��DrawItemNo��
        begin
          if (vNewCaretDrawItemNo = CaretDrawItemNo - 1)  // �ƶ���ǰһ����
            and (DrawItems[vNewCaretDrawItemNo].ItemNo = DrawItems[CaretDrawItemNo].ItemNo)  // ��ͬһ��Item
            and (DrawItems[CaretDrawItemNo].LineFirst)  // ԭ������
            and (SelectInfo.StartItemOffset = DrawItems[CaretDrawItemNo].CharOffs - 1)  // ���λ��Ҳ��ԭDrawItem����ǰ��
          then
            // ������
          else
            CaretDrawItemNo := vNewCaretDrawItemNo;
        end;
      end;
    end;
  end;
  {$ENDREGION}

  {$REGION ' RightKeyDown �ҷ�������˴������漰��񣬱����RectItemKeyDown�д����� '}
  procedure RightKeyDown;

    procedure SelectNext(var AItemNo, AOffset: Integer);
    begin
      if AOffset = GetItemAfterOffset(AItemNo) then  // ��Item����ƶ�����һ��Item
      begin
        if AItemNo < Items.Count - 1 then
        begin
          Inc(AItemNo);

          if Items[AItemNo].StyleNo < THCStyle.Null then
            AOffset := OffsetAfter
          else
            AOffset := 1;
        end;
      end
      else  // �������
      begin
        if Items[AItemNo].StyleNo < THCStyle.Null then
          AOffset := OffsetAfter
        else
          AOffset := AOffset + 1;
      end;
    end;

    procedure SelectStartItemNext;
    var
      vItemNo, vOffset: Integer;
    begin
      vItemNo := SelectInfo.StartItemNo;
      vOffset := SelectInfo.StartItemOffset;
      SelectNext(vItemNo, vOffset);
      SelectInfo.StartItemNo := vItemNo;
      SelectInfo.StartItemOffset := vOffset;
    end;

    procedure SelectEndItemNext;
    var
      vItemNo, vOffset: Integer;
    begin
      vItemNo := SelectInfo.EndItemNo;
      vOffset := SelectInfo.EndItemOffset;
      SelectNext(vItemNo, vOffset);
      SelectInfo.EndItemNo := vItemNo;
      SelectInfo.EndItemOffset := vOffset;
    end;

  var
    vNewCaretDrawItemNo: Integer;
  begin
    if Shift = [ssShift] then  // Shift+�����ѡ��
    begin
      if SelectInfo.EndItemNo >= 0 then  // ��ѡ������
      begin
        if IsSelectSeekStart then  // �α���ѡ����ʼ
        begin
          SelectStartItemNext;
          SetSelectSeekStart;
        end
        else  // �α���ѡ�н���
        begin
          SelectEndItemNext;
          SetSelectSeekEnd;
        end;
      end
      else   // û��ѡ��
      begin
        if SelectInfo.StartItemNo < Items.Count - 1 then
        begin
          if Items[SelectInfo.StartItemNo].StyleNo < THCStyle.Null then
          begin
            if SelectInfo.StartItemOffset = OffsetAfter then
            begin
              SelectInfo.StartItemNo := SelectInfo.StartItemNo + 1;
              SelectInfo.StartItemOffset := 0;
            end;
          end
          else
          if SelectInfo.StartItemOffset = Items[SelectInfo.StartItemNo].Length then
          begin
            SelectInfo.StartItemNo := SelectInfo.StartItemNo + 1;
            SelectInfo.StartItemOffset := 0;
          end;
        end;

        SelectInfo.EndItemNo := SelectInfo.StartItemNo;
        SelectInfo.EndItemOffset := SelectInfo.StartItemOffset;

        SelectEndItemNext;
        SetSelectSeekEnd;
      end;

      CheckSelectEndEff;
      MatchItemSelectState;
      Style.UpdateInfoRePaint;
    end
    else  // û�а���Shift
    begin
      if vSelectExist then  // ��ѡ������
      begin
        SelectInfo.StartItemNo := SelectInfo.EndItemNo;
        SelectInfo.StartItemOffset := SelectInfo.EndItemOffset;
        SelectInfo.EndItemNo := -1;
        SelectInfo.EndItemOffset := -1;
      end
      else  // ��ѡ������
      begin
        if SelectInfo.StartItemOffset < vCurItem.Length then  // ����Item���ұ�
          SelectInfo.StartItemOffset := SelectInfo.StartItemOffset + 1
        else  // ��Item���ұ�
        begin
          if SelectInfo.StartItemNo < Items.Count - 1 then  // �������һ��Item�����ұ�
          begin
            SelectInfo.StartItemNo := SelectInfo.StartItemNo + 1;  // ѡ����һ��Item
            SelectInfo.StartItemOffset := 0;  // ��һ����ǰ��
            if not DrawItems[Items[SelectInfo.StartItemNo].FirstDItemNo].LineFirst then  // ��һ��Item��������ʼ
            begin
              KeyDown(Key, Shift);
              Exit;
            end;
          end
          else  // �����һ��Item�����水���ҷ����
            Key := 0;
        end;
      end;

      if Key <> 0 then
      begin
        vNewCaretDrawItemNo := GetDrawItemNoByOffset(SelectInfo.StartItemNo, SelectInfo.StartItemOffset);
        if vNewCaretDrawItemNo = CaretDrawItemNo then  // �ƶ�ǰ����ͬһ��DrawItem
        begin
          if (SelectInfo.StartItemOffset = DrawItems[vNewCaretDrawItemNo].CharOffsetEnd)  // �ƶ���DrawItem�������
            and (vNewCaretDrawItemNo < DrawItems.Count - 1)  // �������һ��
            and (DrawItems[vNewCaretDrawItemNo].ItemNo = DrawItems[vNewCaretDrawItemNo + 1].ItemNo)  // ��һ��DrawItem�͵�ǰ��ͬһ��Item
            and (DrawItems[vNewCaretDrawItemNo + 1].LineFirst)  // ��һ��������
            and (SelectInfo.StartItemOffset = DrawItems[vNewCaretDrawItemNo + 1].CharOffs - 1)  // ���λ��Ҳ����һ��DrawItem����ǰ��
          then
            CaretDrawItemNo := vNewCaretDrawItemNo + 1;  // ����Ϊ��һ������
        end
        else
          CaretDrawItemNo := vNewCaretDrawItemNo;
      end;
    end;
  end;
  {$ENDREGION}

  {$REGION ' HomeKeyDown ���� '}
  procedure HomeKeyDown;
  var
    vFirstDItemNo, vLastDItemNo: Integer;
  begin
    if Shift = [ssShift] then  // Shift+Home
    begin
      // ȡ����DrawItem
      vFirstDItemNo := GetDrawItemNoByOffset(FSelectSeekNo, FSelectSeekOffset);  // GetSelectStartDrawItemNo
      while vFirstDItemNo > 0 do
      begin
        if DrawItems[vFirstDItemNo].LineFirst then
          Break
        else
          Dec(vFirstDItemNo);
      end;

      if SelectInfo.EndItemNo >= 0 then  // ��ѡ������
      begin
        if IsSelectSeekStart then  // �α���ѡ����ʼ
        begin
          SelectInfo.StartItemNo := DrawItems[vFirstDItemNo].ItemNo;
          SelectInfo.StartItemOffset := DrawItems[vFirstDItemNo].CharOffs - 1;
          SetSelectSeekStart;
        end
        else  // �α���ѡ�н���
        begin
          if DrawItems[vFirstDItemNo].ItemNo > SelectInfo.StartItemNo then
          begin
            SelectInfo.EndItemNo := DrawItems[vFirstDItemNo].ItemNo;
            SelectInfo.EndItemOffset := DrawItems[vFirstDItemNo].CharOffs - 1;
            SetSelectSeekEnd;
          end
          else
          if DrawItems[vFirstDItemNo].ItemNo = SelectInfo.StartItemNo then
          begin
            if DrawItems[vFirstDItemNo].CharOffs - 1 > SelectInfo.StartItemOffset then
            begin
              SelectInfo.EndItemNo := SelectInfo.StartItemNo;
              SelectInfo.EndItemOffset := DrawItems[vFirstDItemNo].CharOffs - 1;
              SetSelectSeekEnd;
            end;
          end
          else
          begin
            SelectInfo.EndItemNo := SelectInfo.StartItemNo;
            SelectInfo.EndItemOffset := SelectInfo.StartItemOffset;
            SelectInfo.StartItemNo := DrawItems[vFirstDItemNo].ItemNo;
            SelectInfo.StartItemOffset := DrawItems[vFirstDItemNo].CharOffs - 1;
            SetSelectSeekStart;
          end;
        end;
      end
      else   // û��ѡ��
      begin
        SelectInfo.EndItemNo := SelectInfo.StartItemNo;
        SelectInfo.EndItemOffset := SelectInfo.StartItemOffset;
        SelectInfo.StartItemNo := DrawItems[vFirstDItemNo].ItemNo;
        SelectInfo.StartItemOffset := DrawItems[vFirstDItemNo].CharOffs - 1;
        SetSelectSeekStart;
      end;

      CheckSelectEndEff;
      MatchItemSelectState;
      Style.UpdateInfoRePaint;
    end
    else
    begin
      if vSelectExist then  // ��ѡ������
      begin
        SelectInfo.EndItemNo := -1;
        SelectInfo.EndItemOffset := -1;
      end
      else  // ��ѡ������
      begin
        vFirstDItemNo := GetSelectStartDrawItemNo;
        GetLineDrawItemRang(vFirstDItemNo, vLastDItemNo);
        SelectInfo.StartItemNo := DrawItems[vFirstDItemNo].ItemNo;
        SelectInfo.StartItemOffset := DrawItems[vFirstDItemNo].CharOffs - 1;
      end;

      if Key <> 0 then
        CaretDrawItemNo := GetDrawItemNoByOffset(SelectInfo.StartItemNo, SelectInfo.StartItemOffset);
    end;
  end;
  {$ENDREGION}

  {$REGION ' EndKeyDown ���� '}
  procedure EndKeyDown;
  var
    vFirstDItemNo, vLastDItemNo: Integer;
  begin
    if Shift = [ssShift] then  // Shift+End
    begin
      // ȡ��βDrawItem
      vLastDItemNo := GetDrawItemNoByOffset(FSelectSeekNo, FSelectSeekOffset);// GetSelectEndDrawItemNo;
      vLastDItemNo := vLastDItemNo + 1;
      while vLastDItemNo < DrawItems.Count do
      begin
        if DrawItems[vLastDItemNo].LineFirst then
          Break
        else
          Inc(vLastDItemNo);
      end;
      Dec(vLastDItemNo);

      if SelectInfo.EndItemNo >= 0 then  // ��ѡ������
      begin
        if IsSelectSeekStart then  // �α���ѡ����ʼ
        begin
          if DrawItems[vLastDItemNo].ItemNo > SelectInfo.EndItemNo then  // ��Ȼ�ڽ���ǰ��
          begin
            SelectInfo.StartItemNo := DrawItems[vLastDItemNo].ItemNo;
            SelectInfo.StartItemOffset := DrawItems[vLastDItemNo].CharOffsetEnd;
            SetSelectSeekStart;
          end
          else
          if DrawItems[vLastDItemNo].ItemNo = SelectInfo.EndItemNo then
          begin
            SelectInfo.StartItemNo := SelectInfo.EndItemNo;
            if DrawItems[vLastDItemNo].CharOffsetEnd < SelectInfo.EndItemOffset then
            begin
              SelectInfo.StartItemOffset := DrawItems[vLastDItemNo].CharOffsetEnd;
              SetSelectSeekStart;
            end
            else
            begin
              SelectInfo.StartItemOffset := SelectInfo.EndItemOffset;
              SelectInfo.EndItemOffset := DrawItems[vLastDItemNo].CharOffsetEnd;
              SetSelectSeekEnd;
            end;
          end
          else
          begin
            SelectInfo.StartItemNo := SelectInfo.EndItemNo;
            SelectInfo.StartItemOffset := SelectInfo.EndItemOffset;
            SelectInfo.EndItemNo := DrawItems[vLastDItemNo].ItemNo;
            SelectInfo.EndItemOffset := DrawItems[vLastDItemNo].CharOffsetEnd;
            SetSelectSeekEnd;
          end;
        end
        else  // �α���ѡ�н���
        begin
          SelectInfo.EndItemNo := DrawItems[vLastDItemNo].ItemNo;
          SelectInfo.EndItemOffset := DrawItems[vLastDItemNo].CharOffsetEnd;
          SetSelectSeekEnd;
        end;
      end
      else   // û��ѡ��
      begin
        SelectInfo.EndItemNo := DrawItems[vLastDItemNo].ItemNo;
        SelectInfo.EndItemOffset := DrawItems[vLastDItemNo].CharOffsetEnd;
        SetSelectSeekEnd;
      end;

      CheckSelectEndEff;
      MatchItemSelectState;
      Style.UpdateInfoRePaint;
    end
    else
    begin
      if vSelectExist then  // ��ѡ������
      begin
        SelectInfo.StartItemNo := SelectInfo.EndItemNo;
        SelectInfo.StartItemOffset := SelectInfo.EndItemOffset;
        SelectInfo.EndItemNo := -1;
        SelectInfo.EndItemOffset := -1;
      end
      else  // ��ѡ������
      begin
        vFirstDItemNo := GetSelectStartDrawItemNo;
        GetLineDrawItemRang(vFirstDItemNo, vLastDItemNo);
        SelectInfo.StartItemNo := DrawItems[vLastDItemNo].ItemNo;
        SelectInfo.StartItemOffset := DrawItems[vLastDItemNo].CharOffsetEnd;
      end;

      if Key <> 0 then
        CaretDrawItemNo := GetDrawItemNoByOffset(SelectInfo.StartItemNo, SelectInfo.StartItemOffset);
    end;
  end;
  {$ENDREGION}

  {$REGION ' UpKeyDown �Ϸ��򰴼� '}
  procedure UpKeyDown;

    function GetUpDrawItemNo(var ADrawItemNo, ADrawItemOffset: Integer): Boolean;
    var
      i, vFirstDItemNo, vLastDItemNo, vX: Integer;
    begin
      Result := False;
      vFirstDItemNo := ADrawItemNo;
      GetLineDrawItemRang(vFirstDItemNo, vLastDItemNo);  // ��ǰ����ʼ����DrawItemNo
      if vFirstDItemNo > 0 then  // ��ǰ�в��ǵ�һ��
      begin
        Result := True;
        // ��ȡ��ǰ���Xλ��
        vX := DrawItems[ADrawItemNo].Rect.Left + GetDrawItemOffsetWidth(ADrawItemNo, ADrawItemOffset);

        // ��ȡ��һ����Xλ�ö�Ӧ��DItem��Offset
        vFirstDItemNo := vFirstDItemNo - 1;
        GetLineDrawItemRang(vFirstDItemNo, vLastDItemNo);  // ��һ����ʼ�ͽ���DItem

        for i := vFirstDItemNo to vLastDItemNo do
        begin
          if DrawItems[i].Rect.Right > vX then
          begin
            ADrawItemNo := i;
            ADrawItemOffset := DrawItems[i].CharOffs + GetDrawItemOffset(i, vX) - 1;

            Exit;  // �к��ʣ����˳�
          end;
        end;

        // û������ѡ�����
        ADrawItemNo := vLastDItemNo;
        ADrawItemOffset := DrawItems[vLastDItemNo].CharOffsetEnd;
      end
    end;

  var
    vDrawItemNo, vDrawItemOffset: Integer;
  begin
    if Shift = [ssShift] then  // Shift+Up
    begin
      if SelectInfo.EndItemNo >= 0 then  // ��ѡ������
      begin
        if IsSelectSeekStart then  // �α���ѡ����ʼ
        begin
          vDrawItemNo := GetSelectStartDrawItemNo;
          vDrawItemOffset := SelectInfo.StartItemOffset - DrawItems[vDrawItemNo].CharOffs + 1;
          if GetUpDrawItemNo(vDrawItemNo, vDrawItemOffset) then
          begin
            SelectInfo.StartItemNo := DrawItems[vDrawItemNo].ItemNo;
            SelectInfo.StartItemOffset := vDrawItemOffset;
            SetSelectSeekStart;
          end;
        end
        else  // �α���ѡ�н���
        begin
          vDrawItemNo := GetSelectEndDrawItemNo;
          vDrawItemOffset := SelectInfo.EndItemOffset - DrawItems[vDrawItemNo].CharOffs + 1;
          if GetUpDrawItemNo(vDrawItemNo, vDrawItemOffset) then
          begin
            if DrawItems[vDrawItemNo].ItemNo > SelectInfo.StartItemNo then  // �ƶ�����ʼ�����Item��
            begin
              SelectInfo.EndItemNo := vDrawItemNo;
              SelectInfo.EndItemOffset := vDrawItemOffset;
              SetSelectSeekEnd;
            end
            else
            if DrawItems[vDrawItemNo].ItemNo = SelectInfo.StartItemNo then  // �ƶ�����ʼItem��
            begin
              SelectInfo.EndItemNo := SelectInfo.StartItemNo;
              if vDrawItemOffset > SelectInfo.StartItemOffset then  // �ƶ�����ʼOffset����
              begin
                SelectInfo.EndItemOffset := vDrawItemOffset;
                SetSelectSeekEnd;
              end
              else  // �ƶ�����ʼOffsetǰ��
              begin
                SelectInfo.EndItemOffset := SelectInfo.StartItemOffset;
                SelectInfo.StartItemOffset := vDrawItemOffset;
                SetSelectSeekStart;
              end;
            end
            else  // �ƶ�����ʼItemǰ����
            begin
              SelectInfo.EndItemNo := SelectInfo.StartItemNo;
              SelectInfo.EndItemOffset := SelectInfo.StartItemOffset;
              SelectInfo.StartItemNo := DrawItems[vDrawItemNo].ItemNo;
              SelectInfo.StartItemOffset := vDrawItemOffset;
              SetSelectSeekStart;
            end;
          end;
        end;
      end
      else   // û��ѡ��
      begin
        vDrawItemNo := CaretDrawItemNo;
        vDrawItemOffset := SelectInfo.StartItemOffset - DrawItems[vDrawItemNo].CharOffs + 1;
        if GetUpDrawItemNo(vDrawItemNo, vDrawItemOffset) then
        begin
          SelectInfo.EndItemNo := SelectInfo.StartItemNo;
          SelectInfo.EndItemOffset := SelectInfo.StartItemOffset;
          SelectInfo.StartItemNo := DrawItems[vDrawItemNo].ItemNo;
          SelectInfo.StartItemOffset := vDrawItemOffset;
          SetSelectSeekStart;
        end;
      end;

      CheckSelectEndEff;
      MatchItemSelectState;
      Style.UpdateInfoRePaint;
    end
    else  // ��Shift����
    begin
      if vSelectExist then  // ��ѡ������
      begin
        SelectInfo.EndItemNo := -1;
        SelectInfo.EndItemOffset := -1;
      end
      else  // ��ѡ������
      begin
        vDrawItemNo := CaretDrawItemNo;  // GetSelectStartDrawItemNo;
        vDrawItemOffset := SelectInfo.StartItemOffset - DrawItems[vDrawItemNo].CharOffs + 1;
        if GetUpDrawItemNo(vDrawItemNo, vDrawItemOffset) then
        begin
          SelectInfo.StartItemNo := DrawItems[vDrawItemNo].ItemNo;
          SelectInfo.StartItemOffset := vDrawItemOffset;
          CaretDrawItemNo := vDrawItemNo;
        end
        else
          Key := 0;
      end;
    end;
  end;
  {$ENDREGION}

  {$REGION ' DownKeyDown �·���� '}
  procedure DownKeyDown;

    function GetDownDrawItemNo(var ADrawItemNo, ADrawItemOffset: Integer): Boolean;
    var
      i, vFirstDItemNo, vLastDItemNo, vX: Integer;
    begin
      Result := False;
      vFirstDItemNo := ADrawItemNo;  // GetSelectStartDrawItemNo;
      GetLineDrawItemRang(vFirstDItemNo, vLastDItemNo);  // ��ǰ����ʼ����DItemNo
      if vLastDItemNo < DrawItems.Count - 1 then  // ��ǰ�в������һ��
      begin
        Result := True;
        { ��ȡ��ǰ���Xλ�� }
        vX := DrawItems[ADrawItemNo].Rect.Left + GetDrawItemOffsetWidth(ADrawItemNo, ADrawItemOffset);

        { ��ȡ��һ����Xλ�ö�Ӧ��DItem��Offset }
        vFirstDItemNo := vLastDItemNo + 1;
        GetLineDrawItemRang(vFirstDItemNo, vLastDItemNo);  // ��һ����ʼ�ͽ���DItem

        for i := vFirstDItemNo to vLastDItemNo do
        begin
          if DrawItems[i].Rect.Right > vX then
          begin
            ADrawItemNo := i;
            ADrawItemOffset := DrawItems[i].CharOffs + GetDrawItemOffset(i, vX) - 1;

            Exit;  // �к��ʣ����˳�
          end;
        end;

        { û������ѡ����� }
        ADrawItemNo := vLastDItemNo;
        ADrawItemOffset := DrawItems[vLastDItemNo].CharOffsetEnd;
      end
    end;

  var
    vDrawItemNo, vDrawItemOffset: Integer;
  begin
    if Shift = [ssShift] then  // Shift+Up
    begin
      if SelectInfo.EndItemNo >= 0 then  // ��ѡ������
      begin
        if IsSelectSeekStart then  // �α���ѡ����ʼ
        begin
          vDrawItemNo := GetSelectStartDrawItemNo;
          vDrawItemOffset := SelectInfo.StartItemOffset - DrawItems[vDrawItemNo].CharOffs + 1;
          if GetDownDrawItemNo(vDrawItemNo, vDrawItemOffset) then
          begin
            if DrawItems[vDrawItemNo].ItemNo < SelectInfo.EndItemNo then  // �ƶ�������ItemNoǰ��
            begin
              SelectInfo.StartItemNo := SelectInfo.EndItemNo;
              SelectInfo.StartItemOffset := SelectInfo.EndItemOffset;
              SetSelectSeekStart;
            end
            else
            if DrawItems[vDrawItemNo].ItemNo = SelectInfo.EndItemNo then  // �ƶ����ͽ���Item
            begin
              SelectInfo.StartItemNo := SelectInfo.EndItemNo;
              if vDrawItemOffset < SelectInfo.EndItemOffset then  // λ���ڽ���Offsetǰ��
              begin
                SelectInfo.StartItemOffset := vDrawItemOffset;
                SetSelectSeekStart;
              end
              else  // λ���ڽ���Offset����
              begin
                SelectInfo.StartItemOffset := SelectInfo.EndItemOffset;
                SelectInfo.EndItemOffset := vDrawItemOffset;
                SetSelectSeekEnd;
              end;
            end
            else  // �ƶ�������Item���棬����
            begin
              SelectInfo.StartItemNo := SelectInfo.EndItemNo;
              SelectInfo.StartItemOffset := SelectInfo.EndItemOffset;
              SelectInfo.EndItemNo := DrawItems[vDrawItemNo].ItemNo;
              SelectInfo.EndItemOffset := vDrawItemOffset;
              SetSelectSeekEnd;
            end;
          end;
        end
        else  // �α���ѡ�н���
        begin
          vDrawItemNo := GetSelectEndDrawItemNo;
          vDrawItemOffset := SelectInfo.EndItemOffset - DrawItems[vDrawItemNo].CharOffs + 1;
          if GetDownDrawItemNo(vDrawItemNo, vDrawItemOffset) then
          begin
            SelectInfo.EndItemNo := DrawItems[vDrawItemNo].ItemNo;
            SelectInfo.EndItemOffset := vDrawItemOffset;
            SetSelectSeekEnd;
          end;
        end;
      end
      else   // û��ѡ��
      begin
        vDrawItemNo := CaretDrawItemNo;
        vDrawItemOffset := SelectInfo.StartItemOffset - DrawItems[vDrawItemNo].CharOffs + 1;
        if GetDownDrawItemNo(vDrawItemNo, vDrawItemOffset) then
        begin
          SelectInfo.EndItemNo := DrawItems[vDrawItemNo].ItemNo;
          SelectInfo.EndItemOffset := vDrawItemOffset;
          SetSelectSeekEnd;
        end;
      end;

      CheckSelectEndEff;
      MatchItemSelectState;
      Style.UpdateInfoRePaint;
    end
    else  // ��Shift����
    begin
      if vSelectExist then  // ��ѡ������
      begin
        SelectInfo.StartItemNo := SelectInfo.EndItemNo;
        SelectInfo.StartItemOffset := SelectInfo.EndItemOffset;
        SelectInfo.EndItemNo := -1;
        SelectInfo.EndItemOffset := -1;
      end
      else  // ��ѡ������
      begin
        vDrawItemNo := CaretDrawItemNo;  // GetSelectStartDrawItemNo;
        vDrawItemOffset := SelectInfo.StartItemOffset - DrawItems[vDrawItemNo].CharOffs + 1;
        if GetDownDrawItemNo(vDrawItemNo, vDrawItemOffset) then
        begin
          SelectInfo.StartItemNo := DrawItems[vDrawItemNo].ItemNo;
          SelectInfo.StartItemOffset := vDrawItemOffset;
          CaretDrawItemNo := vDrawItemNo;
        end
        else  // ��ǰ�������һ��
          Key := 0;
      end;
    end;
  end;
  {$ENDREGION}

  {$REGION ' RectItemKeyDown Rect����Item��KeyDown�¼� '}
  procedure RectItemKeyDown;
  var
    vItem: THCCustomItem;
    vLen: Integer;
    vRectItem: THCCustomRectItem;
  begin
    vRectItem := vCurItem as THCCustomRectItem;

    if SelectInfo.StartItemOffset = OffsetInner then  // ������
    begin
      if vRectItem.WantKeyDown(Key, Shift) then
      begin
        vRectItem.KeyDown(Key, Shift);
        if vRectItem.SizeChanged then
        begin
          GetReformatItemRange(vFormatFirstItemNo, vFormatLastItemNo);
          FormatItemPrepare(vFormatFirstItemNo, vFormatLastItemNo);

          vRectItem.SizeChanged := False;
          ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo);
        end;
      end
      else  // �ڲ�����Ӧ�˼�
      begin
        case Key of
          VK_BACK:
            begin
              SelectInfo.StartItemOffset := OffsetAfter;
              RectItemKeyDown;
            end;

          VK_DELETE:
            begin
              SelectInfo.StartItemOffset := OffsetBefor;
              RectItemKeyDown;
            end;
        end;
      end;
    end
    else
    if SelectInfo.StartItemOffset = OffsetBefor then  // ��RectItemǰ
    begin
      case Key of
        VK_LEFT:
          LeftKeyDown;

        VK_RIGHT:
          begin
            if Shift = [ssShift] then  // Shift+�����ѡ��
              RightKeyDown
            else
            begin
              if vRectItem.WantKeyDown(Key, Shift) then
                SelectInfo.StartItemOffset := OffsetInner
              else
                SelectInfo.StartItemOffset := OffsetAfter;

              CaretDrawItemNo := Items[SelectInfo.StartItemNo].FirstDItemNo;
            end;
          end;

        VK_UP: UpKeyDown;

        VK_DOWN: DownKeyDown;

        VK_END: EndKeyDown;

        VK_HOME: HomeKeyDown;

        VK_RETURN:
          begin
            GetReformatItemRange(vFormatFirstItemNo, vFormatLastItemNo);
            FormatItemPrepare(vFormatFirstItemNo, vFormatLastItemNo);

            if vCurItem.ParaFirst then  // RectItem�ڶ��ף��������
            begin
              vCurItem := CreateDefaultTextItem;
              vCurItem.ParaFirst := True;
              Items.Insert(SelectInfo.StartItemNo, vCurItem);

              ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo + 1, 1);

              SelectInfo.StartItemNo := SelectInfo.StartItemNo + 1;
              ReSetSelectAndCaret(SelectInfo.StartItemNo, SelectInfo.StartItemOffset);
            end
            else  // RectItem��������
            begin
              vCurItem.ParaFirst := True;
              ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo);
            end;
          end;

        VK_BACK:  // ��RectItemǰ
          begin
            if vCurItem.ParaFirst then  // �Ƕ���
            begin
              if SelectInfo.StartItemNo > 0 then  // ����Data��һ��Item
              begin
                GetReformatItemRange(vFormatFirstItemNo, vFormatLastItemNo);
                FormatItemPrepare(vFormatFirstItemNo, vFormatLastItemNo);

                Undo_StartRecord;
                Undo_ItemParaFirst(SelectInfo.StartItemNo, SelectInfo.StartItemOffset, False);

                vCurItem.ParaFirst := False;
                ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo);
              end
              else
                DrawItems.ClearFormatMark;  // ��һ��ǰ��ɾ������ֹͣ��ʽ��
            end
            else  // ���Ƕ���
            begin
              // ѡ����һ�����
              SelectInfo.StartItemNo := SelectInfo.StartItemNo - 1;
              SelectInfo.StartItemOffset := GetItemAfterOffset(SelectInfo.StartItemNo);

              KeyDown(Key, Shift);  // ִ��ǰһ����ɾ��
            end;
          end;

        VK_DELETE:  // ��RectItemǰ
          begin
            if not CanDeleteItem(SelectInfo.StartItemNo) then  // ����ɾ��
            begin
              SelectInfo.StartItemOffset := OffsetAfter;
              Exit;
            end;

            GetReformatItemRange(vFormatFirstItemNo, vFormatLastItemNo);
            FormatItemPrepare(vFormatFirstItemNo, vFormatLastItemNo);

            if vCurItem.ParaFirst then  // �Ƕ���
            begin
              if SelectInfo.StartItemNo <> vFormatLastItemNo then  // �β���ֻ��һ��
              begin
                Undo_StartRecord;

                Undo_ItemParaFirst(SelectInfo.StartItemNo + 1, 0, True);
                Items[SelectInfo.StartItemNo + 1].ParaFirst := True;

                Undo_DeleteItem(SelectInfo.StartItemNo, 0);
                Items.Delete(SelectInfo.StartItemNo);

                ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo - 1, -1);
              end
              else  // ��ɾ������
              begin
                Undo_StartRecord;
                Undo_DeleteItem(SelectInfo.StartItemNo, 0);
                Items.Delete(SelectInfo.StartItemNo);

                vCurItem := CreateDefaultTextItem;
                vCurItem.ParaFirst := True;
                Items.Insert(SelectInfo.StartItemNo, vCurItem);
                Undo_InsertItem(SelectInfo.StartItemNo, 0);

                ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo);
              end;
            end
            else  // ���Ƕ���
            begin
              if SelectInfo.StartItemNo < vFormatLastItemNo then  // ���м�
              begin
                vLen := GetItemAfterOffset(SelectInfo.StartItemNo - 1);

                Undo_StartRecord;
                Undo_DeleteItem(SelectInfo.StartItemNo, 0);
                // ���RectItemǰ��(ͬһ��)�и߶�С�ڴ�RectItme��Item(��Tab)��
                // ���ʽ��ʱ��RectItemΪ�ߣ����¸�ʽ��ʱ�����RectItem����λ����ʼ��ʽ����
                // �и߶��Ի���TabΪ�иߣ�Ҳ����RectItem�߶ȣ�������Ҫ���п�ʼ��ʽ��
                Items.Delete(SelectInfo.StartItemNo);
                if MergeItemText(Items[SelectInfo.StartItemNo - 1], Items[SelectInfo.StartItemNo]) then  // ԭRectItemǰ���ܺϲ�
                begin
                  Undo_InsertText(SelectInfo.StartItemNo - 1,
                    Items[SelectInfo.StartItemNo - 1].Length + 1, Items[SelectInfo.StartItemNo].Text);

                  Items.Delete(SelectInfo.StartItemNo);
                  ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo - 2, -2);
                end
                else
                  ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo - 1, -1);

                SelectInfo.StartItemNo := SelectInfo.StartItemNo - 1;
                SelectInfo.StartItemOffset := vLen;
              end
              else  // ��β(�β�ֻһ��Item)
              begin
                Undo_StartRecord;
                Undo_DeleteItem(SelectInfo.StartItemNo, 0);
                Items.Delete(SelectInfo.StartItemNo);

                ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo - 1, -1);

                SelectInfo.StartItemNo := SelectInfo.StartItemNo - 1;
                SelectInfo.StartItemOffset := GetItemAfterOffset(SelectInfo.StartItemNo);
              end;
            end;

            ReSetSelectAndCaret(SelectInfo.StartItemNo, SelectInfo.StartItemOffset);
          end;

        VK_TAB:
          TABKeyDown;
      end;
    end
    else
    if SelectInfo.StartItemOffset = OffsetAfter then  // �����
    begin
      case Key of
        VK_BACK:
          begin
            if not CanDeleteItem(SelectInfo.StartItemNo) then  // ����ɾ��
            begin
              SelectInfo.StartItemOffset := OffsetBefor;
              Exit;
            end;

            GetReformatItemRange(vFormatFirstItemNo, vFormatLastItemNo);
            FormatItemPrepare(vFormatFirstItemNo, vFormatLastItemNo);

            if vCurItem.ParaFirst then  // �Ƕ���
            begin
              if (SelectInfo.StartItemNo >= 0)
                and (SelectInfo.StartItemNo < Items.Count - 1)
                and (not Items[SelectInfo.StartItemNo + 1].ParaFirst)
              then  // ͬһ�λ�������
              begin
                Undo_StartRecord;
                Undo_DeleteItem(SelectInfo.StartItemNo, SelectInfo.StartItemOffset);
                Items.Delete(SelectInfo.StartItemNo);

                Undo_ItemParaFirst(SelectInfo.StartItemNo, 0, True);
                Items[SelectInfo.StartItemNo].ParaFirst := True;
                ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo - 1, -1);

                ReSetSelectAndCaret(SelectInfo.StartItemNo, 0);
              end
              else  // �ն���
              begin
                Undo_StartRecord;
                Undo_DeleteItem(SelectInfo.StartItemNo, 0);
                Items.Delete(SelectInfo.StartItemNo);

                vItem := CreateDefaultTextItem;
                vItem.ParaFirst := True;
                Items.Insert(SelectInfo.StartItemNo, vItem);
                Undo_InsertItem(SelectInfo.StartItemNo, 0);

                ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo);
                SelectInfo.StartItemOffset := 0;
              end;
            end
            else  // ���Ƕ���
            begin
              SelectInfo.StartItemOffset := OffsetBefor;
              Key := VK_DELETE;  // ��ʱ�滻
              RectItemKeyDown;
              Key := VK_BACK;  // ��ԭ
            end;
          end;

        VK_DELETE:
          begin
            if SelectInfo.StartItemNo < Items.Count - 1 then  // �������һ��
            begin
              SelectInfo.StartItemNo := SelectInfo.StartItemNo + 1;
              SelectInfo.StartItemOffset := 0;

              if Items[SelectInfo.StartItemNo].ParaFirst then
              begin
                GetReformatItemRange(vFormatFirstItemNo, vFormatLastItemNo);
                FormatItemPrepare(vFormatFirstItemNo, vFormatLastItemNo);

                Undo_StartRecord;
                Undo_ItemParaFirst(SelectInfo.StartItemNo, 0, False);

                Items[SelectInfo.StartItemNo].ParaFirst := False;

                ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo);
                ReSetSelectAndCaret(SelectInfo.StartItemNo, 0);
              end
              else
                KeyDown(Key, Shift);
              //Exit;
            end;
          end;

        VK_LEFT:
          begin
            if Shift = [ssShift] then  // Shift+�����ѡ��
              LeftKeyDown
            else
            begin
              if vRectItem.WantKeyDown(Key, Shift) then
                SelectInfo.StartItemOffset := OffsetInner
              else
                SelectInfo.StartItemOffset := OffsetBefor;

              CaretDrawItemNo := Items[SelectInfo.StartItemNo].FirstDItemNo;
            end;
          end;

        VK_RIGHT: RightKeyDown;

        VK_UP: UpKeyDown;

        VK_DOWN: DownKeyDown;

        VK_END: EndKeyDown;

        VK_HOME: HomeKeyDown;

        VK_RETURN:
          begin
            GetReformatItemRange(vFormatFirstItemNo, vFormatLastItemNo);
            FormatItemPrepare(vFormatFirstItemNo, vFormatLastItemNo);

            if (SelectInfo.StartItemNo < Items.Count - 1)  // �������һ��
              and (not Items[SelectInfo.StartItemNo + 1].ParaFirst)  // ��һ�����Ƕ���
            then
            begin
              Items[SelectInfo.StartItemNo + 1].ParaFirst := True;
              ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo);
              SelectInfo.StartItemNo := SelectInfo.StartItemNo + 1;
              SelectInfo.StartItemOffset := 0;
              CaretDrawItemNo := Items[SelectInfo.StartItemNo].FirstDItemNo;
            end
            else
            begin
              vCurItem := CreateDefaultTextItem;
              vCurItem.ParaFirst := True;
              Items.Insert(SelectInfo.StartItemNo + 1, vCurItem);
              ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo + 1, 1);
              ReSetSelectAndCaret(SelectInfo.StartItemNo + 1, vCurItem.Length);
            end;
          end;

        VK_TAB:
          TABKeyDown;
      end;
    end;
  end;
  {$ENDREGION}

  {$REGION ' EnterKeyDown �س� '}
  procedure EnterKeyDown;
  var
    vItem: THCCustomItem;
  begin
    GetReformatItemRange(vFormatFirstItemNo, vFormatLastItemNo);
    FormatItemPrepare(vFormatFirstItemNo, vFormatLastItemNo);
    // �жϹ��λ��������λ���
    if SelectInfo.StartItemOffset = 0 then  // �����Item��ǰ��
    begin
      if not vCurItem.ParaFirst then  // ԭ�����Ƕ���
      begin
        vCurItem.ParaFirst := True;
        ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo);
      end
      else  // ԭ�����Ƕ���
      begin
        vItem := CreateDefaultTextItem;
        vItem.ParaNo := vCurItem.ParaNo;
        vItem.StyleNo := vCurItem.StyleNo;
        vItem.ParaFirst := True;
        Items.Insert(SelectInfo.StartItemNo, vItem);  // ԭλ�õ������ƶ�
        ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo + 1, 1);
        SelectInfo.StartItemNo := SelectInfo.StartItemNo + 1;
      end;
    end
    else
    if SelectInfo.StartItemOffset = vCurItem.Length then  // �����Item�����
    begin
      if SelectInfo.StartItemNo < Items.Count - 1 then  // �������һ��Item
      begin
        vItem := Items[SelectInfo.StartItemNo + 1];  // ��һ��Item
        if not vItem.ParaFirst then  // ��һ�����Ƕ���ʼ
        begin
          vItem.ParaFirst := True;
          ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo);
        end
        else  // ��һ���Ƕ���ʼ
        begin
          vItem := CreateDefaultTextItem;
          vItem.ParaNo := vCurItem.ParaNo;
          vItem.StyleNo := vCurItem.StyleNo;
          vItem.ParaFirst := True;
          Items.Insert(SelectInfo.StartItemNo + 1, vItem);
          ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo + 1, 1);
        end;
        SelectInfo.StartItemNo := SelectInfo.StartItemNo + 1;
        SelectInfo.StartItemOffset := 0;
      end
      else  // ��Data���һ��Item���½�����
      begin
        vItem := CreateDefaultTextItem;
        vItem.ParaNo := vCurItem.ParaNo;
        vItem.StyleNo := vCurItem.StyleNo;
        vItem.ParaFirst := True;
        Items.Insert(SelectInfo.StartItemNo + 1, vItem);
        ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo + 1, 1);
        SelectInfo.StartItemNo := SelectInfo.StartItemNo + 1;
        SelectInfo.StartItemOffset := 0;
      end;
    end
    else  // �����Item�м�
    begin
      vItem := vCurItem.BreakByOffset(SelectInfo.StartItemOffset);  // �ضϵ�ǰItem
      vItem.ParaFirst := True;

      Items.Insert(SelectInfo.StartItemNo + 1, vItem);
      ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo + 1, 1);

      SelectInfo.StartItemNo := SelectInfo.StartItemNo + 1;
      SelectInfo.StartItemOffset := 0;
    end;
    if Key <> 0 then
      CaretDrawItemNo := GetDrawItemNoByOffset(SelectInfo.StartItemNo, SelectInfo.StartItemOffset);
  end;
  {$ENDREGION}

  {$REGION ' DeleteKeyDown ���ɾ���� '}
  procedure DeleteKeyDown;
  var
    vText: string;
    i, vCurItemNo, vLen, vDelCount, vParaNo: Integer;
  begin
    vDelCount := 0;
    vCurItemNo := SelectInfo.StartItemNo;
    GetReformatItemRange(vFormatFirstItemNo, vFormatLastItemNo);

    if SelectInfo.StartItemOffset = vCurItem.Length then  // �����Item���ұ�(��������)
    begin
      if vCurItemNo <> Items.Count - 1 then  // �������һ��Item���ұ�ɾ��
      begin
        if Items[vCurItemNo + 1].ParaFirst then  // ��һ���Ƕ��ף���괦Item����һ�����һ������һ��Ҫ������
        begin
          vFormatLastItemNo := GetParaLastItemNo(vCurItemNo + 1);  // ��ȡ��һ�����һ��
          if vCurItem.Length = 0 then  // ��ǰ�ǿ���
          begin
            FormatItemPrepare(vFormatFirstItemNo, vFormatLastItemNo);
            Items.Delete(vCurItemNo);
            ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo - 1, -1);
          end
          else  // ��ǰ���ǿ���
          begin
            if Items[vCurItemNo + 1].StyleNo < THCStyle.Null then  // ��һ��������RectItem�����ܺϲ�
            begin
              SelectInfo.StartItemNo := vCurItemNo + 1;
              SelectInfo.StartItemOffset := OffsetBefor;

              KeyDown(Key, Shift);
              Exit;
            end
            else  // ��һ��������TextItem(��ǰ����һ�ζ�β)
            begin
              FormatItemPrepare(vFormatFirstItemNo, vFormatLastItemNo);

              if Items[vCurItemNo + 1].Length = 0 then  // ��һ�εĶ������ǿ���
              begin
                Items.Delete(vCurItemNo + 1);
                Inc(vDelCount);
              end
              else  // ��һ�εĶ��ײ��ǿ���
              begin
                //if (vCurItem.ClassType = Items[vCurItemNo + 1].ClassType)
                //  and (vCurItem.StyleNo = Items[vCurItemNo + 1].StyleNo)
                if vCurItem.CanConcatItems(Items[vCurItemNo + 1]) then  // ��һ�ζ��׿ɺϲ�����ǰ(��ǰ����һ�ζ�β) 201804111209 (������MergeItemText�����)
                begin
                  vCurItem.Text := vCurItem.Text + Items[vCurItemNo + 1].Text;
                  Items.Delete(vCurItemNo + 1);
                  Inc(vDelCount);
                end
                else// ��һ�ζ��ײ��ǿ���Ҳ���ܺϲ�
                  Items[vCurItemNo + 1].ParaFirst := False;

                // ������һ�κϲ�������Item����ʽ��������ʽ
                vParaNo := Items[vCurItemNo].ParaNo;
                for i := vCurItemNo + 1 to vFormatLastItemNo - vDelCount do
                  Items[i].ParaNo := vParaNo;
              end;

              ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo - vDelCount, -vDelCount);
            end;
          end;
        end
        else  // ��һ�����ܺϲ�Ҳ���Ƕ��ף��ƶ�����һ����ͷ�ٵ���DeleteKeyDown
        begin
          SelectInfo.StartItemNo := vCurItemNo + 1;
          SelectInfo.StartItemOffset := 0;
          vCurItem := GetCurItem;
          {if vCurItem.StyleNo < THCStyle.RsNull then
            RectItemKeyDown
          else
            DeleteKeyDown;}

          KeyDown(Key, Shift);
          Exit;
        end;
      end;
    end
    else  // ��겻��Item���ұ�
    begin
      if not CanDeleteItem(vCurItemNo) then  // ����ɾ��
        SelectInfo.StartItemOffset := SelectInfo.StartItemOffset + 1
      else  // ��ɾ��
      begin
        vText := Items[vCurItemNo].Text;

        Delete(vText, SelectInfo.StartItemOffset + 1, 1);
        vCurItem.Text := vText;
        if vText = '' then  // ɾ����û��������
        begin
          if not DrawItems[Items[vCurItemNo].FirstDItemNo].LineFirst then  // ��Item��������(�����м����ĩβ)
          begin
            if vCurItemNo < Items.Count - 1 then  // ��������Ҳ�������һ��Item
            begin
              if MergeItemText(Items[vCurItemNo - 1], Items[vCurItemNo + 1]) then  // ��һ���ɺϲ�����һ��
              begin
                vLen := Items[vCurItemNo + 1].Length;
                GetReformatItemRange(vFormatFirstItemNo, vFormatLastItemNo, vCurItemNo - 1, vLen);
                FormatItemPrepare(vCurItemNo - 1, vFormatLastItemNo);
                Items.Delete(vCurItemNo);  // ɾ����ǰ
                Items.Delete(vCurItemNo);  // ɾ����һ��
                ReFormatData_(vCurItemNo - 1, vFormatLastItemNo - 2, -2);
              end
              else  // ��һ���ϲ�������һ��
              begin
                vLen := 0;
                FormatItemPrepare(vFormatFirstItemNo, vFormatLastItemNo);
                Items.Delete(vCurItemNo);
                ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo - 1, -1);
              end;

              // �������
              SelectInfo.StartItemNo := vCurItemNo - 1;
              if GetItemStyle(SelectInfo.StartItemNo) < THCStyle.Null then
                SelectInfo.StartItemOffset := OffsetAfter
              else
                SelectInfo.StartItemOffset := Items[SelectInfo.StartItemNo].Length - vLen;
            end
            else  // �����һ��Itemɾ������
            begin
              // �������
              FormatItemPrepare(vCurItemNo);
              Items.Delete(vCurItemNo);
              SelectInfo.StartItemNo := vCurItemNo - 1;
              SelectInfo.StartItemOffset := GetItemAfterOffset(SelectInfo.StartItemNo);
              //ReFormatData_(SelectInfo.StartItemNo, SelectInfo.StartItemNo, -1);
              DrawItems.DeleteFormatMark;
            end;
          end
          else  // ����Item��ɾ����
          begin
            if vCurItemNo <> vFormatLastItemNo then  // ��ǰ�κ��滹��Item
            begin
              FormatItemPrepare(vFormatFirstItemNo, vFormatLastItemNo);
              SelectInfo.StartItemOffset := 0;
              Items[vCurItemNo + 1].ParaFirst := Items[vCurItemNo].ParaFirst;
              Items.Delete(vCurItemNo);
              ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo - 1, -1);
            end
            else  // ��ǰ��ɾ������
            begin
              FormatItemPrepare(vCurItemNo);
              SelectInfo.StartItemOffset := 0;
              ReFormatData_(vCurItemNo);
            end;
          end;
        end
        else  // ɾ����������
        begin
          FormatItemPrepare(vFormatFirstItemNo, vFormatLastItemNo);
          ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo);
        end;
      end;
    end;
    if Key <> 0 then
      CaretDrawItemNo := GetDrawItemNoByOffset(SelectInfo.StartItemNo, SelectInfo.StartItemOffset);
  end;
  {$ENDREGION}

  {$REGION ' BackspaceKeyDown ��ǰɾ���� '}
  procedure BackspaceKeyDown;
  var
    vText: string;
    i, vCurItemNo, vDrawItemNo, vLen, vDelCount, vParaNo: Integer;
    vParaFirst: Boolean;
  begin
    if SelectInfo.StartItemOffset = 0 then  // �����Item�ʼ
    begin
      if (vCurItem.Text = '') and (Style.ParaStyles[vCurItem.ParaNo].AlignHorz <> TParaAlignHorz.pahJustify) then
        ApplyParaAlignHorz(TParaAlignHorz.pahJustify)  // ���еȶ���Ŀ�Item��ɾ��ʱ�л�����ɢ����
      else
      if SelectInfo.StartItemNo <> 0 then  // ���ǵ�1��Item��ǰ��ɾ��
      begin
        vCurItemNo := SelectInfo.StartItemNo;
        if vCurItem.ParaFirst then  // �Ƕ���ʼItem
        begin
          vLen := Items[SelectInfo.StartItemNo - 1].Length;

          //if (vCurItem.ClassType = Items[SelectInfo.StartItemNo - 1].ClassType)
          //  and (vCurItem.StyleNo = Items[SelectInfo.StartItemNo - 1].StyleNo)
          if vCurItem.CanConcatItems(Items[SelectInfo.StartItemNo - 1]) then  // ��ǰ���Ժ���һ���ϲ�(��ǰ�ڶ���) 201804111209 (������MergeItemText�����)
          begin
            Undo_StartRecord;
            Undo_InsertText(SelectInfo.StartItemNo - 1, Items[SelectInfo.StartItemNo - 1].Length + 1,
              Items[SelectInfo.StartItemNo].Text);

            Items[SelectInfo.StartItemNo - 1].Text := Items[SelectInfo.StartItemNo - 1].Text
              + Items[SelectInfo.StartItemNo].Text;

            vFormatFirstItemNo := GetLineFirstItemNo(SelectInfo.StartItemNo - 1, vLen);
            vFormatLastItemNo := GetParaLastItemNo(SelectInfo.StartItemNo);
            FormatItemPrepare(vFormatFirstItemNo, vFormatLastItemNo);

            Undo_DeleteItem(SelectInfo.StartItemNo, SelectInfo.StartItemOffset);
            Items.Delete(SelectInfo.StartItemNo);

            // ������һ�κϲ�������Item�Ķ���ʽ��������ʽ
            vParaNo := Items[SelectInfo.StartItemNo - 1].ParaNo;
            if vParaNo <> vCurItem.ParaNo then  // 2��ParaNo��ͬ
            begin
              for i := SelectInfo.StartItemNo to vFormatLastItemNo - 1 do
              begin
                //Undo_ItemParaNo(i, 0, vParaNo);
                Items[i].ParaNo := vParaNo;
              end;
            end;

            ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo - 1, -1);

            ReSetSelectAndCaret(SelectInfo.StartItemNo - 1, vLen);
          end
          else  // ����ʼ�Ҳ��ܺ���һ���ϲ�
          begin
            if vCurItem.Length = 0 then  // �Ѿ�û��������(���ǵ�1��Item��˵���ǿ���)
            begin
              FormatItemPrepare(SelectInfo.StartItemNo - 1, SelectInfo.StartItemNo);

              Undo_StartRecord;
              Undo_DeleteItem(SelectInfo.StartItemNo, SelectInfo.StartItemOffset);
              Items.Delete(SelectInfo.StartItemNo);

              ReFormatData_(SelectInfo.StartItemNo - 1, SelectInfo.StartItemNo - 1, -1);

              ReSetSelectAndCaret(SelectInfo.StartItemNo - 1);
            end
            else  // ��ǰɾ���Ҳ��ܺ���һ�����ϲ�
            begin
              GetReformatItemRange(vFormatFirstItemNo, vFormatLastItemNo);
              FormatItemPrepare(vFormatFirstItemNo, vFormatLastItemNo);

              Undo_StartRecord;
              Undo_ItemParaFirst(SelectInfo.StartItemNo, SelectInfo.StartItemOffset, False);

              vCurItem.ParaFirst := False;  // ��ǰ�κ���һ��Itemƴ�ӳ�һ��

              vParaNo := Items[SelectInfo.StartItemNo - 1].ParaNo;  // ��һ�ε�ParaNo
              if vParaNo <> vCurItem.ParaNo then  // 2��ParaNo��ͬ
              begin
                for i := SelectInfo.StartItemNo to vFormatLastItemNo do
                begin
                  //Undo_ItemParaNo(i, 0, vParaNo);
                  Items[i].ParaNo := vParaNo;
                end;
              end;

              ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo);

              ReSetSelectAndCaret(SelectInfo.StartItemNo, 0);
            end;
          end;
        end
        else  // ��Item��ʼ��ǰɾ����Item���Ƕ���ʼ
        begin
          if Items[SelectInfo.StartItemNo - 1].StyleNo < THCStyle.Null then  // ǰ����RectItem
          begin
            vCurItemNo := SelectInfo.StartItemNo - 1;
            if CanDeleteItem(vCurItemNo) then  // ��ɾ��
            begin
              Undo_StartRecord;

              vParaFirst := Items[vCurItemNo].ParaFirst;  // ��¼ǰ���RectItem��������

              GetReformatItemRange(vFormatFirstItemNo, vFormatLastItemNo);
              FormatItemPrepare(vFormatFirstItemNo, vFormatLastItemNo);

              // ɾ��ǰ���RectItem
              Undo_DeleteItem(vCurItemNo, OffsetAfter);
              Items.Delete(vCurItemNo);

              if vParaFirst then  // ǰ��ɾ����RectItem�Ƕ���
              begin
                Undo_ItemParaFirst(vCurItemNo, 0, vParaFirst);
                vCurItem.ParaFirst := vParaFirst;  // ��ֵǰ��RectItem�Ķ���ʼ����
                vLen := 0;
              end
              else  // ǰ��ɾ����RectItem���Ƕ���
              begin
                vDelCount := 1;
                vCurItemNo := vCurItemNo - 1;  // ��һ��
                vLen := Items[vCurItemNo].Length;  // ��һ�������

                if MergeItemText(Items[vCurItemNo], vCurItem) then  // ��ǰ�ܺϲ�����һ��
                begin
                  Undo_InsertText(vCurItemNo, vLen + 1, vCurItem.Text);
                  Undo_DeleteItem(vCurItemNo + 1, 0);
                  Items.Delete(vCurItemNo + 1); // ɾ����ǰ��
                  vDelCount := 2;
                end;
              end;

              ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo - vDelCount, -vDelCount);
            end
            else  // ����ɾ����������ǰ
              vLen := OffsetBefor;

            ReSetSelectAndCaret(vCurItemNo, vLen);
          end
          else  // ǰ�����ı�����ֵΪǰ�����������´���ɾ��
          begin
            SelectInfo.StartItemNo := SelectInfo.StartItemNo - 1;
            SelectInfo.StartItemOffset := GetItemAfterOffset(SelectInfo.StartItemNo);
            vCurItem := GetCurItem;

            Style.UpdateInfoReStyle;
            BackspaceKeyDown;  // ���´���
            Exit;
          end;
        end;
      end;
    end
    else  // ��겻��Item�ʼ  �ı�TextItem
    begin
      if vCurItem.Length = 1 then  // ɾ����û��������
      begin
        vCurItemNo := SelectInfo.StartItemNo;  // ��¼ԭλ��
        if not DrawItems[Items[vCurItemNo].FirstDItemNo].LineFirst then  // ��ǰ�������ף�ǰ��������
        begin
          vLen := Items[vCurItemNo - 1].Length;

          if (vCurItemNo > 0) and (vCurItemNo < vParaLastItemNo)  // ���Ƕ����һ��
            and MergeItemText(Items[vCurItemNo - 1], Items[vCurItemNo + 1])
          then  // ��ǰItemλ����һ���͵�ǰItemλ����һ���ɺϲ�
          begin
            Undo_StartRecord;
            Undo_InsertText(vCurItemNo - 1, Items[vCurItemNo - 1].Length - Items[vCurItemNo + 1].Length + 1,
              Items[vCurItemNo + 1].Text);

            GetReformatItemRange(vFormatFirstItemNo, vFormatLastItemNo, vCurItemNo - 1, vLen);
            FormatItemPrepare(vFormatFirstItemNo, vFormatLastItemNo);

            Undo_DeleteItem(vCurItemNo, Items[vCurItemNo].Length);
            Items.Delete(vCurItemNo);  // ɾ����ǰ

            Undo_DeleteItem(vCurItemNo, 0);
            Items.Delete(vCurItemNo);  // ɾ����һ��

            ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo - 2, -2);

            ReSetSelectAndCaret(SelectInfo.StartItemNo - 1, vLen);  // ��һ��ԭ���λ��
          end
          else  // ��ǰ�������ף�ɾ����û�������ˣ��Ҳ��ܺϲ���һ������һ��
          begin
            if SelectInfo.StartItemNo = vParaLastItemNo then  // �����һ��
            begin
              vFormatFirstItemNo := GetLineFirstItemNo(SelectInfo.StartItemNo, SelectInfo.StartItemOffset);
              vFormatLastItemNo := vParaLastItemNo;
              FormatItemPrepare(vFormatFirstItemNo, vFormatLastItemNo);

              Undo_StartRecord;
              Undo_DeleteItem(vCurItemNo, SelectInfo.StartItemOffset);
              Items.Delete(vCurItemNo);

              ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo - 1, -1);

              ReSetSelectAndCaret(vCurItemNo - 1);
            end
            else  // ���Ƕ����һ��
            begin
              GetReformatItemRange(vFormatFirstItemNo, vFormatLastItemNo);
              FormatItemPrepare(vFormatFirstItemNo, vFormatLastItemNo);

              Undo_StartRecord;
              Undo_DeleteItem(vCurItemNo, Items[vCurItemNo].Length);
              Items.Delete(vCurItemNo);

              ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo - 1, -1);

              ReSetSelectAndCaret(vCurItemNo - 1);
            end;
          end;
        end
        else  // Item���е�һ��������Itemɾ�����ˣ�
        begin
          GetReformatItemRange(vFormatFirstItemNo, vFormatLastItemNo);

          if Items[vCurItemNo].ParaFirst then  // �Ƕ��ף�ɾ������
          begin
            FormatItemPrepare(vFormatFirstItemNo, vFormatLastItemNo);

            if vCurItemNo < vFormatLastItemNo then  // ͬ�κ��滹������
            begin
              Undo_StartRecord;

              vParaFirst := True;  // Items[vCurItemNo].ParaFirst;  // ��¼����Item�Ķ�����

              Undo_DeleteItem(vCurItemNo, Items[vCurItemNo].Length);
              Items.Delete(vCurItemNo);

              if vParaFirst then  // ɾ�����Ƕ���
              begin
                Undo_ItemParaFirst(vCurItemNo, 0, vParaFirst);
                Items[vCurItemNo].ParaFirst := vParaFirst;  // ���̳ж�������
              end;

              ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo - 1, -1);
              ReSetSelectAndCaret(vCurItemNo, 0);  // ��һ����ǰ��
            end
            else  // ͬ�κ���û�������ˣ����ֿ���
            begin
              Undo_StartRecord;
              Undo_DeleteText(SelectInfo.StartItemNo, SelectInfo.StartItemOffset,
                vCurItem.Text);  // Copy(vText, SelectInfo.StartItemOffset, 1));

              //System.Delete(vText, SelectInfo.StartItemOffset, 1);
              vCurItem.Text := '';  // vText;
              SelectInfo.StartItemOffset := SelectInfo.StartItemOffset - 1;

              ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo);  // ��������
            end;
          end
          else  // ���Ƕ���Item����������Itemɾ������
          begin
            Undo_StartRecord;

            if vCurItemNo < vFormatLastItemNo then  // ���ɾ����ͬ�κ��滹������
            begin
              vLen := Items[vCurItemNo - 1].Length;
              if MergeItemText(Items[vCurItemNo - 1], Items[vCurItemNo + 1]) then  // ǰ���ܺϲ�
              begin
                Undo_InsertText(vCurItemNo - 1,
                  Items[vCurItemNo - 1].Length - Items[vCurItemNo + 1].Length + 1, Items[vCurItemNo + 1].Text);

                GetReformatItemRange(vFormatFirstItemNo, vFormatLastItemNo, vCurItemNo - 1, Items[vCurItemNo - 1].Length);  // ȡǰһ����ʽ����ʼλ��
                FormatItemPrepare(vFormatFirstItemNo, vFormatLastItemNo);

                Undo_DeleteItem(vCurItemNo, Items[vCurItemNo].Length);  // ɾ���յ�Item
                Items.Delete(vCurItemNo);

                Undo_DeleteItem(vCurItemNo, Items[vCurItemNo].Length);  // ���ϲ���Item
                Items.Delete(vCurItemNo);

                ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo - 2, -2);
                ReSetSelectAndCaret(vCurItemNo - 1, vLen);
              end
              else  // ǰ���ܺϲ�
              begin
                FormatItemPrepare(vFormatFirstItemNo, vFormatLastItemNo);

                Undo_DeleteItem(vCurItemNo, Items[vCurItemNo].Length);
                Items.Delete(vCurItemNo);

                ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo - 1, -1);
                ReSetSelectAndCaret(vCurItemNo - 1);
              end;
            end
            else  // ͬ�κ���û��������
            begin
              if vFormatFirstItemNo = vCurItemNo then  // ��ʽ����ʼ��ɾ����
                Dec(vFormatFirstItemNo);

              FormatItemPrepare(vFormatFirstItemNo, vFormatLastItemNo);

              Undo_DeleteItem(vCurItemNo, Items[vCurItemNo].Length);
              Items.Delete(vCurItemNo);

              ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo - 1, -1);
              ReSetSelectAndCaret(vCurItemNo - 1);
            end;
          end;
        end;
      end
      else  // ɾ����������
      begin
        { ���Ƕε�һ�е�����ʱ��������������һ������Item�����ƶ�����һ�е������
          ����ɾ����Ҫ����һ�п�ʼ�ж� }
        if SelectInfo.StartItemNo > vParaFirstItemNo then
          vFormatFirstItemNo := GetLineFirstItemNo(SelectInfo.StartItemNo - 1, 0)
        else
          vFormatFirstItemNo := SelectInfo.StartItemNo;

        vFormatLastItemNo := vParaLastItemNo;

        FormatItemPrepare(vFormatFirstItemNo, vFormatLastItemNo);

        vText := vCurItem.Text;  // ������ 201806242257 ��һ��

        Undo_StartRecord;
        Undo_DeleteText(SelectInfo.StartItemNo, SelectInfo.StartItemOffset,
          Copy(vText, SelectInfo.StartItemOffset, 1));

        System.Delete(vText, SelectInfo.StartItemOffset, 1);
        vCurItem.Text := vText;

        ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo);

        SelectInfo.StartItemOffset := SelectInfo.StartItemOffset - 1;
        ReSetSelectAndCaret(SelectInfo.StartItemNo, SelectInfo.StartItemOffset);
      end;
    end;
  end;
  {$ENDREGION}

begin
  if not CanEdit then Exit;

  if Key in [VK_BACK, VK_DELETE, VK_RETURN, VK_TAB] then
    Self.InitializeMouseField;  // ���Itemɾ�����ˣ�ԭMouseMove��ItemNo���ܲ������ˣ���MouseMoveʱ����ɵĳ���

  vCurItem := GetCurItem;
  if not Assigned(vCurItem) then Exit;  // ��ҳ�ϲ�ʱ���ϲ���û�е�ǰItem

  vSelectExist := SelectExists;

  if vSelectExist and (Key in [VK_BACK, VK_DELETE, VK_RETURN, VK_TAB]) then
  begin
    if DeleteSelected then
    begin
      if Key in [VK_BACK, VK_DELETE] then Exit;
    end;
  end;

  GetParaItemRang(SelectInfo.StartItemNo, vParaFirstItemNo, vParaLastItemNo);

  if vCurItem.StyleNo < THCStyle.Null then
    RectItemKeyDown
  else
  begin
    case Key of
      VK_BACK:   BackspaceKeyDown;  // ��ɾ
      VK_RETURN: EnterKeyDown;      // �س�
      VK_LEFT:   LeftKeyDown;       // �����
      VK_RIGHT:  RightKeyDown;      // �ҷ����
      VK_DELETE: DeleteKeyDown;     // ɾ����
      VK_HOME:   HomeKeyDown;       // Home��
      VK_END:    EndKeyDown;        // End��
      VK_UP:     UpKeyDown;         // �Ϸ����
      VK_DOWN:   DownKeyDown;       // �·����
      VK_TAB:    TABKeyDown;        // TAB��
    end;
  end;

  case Key of
    VK_BACK, VK_DELETE, VK_RETURN, VK_TAB:
      begin
        Style.UpdateInfoRePaint;
        Style.UpdateInfoReCaret;  // ɾ��������λ�ù��Ϊ��ǰ��ʽ
        Style.UpdateInfoReScroll;
      end;

    VK_LEFT, VK_RIGHT, VK_UP, VK_DOWN, VK_HOME, VK_END:
      begin
        if vSelectExist then
          Style.UpdateInfoRePaint;
        Style.UpdateInfoReCaret;
        Style.UpdateInfoReScroll;
      end;
  end;
end;

procedure THCCustomRichData.KeyPress(var Key: Char);
var
  vCarteItem: THCCustomItem;
  vRectItem: THCCustomRectItem;
  vFormatFirstItemNo, vFormatLastItemNo: Integer;
begin
  if not CanEdit then Exit;

  DeleteSelected;

  vCarteItem := GetCurItem;
  if not Assigned(vCarteItem) then Exit;  // ��ҳ�ϲ�ʱ���ϲ���û�е�ǰItem

  if (vCarteItem.StyleNo < THCStyle.Null)  // ��ǰλ���� RectItem
    and (SelectInfo.StartItemOffset = OffsetInner)  // ��������������
  then
  begin
    Undo_StartRecord;
    Undo_ItemSelf(SelectInfo.StartItemNo, OffsetInner);

    vRectItem := vCarteItem as THCCustomRectItem;
    vRectItem.KeyPress(Key);
    if vRectItem.SizeChanged then
    begin
      vRectItem.SizeChanged := False;
      GetReformatItemRange(vFormatFirstItemNo, vFormatLastItemNo);
      FormatItemPrepare(vFormatFirstItemNo, vFormatLastItemNo);
      if Key <> #0 then
        ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo);

      Style.UpdateInfoRePaint;
      Style.UpdateInfoReCaret;
      Style.UpdateInfoReScroll;
    end;
  end
  else
    InsertText(Key);
end;

procedure THCCustomRichData.KeyUp(var Key: Word; Shift: TShiftState);
begin
  if not CanEdit then Exit;
end;

procedure THCCustomRichData.KillFocus;
var
  vItemNo: Integer;
begin
  vItemNo := GetCurItemNo;
  if vItemNo >= 0 then
    Items[vItemNo].KillFocus;
end;

procedure THCCustomRichData.LoadFromStream(const AStream: TStream;
  const AStyle: THCStyle; const AFileVersion: Word);
begin
  if not CanEdit then Exit;

  //Self.InitializeField;  LoadFromStream�е�Clear������
  inherited LoadFromStream(AStream, AStyle, AFileVersion);
  InsertStream(AStream, AStyle, AFileVersion);
  // ������ɺ󣬳�ʼ��(��һ������LoadFromStream�г�ʼ����)
  ReSetSelectAndCaret(0, 0);
end;

function THCCustomRichData.LoadItemFromStreamAlone(
  const AStream: TStream): THCCustomItem;
var
  vFileExt, vFileVersion: string;
  viVersion: Word;
  vStyleNo, vParaNo: Integer;
  vTextStyle: THCTextStyle;
  vParaStyle: THCParaStyle;
begin
  AStream.Position := 0;
  _LoadFileFormatAndVersion(AStream, vFileExt, vFileVersion);  // �ļ���ʽ�Ͱ汾
  if (vFileExt <> HC_EXT) and (vFileExt <> 'cff.') then
    raise Exception.Create('����ʧ�ܣ�����' + HC_EXT + '�ļ���');

  viVersion := GetVersionAsInteger(vFileVersion);

  AStream.ReadBuffer(vStyleNo, SizeOf(vStyleNo));
  Result := CreateItemByStyle(vStyleNo);
  Result.LoadFromStream(AStream, Style, viVersion);

  if vStyleNo > THCStyle.Null then
  begin
    vTextStyle := THCTextStyle.Create;
    try
      vTextStyle.LoadFromStream(AStream, viVersion);
      vStyleNo := Style.GetStyleNo(vTextStyle, True);
      Result.StyleNo := vStyleNo;
    finally
      FreeAndNil(vTextStyle);
    end;
  end;

  vParaStyle := THCParaStyle.Create;
  try
    vParaStyle.LoadFromStream(AStream, viVersion);
    vParaNo := Style.GetParaNo(vParaStyle, True);
  finally
    FreeAndNil(vParaStyle);
  end;

  Result.ParaNo := vParaNo;
end;

function THCCustomRichData.MergeItemText(const ADestItem,
  ASrcItem: THCCustomItem): Boolean;
begin
  Result := ADestItem.CanConcatItems(ASrcItem);
  if Result then
    ADestItem.Text := ADestItem.Text + ASrcItem.Text;
end;

function THCCustomRichData.MergeTableSelectCells: Boolean;
var
  vItemNo, vFormatFirstItemNo, vFormatLastItemNo: Integer;
begin
  Result := False;

  if not CanEdit then Exit;

  vItemNo := GetCurItemNo;
  if Items[vItemNo].StyleNo = THCStyle.Table then
  begin
    Undo_StartRecord;
    Undo_ItemSelf(vItemNo, OffsetInner);
    Result := (Items[vItemNo] as THCTableItem).MergeSelectCells;
    if Result then  // �ϲ��ɹ�
    begin
      GetReformatItemRange(vFormatFirstItemNo, vFormatLastItemNo);
      FormatItemPrepare(vFormatFirstItemNo, vFormatLastItemNo);
      ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo);
      DisSelect;  // �ϲ������ѡ�У��ᵼ�µ�ǰItemNoû����
      InitializeMouseField;  // 201807311101
      Style.UpdateInfoRePaint;
    end;
  end;
end;

procedure THCCustomRichData.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

  {$REGION 'DoItemMouseDown'}
  procedure DoItemMouseDown(const AItemNo, AOffset: Integer);
  var
    vX, vY: Integer;
  begin
    if AItemNo < 0 then Exit;
    CoordToItemOffset(X, Y, AItemNo, AOffset, vX, vY);
    Items[AItemNo].MouseDown(Button, Shift, vX, vY);

    if Assigned(OnItemMouseDown) then
      OnItemMouseDown(Self, AItemNo, Button, Shift, vX, vY);
  end;
  {$ENDREGION}

var
  vMouseDownItemNo, vMouseDownItemOffset, vDrawItemNo: Integer;
  vRestrain, vMouseDownInSelect: Boolean;
begin
  FSelecting := False;  // ׼����ѡ
  FDraging := False;  // ׼����ק
  FMouseLBDouble := False;
  FMouseDownReCaret := False;
  FSelectSeekOffset := -1;

  FMouseLBDowning := (Button = mbLeft) and (Shift = [ssLeft]);

  FMouseDownX := X;
  FMouseDownY := Y;

  GetItemAt(X, Y, vMouseDownItemNo, vMouseDownItemOffset, vDrawItemNo, vRestrain);

  vMouseDownInSelect := CoordInSelect(X, Y, vMouseDownItemNo, vMouseDownItemOffset, vRestrain);

  if vMouseDownInSelect then   // ��ѡ�������а���
  begin
    if FMouseLBDowning then  // ���������ʼ��ק
    begin
      FDraging := True;
      Style.UpdateInfo.Draging := True;
    end;

    if Items[vMouseDownItemNo].StyleNo < THCStyle.Null then  // ��RectItem����ק
      DoItemMouseDown(vMouseDownItemNo, vMouseDownItemOffset);
  end
  else  // û����ѡ��������
  begin
    if SelectInfo.StartItemNo >= 0 then  // �ɰ��µĻ��߷���������ȡ������
    begin
      if Items[SelectInfo.StartItemNo].StyleNo < THCStyle.Null then
        (Items[SelectInfo.StartItemNo] as THCCustomRectItem).DisSelect;

      Style.UpdateInfoRePaint;  // �ɵ�ȥ���㣬�µ��뽹��
    end;

    if (vMouseDownItemNo <> FMouseDownItemNo)
      or (vMouseDownItemOffset <> FMouseDownItemOffset)
      or (CaretDrawItemNo <> vDrawItemNo)
    then  // λ�÷����仯
    begin
      Style.UpdateInfoReCaret;
      FMouseDownReCaret := True;

      DisSelect;

      // ���¸�ֵ��λ��
      FMouseDownItemNo := vMouseDownItemNo;
      FMouseDownItemOffset := vMouseDownItemOffset;
      {if not vRestrain then  // û����
        Items[FMouseDownItemNo].Active := True;}

      SelectInfo.StartItemNo := FMouseDownItemNo;
      SelectInfo.StartItemOffset := FMouseDownItemOffset;
      CaretDrawItemNo := vDrawItemNo;
    end;

    //if not vRestrain then  // û���������ҳItem�����ǰ��λ��ʱ��Ҫ�������������Բ�������
      DoItemMouseDown(FMouseDownItemNo, FMouseDownItemOffset);
  end;
end;

procedure THCCustomRichData.MouseLeave;
begin
  if FMouseMoveItemNo >= 0 then
  begin
    DoItemMouseLeave(FMouseMoveItemNo);
    FMouseMoveItemNo := -1;
    FMouseMoveItemOffset := -1;
    Style.UpdateInfoRePaint;
  end;
end;

procedure THCCustomRichData.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  //vOldMouseMoveItemOffset,
  vMoveDrawItemNo: Integer;

  {$REGION ' AdjustSelectRang '}
  procedure AdjustSelectRang;
  var
    i, vOldStartItemNo, vOldEndItemNo: Integer;
    vLeftToRight: Boolean;
  begin
    vLeftToRight := False;
    // ��¼ԭ��ѡ�з�Χ
    vOldStartItemNo := SelectInfo.StartItemNo;
    vOldEndItemNo := SelectInfo.EndItemNo;

    if FMouseDownItemNo < FMouseMoveItemNo then  // ��ǰ����ѡ���ڲ�ͬ��Item
    begin
      vLeftToRight := True;

      if FMouseDownItemOffset = GetItemAfterOffset(FMouseDownItemNo) then  // ��ʼ��Item����棬��Ϊ��һ��Item��ʼ
      begin
        if FMouseDownItemNo < Items.Count - 1 then  // ��ʼ��Ϊ��һ��Item��ʼ
        begin
          FMouseDownItemNo := FMouseDownItemNo + 1;
          FMouseDownItemOffset := 0;
        end;
      end;

      if (FMouseDownItemNo <> FMouseMoveItemNo) and (FMouseMoveItemNo >= 0)
        and (FMouseMoveItemOffset = 0)
      then  // ������Item��ǰ�棬��Ϊ��һ��Item����
      begin
        Items[FMouseMoveItemNo].DisSelect;  // ��ǰ����ѡ������ƶ���ǰһ��ǰ�棬ԭ��괦���Ƴ�ѡ�з�Χ

        FMouseMoveItemNo := FMouseMoveItemNo - 1;
        FMouseMoveItemOffset := GetItemAfterOffset(FMouseMoveItemNo);
      end;
    end
    else
    if FMouseMoveItemNo < FMouseDownItemNo then  // �Ӻ���ǰѡ���ڲ�ͬ��Item
    begin
      vLeftToRight := False;

      if (FMouseDownItemNo > 0) and (FMouseDownItemOffset = 0) then  // ��ʼ��Item��ǰ�棬��Ϊ��һ��Item����
      begin
        FMouseDownItemNo := FMouseDownItemNo - 1;
        FMouseDownItemOffset := GetItemAfterOffset(FMouseDownItemNo);
      end;

      if (FMouseDownItemNo <> FMouseMoveItemNo)
        and (FMouseMoveItemOffset = GetItemAfterOffset(FMouseMoveItemNo))
      then  // ������Item����棬��Ϊ��һ��Item��ʼ
      begin
        Items[FMouseMoveItemNo].DisSelect;  // �Ӻ���ǰѡ������ƶ���ǰһ�����棬ԭ��괦���Ƴ�ѡ�з�Χ

        if FMouseMoveItemNo < Items.Count - 1 then  // ��Ϊ��һ��Item��ʼ
        begin
          FMouseMoveItemNo := FMouseMoveItemNo + 1;
          FMouseMoveItemOffset := 0;
        end;
      end;
    end;

    if FMouseDownItemNo = FMouseMoveItemNo then  // ѡ�������ͬһ��Item�н���
    begin
      if FMouseMoveItemOffset > FMouseDownItemOffset then  // ѡ�н���λ�ô�����ʼλ��
      begin
        if Items[FMouseDownItemNo].StyleNo < THCStyle.Null then  // RectItem
        begin
          SelectInfo.StartItemNo := FMouseDownItemNo;
          SelectInfo.StartItemOffset := FMouseDownItemOffset;

          if (FMouseDownItemOffset = OffsetBefor)
            and (FMouseMoveItemOffset = OffsetAfter)
          then  // ��RectItem��ǰ��ѡ���������(ȫѡ��)
          begin
            SelectInfo.EndItemNo := FMouseMoveItemNo;
            SelectInfo.EndItemOffset := FMouseMoveItemOffset;
          end
          else  // û��ȫѡ��
          begin
            SelectInfo.EndItemNo := -1;
            SelectInfo.EndItemOffset := -1;
            CaretDrawItemNo := vMoveDrawItemNo;
          end;
        end
        else  // TextItem
        begin
          SelectInfo.StartItemNo := FMouseDownItemNo;
          SelectInfo.StartItemOffset := FMouseDownItemOffset;
          SelectInfo.EndItemNo := FMouseDownItemNo;
          SelectInfo.EndItemOffset := FMouseMoveItemOffset;
        end;
      end
      else
      if FMouseMoveItemOffset < FMouseDownItemOffset then  // ѡ�н���λ��С����ʼλ��
      begin
        if Items[FMouseDownItemNo].StyleNo < THCStyle.Null then  // RectItem
        begin
          if FMouseMoveItemOffset = OffsetBefor then  // �Ӻ���ǰѡ����ǰ����
          begin
            SelectInfo.StartItemNo := FMouseDownItemNo;
            SelectInfo.StartItemOffset := FMouseMoveItemOffset;
            SelectInfo.EndItemNo := FMouseDownItemNo;
            SelectInfo.EndItemOffset := FMouseDownItemOffset;
          end
          else  // �Ӻ���ǰѡ��OffsetInner��
          begin
            SelectInfo.StartItemNo := FMouseDownItemNo;
            SelectInfo.StartItemOffset := FMouseDownItemOffset;
            SelectInfo.EndItemNo := -1;
            SelectInfo.EndItemOffset := -1;

            CaretDrawItemNo := vMoveDrawItemNo;
          end;
        end
        else  // TextItem
        begin
          SelectInfo.StartItemNo := FMouseMoveItemNo;
          SelectInfo.StartItemOffset := FMouseMoveItemOffset;
          SelectInfo.EndItemNo := FMouseMoveItemNo;
          SelectInfo.EndItemOffset := FMouseDownItemOffset;
        end;
      end
      else  // ����λ�ú���ʼλ����ͬ(ͬһ��Item)
      begin
        if SelectInfo.EndItemNo >= 0 then  // ͬһItem�л�ѡ�ص���ʼλ��
          Items[SelectInfo.EndItemNo].DisSelect;

        SelectInfo.StartItemNo := FMouseDownItemNo;
        SelectInfo.StartItemOffset := FMouseDownItemOffset;
        SelectInfo.EndItemNo := -1;
        SelectInfo.EndItemOffset := -1;

        CaretDrawItemNo := vMoveDrawItemNo;
      end;
    end
    else  // ѡ���������ͬһ��Item
    begin
      if vLeftToRight then
      begin
        SelectInfo.StartItemNo := FMouseDownItemNo;
        SelectInfo.StartItemOffset := FMouseDownItemOffset;
        SelectInfo.EndItemNo := FMouseMoveItemNo;
        SelectInfo.EndItemOffset := FMouseMoveItemOffset;
      end
      else
      begin
        SelectInfo.StartItemNo := FMouseMoveItemNo;
        SelectInfo.StartItemOffset := FMouseMoveItemOffset;
        SelectInfo.EndItemNo := FMouseDownItemNo;
        SelectInfo.EndItemOffset := FMouseDownItemOffset;
      end;
    end;

    // ��ѡ�з�Χ������ѡ��
    if vOldStartItemNo >= 0 then  // �о�ѡ��Item
    begin
      if vOldStartItemNo > SelectInfo.StartItemNo then
      begin
        for i := vOldStartItemNo downto SelectInfo.StartItemNo + 1 do
          Items[i].DisSelect;
      end
      else
      begin
        for i := vOldStartItemNo to SelectInfo.StartItemNo - 1 do
          Items[i].DisSelect;
      end;
    end;

    if SelectInfo.EndItemNo < 0 then  // ��ѡ�б����ѡ��
    begin
      for i := vOldEndItemNo downto SelectInfo.StartItemNo + 1 do  // ��ǰ�����ȡ��ѡ��
        Items[i].DisSelect;
    end
    else  // ��ѡ�н���
    begin
      for i := vOldEndItemNo downto SelectInfo.EndItemNo + 1 do  // ԭ���������ֽ�����һ����ȡ��ѡ��
        Items[i].DisSelect;
    end;
  end;
  {$ENDREGION}

  {$REGION 'DoItemMouseMove'}
  procedure DoItemMouseMove(const AItemNo, AOffset: Integer);
  var
    vX, vY: Integer;
  begin
    if AItemNo < 0 then Exit;
    CoordToItemOffset(X, Y, AItemNo, AOffset, vX, vY);
    Items[AItemNo].MouseMove(Shift, vX, vY);
  end;
  {$ENDREGION}

var
  vMouseMoveItemNo, vMouseMoveItemOffset: Integer;
  vRestrain: Boolean;
begin
  if SelectedResizing then  // RectItem����ing����������
  begin
    FMouseMoveItemNo := FMouseDownItemNo;
    FMouseMoveItemOffset := FMouseDownItemOffset;
    FMouseMoveRestrain := False;
    DoItemMouseMove(FMouseMoveItemNo, FMouseMoveItemOffset);
    Style.UpdateInfoRePaint;

    Exit;
  end;

  //vOldMouseMoveItemOffset := FMouseMoveItemOffset;

  GetItemAt(X, Y, vMouseMoveItemNo, vMouseMoveItemOffset, vMoveDrawItemNo, vRestrain);

  if FDraging or Style.UpdateInfo.Draging then  // ��ק
  begin
    GCursor := crDrag;

    FMouseMoveItemNo := vMouseMoveItemNo;
    FMouseMoveItemOffset := vMouseMoveItemOffset;
    FMouseMoveRestrain := vRestrain;
    CaretDrawItemNo := vMoveDrawItemNo;

    Style.UpdateInfoReCaret;

    if (not vRestrain) and (Items[FMouseMoveItemNo].StyleNo < THCStyle.Null) then  // RectItem
      DoItemMouseMove(FMouseMoveItemNo, FMouseMoveItemOffset);
  end
  else
  if FSelecting then  // ��ѡ
  begin
    FMouseMoveItemNo := vMouseMoveItemNo;
    FMouseMoveItemOffset := vMouseMoveItemOffset;
    FMouseMoveRestrain := vRestrain;
    FSelectSeekNo := vMouseMoveItemNo;
    FSelectSeekOffset := vMouseMoveItemOffset;

    AdjustSelectRang;  // ȷ��SelectRang
    MatchItemSelectState;  // ����ѡ�з�Χ�ڵ�Itemѡ��״̬
    Style.UpdateInfoRePaint;
    Style.UpdateInfoReCaret;

    if (not vRestrain) and (Items[FMouseMoveItemNo].StyleNo < THCStyle.Null) then  // RectItem
      DoItemMouseMove(FMouseMoveItemNo, FMouseMoveItemOffset);
  end
  else  // ����ק���ǻ�ѡ
  if FMouseLBDowning and ((FMouseDownX <> X) or (FMouseDownY <> Y)) then  // ��������ƶ�����ʼ��ѡ
  begin
    FSelecting := True;
    Style.UpdateInfo.Selecting := True;
  end
  else  // ����ק���ǻ�ѡ���ǰ���
  begin
    if vMouseMoveItemNo <> FMouseMoveItemNo then  // �ƶ������µ�Item��
    begin
      if FMouseMoveItemNo >= 0 then  // �ɵ��Ƴ�
        DoItemMouseLeave(FMouseMoveItemNo);
      if (vMouseMoveItemNo >= 0) and (not vRestrain) then  // �µ�����
        DoItemMouseEnter(vMouseMoveItemNo);

      Style.UpdateInfoRePaint;
    end
    else  // �����ƶ�����Item����һ����ͬһ��(������һֱ��һ��Item���ƶ�)
    begin
      if vRestrain <> FMouseMoveRestrain then  // ����Move���ϴ�Move��ͬһ��Item��2�ε����������˱仯
      begin
        if (not FMouseMoveRestrain) and vRestrain then  // �ϴ�û���������������ˣ��Ƴ�
        begin
          if FMouseMoveItemNo >= 0 then
            DoItemMouseLeave(FMouseMoveItemNo);
        end
        else
        if FMouseMoveRestrain and (not vRestrain) then  // �ϴ����������β�����������
        begin
          if vMouseMoveItemNo >= 0 then
            DoItemMouseEnter(vMouseMoveItemNo);
        end;

        Style.UpdateInfoRePaint;
      end;
    end;

    FMouseMoveItemNo := vMouseMoveItemNo;
    FMouseMoveItemOffset := vMouseMoveItemOffset;
    FMouseMoveRestrain := vRestrain;

    if not vRestrain then
      DoItemMouseMove(FMouseMoveItemNo, FMouseMoveItemOffset);
  end;
end;

procedure THCCustomRichData.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  vUpItemNo, vUpItemOffset, vDrawItemNo: Integer;

  {$REGION ' DoItemMouseUp '}
  procedure DoItemMouseUp(const AItemNo, AOffset: Integer);
  var
    vX, vY: Integer;
  begin
    if AItemNo < 0 then Exit;
    CoordToItemOffset(X, Y, AItemNo, AOffset, vX, vY);
    Items[AItemNo].MouseUp(Button, Shift, vX, vY);

    if Assigned(FOnItemMouseUp) then
      FOnItemMouseUp(Self, AItemNo, Button, Shift, vX, vY);
  end;
  {$ENDREGION}

  {$REGION ' DoNormalMouseUp '}
  procedure DoNormalMouseUp;
  begin
    if FMouseMoveItemNo < 0 then
    begin
      SelectInfo.StartItemNo := vUpItemNo;
      SelectInfo.StartItemOffset := vUpItemOffset;
    end
    else
    begin
      SelectInfo.StartItemNo := FMouseMoveItemNo;
      SelectInfo.StartItemOffset := FMouseMoveItemOffset;
    end;

    CaretDrawItemNo := vDrawItemNo;
    Style.UpdateInfoRePaint;

    if not FMouseDownReCaret then  // �����ظ���ȡ���λ��
      Style.UpdateInfoReCaret;

    if Items[vUpItemNo].StyleNo < THCStyle.Null then  // RectItem
      DoItemMouseUp(vUpItemNo, vUpItemOffset);  // ������Ϊ�������Ƴ�Item�����������ﲻ��vRestrainԼ��
  end;
  {$ENDREGION}

var
  i, vFormatFirstItemNo, vFormatLastItemNo: Integer;
  vRestrain: Boolean;
  vMouseUpInSelect: Boolean;
begin
  if not FMouseLBDowning then Exit;  // ����OpenDialog�Ի���˫������ĵ���
  FMouseLBDowning := False;

  if FMouseLBDouble then Exit;

  if SelectedResizing then  // RectItem����ing��ֹͣ����
  begin
    Undo_StartRecord;
    Undo_ItemSelf(FMouseDownItemNo, FMouseDownItemOffset);

    DoItemMouseUp(FMouseDownItemNo, FMouseDownItemOffset);
    DoItemResized(FMouseDownItemNo);  // ��������¼�(�ɿ������Ų�Ҫ����ҳ��)
    GetReformatItemRange(vFormatFirstItemNo, vFormatLastItemNo, FMouseDownItemNo, FMouseDownItemOffset);

    if (vFormatFirstItemNo > 0) and (not Items[vFormatFirstItemNo].ParaFirst) then  // ����ʱ��ȱ�խ�����ܻ�����һ�к���ŵ���
    begin
      Dec(vFormatFirstItemNo);
      vFormatFirstItemNo := GetLineFirstItemNo(vFormatFirstItemNo, 0);
    end;

    FormatItemPrepare(vFormatFirstItemNo, vFormatLastItemNo);
    ReFormatData_(vFormatFirstItemNo, vFormatLastItemNo);
    Style.UpdateInfoRePaint;

    Exit;
  end;

  GetItemAt(X, Y, vUpItemNo, vUpItemOffset, vDrawItemNo, vRestrain);

  if FSelecting or Style.UpdateInfo.Selecting then  // ��ѡ��ɵ���
  begin
    FSelecting := False;

    // ѡ�з�Χ�ڵ�RectItemȡ����ѡ״̬(��ʱ����FSelectingΪTrue)
    //if SelectInfo.StartItemNo >= 0 then
    begin
      for i := SelectInfo.StartItemNo to SelectInfo.EndItemNo do
      begin
        if (i <> vUpItemNo) and (Items[i].StyleNo < THCStyle.Null) then
          DoItemMouseUp(i, 0);
      end;
    end;

    if Items[vUpItemNo].StyleNo < THCStyle.Null then  // ����ʱ��RectItem
      DoItemMouseUp(vUpItemNo, vUpItemOffset);
  end
  else
  if FDraging or Style.UpdateInfo.Draging then  // ��ק����
  begin
    FDraging := False;
    vMouseUpInSelect := CoordInSelect(X, Y, vUpItemNo, vUpItemOffset, vRestrain);

    // ��ʱ��֧����ק
    {if not vMouseUpInSelect then  // ��ק����ʱ����ѡ��������
    begin
      //to do: ȡ��קѡ�е�����
      DeleteSelected;  // ɾ��ѡ������
    end
    else}  // ��ק����ʱ��ѡ��������
    begin
      // �������λ��֮���Itemѡ��״̬�������Լ��������𴦲���ѡ�з�Χ��ʱ
      // ��֤����ȡ��(��ItemA��ѡ����ק����һ��ItemBʱ��ItemAѡ��״̬��Ҫȡ��)
      // ��201805172309����
      if SelectInfo.StartItemNo >= 0 then  // ����ʱ�ĵ�Ԫ�񲢲��ǰ���ʱ�ģ������SelectInfo.StartItemNo < 0�����
      begin
        if SelectInfo.StartItemNo <> vUpItemNo then
        begin
          Items[SelectInfo.StartItemNo].DisSelect;
          //Items[SelectInfo.StartItemNo].Active := False;
        end;
        // ѡ�з�Χ������Itemȡ��ѡ��
        for i := SelectInfo.StartItemNo + 1 to SelectInfo.EndItemNo do  // ��������λ��֮�������Item
        begin
          if i <> vUpItemNo then
          begin
            Items[i].DisSelect;
            //Items[i].Active := False;
          end;
        end;
      end;
    end;

    // Ϊ��ק���׼��
    FMouseMoveItemNo := vUpItemNo;
    FMouseMoveItemOffset := vUpItemOffset;
    // Ϊ��һ�ε��ʱ�����һ�ε��ѡ����׼��
    FMouseDownItemNo := vUpItemNo;
    FMouseDownItemOffset := vUpItemOffset;

    DoNormalMouseUp;  // �����Լ�����Itemѡ��״̬�����Ե���Ϊ��ǰ�༭λ��

    SelectInfo.EndItemNo := -1;
    SelectInfo.EndItemOffset := -1;
  end
  else  // ����ק���ǻ�ѡ
  begin
    if SelectExists(False) then  // �����Data�����ڵ�ѡ��
      DisSelect;

    DoNormalMouseUp;
  end;
end;

procedure THCCustomRichData.ReFormatData_(const AStartItemNo: Integer; const ALastItemNo: Integer = -1;
  const AExtraItemCount: Integer = 0);
var
  i, vLastItemNo, vLastDrawItemNo, vFormatIncHight,
  vDrawItemCount, vFmtTopOffset, vClearFmtHeight: Integer;
begin
  vDrawItemCount := DrawItems.Count;
  if ALastItemNo < 0 then
    FormatData(AStartItemNo, AStartItemNo)
  else
    FormatData(AStartItemNo, ALastItemNo);  // ��ʽ��ָ����Χ�ڵ�Item
  DrawItems.DeleteFormatMark;
  vDrawItemCount := DrawItems.Count - vDrawItemCount;

  // �����ʽ����εĵײ�λ�ñ仯
  if ALastItemNo < 0 then
    vLastDrawItemNo := GetItemLastDrawItemNo(AStartItemNo)
  else
    vLastDrawItemNo := GetItemLastDrawItemNo(ALastItemNo);
  vFormatIncHight := DrawItems[vLastDrawItemNo].Rect.Bottom - DrawItems.FormatBeforBottom;  // �θ�ʽ���󣬸߶ȵ�����

  // ĳ�θ�ʽ���󣬴���������Item��ӦDrawItem��Ӱ��
  // ��ͼ2017-6-8_1��Ϊͼ2017-6-8_2�Ĺ����У���3��λ��û�䣬Ҳû���µ�Item�����仯��
  // ����DrawItem�������б仯
  // ��3��Item��Ӧ��FirstDItemNo��Ҫ�޸ģ����Դ˴�����DrawItemCount�����ı仯
  // Ŀǰ��ʽ��ʱALastItemNoΪ�ε����һ��������vLastDrawItemNoΪ�����һ��DrawItem
  if (vFormatIncHight <> 0) or (AExtraItemCount <> 0) or (vDrawItemCount <> 0) then
  begin
    if DrawItems.Count > vLastDrawItemNo then
    begin
      vLastItemNo := -1;
      for i := vLastDrawItemNo + 1 to DrawItems.Count - 1 do  // �Ӹ�ʽ���䶯�ε���һ�ο�ʼ
      begin
        // �����ʽ�������DrawItem��Ӧ��ItemNoƫ��
        DrawItems[i].ItemNo := DrawItems[i].ItemNo + AExtraItemCount;
        if vLastItemNo <> DrawItems[i].ItemNo then
        begin
          vLastItemNo := DrawItems[i].ItemNo;
          Items[vLastItemNo].FirstDItemNo := i;
        end;

        if vFormatIncHight <> 0 then  // ������ȷ��Ϊ0ʱ����Ҫ���´���ƫ����
        begin
          // ��ԭ��ʽ�����ҳ��ԭ��������������ƻ����ӵĸ߶Ȼָ�����
          // ������������洦��ItemNo��ƫ�ƣ��ɽ�TTableCellData.ClearFormatExtraHeight����д�����࣬����ֱ�ӵ���
          if DrawItems[i].LineFirst then
            vFmtTopOffset := DrawItems[i - 1].Rect.Bottom - DrawItems[i].Rect.Top;

          OffsetRect(DrawItems[i].Rect, 0, vFmtTopOffset);

          if Items[DrawItems[i].ItemNo].StyleNo < THCStyle.Null then  // RectItem�����ڸ�ʽ��ʱ���к����м��ƫ�ƣ��¸�ʽ��ʱҪ�ָ����ɷ�ҳ�����ٴ����¸�ʽ�����ƫ��
          begin
            vClearFmtHeight := (Items[DrawItems[i].ItemNo] as THCCustomRectItem).ClearFormatExtraHeight;
            DrawItems[i].Rect.Bottom := DrawItems[i].Rect.Bottom - vClearFmtHeight;
          end;
        end;
      end;
    end;
  end;
end;

procedure THCCustomRichData.ReSetSelectAndCaret(const AItemNo, AOffset: Integer;
  const ANextWhenMid: Boolean = False);
var
  vDrawItemNo: Integer;
begin
  SelectInfo.StartItemNo := AItemNo;
  SelectInfo.StartItemOffset := AOffset;

  vDrawItemNo := GetDrawItemNoByOffset(AItemNo, AOffset);
  if ANextWhenMid
    and (vDrawItemNo < DrawItems.Count - 1)
    and (DrawItems[vDrawItemNo + 1].ItemNo = AItemNo)
    and (DrawItems[vDrawItemNo + 1].CharOffs = AOffset + 1)
  then
    Inc(vDrawItemNo);

  CaretDrawItemNo := vDrawItemNo;
end;

procedure THCCustomRichData.ReSetSelectAndCaret(const AItemNo: Integer);
begin
  ReSetSelectAndCaret(AItemNo, GetItemAfterOffset(AItemNo));
end;

procedure THCCustomRichData.SaveItemToStreamAlone(const AItem: THCCustomItem;
  const AStream: TStream);
begin
  _SaveFileFormatAndVersion(AStream);
  AItem.SaveToStream(AStream);
  if AItem.StyleNo > THCStyle.Null then
    Style.TextStyles[AItem.StyleNo].SaveToStream(AStream);

  Style.ParaStyles[AItem.ParaNo].SaveToStream(AStream);
end;

procedure THCCustomRichData.SetEmptyData;
var
  vItem: THCCustomItem;
begin
  if Self.Items.Count = 0 then
  begin
    vItem := CreateDefaultTextItem;
    vItem.ParaFirst := True;
    Items.Add(vItem);  // ��ʹ��InsertText��Ϊ�����䴥��ReFormatʱ��Ϊû�и�ʽ��������ȡ������Ӧ��DrawItem

    FormatData(0, 0);
    ReSetSelectAndCaret(0);
  end;
end;

procedure THCCustomRichData.SetReadOnly(const Value: Boolean);
begin
  FReadOnly := Value;
end;

procedure THCCustomRichData.SetWidth(const Value: Cardinal);
begin
  if FWidth <> Value then
    FWidth := Value;
end;

procedure THCCustomRichData._FormatReadyParam(const AStartItemNo: Integer;
  var APrioDrawItemNo: Integer; var APos: TPoint);
{var
  i, vEndDrawItemNo: Integer;}
begin
  { ��ȡ��ʼDrawItem����һ����ż���ʽ����ʼλ�� }
  if AStartItemNo > 0 then  // ���ǵ�һ��
  begin
    APrioDrawItemNo := GetItemLastDrawItemNo(AStartItemNo - 1);  // ��һ������DItem
    if Items[AStartItemNo].ParaFirst then
    begin
      APos.X := 0;
      APos.Y := DrawItems[APrioDrawItemNo].Rect.Bottom;
    end
    else
    begin
      APos.X := DrawItems[APrioDrawItemNo].Rect.Right;
      APos.Y := DrawItems[APrioDrawItemNo].Rect.Top;
    end;
  end
  else  // �ǵ�һ��
  begin
    APrioDrawItemNo := -1;
    APos.X := 0;
    APos.Y := 0;
  end;
end;

end.



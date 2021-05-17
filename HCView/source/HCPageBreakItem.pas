{*******************************************************}
{                                                       }
{               HCView V1.1  ���ߣ���ͨ                 }
{                                                       }
{      ��������ѭBSDЭ�飬����Լ���QQȺ 649023932      }
{            ����ȡ����ļ������� 2018-5-4              }
{                                                       }
{         �ĵ�PageBreakItem(��ҳ������ʵ�ֵ�Ԫ          }
{                                                       }
{*******************************************************}

unit HCPageBreakItem;

interface

uses
  Windows, HCRectItem, HCStyle, HCCommon, HCCustomData;

type
  TPageBreakItem = class(THCCustomRectItem)
  protected
    function JustifySplit: Boolean; override;
    //function GetOffsetAt(const X: Integer): Integer; override;
  public
    constructor Create(const AOwnerData: THCCustomData); override;
  end;

implementation

{ TPageBreakItem }

constructor TPageBreakItem.Create(const AOwnerData: THCCustomData);
var
  vSize: TSize;
begin
  inherited Create(AOwnerData);
  StyleNo := THCStyle.PageBreak;

  if AOwnerData.Style.CurStyleNo > THCStyle.Null then
    AOwnerData.Style.TextStyles[AOwnerData.Style.CurStyleNo].ApplyStyle(AOwnerData.Style.DefCanvas)
  else
    AOwnerData.Style.TextStyles[0].ApplyStyle(AOwnerData.Style.DefCanvas);

  vSize := AOwnerData.Style.DefCanvas.TextExtent('H');

  Width := 0;
  Height := vSize.cy;
end;

{function TPageBreakItem.GetOffsetAt(const X: Integer): Integer;
begin
  if X < 0 then
    Result := OffsetBefor
  else
    Result := OffsetAfter;
end;}

function TPageBreakItem.JustifySplit: Boolean;
begin
  Result := False;
end;

end.

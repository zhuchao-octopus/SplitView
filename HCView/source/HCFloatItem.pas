{*******************************************************}
{                                                       }
{               HCView V1.1  ���ߣ���ͨ                 }
{                                                       }
{      ��������ѭBSDЭ�飬����Լ���QQȺ 649023932      }
{            ����ȡ����ļ������� 2018-8-16             }
{                                                       }
{            �ĵ�FloatItem(����)����ʵ�ֵ�Ԫ            }
{                                                       }
{*******************************************************}

unit HCFloatItem;

interface

uses
  Windows, SysUtils, Classes, Controls, Graphics, Messages, HCItem, HCRectItem,
  HCStyle, HCCustomData;

const
  PointSize = 5;

type
  THCFloatItem = class(THCResizeRectItem)  // �ɸ���Item
  private
    FLeft, FTop, FPageIndex: Integer;
    FDrawRect: TRect;
  public
    constructor Create(const AOwnerData: THCCustomData); override;
    function PtInClient(const APoint: TPoint): Boolean; overload; virtual;
    function PtInClient(const X, Y: Integer): Boolean; overload;
    procedure Assign(Source: THCCustomItem); override;
    procedure DoPaint(const AStyle: THCStyle; const ADrawRect: TRect;
      const ADataDrawTop, ADataDrawBottom, ADataScreenTop, ADataScreenBottom: Integer;
      const ACanvas: TCanvas; const APaintInfo: TPaintInfo); override;
    procedure SaveToStream(const AStream: TStream; const AStart, AEnd: Integer); override;
    procedure LoadFromStream(const AStream: TStream; const AStyle: THCStyle; const AFileVersion: Word); override;

    property DrawRect: TRect read FDrawRect write FDrawRect;
    property Left: Integer read FLeft write FLeft;
    property Top: Integer read FTop write FTop;
    property PageIndex: Integer read FPageIndex write FPageIndex;
  end;

implementation

{ THCFloatItem }

procedure THCFloatItem.Assign(Source: THCCustomItem);
begin
  inherited Assign(Source);
  FLeft := (Source as THCFloatItem).Left;
  FTop := (Source as THCFloatItem).Top;
  Width := (Source as THCFloatItem).Width;
  Height := (Source as THCFloatItem).Height;
end;

constructor THCFloatItem.Create(const AOwnerData: THCCustomData);
begin
  inherited Create(AOwnerData);
  //Self.StyleNo := THCStyle.FloatItem;
end;

function THCFloatItem.PtInClient(const APoint: TPoint): Boolean;
begin
  Result := PtInRect(Bounds(0, 0, Width, Height), APoint);
end;

procedure THCFloatItem.DoPaint(const AStyle: THCStyle; const ADrawRect: TRect;
  const ADataDrawTop, ADataDrawBottom, ADataScreenTop,
  ADataScreenBottom: Integer; const ACanvas: TCanvas;
  const APaintInfo: TPaintInfo);
begin
  //inherited;
  if Self.Active then
    ACanvas.DrawFocusRect(FDrawRect);
end;

procedure THCFloatItem.LoadFromStream(const AStream: TStream;
  const AStyle: THCStyle; const AFileVersion: Word);
var
  vValue: Integer;
begin
  //AStream.ReadBuffer(StyleNo, SizeOf(StyleNo));  // ����ʱ�ȶ�ȡ������ֵ����
  AStream.ReadBuffer(FLeft, SizeOf(FLeft));
  AStream.ReadBuffer(FTop, SizeOf(FTop));

  AStream.ReadBuffer(vValue, SizeOf(vValue));
  Width := vValue;
  AStream.ReadBuffer(vValue, SizeOf(vValue));
  Height := vValue;
end;

function THCFloatItem.PtInClient(const X, Y: Integer): Boolean;
begin
  Result := PtInClient(Point(X, Y));
end;

procedure THCFloatItem.SaveToStream(const AStream: TStream; const AStart,
  AEnd: Integer);
var
  vValue: Integer;
begin
  AStream.WriteBuffer(Self.StyleNo, SizeOf(Self.StyleNo));
  AStream.WriteBuffer(FLeft, SizeOf(FLeft));
  AStream.WriteBuffer(FTop, SizeOf(FTop));

  vValue := Width;
  AStream.WriteBuffer(vValue, SizeOf(vValue));
  vValue := Height;
  AStream.WriteBuffer(vValue, SizeOf(vValue));
end;

end.

unit VMatrix;

interface

uses
{$IFDEF UNIX}Unix, {$ENDIF}
{$IFDEF MSWINDOWS}Windows, {$ENDIF}
{$IFDEF FPC}
  LCLType, LCLIntf, LazarusPackageIntf, LMessages, LResources, Forms, Dialogs,
{$ELSE}
  Messages,
{$ENDIF}
  Classes, SysUtils, Controls, ExtCtrls, Graphics;

type
  TVideoMatrix = class
  private
    FRow: Integer;
    FCol: Integer;
    FVM: array of array of TPasLibVlcPlayer;
    //FDM: array of array of TVData;

    procedure SetRowAndCol(rc: Integer);
  protected
  public
    constructor Create(rc: Integer);
    destructor Destroy;

    function GetVM(index: Integer): TPasLibVlcPlayer overload;
    function GetVM(row: Integer; col: Integer): TPasLibVlcPlayer overload;
    property VM[index: Integer]: TPasLibVlcPlayer read GetVM;
  end;

implementation

{ TVideoMatrix }

constructor TVideoMatrix.Create(rc: Integer);
var
  i, j: Integer;
begin
  SetRowAndCol(rc);
  for i := 0 to FRow do
  begin
    for j := 0 to FCol do
    begin
      FVM[i, j] := TPasLibVlcPlayer.create(nil);
    end;
  end;

end;

destructor TVideoMatrix.Destroy;
var
  i, j: Integer;
begin
  for i := 0 to FRow do
  begin
    for j := 0 to FCol do
      if Assigned(FVM[i, j]) then
      begin
        FVM[i, j].Free;
        FVM[i, j] := nil;
      end;
  end;
end;

function TVideoMatrix.GetVM(row, col: Integer): TPasLibVlcPlayer;
begin

  Result := FVM[row, col];
end;

function TVideoMatrix.GetVM(index: Integer): TPasLibVlcPlayer;
begin
  // Result := FVM[index][];
end;

procedure TVideoMatrix.SetRowAndCol(rc: Integer);
begin
  FRow := rc;
  FCol := rc;
  SetLength(FVM, rc, rc);
end;

end.

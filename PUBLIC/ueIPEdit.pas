unit ueIPEdit;

interface

uses

  System.SysUtils, System.Classes, Vcl.Controls, Winapi.Windows,
  Winapi.Messages,

  Vcl.ComCtrls, Winapi.CommCtrl;

type

  TFieldChangeEvent = procedure(Sender: TObject; OldField, OldValue: Byte)
    of object;

  TUeIPEdit = class(TWinControl)

  private

    FState: Integer; // Internal use

    FBakIP: Longint; // Internal use

    FMinIP: Longint;

    FMaxIP: Longint;

    FOnChange: TNotifyEvent;

    FOnFieldChange: TFieldChangeEvent;

    procedure CNNotify(var Message: TWMNotify); message CN_NOTIFY;

    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;

  protected

    procedure CreateParams(var Params: TCreateParams); override;

    function GetMinIP: String;

    function GetMaxIP: String;

    procedure SetMinIP(const Value: String);

    procedure SetMaxIP(const Value: String);

    procedure UpdateRange;

    function GetIP: String;

    procedure SetIP(const Value: String);

    function GetEmpty: Boolean;

    function GetReadOnly: Boolean;

    procedure SetReadOnly(Value: Boolean);

    function IPToString(const AIp: Longint): String;

    function StringToIP(const Value: String): Longint;

  public

    constructor Create(AOwner: TComponent); override;

    procedure Clear;

    procedure SetActiveField(const Value: Integer);

    property Empty: Boolean read GetEmpty;

    property ReadOnly: Boolean read GetReadOnly write SetReadOnly;

    property IP: String read GetIP write SetIP;

    property MinIP: String read GetMinIP write SetMinIP;

    property MaxIP: String read GetMaxIP write SetMaxIP;

    property OnChange: TNotifyEvent read FOnChange write FOnChange;

    property OnIPFieldChange: TFieldChangeEvent read FOnFieldChange
      write FOnFieldChange;

    property Font;

    property ParentColor;

    property ParentFont;

    property ParentShowHint;

    property PopupMenu;

    property ShowHint;

    property TabOrder;

    property TabStop;

    property Tag;

    property DragCursor;

    property DragMode;

    property HelpContext;

  end;
  procedure Register;
implementation

uses Vcl.Graphics;



procedure Register;
begin
 RegisterComponents('MyComponent', [TUeIPEdit]);
end;

constructor TUeIPEdit.Create(AOwner: TComponent);

const

  EditStyle = [csClickEvents, csSetCaption, csDoubleClicks, csFixedHeight,
    csPannable];

begin

  inherited Create(AOwner);

  if NewStyleControls then

    ControlStyle := EditStyle
  else

    ControlStyle := EditStyle + [csFramed];

  ParentColor := False;

  Color := clWindow;

  Width := 130;

  Height := 24;

  TabStop := True;

  FState := 0;

  FBakIP := -1;

  FMinIP := 0;

  FMaxIP := $0FFFFFFFF;

  FOnChange := nil;

  FOnFieldChange := nil;

end;

procedure TUeIPEdit.CreateParams(var Params: TCreateParams);

begin

  InitCommonControl(ICC_INTERNET_CLASSES);

  inherited CreateParams(Params);

  CreateSubClass(Params, WC_IPADDRESS);

  with Params do

  begin

    Style := WS_VISIBLE or WS_BORDER or WS_CHILD;

    if NewStyleControls and Ctl3D then

    begin

      Style := Style and not WS_BORDER;

      ExStyle := ExStyle or WS_EX_CLIENTEDGE;

    end;

  end;

end;

procedure TUeIPEdit.CNNotify(var Message: TWMNotify);

begin

  if (FState = 0) and Assigned(FOnFieldChange) and

    (Message.NMHdr^.code = IPN_FIELDCHANGED) then

    FOnFieldChange(Self, PNMIPAddress(Message.NMHdr)^.iField,

      PNMIPAddress(Message.NMHdr)^.iValue);

end;

procedure TUeIPEdit.CNCommand(var Message: TWMCommand);

begin

  if (Message.NotifyCode = EN_CHANGE) then

  begin

    case FState of

      0:
        if Assigned(FOnChange) then
          FOnChange(Self);

      1:
        begin

          FState := 2;

          PostMessage(Handle, IPM_SETADDRESS, 0, FBakIP);

        end;

      2:
        FState := 1;

    end;

  end;

end;

function TUeIPEdit.IPToString(const AIp: Longint): String;

begin

  Result := Format('%d.%d.%d.%d', [FIRST_IPADDRESS(AIp), SECOND_IPADDRESS(AIp),

    THIRD_IPADDRESS(AIp), FOURTH_IPADDRESS(AIp)]);

end;

function TUeIPEdit.StringToIP(const Value: String): Longint;

var

  B: array [0 .. 3] of Byte;

  Strs: TArray<string>;

  i, Cnt: Integer;

begin

  B[0] := 0;

  B[1] := 0;

  B[2] := 0;

  B[3] := 0;

  if Value <> '' then

  begin

    Strs := Value.Split(['.'], TStringSplitOptions.ExcludeEmpty);

    try

      Cnt := Length(Strs);

      if Cnt > 4 then
        Cnt := 4;

      for i := 0 to Cnt - 1 do

        B[i] := StrToInt(Strs[i]);

    finally

      Strs := nil;

    end;

  end;

  Result := MakeIPAddress(B[0], B[1], B[2], B[3]);

end;

function TUeIPEdit.GetIP: String;

var

  AIp: Longint;

begin

  SendMessage(Handle, IPM_GETADDRESS, 0, Longint(@AIp));

  Result := IPToString(AIp);

end;

procedure TUeIPEdit.SetIP(const Value: String);

begin

  SendMessage(Handle, IPM_SETADDRESS, 0, StringToIP(Value));

end;

function TUeIPEdit.GetMinIP: String;

begin

  Result := IPToString(FMinIP);

end;

procedure TUeIPEdit.SetMinIP(const Value: String);

var

  AMin: Longint;

begin

  AMin := StringToIP(Value);

  if FMinIP <> AMin then

  begin

    FMinIP := AMin;

    UpdateRange;

  end;

end;

procedure TUeIPEdit.UpdateRange;

begin

  SendMessage(Handle, IPM_SETRANGE, 0, MAKEIPRANGE(FIRST_IPADDRESS(FMinIP),
    FIRST_IPADDRESS(FMaxIP)));

  SendMessage(Handle, IPM_SETRANGE, 1, MAKEIPRANGE(SECOND_IPADDRESS(FMinIP),
    SECOND_IPADDRESS(FMaxIP)));

  SendMessage(Handle, IPM_SETRANGE, 2, MAKEIPRANGE(THIRD_IPADDRESS(FMinIP),
    THIRD_IPADDRESS(FMaxIP)));

  SendMessage(Handle, IPM_SETRANGE, 3, MAKEIPRANGE(FOURTH_IPADDRESS(FMinIP),
    FOURTH_IPADDRESS(FMaxIP)));

end;

procedure TUeIPEdit.SetMaxIP(const Value: String);

var

  AMax: Longint;

begin

  AMax := StringToIP(Value);

  if FMaxIP <> AMax then

  begin

    FMaxIP := AMax;

    UpdateRange;

  end;

end;

function TUeIPEdit.GetMaxIP: String;

begin

  Result := IPToString(FMaxIP);

end;

function TUeIPEdit.GetReadOnly: Boolean;

begin

  Result := FState <> 0;

end;

procedure TUeIPEdit.SetReadOnly(Value: Boolean);

begin

  if Value <> GetReadOnly then

  begin

    if Value then

    begin

      SendMessage(Handle, IPM_GETADDRESS, 0, Longint(@FBakIP));

      FState := 1;

    end
    else
    begin

      FState := 0;

    end;

  end;

end;

function TUeIPEdit.GetEmpty: Boolean;

begin

  Result := Boolean(SendMessage(Handle, IPM_ISBLANK, 0, 0));

end;

procedure TUeIPEdit.Clear;

begin

  SendMessage(Handle, IPM_CLEARADDRESS, 0, 0);

end;

procedure TUeIPEdit.SetActiveField(const Value: Integer);

begin

  if (Value < 4) then

  begin

    SendMessage(Handle, IPM_SETFOCUS, wParam(Value), 0);

  end;

end;

end.

unit MyMessageQueue;

interface

uses SysUtils, Classes, Windows,
  ExtCtrls, MATH, Messages, SyncObjs;

type
  TMyMessage = class
  private
    FID: Integer;
    FData1: Int64;
    FData2: Int64;
    FMsg: String;
    FObj: TObject;
  protected
  public
    constructor Create(ID: Integer; Data: Int64; Msg: String); overload;
    constructor Create(ID: Integer; Data1, Data2: Int64; Msg: String); overload;
    constructor Create(ID: Integer; Obj: TObject); overload;
    destructor Destroy;
    property ID: Integer read FID;
    property Data1: Int64 read FData1;
    property Data2: Int64 read FData2;
    property Msg: String read FMsg;
    property Obj: TObject read FObj;
  end;

  TMyMessageQueue = class
  private
    FMsgList: TList;
    MessageCriticalSection: TCriticalSection;
  protected
  public
    constructor Create();
    destructor Destroy;
    procedure SendMessage(Msg: TMyMessage); overload;
    procedure SendMessage(ID: Integer); overload;
    procedure SendMessage(ID: Integer; Obj: TObject); overload;
    function get(): TMyMessage;
  end;

var
  MQueue: TMyMessageQueue;

implementation

constructor TMyMessage.Create(ID: Integer; Data: Int64; Msg: string);
begin
  Self.FID := ID;
  Self.FData1 := Data;
  Self.FMsg := Msg;
end;

constructor TMyMessage.Create(ID: Integer; Data1, Data2: Int64; Msg: string);
begin
  Self.FID := ID;
  Self.FData1 := Data1;
  Self.FData2 := Data2;
  Self.FMsg := Msg;
end;

constructor TMyMessage.Create(ID: Integer; Obj: TObject);
begin
  Self.FID := ID;
  Self.FObj := Obj;
end;

destructor TMyMessage.Destroy;
begin

end;

constructor TMyMessageQueue.Create();
begin
  FMsgList := TList.Create;
  // FMsgList.OwnsObjects
  MessageCriticalSection := TCriticalSection.Create;
end;

destructor TMyMessageQueue.Destroy;
begin
  FMsgList.Clear;
  FMsgList.Free;
  MessageCriticalSection.Free;
end;

procedure TMyMessageQueue.SendMessage(Msg: TMyMessage);
begin
  MessageCriticalSection.Enter;
  FMsgList.Add(Msg);
  MessageCriticalSection.Leave;
end;

procedure TMyMessageQueue.SendMessage(ID: Integer);
var
  Msg: TMyMessage;
begin
  Msg := TMyMessage.Create(ID, 0, '');
  MessageCriticalSection.Enter;
  FMsgList.Add(Msg);
  MessageCriticalSection.Leave;
end;

procedure TMyMessageQueue.SendMessage(ID: Integer; Obj: TObject);
var
  Msg: TMyMessage;
begin
  Msg := TMyMessage.Create(ID, Obj);
  MessageCriticalSection.Enter;
  FMsgList.Add(Msg);
  MessageCriticalSection.Leave;
end;

function TMyMessageQueue.get: TMyMessage;
begin
  Result := nil;
  try
    if FMsgList.Count > 0 then
    begin
      MessageCriticalSection.Enter;
      Result := FMsgList.First;
      FMsgList.Remove(Result);
      MessageCriticalSection.Leave;
    end;
  finally
  end;

end;

initialization

MQueue := TMyMessageQueue.Create;

finalization

MQueue.CleanupInstance;
MQueue.Free;

end.

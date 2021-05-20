{ $HDR$ }
{ ********************************************************************** }
{ Unit archived using Team Coherence }
{ Team Coherence is Copyright 2002 by Quality Software Components }
{ }
{ For further information / comments, visit our WEB site at }
{ http://www.TeamCoherence.com }
{ ********************************************************************** }
{ }
{ $Log:  22956: ClientThread.pas
  {
  {   Rev 1.0    09/10/2003 3:10:54 PM  Jeremy Darling
  { Project Checked into TC for the first time
}
unit ClientObject;

interface

uses
  IdTCPClient,
  ComCtrls,
  Classes,
  SysUtils,
  SyncObjs,
  Windows;

type
  TClientObject = class(TObject)
  private
    FClient: TIdTCPClient;
    FFree: Boolean;
    // FLastTick: Cardinal;
    FuiLock: TCriticalSection;
    FSleepTime: Integer;
    procedure SetuiLock(const Value: TCriticalSection);
    procedure SetSleepTime(const Value: Integer);
  public
    procedure AssignClient(AClient: TIdTCPClient);
    procedure Execute;
    Constructor Create(Free: Boolean);
    destructor Destroy; override;
    property SleepTime: Integer read FSleepTime write SetSleepTime;
    property Client: TIdTCPClient read FClient;
    property uiLock: TCriticalSection read FuiLock write SetuiLock;
  end;

implementation

{ TClientThread }

procedure TClientObject.AssignClient(AClient: TIdTCPClient);
begin
  if not Assigned(FClient) then
    FClient := TIdTCPClient.Create(nil);
  with FClient do
  begin
    Port := AClient.Port;
    Host := AClient.Host;
    IOHandler := AClient.IOHandler;
    OnConnected := AClient.OnConnected;
    OnDisconnected := AClient.OnDisconnected;
    OnStatus := AClient.OnStatus;
    OnWork := AClient.OnWork;
    OnWorkBegin := AClient.OnWorkBegin;
    OnWorkEnd := AClient.OnWorkEnd;
  end;
end;

Constructor TClientObject.Create(Free: Boolean);
begin
  FFree := Free;
  //inherited;
end;

destructor TClientObject.Destroy;
begin
  FFree := True;
  uiLock.Enter;
  uiLock.Leave;
  FClient.Free;
  inherited;
end;

procedure TClientObject.Execute;
var
  i: Integer;
begin
  if (not FClient.Connected) then
  begin
    FClient.Connect;
  end;

  while not FFree do
  begin
    //:= FClient.IOHandler.Buffer.Size;
    if i > 0 then
    begin
      //SetLength(s, i);
      //FClient.IOHandler.ReadBuffer(s[1], i);
    end;
  end;
end;

procedure TClientObject.SetSleepTime(const Value: Integer);
begin
  FSleepTime := Value;
end;

procedure TClientObject.SetuiLock(const Value: TCriticalSection);
begin
  FuiLock := Value;
end;

end.

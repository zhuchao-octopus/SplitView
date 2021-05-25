unit ObjManager;

interface

uses ClientObject, DataEngine, IdTCPClient, System.SysUtils;

function GetTCPObj(IdTCPClient1: TIdTCPClient; Ip: String; Port: Integer)
  : TClientObject;

implementation

function GetTCPObj(IdTCPClient1: TIdTCPClient; Ip: String; Port: Integer)
  : TClientObject;
var
  ClientObject: TClientObject;
begin

  Result := TClientObject(DataEngineManager.get(Ip + ':' + IntToStr(Port)));
  if Result <> nil then
  begin
    DataEngineManager.DoIt(ClientObject.OpenTCP);
    Exit;
  end;

  try
    ClientObject := TClientObject.Create(False);
    if TIdTCPClient <> nil then
    begin
      IdTCPClient1.Host := Ip;
      IdTCPClient1.Port := Port;
    end;
    ClientObject.AssignTCPClient(IdTCPClient1);
    ClientObject.Client.tag := Integer(Pointer(TClientObject(ClientObject)));
    DataEngineManager.Add(Ip + ':' + IntToStr(Port), ClientObject);
    DataEngineManager.DoIt(ClientObject.OpenTCP);
  Except
  end;
  Result := ClientObject;
end;

end.

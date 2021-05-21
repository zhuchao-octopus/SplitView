unit Trash;

interface

uses SysUtils, Classes, Windows,
  System.Variants;

//var
  // MyErrorMsgs: TStringList;
  // MsgLogList: TStringList;

//  LocalIPList: TStringList;


procedure PrintError(Name: String; Position: integer; Msg: String);
procedure PrintMsg(Msg: String);

implementation

procedure PrintError(Name: String; Position: integer; Msg: String);
var
  ErrorMsg: String;
begin
  // ErrorMsg := GetSystemDateTimeStr + ', ErrorName:' + Name + ', Position:' + inttostr(Position) + ', Msg:' + Msg;
  // MyErrorMsgs.Append(ErrorMsg);
  // MyErrorMsgs.SaveToFile(MyErrorMsgs.Strings[0]);
end;

procedure PrintMsg(Msg: String);
begin
//  if MsgLogList = nil then
//    MsgLogList := TStringList.Create;
//  MsgLogList.Add(Msg);
 // MsgLogList.SaveToFile('Debug.log');
end;

initialization
//DeviceList := TVDeviceGroup.Create('');
finalization

end.

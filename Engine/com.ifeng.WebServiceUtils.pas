unit com.ifeng.WebServiceUtils;

interface

uses SysUtils, Classes, Windows,
  ExtCtrls, MATH, Messages, SyncObjs, System.Threading,
  System.json, GlobalConst, GlobalTypes, GlobalFunctions,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdHTTP, Stock;

type
  TOnProcessEvent = procedure(value: Integer) of object;

  TDataSourceWebServiceThread = class(TThread)
    constructor Create(FormHandle: HWND; stkObj: TStockObject; MaxDowndCount: Integer;
      ThreadPool: TStringList); overload;
  private
    FStockObj: TStockObject;
    FFormHandle: HWND;
    FMaxDowndCount: Integer;
    FThreadPool: TStringList;

  protected
    procedure Execute; override;

  public
  end;

implementation

constructor TDataSourceWebServiceThread.Create(FormHandle: HWND; stkObj: TStockObject;
  MaxDowndCount: Integer; ThreadPool: TStringList);
begin
  inherited Create(True);
  FStockObj := stkObj;
  FFormHandle := FormHandle;
  FMaxDowndCount := MaxDowndCount;
  FThreadPool:= ThreadPool;

end;

{ WebServiceUtils }
// GetTickCount
procedure TDataSourceWebServiceThread.Execute;
var
  pDAYS: PTStockDealInfoDynamicArray;
  url: String;
  ss: TStringStream;
  stkCode: String;
  JsonStr, strtemp: String;
  JSONObject: TJSONObject;
  JSONArray: TJSONArray;
  JsonValue: String;
  i, J, k, Count, nn: Integer;
  AStrings: TStringList;
  IdHTTP: TIdHTTP;

begin
  try
    begin
      ss := TStringStream.Create('');
      AStrings := TStringList.Create;
      AStrings.Clear;
      ss.Clear;
      stkCode := stkCode.LowerCase(FStockObj.stkCode);
      pDAYS := @FStockObj.DAYS;
      if FStockObj.KLineMode = KD_DAY then
        url := 'http://api.finance.ifeng.com/akdaily?code=' + stkCode + '&type=last'
      else if FStockObj.KLineMode = KD_WEEK then
        url := 'http://api.finance.ifeng.com/akweekly?code=' + stkCode + '&type=last'
      else if FStockObj.KLineMode = KD_MONTH then
        url := 'http://api.finance.ifeng.com/akmonthly?code=' + stkCode + '&type=last'
      else
        Exit;

      IdHTTP := TIdHTTP.Create();
      IdHTTP.ReadTimeout := 5000;
      IdHTTP.ConnectTimeout := 5000;
      IdHTTP.Get(url, ss);

      JsonStr := trim(ss.DataString);
      if JsonStr = '' then
        Exit;

      JSONObject := TJSONObject.ParseJSONValue(JsonStr) as TJSONObject;
      if JSONObject = nil then
        Exit;
      JSONArray := TJSONArray(JSONObject.GetValue('record'));
      if JSONArray = nil then
        Exit;

      SetLength(pDAYS^, JSONArray.Count);
      try
        // for i := 0 to JSONArray.Count - 1 do // jsonArray 0号元素是最老的数据
        for i := JSONArray.Count - 1 downto 0 do // 从最新元素开始复制数据
        begin // DAYS[I] 0 号元素需要最新
          JsonValue := JSONArray.Items[i].ToJSON;
          AStrings.Clear;
          Count := ExtractStrings([','], [' ', '[', ']'], PChar(JsonValue), AStrings);
          J := 0;
          k := JSONArray.Count - 1 - i;
          if (k > FMaxDowndCount) then
            break;

          strtemp := StringReplace(AStrings.Strings[J], '"', '', [rfReplaceAll, rfIgnoreCase]);
          pDAYS^[k].DATE := DateTimeToLocalLongWord(StrToDateMyTime(strtemp), 5);
          // dateTime := StrToDateTime1(strtemp);
          INC(J);
          strtemp := (StringReplace(AStrings.Strings[J], '"', '', [rfReplaceAll, rfIgnoreCase]));
          pDAYS^[k].Open := StrToFloat(strtemp);
          INC(J);
          strtemp := (StringReplace(AStrings.Strings[J], '"', '', [rfReplaceAll, rfIgnoreCase]));
          pDAYS^[k].High := StrToFloat(strtemp);
          INC(J);
          strtemp := (StringReplace(AStrings.Strings[J], '"', '', [rfReplaceAll, rfIgnoreCase]));
          pDAYS^[k].Close := StrToFloat(strtemp);
          INC(J);
          strtemp := (StringReplace(AStrings.Strings[J], '"', '', [rfReplaceAll, rfIgnoreCase]));
          pDAYS^[k].Low := StrToFloat(strtemp);
          INC(J);
          strtemp := (StringReplace(AStrings.Strings[J], '"', '', [rfReplaceAll, rfIgnoreCase]));
          pDAYS^[k].volume := Trunc(StrToFloat(strtemp));
        end;

        //FStockObj.UpdateZSBWM();
        // Atom:=GlobalAddAtom(@stkObj.StkCode[1]);
        //SendMessage(FFormHandle, WM_MYMESSAGE_THREAD_CONTENT, Integer(@FStockObj.stkCode),
        //  Integer(@FStockObj.StkName));
        // PString(Integer(@stkObj.StkCode));
      Except
      end;
    end;

  finally
    FCriticalSection.Enter;
    FThreadPool.BeginUpdate;
    i:= FThreadPool.IndexOf(FStockObj.GetLevelKey);
    if i>=0 then
      FThreadPool.Delete(i);
    FThreadPool.EndUpdate;
    FCriticalSection.Leave;
    AStrings.Free;
    ss.Free;
    JSONObject.Free;
    IdHTTP.Disconnect;
    IdHTTP.Free;
  end;
end;


end.

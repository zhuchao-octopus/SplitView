unit com.sina.WebServiceUtils;

interface

uses SysUtils, Classes, Windows,
  ExtCtrls, MATH, Messages, SyncObjs, System.Threading,
  System.json, GlobalConst, GlobalTypes, GlobalFunctions,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdHTTP, Stock;

type
  TOnProcessEvent = procedure(value: Integer) of object;

  TDataSourceWebServiceThread = class(TThread)
    constructor Create(FormHandle: HWND; stkObj: TStockObject; MaxDowndCount: Integer; ThreadPool: TStringList); overload;
  private
    FStockObj: TStockObject;
    FFormHandle: HWND;
    FMaxDowndCount: Integer;
  protected
    procedure Execute; override;

  public
  end;

implementation

constructor TDataSourceWebServiceThread.Create(FormHandle: HWND; stkObj: TStockObject; MaxDowndCount: Integer; ThreadPool: TStringList);
begin
  inherited Create(false);
  FStockObj := stkObj;
  FFormHandle := FormHandle;
  FMaxDowndCount := MaxDowndCount;
end;

{ WebServiceUtils }
// GetTickCount
procedure TDataSourceWebServiceThread.Execute;
var
  pDAYS: PTStockDealInfoDynamicArray;
  url, JiBie: String;
  ss: TStringStream;
  stkCode: String;
  JsonStr, strtemp: String;
  DataLength: Integer;

  i, k: Integer;
  AStrings: TStringList;
  IdHTTP: TIdHTTP;
  JSONObject: TJSONObject;
  JSONArray: TJSONArray;
begin
  IdHTTP := TIdHTTP.Create();
  IdHTTP.ReadTimeout := 5000;
  IdHTTP.ConnectTimeout := 5000;
  ss := TStringStream.Create('');
  AStrings := TStringList.Create;
  AStrings.Clear;
  try
    begin
      // CriticalSection.Enter;
      ss.Clear;
      stkCode := stkCode.LowerCase(FStockObj.stkCode);
      JiBie := KLineJiBieDataStr[FStockObj.KLineMode];
      DataLength := FStockObj.KLineCount;
      pDAYS := @FStockObj.DAYS;

      url := 'http://money.finance.sina.com.cn/quotes_service/api/json_v2.php/CN_MarketData.getKLineData?symbol=' + stkCode + '&scale=' + JiBie + '&ma=no&datalen=' + IntToStr(DataLength);

      IdHTTP.Get(url, ss);

      JsonStr := trim(ss.DataString);
      if JsonStr = '' then
        Exit;

      JsonStr := StringReplace(JsonStr, 'day', '"day"', [rfReplaceAll, rfIgnoreCase]);
      JsonStr := StringReplace(JsonStr, 'open', '"open"', [rfReplaceAll, rfIgnoreCase]);
      JsonStr := StringReplace(JsonStr, 'high', '"high"', [rfReplaceAll, rfIgnoreCase]);
      JsonStr := StringReplace(JsonStr, 'low', '"low"', [rfReplaceAll, rfIgnoreCase]);
      JsonStr := StringReplace(JsonStr, 'close', '"close"', [rfReplaceAll, rfIgnoreCase]);
      JsonStr := StringReplace(JsonStr, 'volume', '"volume"', [rfReplaceAll, rfIgnoreCase]);
      JSONArray := TJSONObject.Create.ParseJSONValue(JsonStr, true) as TJSONArray;
      if JSONArray = nil then
        Exit;

      try
        SetLength(pDAYS^, JSONArray.Count);
        for i := 0 to JSONArray.Count - 1 do // JSONArray 0号元素是最老的数据
        // for I := JSONArray.Count - 1 downto 0 do //从最新的元素开始读取
        begin // DAYS[I] 0 号元素需要最新
          k := JSONArray.Count - 1 - i;
          JSONObject := JSONArray.Items[i] as TJSONObject;
          strtemp := JSONObject.GetValue('day').ToString;
          strtemp := StringReplace(strtemp, '"', '', [rfReplaceAll, rfIgnoreCase]);
          pDAYS^[k].DATE := DateTimeStrToMyLongWord(strtemp, 5);
          // dateTime := StrToDateTime1(strtemp);

          strtemp := JSONObject.GetValue('open').ToString;
          strtemp := StringReplace(strtemp, '"', '', [rfReplaceAll, rfIgnoreCase]);
          pDAYS^[k].Open := StrToFloat(strtemp);

          strtemp := JSONObject.GetValue('high').ToString;
          strtemp := StringReplace(strtemp, '"', '', [rfReplaceAll, rfIgnoreCase]);
          pDAYS^[k].High := StrToFloat(strtemp);

          strtemp := JSONObject.GetValue('low').ToString;
          strtemp := StringReplace(strtemp, '"', '', [rfReplaceAll, rfIgnoreCase]);
          pDAYS^[k].Low := StrToFloat(strtemp);

          strtemp := JSONObject.GetValue('close').ToString;
          strtemp := StringReplace(strtemp, '"', '', [rfReplaceAll, rfIgnoreCase]);
          pDAYS^[k].Close := StrToFloat(strtemp);

          strtemp := JSONObject.GetValue('volume').ToString;
          strtemp := StringReplace(strtemp, '"', '', [rfReplaceAll, rfIgnoreCase]);
          pDAYS^[k].volume := Trunc(StrToFloat(strtemp));
        end;
        // FStockObj.UpdateCZSC_ZSBWM();
      Except
        SetLength(pDAYS^, 0);
      end;

    end;

  finally
    AStrings.Free;
    ss.Free;
    JSONObject.Free;
    IdHTTP.Disconnect;
    IdHTTP.Free;
  end;

end;

end.

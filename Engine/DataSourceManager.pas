unit DataSourceManager;

interface

uses SysUtils, Classes, Windows,
  ExtCtrls, MATH, Messages, SyncObjs, System.Threading,
  System.json, GlobalConst, GlobalTypes, GlobalFunctions,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdHTTP, Stock,com.sina.WebServiceUtils;

type
  TDataSourceManager = class(TThread)
  private
    FStocks: TStringList;
    FMyThreadPool: TStringList;
    FThreadMaxWorkCount: Integer; // 正在工作的线程计数
    FThreadMinWorkCount: Integer; // 即将工作完成的线程计数

    FLastDAYSTick: LongWord;
    FFormHandle: HWND;
    FIdHTTP: TIdHTTP;
    FMaxDowndCount: Integer;

    procedure Execute; override; { 执行 }

    // procedure SendMyMesssage(p1, p2: LongWord);
    Destructor Destroy; override;
  protected
  public
    Constructor Create();
    procedure GetMarketInformation();
    Procedure doRunFThreadPool();
    function Exist(stkObj: TStockObject): boolean; OverLoad;
    function Exist(KLineMode: TKLineDateMode; stkObj: TStockObject): boolean; OverLoad;
    procedure AddStock(stkObj: TStockObject);
    procedure AddStocks(stkObjList: TStringList);
    procedure RemoveStock(stkObj: TStockObject);
    procedure RemoveStocks(stkObjList: TStringList);

    procedure ExecuteSinaWebService(stkObj: TStockObject);
    procedure ExecuteIfengWebService(stkObj: TStockObject);
    function GetIdHTTPConnection(): TIdHTTP;
    property FormHandle: HWND read FFormHandle write FFormHandle;
    property MaxDowndCount: Integer read FMaxDowndCount write FMaxDowndCount;

  end;

implementation

Constructor TDataSourceManager.Create();
begin
  inherited Create(true);
  FStocks := TStringList.Create;
  FLastDAYSTick := 0;
  MaxDowndCount := 100;
  FMyThreadPool := TStringList.Create;
  FThreadMaxWorkCount := 500;
  FThreadMinWorkCount := 5;
end;

Destructor TDataSourceManager.Destroy;
begin
  inherited;
  Self.Terminate;
  FMyThreadPool.Free;
end;

function TDataSourceManager.Exist(stkObj: TStockObject): boolean;
var
  sKey: String;
begin
  Result := False;
  sKey := stkObj.GetLevelKey;
  if FStocks.IndexOf(sKey) >= 0 then
  begin
    Result := true;
  end;
end;

function TDataSourceManager.Exist(KLineMode: TKLineDateMode; stkObj: TStockObject): boolean;
var
  sKey: String;
begin
  Result := False;
  sKey := stkObj.GetLevelKey(KLineMode);
  if FStocks.IndexOf(sKey) >= 0 then
  begin
    Result := true;
  end;
end;

procedure TDataSourceManager.AddStock(stkObj: TStockObject);
var
  sKey: String;
begin
  FCriticalSection.Enter;
  sKey := stkObj.GetLevelKey;
  if FStocks.IndexOf(sKey) < 0 then
  begin
    FStocks.BeginUpdate;
    FStocks.AddObject(sKey, stkObj);
    FStocks.EndUpdate;
  end;
  FCriticalSection.Leave;
end;

procedure TDataSourceManager.AddStocks(stkObjList: TStringList);
var
  sKey: String;
  i: Integer;
  stkObj: TStockObject;
begin
  FCriticalSection.Enter;
  for i := 0 to stkObjList.Count - 1 do
  begin
    FStocks.BeginUpdate;
    stkObj := TStockObject(stkObjList.Objects[i]);
    sKey := stkObj.GetLevelKey;
    if FStocks.IndexOf(sKey) < 0 then
    begin
      FStocks.AddObject(sKey, stkObj);
    end;
    FStocks.EndUpdate;
  end;
  FCriticalSection.Leave;
end;

procedure TDataSourceManager.RemoveStock(stkObj: TStockObject);
var
  sKey: String;
  i: Integer;
begin
  FCriticalSection.Enter;
  sKey := stkObj.GetLevelKey;
  i := FStocks.IndexOf(sKey);
  if i > 0 then
  begin
    FStocks.BeginUpdate;
    FStocks.Delete(i);
    FStocks.EndUpdate
  end;
  FCriticalSection.Leave;
end;

procedure TDataSourceManager.RemoveStocks(stkObjList: TStringList);
var
  sKey: String;
  i: Integer;
  stkObj: TStockObject;
begin
  FCriticalSection.Enter;
  for i := 0 to stkObjList.Count - 1 do
  begin
    stkObj := TStockObject(stkObjList.Objects[i]);
    sKey := stkObj.GetLevelKey;
    if FStocks.IndexOf(sKey) > 0 then
    begin
      FStocks.BeginUpdate;
      FStocks.Delete(i);
      FStocks.EndUpdate;
    end;
  end;
  FCriticalSection.Leave;
end;

procedure TDataSourceManager.Execute;
var
  i: Integer;
  stkObj: TStockObject;
  DataSourceWebServiceThread: TDataSourceWebServiceThread;
begin
  i := -1;
  while not Self.Terminated do
  begin
     INC(i);
     if i >= FStocks.Count then
      break;

    stkObj := TStockObject(FStocks.Objects[i]);
    if (stkObj.KLineMode <= KD_MIN60) then
    begin
      if (GetTickCount() - stkObj.WordTick) > 30000 then
      begin
        ExecuteSinaWebService(stkObj); // 新浪数据接口
        stkObj.WordTick := GetTickCount();
      end;
    end
    else if (stkObj.KLineMode = KD_DAY) then
    begin
      //if (GetTickCount() - stkObj.ThreadTick) > (60000 * 60) then
      begin
        FCriticalSection.Enter;
        DataSourceWebServiceThread := TDataSourceWebServiceThread.Create(FFormHandle, stkObj,FMaxDowndCount, FMyThreadPool);
        FMyThreadPool.AddObject(stkObj.GetLevelKey, DataSourceWebServiceThread);
        DataSourceWebServiceThread.Start;
        SendMessage(FFormHandle, WM_MYMESSAGE_THREAD, FMyThreadPool.Count, i);
        // stkObj.ThreadTick := GetTickCount();
        FCriticalSection.Leave;
      end;
    end
    else if (stkObj.KLineMode = KD_WEEK) then
    begin
      if (GetTickCount() - stkObj.WordTick) > (60000 * 60 * 4) then
      begin
        ExecuteIfengWebService(stkObj); // 凤凰数据接口
        stkObj.WordTick := GetTickCount();
      end;
    end
    else if (stkObj.KLineMode = KD_MONTH) then
    begin
      if (GetTickCount() - stkObj.WordTick) > (60000 * 60 * 4) then
      begin
        ExecuteIfengWebService(stkObj); // 凤凰数据接口
        stkObj.WordTick := GetTickCount();
      end;
    end;
  end;


end;

Procedure TDataSourceManager.doRunFThreadPool;
begin

end;

function TDataSourceManager.GetIdHTTPConnection(): TIdHTTP;
begin
  if FIdHTTP = nil then
  begin
    FIdHTTP := TIdHTTP.Create();
  end;
  FIdHTTP.ReadTimeout := 5000;
  FIdHTTP.ConnectTimeout := 5000;
  Result := FIdHTTP;
end;

procedure TDataSourceManager.ExecuteSinaWebService(stkObj: TStockObject);
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
  try
    begin
      // CriticalSection.Enter;
      ss := TStringStream.Create('');
      AStrings := TStringList.Create;
      AStrings.Clear;
      ss.Clear;
      stkCode := stkCode.LowerCase(stkObj.stkCode);
      JiBie := KLineJiBieDataStr[stkObj.KLineMode];
      DataLength := stkObj.KLineCount;
      pDAYS := @stkObj.DAYS;

      url := 'http://money.finance.sina.com.cn/quotes_service/api/json_v2.php/CN_MarketData.getKLineData?symbol='
        + stkCode + '&scale=' + JiBie + '&ma=no&datalen=' + IntToStr(DataLength);

      IdHTTP := TIdHTTP.Create();
      IdHTTP.ReadTimeout := 5000;
      IdHTTP.ConnectTimeout := 5000;
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
        //stkObj.UpdateZSBWM();
        //stkObj.OnAfterDataChanged(stkObj.KLineMode);
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

// 凤凰接口只能获取历史日线，没有实时数据
procedure TDataSourceManager.ExecuteIfengWebService(stkObj: TStockObject);
var
  pDAYS: PTStockDealInfoDynamicArray;
  url: String;
  ss: TStringStream;
  stkCode: String;
  JsonStr, strtemp: String;
  // JiBie: Integer;
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
      stkCode := stkCode.LowerCase(stkObj.stkCode);
      pDAYS := @stkObj.DAYS;
      if stkObj.KLineMode = KD_DAY then
        url := 'http://api.finance.ifeng.com/akdaily?code=' + stkCode + '&type=last'
      else if stkObj.KLineMode = KD_WEEK then
        url := 'http://api.finance.ifeng.com/akweekly?code=' + stkCode + '&type=last'
      else if stkObj.KLineMode = KD_MONTH then
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
          if (k > MaxDowndCount) then
            break;

          strtemp := StringReplace(AStrings.Strings[J], '"', '', [rfReplaceAll, rfIgnoreCase]);
          pDAYS^[k].DATE := DateTimeStrToMyLongWord(strtemp, 5);
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
        //stkObj.UpdateZSBWM();
        //stkObj.OnAfterDataChanged(stkObj.KLineMode);
        SendMessage(FFormHandle, WM_MYMESSAGE_THREAD_CONTENT, Integer(@stkObj.stkCode),
          Integer(@stkObj.StkName));
      Except
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

procedure TDataSourceManager.GetMarketInformation;
begin;
end;



end.

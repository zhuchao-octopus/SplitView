﻿unit GlobalFunctions;

interface

uses SysUtils, Classes, Windows, GlobalTypes, SyncObjs, ShlObj, GlobalConst,

  System.Variants, IdGlobal, unit200;

// 取的汉字拼音的首字母
function GetHzPy(const AHzStr: string): string;
Function KModeToJiBie(KLineDateMode: TKLineDateMode): integer;
function GetBeginTradeTime(KLineDateMode: TKLineDateMode): LongWord;
function DateTimeToMyLongWord(DateTime: TDateTime; JiBie: integer): LongWord;
function DateTimeStrToMyLongWord(DateTimeStr: String; JiBie: integer): LongWord;
function DateTimeStrToMyLongWord2(DateTimeStr: String; JiBie: integer): LongWord;
function MyLongWordToDateTimeStr(cDataTime: LongWord; JiBie: SmallInt): String;

function MyMinLongWordToMyDayLongWord(MinLW: LongWord): LongWord;

function NowDateTimeHHNNSSToStr(): String;
function StrToMyDateTime(DateTimeStr: String): TDateTime;
function StrToMyDate(DateTimeStr: String): TDate;

function GetSystemYMDStr(): string;
function GetSystemYMD(): Int64;
function GetSystemDateTime(): NTime;
function GetSystemDateTimeStr(): string;

function FormatVolume(value: Int64): String;
function FormatAmount(sg: Double): String;
function FormatLB(sg: Single): string;

function SingleToStr(sg: Double): String;
function StrToLongWord(value: String): LongWord;

function GetCountryTradeTime(): integer;
function GetWeek: string;
function GetWeek2: integer;
function GetWeek3(DataTime: String): String;
function IsWorkDay: Boolean;

function SearchInList(Key: string; SList: TStrings; DList: TStrings): integer;

function GetNowTimeNN(): integer;
function GetNowTimeSS(): integer;
function GetSpecialFolderDir(const folderid: integer): string;
function GetCFGDir(DirName: String): String;

Function GetUpperLevel(KLineDateMode: TKLineDateMode): TKLineDateMode;
Function GetLowerLevel(KLineDateMode: TKLineDateMode): TKLineDateMode;
procedure GetBuildInfo(FileName: string; var vs: string);
function BytestoHexString(ABytes: array of Byte; len: integer): AnsiString;
function IdBytesToAnsiString(ParamBytes: TIdBytes): AnsiString;

function HexStrToBuff(hs: string): TIdBytes;
function StrToBuff(s: String; buff: array of Byte): integer;
function UnicodeToChinese(inputstr: string): string;
function ChineseToUniCode(sStr: string): string;

implementation

function ChineseToUniCode(sStr: string): string;
// 汉字的 UniCode 编码范围是: $4E00..$9FA5
var
  w: Word;
  hz: WideString;
  i: integer;
  s: string;
begin
  hz := sStr;
  for i := 1 to Length(hz) do
  begin
    w := Ord(hz[i]);
    s := IntToHex(w, 4);
    Result := Result + '\u' + LowerCase(s);
  end;
end;

function UnicodeToChinese(inputstr: string): string;
var
  i: integer;
  index: integer;
  temp, top, last: string;
begin
  index := 1;
  while index >= 0 do
  begin
    index := inputstr.IndexOf('\u');
    if index < 0 then
    begin
      last := inputstr;
      Result := Result + last;
      Exit;
    end;
    top := Copy(inputstr, 1, index); // 取出 编码字符前的 非 unic 编码的字符，如数字
    temp := Copy(inputstr, index + 1, 6); // 取出编码，包括 \u    ,如\u4e3f
    Delete(temp, 1, 2);
    Delete(inputstr, 1, index + 6);
    Result := Result + top + WideChar(StrToInt('$' + temp));
  end;
end;

function StrToBuff(s: String; buff: array of Byte): integer;
var
  P: PChar;
  // B:array of Byte;
begin
  // SetLength(buff, Length(s) + 1);
  P := PChar(s);
  CopyMemory(@buff, P, Length(s) + 1);
  Result := Length(buff);
end;

function HexStrToBuff(hs: string): TIdBytes;
var
  i, len, bLen: Word;
  buf: TIdBytes;
begin
  len := (Length(hs) + 2) div 3;
  SetLength(buf, len);
  bLen := Length(buf);
  ZeroMemory(@buf, bLen);

  for i := 1 to len do
  begin
    buf[i - 1] := CharToByte(hs[i * 3 - 2], hs[i * 3 - 1]);
  end;
  Result := buf;
end;

function IdBytesToAnsiString(ParamBytes: TIdBytes): AnsiString;
var
  i: integer;
  s: AnsiString;
begin
  s := '';
  for i := 0 to Length(ParamBytes) - 1 do
  begin
    s := s + AnsiChar(ParamBytes[i]);
  end;
  Result := s;
end;

function BytestoHexString(ABytes: array of Byte; len: integer): AnsiString;
begin
  SetLength(Result, len * 2);
  BinToHex(@ABytes[0], PAnsiChar(Result), len);
end;

procedure GetBuildInfo(FileName: string; var vs: string);
var
  VerInfoSize, VerValueSize, Dummy: DWORD;
  VerInfo: Pointer;
  VerValue: PVSFixedFileInfo;
  V1, V2, V3, V4: Word;
begin
  vs := '';
  if not FileExists(FileName) then
    Exit;
  VerInfoSize := GetFileVersionInfoSize(PChar(FileName), Dummy);
  if VerInfoSize = 0 then
    Exit;
  GetMem(VerInfo, VerInfoSize);
  if not GetFileVersionInfo(PChar(FileName), 0, VerInfoSize, VerInfo) then
    Exit;
  VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
  with VerValue^ do
  begin
    V1 := dwFileVersionMS shr 16;
    V2 := dwFileVersionMS and $FFFF;
    V3 := dwFileVersionLS shr 16;
    V4 := dwFileVersionLS and $FFFF;
    vs := inttostr(V1) + '.' + inttostr(V2) + '.' + inttostr(V3) + '.' + inttostr(V4);
  end;
  FreeMem(VerInfo, VerInfoSize);
end;

function GetHzPy(const AHzStr: string): string;
const
  ChinaCode: array [0 .. 25, 0 .. 1] of integer = ((1601, 1636), (1637, 1832), (1833, 2077), (2078, 2273), (2274, 2301), (2302, 2432), (2433, 2593), (2594, 2786), (9999, 0000), (2787, 3105),
    (3106, 3211), (3212, 3471), (3472, 3634), (3635, 3722), (3723, 3729), (3730, 3857), (3858, 4026), (4027, 4085), (4086, 4389), (4390, 4557), (9999, 0000), (9999, 0000), (4558, 4683), (4684, 4924),
    (4925, 5248), (5249, 5589));
var
  i, j, HzOrd: integer;
begin
  i := 1;
  while i <= Length(AHzStr) do
  begin
    if (AHzStr[i] >= #160) and (AHzStr[i + 1] >= #160) then
    begin
      HzOrd := (Ord(AHzStr[i]) - 160) * 100 + Ord(AHzStr[i + 1]) - 160;
      for j := 0 to 25 do
      begin
        if (HzOrd >= ChinaCode[j][0]) and (HzOrd <= ChinaCode[j][1]) then
        begin
          Result := Result + char(Byte('A') + j);
          break;
        end;
      end;
      Inc(i);
    end
    else
    begin
      Result := Result + AHzStr[i];
    end;
    Inc(i);
  end;
end;

function GetWindowsVersion: string;
var
  Info: OSVERSIONINFO;
begin
  FillChar(Info, sizeof(Info), 0);
  Info.dwOSVersionInfoSize := sizeof(OSVERSIONINFO);
  GetVersionEx(Info);
end;

function StrToMyDate(DateTimeStr: String): TDate;
Var
  MySettings: TFormatSettings;
begin
  MySettings.ShortDateFormat := 'yyyymmdd';
  MySettings.DateSeparator := '-';
  Result := StrToDate(DateTimeStr, MySettings);
end;

function StrToMyDateTime(DateTimeStr: String): TDateTime;
Var
  MySettings: TFormatSettings;
begin
  // MySettings.ShortDateFormat := 'yyyy-MM-dd';
  // MySettings.ShortDateFormat := 'yyyymmdd';
  // MySettings.DateSeparator := '-';
  // MySettings.ShortTimeFormat := 'hhnnss';
  // MySettings.TimeSeparator := ':';
  MySettings.LongDateFormat := 'yyyy-MM-dd';
  MySettings.ShortDateFormat := 'yyyy-MM-dd';
  MySettings.LongTimeFormat := 'hh:mm:ss';
  MySettings.ShortTimeFormat := 'hh:mm:ss';
  MySettings.DateSeparator := '-';
  MySettings.timeSeparator := ':';

  Result := StrToDateTime(DateTimeStr, MySettings);
end;

function GetNowTimeString(): String;
begin
  Result := '时间:' + FormatDateTime('hh:nn', Now);
end;

function GetNowTimeNN(): integer;
var
  nn: String;
begin
  nn := FormatDateTime('nn', Now);
  Result := StrToInt(nn);
end;

function GetNowTimeSS(): integer;
var
  ss: String;
begin
  ss := FormatDateTime('ss', Now);
  Result := StrToInt(ss);
end;

function GetTime_part(DateTime: TDateTime; partstr: String): integer;
var
  ss: String;
begin
  ss := FormatDateTime(partstr, DateTime);
  Result := StrToInt(ss);
end;

function GetBlockID(JiBie: integer): integer;
begin
  Result := -1;
  case JiBie of
    5:
      Result := 0;
    15:
      Result := 1;
    30:
      Result := 2;
    60:
      Result := 3;
  else
    Exit;
  end;
end;

function NowDateTimeHHNNSSToStr: String;
begin
  Result := FormatDateTime('hh:nn:ss', Now);
end;

function DateTimeToMyLongWord(DateTime: TDateTime; JiBie: integer): LongWord;
var
  // temp: word;
  yyyy, MM, dd, hh, nn, ss: String;
begin
  // 53431384十进制//032f4c58十六进制//文件存储格式584c2f03//信息20131112 13:35
  // 0000 0011 0010 1111 [01001] [10001] 011000
  // 年  月    日     时      分
  Result := 0;
  yyyy := FormatDateTime('yyyy', DateTime);
  MM := FormatDateTime('MM', DateTime);
  dd := FormatDateTime('dd', DateTime);
  hh := FormatDateTime('hh', DateTime);
  nn := FormatDateTime('nn', DateTime);
  ss := FormatDateTime('ss', DateTime);
  if JiBie > 120 then
  begin
    // temp := StrToInt(yyyy); // - 2008;
    Result := StrToInt(yyyy) shl 20; // =temp * 2048;
    Result := Result + StrToInt(MM) shl 16;
    Result := Result + StrToInt(dd) shl 11;
    // Result := Result + StrToInt(hh) shl 6;
    // Result := Result + StrToInt(nn);
  end
  else
  begin
    // temp := StrToInt(yyyy); // - 2008;
    Result := StrToInt(yyyy) shl 20; // =temp * 2048;
    Result := Result + StrToInt(MM) shl 16;
    Result := Result + StrToInt(dd) shl 11;
    Result := Result + StrToInt(hh) shl 6;
    Result := Result + StrToInt(nn);
  end;
end;

function MyLongWordToDateTimeStr(cDataTime: LongWord; JiBie: SmallInt): string;
var
  wYear, wMon, wDay, wHour, wMin: Word;
begin
  Result := '';
  if JiBie > 120 then
  begin
    wYear := (cDataTime shr 20 and $00000FFF);
    wMon := cDataTime shr 16 and $0000000F;
    wDay := cDataTime shr 11 and $0000001F;
    Result := Format('%d-%.02d-%.02d', [wYear, wMon, wDay]);
  end
  else
  begin
    wYear := (cDataTime shr 20 and $00000FFF);
    wMon := cDataTime shr 16 and $0000000F;
    wDay := cDataTime shr 11 and $0000001F;
    wHour := ((cDataTime shr 6) and $0000001F);
    wMin := cDataTime and $0000003F;
    Result := Format('%0.2d-%0.2d-%0.2d %.02d:%.02d', [wYear, wMon, wDay, wHour, wMin])
  end;
end;

function DateTimeStrToMyLongWord(DateTimeStr: String; JiBie: integer): LongWord;
begin
  Result := DateTimeToMyLongWord(StrToMyDateTime(DateTimeStr), JiBie);
end;

function MyMinLongWordToMyDayLongWord(MinLW: LongWord): LongWord;
begin
  Result := MinLW and $FFFFF800;
end;

// showapi 接口用，作废
function DateTimeStrToMyLongWord2(DateTimeStr: String; JiBie: integer): LongWord;
Var
  DateTime: TDateTime;
  s: String;
begin
  // DateTime:=VarToDateTime(DateTimeStr);
  if (JiBie <= 60) then
  begin
    s := Copy(DateTimeStr, 1, 4) + '-' + Copy(DateTimeStr, 5, 2) + '-' + Copy(DateTimeStr, 7, 2) + ' ' + Copy(DateTimeStr, 9, 2) + ':' + Copy(DateTimeStr, 11, 2);
  end
  else
  begin
    s := Copy(DateTimeStr, 1, 4) + '-' + Copy(DateTimeStr, 5, 2) + '-' + Copy(DateTimeStr, 7, 2);
  end;
  DateTime := StrToMyDateTime(s);
  Result := DateTimeToMyLongWord(DateTime, JiBie);
end;

function CardinalToTime(cDataTime: Cardinal): string;
var
  wYear, wMon, wDay, wHour, wMin: Word;
begin
  Result := '';

  wYear := (cDataTime shr 12 and $0000000F) { + 2008 } + (cDataTime shr 11 and $00000001);
  // wYear := cDataTime shr 12 and $0000000F + 2008;
  wMon := cDataTime and $000007FF div 100;
  wDay := cDataTime and $000007FF mod 100;
  wHour := ((cDataTime shr 16) and $0000FFFF) div 60;
  wMin := (cDataTime shr 16) mod 60;
  Result := Format('%.02d:%.02d', [wHour, wMin])
end;

function GetBeginTradeTime(KLineDateMode: TKLineDateMode): LongWord;
var
  // temp: word;
  yyyy, MM, dd, hh, nn, ss: String;
begin
  yyyy := FormatDateTime('yyyy', Now);
  MM := FormatDateTime('MM', Now);
  dd := FormatDateTime('dd', Now);
  hh := FormatDateTime('hh', Now);
  nn := FormatDateTime('nn', Now);
  ss := yyyy + '-' + MM + '-' + dd + ' ';
  Result := 0;
  case KLineDateMode of
    KD_MIN:
      begin
        Result := DateTimeStrToMyLongWord(ss + '09:30', KModeToJiBie(KLineDateMode));
      end;
    KD_MIN5:
      begin
        Result := DateTimeStrToMyLongWord(ss + '09:35', KModeToJiBie(KLineDateMode));
      end;
    KD_MIN10:
      begin
        Result := DateTimeStrToMyLongWord(ss + '09:40', KModeToJiBie(KLineDateMode));
      end;
    KD_MIN15:
      begin
        Result := DateTimeStrToMyLongWord(ss + '09:45', KModeToJiBie(KLineDateMode));
      end;
    KD_MIN30:
      begin
        Result := DateTimeStrToMyLongWord(ss + '10:00', KModeToJiBie(KLineDateMode));
      end;
    KD_MIN60:
      begin
        Result := DateTimeStrToMyLongWord(ss + '10:30', KModeToJiBie(KLineDateMode));
      end;
    KD_MIN120:
      begin
        Result := DateTimeStrToMyLongWord(ss + '11:30', KModeToJiBie(KLineDateMode));
      end;
    KD_DAY, KD_WEEK, KD_MONTH, KD_DAY45, KD_DAY120, KD_YEAR:
      begin
        Result := DateTimeStrToMyLongWord(ss, KModeToJiBie(KLineDateMode));
      end;
  end;
end;

Function KModeToJiBie(KLineDateMode: TKLineDateMode): integer;
begin
  Result := 0;
  case KLineDateMode of
    KD_MIN:
      begin
        Result := 1;
      end;
    KD_MIN5:
      begin
        Result := 5;
      end;
    KD_MIN10:
      begin
        Result := 10;
      end;
    KD_MIN15:
      begin
        Result := 15;
      end;
    KD_MIN30:
      begin
        Result := 30;
      end;
    KD_MIN60:
      begin
        Result := 60;
      end;
    KD_MIN120:
      begin
        Result := 120;
      end;
    KD_DAY:
      begin
        Result := 240;
      end;
    KD_WEEK:
      begin
        Result := 240 * 5;
      end;
    KD_MONTH:
      begin
        Result := 240 * 20;
      end;
    KD_DAY45:
      begin
        Result := 240 * 45;
      end;
    KD_DAY120:
      begin
        Result := 240 * 120;
      end;
    KD_YEAR:
      begin
        Result := 240 * 240;
      end;
  else
    Result := 0;
  end;
end;

Function GetLowerLevel(KLineDateMode: TKLineDateMode): TKLineDateMode;
begin
  Result := KLineDateMode;
  case KLineDateMode of
    KD_MIN:
      begin
        Result := KD_MIN;
      end;
    KD_MIN5:
      begin
        Result := KD_MIN5;
      end;
    KD_MIN10:
      begin
        Result := KD_MIN5;
      end;
    KD_MIN15:
      begin
        Result := KD_MIN10;
      end;
    KD_MIN30:
      begin
        Result := KD_MIN15;
      end;
    KD_MIN60:
      begin
        Result := KD_MIN30;
      end;
    KD_MIN120:
      begin
        Result := KD_MIN60;
      end;
  else
    ; // Result := KD_MIN;
  end;
end;

Function GetUpperLevel(KLineDateMode: TKLineDateMode): TKLineDateMode;
begin
  Result := KLineDateMode;
  case KLineDateMode of
    KD_MIN:
      begin
        Result := KD_MIN5;
      end;
    KD_MIN5:
      begin
        Result := KD_MIN10;
      end;
    KD_MIN10:
      begin
        Result := KD_MIN15;
      end;
    KD_MIN15:
      begin
        Result := KD_MIN30;
      end;
    KD_MIN30:
      begin
        Result := KD_MIN60;
      end;
    KD_MIN60:
      begin
        Result := KD_MIN120;
      end;
    KD_MIN120:
      begin
        Result := KD_DAY;
      end;
    KD_DAY:
      begin
        Result := KD_WEEK;
      end;
    KD_WEEK:
      begin
        Result := KD_MONTH;
      end;
  else

  end;
end;

function FormatVolume(value: Int64): string; // 股
begin
  if value >= 10000000 then
    Result := Format('%.2f亿', [value / (100000000)])
    // else if value >= 100000 then
    // Result := Format('%.01f万', [value / 10000])
  else
    Result := Format('%.2f万', [value / 10000])
end;

function FormatAmount(sg: Double): string;
begin
  if sg > 10000000 then
    Result := Format('%.2f亿', [sg / (100000000)])
  else
    Result := Format('%.2f万', [sg / (10000)]);
end;

function SingleToStr(sg: Double): string;
begin
  Result := Format(STRING_SINGLEFORMAT, [sg]);
end;

function StrToLongWord(value: String): LongWord;
begin
  Result := Trunc(StrToFloat(value));
end;

function FormatLB(sg: Single): string;
begin
  Result := Format('%f', [sg]);
end;

function GetSystemDateTimeStr(): string;
var
  lpSystemTime: _SYSTEMTIME;
begin
  Result := '';
  // Getsystemtime(lpSystemTime);
  GetLocalTime(lpSystemTime);
  // Result:=Format('[%0.4d\%0.2d\%0.2d\%0.2d:%0.2d:%0.2d] ',[lpSystemTime.wYear,lpSystemTime.wMonth,lpSystemTime.wDay,lpSystemTime.wHour,lpSystemTime.wMinute,lpSystemTime.wSecond]);
  Result := Format('[%0.4d-%0.2d-%0.2d %0.2d:%0.2d:%0.2d]', [lpSystemTime.wYear, lpSystemTime.wMonth, lpSystemTime.wDay, lpSystemTime.wHour, lpSystemTime.wMinute, lpSystemTime.wSecond]);

end;

function GetSystemDateTime(): NTime;
var
  lpSystemTime: _SYSTEMTIME;
begin
  // Result := '';
  // Getsystemtime(lpSystemTime);
  GetLocalTime(lpSystemTime);
  // Result:=Format('[%0.4d\%0.2d\%0.2d\%0.2d:%0.2d:%0.2d] ',[lpSystemTime.wYear,lpSystemTime.wMonth,lpSystemTime.wDay,lpSystemTime.wHour,lpSystemTime.wMinute,lpSystemTime.wSecond]);
  { Result := Format('[%0.4d\%0.2d\%0.2d\%0.2d:%0.2d:%0.2d] ',
    [lpSystemTime.wYear,
    lpSystemTime.wMonth,
    lpSystemTime.wDay,
    lpSystemTime.wHour,
    lpSystemTime.wMinute,
    lpSystemTime.wSecond]
    ); }
  Result.year := lpSystemTime.wYear;
  Result.month := lpSystemTime.wMonth;
  Result.day := lpSystemTime.wDay;
  Result.hour := lpSystemTime.wHour;
  Result.minute := lpSystemTime.wMinute;
  Result.second := lpSystemTime.wSecond;
end;

function GetSystemYMDStr(): string;
var
  lpSystemTime: _SYSTEMTIME;
begin
  Result := '';
  // Getsystemtime(lpSystemTime);
  GetLocalTime(lpSystemTime);
  // Result:=Format('[%0.4d\%0.2d\%0.2d\%0.2d:%0.2d:%0.2d] ',[lpSystemTime.wYear,lpSystemTime.wMonth,lpSystemTime.wDay,lpSystemTime.wHour,lpSystemTime.wMinute,lpSystemTime.wSecond]);
  Result := Format('%0.4d%0.2d%0.2d', [lpSystemTime.wYear, lpSystemTime.wMonth, lpSystemTime.wDay]);

end;

function GetSystemYMD(): Int64;
var
  lpSystemTime: _SYSTEMTIME;
  Str: string;
begin
  Result := 2013116;
  GetLocalTime(lpSystemTime);
  Str := Format('%0.4d%0.2d%0.2d', [lpSystemTime.wYear, lpSystemTime.wMonth, lpSystemTime.wDay]);
  Result := StrToInt(Str);
end;

function GetCountryTradeTime(): integer;
var
  yyyy, MM, dd, hh, nn, ss: String;
begin
  // d0 := Now();
  Result := -1;
  yyyy := FormatDateTime('yyyy', Now);
  MM := FormatDateTime('MM', Now);
  dd := FormatDateTime('dd', Now);
  hh := FormatDateTime('hh', Now);
  nn := FormatDateTime('nn', Now);
  ss := FormatDateTime('ss', Now);
  if (StrToInt(hh) >= 9) and (StrToInt(hh) < 12) then // 9:30
  begin
    if (StrToInt(hh) = 9) and (StrToInt(nn) >= 30) then
    begin
      Result := 0; // 上午
    end
    else if (StrToInt(hh) = 10) then
    begin
      Result := 0; // 上午
    end
    else if (StrToInt(hh) = 11) and (StrToInt(nn) <= 30) then
    begin
      Result := 0; // 上午
    end;
  end;

  if (StrToInt(hh) >= 13) and (StrToInt(hh) < 15) then // 13:
  begin
    Result := 1; // 下午
  end;

end;

function GetWeek: string;
var
  date: SYSTEMTIME;
begin
  GetLocalTime(date);
  case date.wDayOfWeek of
    0:
      Result := '星期天';
    1:
      Result := '星期一';
    2:
      Result := '星期二';
    3:
      Result := '星期三';
    4:
      Result := '星期四';
    5:
      Result := '星期五';
    6:
      Result := '星期六';
  end;
end;

function GetWeek2: integer;
var
  date: SYSTEMTIME;
begin
  GetLocalTime(date);
  Result := date.wDayOfWeek;
end;

function GetWeek3(DataTime: String): String;
var
  // date: SYSTEMTIME;
  DateTime: TDateTime;
begin
  // GetLocalTime(date);
  // DayOfWeek();
  Result := '';
  try
    // if TryStrToDate(DataTime, DateTime) then
    begin
      DateTime := StrToMyDateTime(DataTime);
      case DayOfWeek(DateTime) of
        0, 1:
          Result := '';
        2:
          Result := '一';
        3:
          Result := '二';
        4:
          Result := '三';
        5:
          Result := '四';
        6:
          Result := '五';
        7:
          Result := '六';
        8:
          Result := '日';
      else
        Result := ' ';
      end;
    end;
    Result := '星期' + Result;
    // DateTimeToSystemTime(DateTime, date);
  except
    Exit;
  end;
end;

function IsWorkDay: Boolean;
var
  t: integer;
begin
  t := GetWeek2;
  if (t >= 1) and (t <= 5) then
    Result := True
  else
    Result := False;
end;

function SearchInList(Key: string; SList: TStrings; DList: TStrings): integer;
var
  i: integer;
begin
  Result := 0;
  if Key = '' then
    Exit;
  for i := 0 to SList.Count - 1 do
  begin
    if (Pos(Key, SList.Strings[i]) > 0) then
    begin
      DList.AddObject(SList.Strings[i], DList.Objects[i]);
    end;
  end;
  Result := DList.Count;
end;

function GetCFGDir(DirName: String): String;
begin
  Result := GetSpecialFolderDir(35) + '\' + DirName + '\';
end;

function GetSpecialFolderDir(const folderid: integer): string;
var
  PIDL: PItemIDList; // pItemIDList;     // LPCITEMIDLIST
  buffer: array [0 .. 255] of char;
begin
  // 取指定的文件夹项目表
  SHGetSpecialFolderLocation(0, folderid, PIDL);
  SHGetPathFromIDList(PIDL, buffer); // 转换成文件系统的路径
  Result := strpas(buffer);
end;

end.

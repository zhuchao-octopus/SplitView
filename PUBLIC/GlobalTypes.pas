unit GlobalTypes;

interface

uses SysUtils, Classes, Windows, Messages, Graphics;


type
  TDeviceType = (DT_UNKNOW, DT_ENCODE, DT_DECODE, DT_IPC, DT_MIC, DT_SOUND, TD_RECORD, TD_CONTROL, TD_KVM);

  TKLineDateMode = (KD_MIN, KD_MIN5, KD_MIN10, KD_MIN15, KD_MIN30, KD_MIN60, KD_MIN120, KD_DAY, KD_WEEK, KD_MONTH, KD_DAY45, KD_DAY120, KD_YEAR, KD_);

  TTDX_MSG = record
    MsgID: integer;
    Code: array [0 .. 1023] of char; // 获取盘口数据时，有可能是多个股票的代码字符串
    Name: array [0 .. 1023] of char;
    Market: integer;
    Date: TDateTime;
    P1, P2, P3: integer;
  end;

  pTTDX_MSG = ^TTDX_MSG;

  // PTTDX_STOCKINFO = ^TTDX_STOCKINFO;
  TTDX_STOCKINFO = packed record // 初始化数据 29字节
    Code: array [0 .. 5] of char;
    rate: word; // 实时盘口中的成交量除去的除数？1手=n股？
    Name: array [0 .. 7] of char; // 4个汉字
    W1, W2: word;
    PriceMag: byte; // 价格转换模式 10的n次方
    YClose: single;
    W3, W4: word;
  end;

  PTTDX_STOCKINFO = ^TTDX_STOCKINFO;

  TF10Data = record // F10数据
    Title: array [0 .. 31] of char;
    tmp1: array [0 .. 31] of byte;
    FilePath: array [0 .. 9] of char; // $40
    tmp2: array [0 .. 5] of byte;
    tmp3: array [0 .. $3F] of byte;
    Offset: integer; // $90
    length: integer; // $94
  end;

  TF10Rcd = record
    Data: TF10Data;
    index: integer;
  end;

  TMACDLiDu = record
    LiDuU: single;
    LiDuD: single;
  end;

  PTF10Rcd = ^TF10Rcd;

  _PK = packed record
    YClose: single; // 昨收盘价
    Open: single; // 开盘价
    High: single;
    Low: single;
    Close: single; // 现价
    B1: single;
    S1: single;
    Volume: INT64; // 成交量
    Amount: Double; // 金额
    Buyp: array [0 .. 4] of single; // 五个叫买价    $3C+8
    Buyv: array [0 .. 4] of LongWord; // 对应五个叫买价的五个买盘   $50+8
    Sellp: array [0 .. 4] of single; // 五个叫卖价
    Sellv: array [0 .. 4] of LongWord; // 对应五个叫卖价的五个卖盘
    Date: LongWord;
    Time: LongWord;
    DateTime: LongWord;
  end;

  TTDX_PK_ADD = packed record
    tmp9E: byte;
    tmp9F: single;
    tmpA3, tmpA7, tmpAB: single;
    tmpAF: word;
  end;

  // 盘口数据
  // pTTDX_PKDAT = ^TTDX_PKDAT;     //size=
  TTDX_PKBASE = packed record
    // MarketMode: byte; // 市场
    // Code: array [0 .. 5] of char;
    // tmp7: byte;
    DealCount: word; // 成交笔数
    tmpA: word;
    YClose: single; // 昨收盘价
    Open: single; // 开盘价
    High: single;
    Low: single;
    Close: single; // 现价
    // LastDealTime: longword;
    // tmp24: single;
    Volume: LongWord; // 成交量
    // LastVolume: longword; // 最后一笔单子成交量
    Amount: single; // 金额
    Inside, OutSide: LongWord;
    // tmp3C: single;
    // tmp40: single; // 市赢率？
    Buyp: array [1 .. 5] of single; // 五个叫买价    $3C+8
    Buyv: array [1 .. 5] of LongWord; // 对应五个叫买价的五个买盘   $50+8
    Sellp: array [1 .. 5] of single; // 五个叫卖价
    Sellv: array [1 .. 5] of LongWord; // 对应五个叫卖价的五个卖盘
    // tmp94: word;
    // tmp96: longword;
    // tmp9A: longword;
    // DatEx   :TTDX_PK_ADD;
  end;

  PTTDX_PKBASE = ^TTDX_PKBASE;

  TTDX_PKDAT = packed record
    D: TTDX_PKBASE;
    DEx: TTDX_PK_ADD;
  end;

  PTTDX_PKDAT = ^TTDX_PKDAT;

  TTDX_REALPK_ADD = packed record
    tmp9E: array [1 .. 5] of LongWord;
    tmpB2: array [1 .. 5] of LongWord;
    tmpC6: array [1 .. 5] of single;
    tmpDA: array [1 .. 5] of LongWord;
  end;

  // 实时盘口数据
  TTDX_REALPKDAT = packed record
    PK: TTDX_PKBASE;
    DatEx: TTDX_REALPK_ADD;
    tmpEE, tmpF2: single;
    tmpF6, tmpFA: LongWord;
  end;

  // 期货
  TTDX_FUTURES_PK = packed record // Size=$12C
    Code: array [0 .. 7] of char; // 代码
    tmp8: word;
    tmpA: LongWord;
    YClose, // 昨收盘价
    Open, // 开盘价
    High, // 最高价
    Low, // 最低价
    Close: single; // 当前价
    Inside: LongWord; // 开仓
    OutSide: LongWord;
    Volume: LongWord; // 总量 $2A
    tmp2E: LongWord; // =1
    Amount: single; // 金额
    tmp36: LongWord;
    tmp3A: LongWord;
    tmp3E: LongWord; // =0
    ChiCang: LongWord; // 持仓
    Buyp: array [1 .. 5] of single; // 五个叫买价
    Buyv: array [1 .. 5] of LongWord; // 对应五个叫买价的五个买盘
    Sellp: array [1 .. 5] of single; // 五个叫卖价
    Sellv: array [1 .. 5] of LongWord; // 对应五个叫卖价的五个卖盘

    { tmp96, tmp9A, tmp9E, tmpA2,
      tmpA6, tmpAA, tmpAE, tmpB2 :longword;
      tmpB6, tmpBA, tmpBE, tmpC2,
      tmpC6, tmpCA, tmpCE, tmpD2, tmpD6, tmpDA, tmpDE, tmpE2,
      tmpE6, tmpEA, tmpEE, tmpF2, tmpF6, tmpFA, tmpFE, tmp102,
      tmp106, tmp10A, tmp10E, tmp112, tmp116, tmp11A, tmp11E, tmp122,
      tmp126 :longword;
      tmp12A :word; }
    tmp96: array [0 .. $12C - $96 - 1] of byte;

  end;

  PTTDX_FUTURES_PK = ^TTDX_FUTURES_PK;

  TTDX_Futures_DAYInfo = packed record // size=$20
    DAY: LongWord; // 20100920格式
    Open, High, Low, Close: single; // 开盘 最高 最低 收盘
    ChiCang: LongWord; // 持仓
    Volume: LongWord; // 成交
    settlement: single; // 结算
  end;

  PTTDX_Futures_DAYInfo = ^TTDX_Futures_DAYInfo;

  /// ///////////////////////////////////////////////////////////////////////////////////////
  ///
  // 日K线数据
  TTDX_DAYInfo = packed record
    DAY: LongWord; // 在代码中为tmp1C //4
    Open: single; // 开盘 4
    High: single; // 最高4
    Low: single; // 最低 4
    Close: single; // 收 4
    Amount: Double; // 金额 4
    Volume: INT64; // 成交量 4
    // UpCount: word; // 2
    // DownCount: word; // 2
  end;

  PTTDX_DAYInfo = ^TTDX_DAYInfo;

  TStockDealInfo = packed record // 32
    Date: LongWord; // 日期 4
    Open: single; // 开盘 4
    High: single; // 最高 4
    Low: single; // 最低 4
    Close: single; // 收盘 4
    Amount: Double; // 金额 8
    Volume: INT64; // 成交量 8
    // UpCount: word; // 2
    // DownCount: word; // 2
  end;

  PTStockDealInfo = ^TStockDealInfo;

  // 以下结构专为日线
  { TStockDealInfo2 = packed record // 日线数据是浮点型X100后作为整型存储
    Date: longword; // 在代码中为tmp1C //4
    Open: integer; // 开盘 4
    High: integer; // 最高4
    Low: integer; // 最低 4
    Close: integer; // 收 4
    Amount: single; // 金额 4
    Volume: longword; // 成交量 4
    UpCount: word; // 2
    DownCount: word; // 2
    end; }
  // PTStockDealInfo2 = ^TStockDealInfo2;

  // 分笔历史成交数据
  TTDX_DEALInfo = packed record
    Min: word; // h *60 + Min
    value: LongWord; // 价格*1000
    Volume: LongWord; // 成交量
    DealCount: integer; // 成交笔数
    SellOrBuy: word; // Sell=1 buy=0
  end;

  PTTDX_DEALInfo = ^TTDX_DEALInfo;

  TTDX_Futures_DEALInfo = packed record
    Min: word; // h *60 + Min
    value: LongWord; // 价格*1000
    Volume: LongWord; // 现量
    DealCount: integer; // 增仓
    DealType: word; //
  end;

  PTTDX_Futures_DEALInfo = ^TTDX_Futures_DEALInfo;

  TTDX_MIN = packed record // size=$1A 分时图
    Min: word;
    Close: single;
    Arg: single; // 均价
    Volume: integer; // 成交量
    tmpE: LongWord;
    tmp12: LongWord;
    tmp16: single;
  end;

  PTTDX_MIN = ^TTDX_MIN;

  TTDX_FUTURES_MIN = packed record // Size=$1A
    Min: word;
    Close: single;
    Arg: single; // 均价
    Volume: integer; // 成交量
    tmpE: LongWord;
    tmp12: LongWord;
    ChiCang: LongWord;
  end;

  PTTDX_FUTURES_MIN = ^TTDX_FUTURES_MIN;

  TCallBackStockInfo = packed record // 回调数据触发函数时提供信息
    Code: array [0 .. 5] of char;
    Name: array [0 .. 7] of char;
    Market: word;
  end;

  // ========================== Dll 模式使用
  TTdxDllShareData = packed record
    stockinfo: TCallBackStockInfo;
    start: integer;
    count: integer;
    buf: array [0 .. 256 * 256 - 1] of char;
  end;

  PTTdxDllShareData = ^TTdxDllShareData;

  TWM_TDX_DEPACKDATA = record
    Msg: Cardinal;
    TDX_MSG: longint;
    Data: PTTdxDllShareData;
    Result: longint;
  end;

  TWM_TDX_NOTIFYEVENT = record
    Msg: Cardinal;
    EventCode: longint;
    TDXManager: longint;
    Result: longint;
  end;

  TTdxDataHeader = packed record
    CheckSum: LongWord; //
    EncodeMode: byte;
    tmp: array [0 .. 4] of byte;
    MsgID: word; // 消息代码
    Size: word; // 本次读取的数据包长度
    DePackSize: word; // 解压后的大小
  end;

  TTdxSendHeader = packed record
    CheckSum: byte; // $0C
    tmp: array [0 .. 4] of byte;
    Size: word;
    Size2: word;
    // ..下面2个字节就是发送的消息ID
  end;

  TTdxData = record
    Len: word;
    buf: array [0 .. 256 * 256 + SizeOf(TTdxDataHeader) - 1] of char;
  end;

  pTTdxData = ^TTdxData;

  TTdxDepackData = record
    Head: TTdxDataHeader;
    buf: array [0 .. 256 * 256 - 1] of char;
  end;

  /// ////////////////////////////////////////////////////////////////////////////////////
  /// 分型结构
  T3KFENXING = packed record
    FXType: Shortint;
    FXValue: single;
    FXIndex: integer; // Index in FNContainKData array
    FXDate: LongWord;
    OriginalIndex: integer; // Index in FOriginalKData array
  end;

  TFenXing = T3KFENXING;
  TKLRelation = T3KFENXING;

  PTFenXing = ^T3KFENXING;
  PT3KFENXING = ^T3KFENXING;
  PTKLRelation = ^T3KFENXING;

  TJUNXIANZONGSHU = packed record
    ftype: Shortint;
    fbiCount: Shortint;
    fzhouqi: Shortint;
    p: array [0 .. 4] of Shortint;
    v: array [0 .. 4] of single;
  end;

  TJUNXIANZS = TJUNXIANZONGSHU;

  TJUNXIANBI = packed record
    ftype: Shortint;
    Nftype: Shortint;
    Startx: integer;
    Endx: integer;
  end;

  TVolumeFenXing = packed record
    FXType: integer;
    FXVolume: INT64;
    FXIndex: integer; // Index in FNContainKData array
    FXDate: LongWord;
    FXB: single; // 分型比
    SFLb: single; // 当前比上最大 缩量比，越大表示缩量越小，越小表示缩的越厉害

    BaseIndex: integer; // 分型基于的索引
    BaseCount: integer;
    BaseValue: INT64; // 分型的base 量
  end;

  TBI = packed record
    FenXing1: TKLRelation;
    FenXing2: TKLRelation;
  end;

  PTBI = ^TBI;

  // 每个K线的分型信息
  TCZSCInfo = packed record
    CZSCFXType: integer;
    BiIndex: integer;
    BiFenXing: TFenXing;
    ZSIndex: integer;
    ZSJiBie: integer;
    // CLIDU: single;
    // CFuDu:single;
  end;

  PTCZSCInfo = ^TCZSCInfo;

  // 中枢信息结构，也是走势趋势信息 走势类型信息
  TZSLXInfo = packed record
    ZSType: integer; // 第一个中枢的类型
    ZSCategory: integer; // 中枢的类别
    ZSQs: integer; // 两个以上中枢的走势趋势 或中枢的趋势
    ZSCount: integer; // 趋势中枢数量
    HasMWV: Boolean; // 有三买卖
    HasMWN: Boolean; // 有中阴端 一二类买卖点
    BS: integer;
    Policy: String;
  end;

  TArgConfigInfo = record
    num: integer; // 均线天数
    color: TColor;
    enable: Boolean;
  end;

  TArgInfo = record
    v: Extended; // 均线值
    p: TPoint;
  end;

  TVolumeDraw = record
    VMA: Extended;
    p: TPoint;
  end;

  TMacdInfo = record
    DIF: Double;
    DEA: Double;
    BAR: Double;
    DIFp: TPoint;
    DEAp: TPoint;
    BARp: array [0 .. 1] of TPoint;
  end;

  TStockKVolumeDraw = record
    rc: TRect;
    D: TTDX_DAYInfo;
  end;

  TStockKMinsVolumeDraw = record
    rc: TRect;
    D: TTDX_MIN;
  end;

  TF10TitleDrawInfo = record
    rc: TRect;
    D: TF10Rcd;
  end;

  { TCZSC_LiDu = packed record
    CZSCLiDu: single;
    P0: TPoint;
    P1: TPoint;
    end; }

  TStockKLineDraw = record
    D: TStockDealInfo; // TTDX_DAYInfo; //日线实际数据
    rc: TRect; // K线实体
    Top: integer; // 最高点
    Bottom: integer; // 最低点
    rcVol: TRect; // 成交量
    rcAmount: TRect; // 成交金额
    // YClose: Single; // 昨收

    ZSBWM: TCZSCInfo;
    ZSBWMRec: array [0 .. 4] of TRect;
    QjFxRec: TRect; // 量能分型
    MACD: TMacdInfo;
    PMA: array [0 .. 6] of TArgInfo; // 5、10、20、30、60、120、250价格移动平均
    VMA: array [0 .. 1] of TVolumeDraw; // 5、10均价格 成交量移动平均

  end;

  PTStockKLineDraw = ^TStockKLineDraw;

  { TCZSC_StockInfo = packed record
    StockName: string;
    StockCode: string;
    StockMarket: string;
    // KLineMode: string; //KLDataMode Name
    KLDataMode: TKLineDateMode;
    // KLCount: Integer;
    DataSource: integer;
    // FullFilePathName: string;
    DataSourceStartIndex: integer;
    ObjectType: Shortint;
    NeedReload: Boolean;
    LocalDataAnyWhere: Boolean;
    DeleteContainedKL: Boolean;
    GuangTouJiaoKL: Boolean;
    OriginalShowingType: Boolean;
    JiBie: SmallInt;
    MoniK: SmallInt;
    SelectedType: SmallInt;
    Ma1Period: SmallInt;
    Ma2Period: SmallInt;
    Ma3Period: SmallInt;
    Ma4Period: SmallInt;
    Ma5Period: SmallInt;
    Ma6Period: SmallInt;
    MADKBiaoJi: array [0 .. 7] of Boolean;

    IVMaxValueb: integer;
    IVpjcmbs: integer;
    IVpjcffb: integer; // MaxPJC div MaxPJC

    IVspcmbs: integer;
    IVspcffb: integer; // MaxSPC div MaxSPC

    ToToday: SmallInt;
    MaxLimitPrice: single;

    JiaGeJunXian: SmallInt;
    JiaGeJunXianZQ: SmallInt;
    DuoKongPaiLieZQ: SmallInt;
    MA12Dk: Boolean;

    FromNow_zs: Boolean;
    end; }

  TCZSC_AREA = packed record
    MaxVaule: Double;
    PJCArea: single;
    MaxPJC: single;
    SPCArea: single;
    MaxSPC: single;

    StartIndex: integer; // 接近最新的数据索引
    EndIndex: integer; // 趋向过去的数据索引
  end;

  TStockDayInfo = packed record // 64
    Data: TTDX_DAYInfo; // 接收到的数据
    // _Data: TTDX_DAYInfo; //除权后的数据
    // IndexInfo: TCZSCInfo;
  end;

  TStockInfor = packed record // 用来获取股票基本信息
    Zgf: string; // 总股本
    Zsz: string; // 总市值
    Ltgb: string;
    Ltsz: string;
  end;

  PNTime = ^NTime;

  NTime = packed record
    year: word;
    month: byte;
    DAY: byte;
    hour: byte;
    minute: byte;
    second: byte;
  end;

  PTMASL = ^TMASL;

  TMASL = packed record // 均线数据结构
    Mas: array [0 .. 6] of integer;
    MaType: integer;
    count: integer;
    KLMode: TKLineDateMode;
  end;

  TF10RcdEx = record
    RCD: TF10Rcd;
    Memory: PChar;
    Size: integer;
  end;

  PTF10RcdEx = ^TF10RcdEx;

  TLastMsgs = record
    MSG_KLINE: TTDX_MSG;
  end;

  TStockDataName = (STOCK_DATA_NONE, STOCK_DATA_OPEN, STOCK_DATA_CLOSE, STOCK_DATA_HIGH, STOCK_DATA_LOW, STOCK_DATA_VOLUME, STOCK_DATA_AMOUNT, STOCK_DATA_YCLOSE, // 昨日收盘价格
    STOCK_DATA_CODE, STOCK_DATA_NAME,

    STOCK_DATA_DAYS_1, STOCK_DATA_DAYS_2, STOCK_DATA_DAYS_3, STOCK_DATA_DAYS_5, STOCK_DATA_DAYS_10, STOCK_DATA_DAYS_20, STOCK_DATA_DAYS_30, STOCK_DATA_DAYS_60, STOCK_DATA_DAYS_120,
    STOCK_DATA_DAYS_250,

    STOCK_DATA_BI_FUDU, // 区间涨跌
    STOCK_DATA_BI_SUDU, // 区间涨跌力度
    STOCK_DATA_BI_TOTALAMOUNT, STOCK_DATA_BI_TOTALVOLUME, STOCK_DATA_BI_UPLIDU, STOCK_DATA_BI_DOWNLIDU,

    STOCK_DATA_QJFL_RATIO, STOCK_DATA_QJFL_TOTALVOLUME, STOCK_DATA_QJFL_VOLUME_1, STOCK_DATA_QJFL_VOLUME_2, STOCK_DATA_QJFL_VOLUME_3, STOCK_DATA_QJFL_VOLUME_4, STOCK_DATA_QJFL_VOLUME_5,
    STOCK_DATA_VOLUME_RATIO_1, // 区间量比
    STOCK_DATA_VOLUME_RATIO_2, STOCK_DATA_VOLUME_RATIO_3, STOCK_DATA_VOLUME_RATIO_4, STOCK_DATA_VOLUME_RATIO_5, STOCK_DATA_VOLUME_RATIO_6,

    STOCK_DATA_QJFL_TOTALAMOUNT, STOCK_DATA_QJFL_AMOUNT_1, STOCK_DATA_QJFL_AMOUNT_2, STOCK_DATA_QJFL_AMOUNT_3, STOCK_DATA_QJFL_AMOUNT_4, STOCK_DATA_QJFL_AMOUNT_5,

    STOCK_DATA_CZSC_WC, STOCK_DATA_QJ_SLCount, STOCK_DATA_QJ_SL_RATIO, STOCK_DATA_QJ_SL_BASE_RATIO, STOCK_DATA_BEICHI_RATIO, STOCK_DATA_TITLE_MENU, STOCK_DATA_QJFL_ZF, STOCK_DATA_QJSL_DF,
    STOCK_DATA_QJ_FLCount, STOCK_DATA_NOTES, STOCK_DATA_ZS_ELEMENTCOUNT, STOCK_DATA_ZS_QS, STOCK_DATA_XD, STOCK_DATA_MALS, STOCK_DATA_ZSZF,

    STOCK_DATA_P1, STOCK_DATA_P2, STOCK_DATA_P3, STOCK_DATA_P4, STOCK_DATA_P5, STOCK_DATA_P6, STOCK_DATA_P7, STOCK_DATA_P8, STOCK_DATA_P9, STOCK_DATA_P10, STOCK_DATA_P11);

  TStockSortMode = (STOCK_SORT_CODE, STOCK_SORT_NAME, STOCK_SORT_PERCENTCHANGE, // 与昨日相比上涨幅度
    STOCK_SORT_PRICE, STOCK_SORT_PRICECHANGE, // 价格单日涨跌
    STOCK_SORT_VOLUME, STOCK_SORT_AMOUNT, STOCK_SORT_CHANGE, // 价格单日上下振荡幅度
    STOCK_SORT_YCLOSE, STOCK_SORT_DAYS_1, STOCK_SORT_DAYS_2, STOCK_SORT_DAYS_3, STOCK_SORT_DAYS_5, STOCK_SORT_DAYS_10, STOCK_SORT_DAYS_20, STOCK_SORT_DAYS_30, STOCK_SORT_DAYS_60, STOCK_SORT_DAYS_120,
    STOCK_SORT_DAYS_250,

    STOCK_SORT_BI_FUDU, // 周期涨幅
    STOCK_SORT_BI_SUDU, STOCK_SORT_BI_TOTALAMOUNT, STOCK_SORT_BI_TOTALVOLUME, STOCK_SORT_BI_UPLIDU, STOCK_SORT_BI_DOWNLIDU,

    STOCK_SORT_QJFL_TOTALVOLUME, STOCK_SORT_QJFL_RATIO, STOCK_SORT_QJFL_VOLUME_1, STOCK_SORT_QJFL_VOLUME_2, STOCK_SORT_QJFL_VOLUME_3, STOCK_SORT_QJFL_VOLUME_4, STOCK_SORT_QJFL_VOLUME_5,
    STOCK_SORT_VOLUME_RATIO_1, STOCK_SORT_VOLUME_RATIO_2, STOCK_SORT_VOLUME_RATIO_3, STOCK_SORT_VOLUME_RATIO_4, STOCK_SORT_VOLUME_RATIO_5, STOCK_SORT_VOLUME_RATIO_6, STOCK_SORT_BEICHI_RATIO,

    STOCK_SORT_QJFL_TOTALAMOUNT, STOCK_SORT_QJFL_AMOUNT_1, STOCK_SORT_QJFL_AMOUNT_2, STOCK_SORT_QJFL_AMOUNT_3, STOCK_SORT_QJFL_AMOUNT_4, STOCK_SORT_QJFL_AMOUNT_5,

    STOCK_SORT_ZSWC, STOCK_SORT_QJ_SLCount, STOCK_SORT_QJ_SL_RATIO, STOCK_SORT_QJ_SL_BASE_RATIO, STOCK_SORT_QJ_FLZF, STOCK_SORT_QJ_SLZF, STOCK_SORT_QJ_FLCount, STOCK_SORT_MALS,
    STOCK_SORT_ZSELEMENTCOUNT, STOCK_SORT_ZSQS, STOCK_SORT_XD, STOCK_SORT_ZSZF, STOCK_SORT_CATEGORY, STOCK_SORT_BS, STOCK_SORT_OP, STOCK_SORT_DATE, STOCK_SORT_NONE);

  TSTOCK_BLOCK_ID = (ID_NORMAL, ID_VIEW_ALL_STOCKS, ID_VIEW_KLINE, ID_VIEW_MYSELECT_STOCKS, ID_VIEW_FL_1, ID_VIEW_FL_2, ID_VIEW_FL_3, ID_VIEW_FL_4, ID_VIEW_FL_5, ID_VIEW_FL_6, ID_VIEW_FL_SL,
    ID_VIEW_SL, ID_VIEW_WC_0, ID_VIEW_WC_1, ID_VIEW_WC_2, ID_VIEW_WC_3, ID_VIEW_WC_4, ID_VIEW_WC_5, ID_VIEW_NOT_CONTAINER, ID_VIEW_BI, ID_VIEW_XD, ID_VIEW_5F, ID_VIEW_30FU, ID_VIEW_30FD, ID_VIEW_60F,

    ID_VIEW_DAYUP, ID_VIEW_DAYPU, ID_VIEW_DAYDP, ID_VIEW_DAYPD,

    ID_VIEW_DAY_ZSU, ID_VIEW_DAY_ZSFU, // 中枢第一次上移 First Up
    ID_VIEW_DAY_ZSD, ID_VIEW_DAY_ZSMWV, ID_VIEW_DAY_GUANZHU, // 关注
    ID_VIEW_DAY_NOTIFICATION, ID_VIEW_DAY_AI,

    ID_VIEW_AI, ID_VIEW_WEEK, ID_VIEW_MONTH, ID_VIEW_FL_OTHERS, ID_VIEW_SYSTEM,

    ID_VIEW_MONITOR, ID_VIEW_LHXX, // 龙虎信息
    ID_VIEW_YXDT, ID_VIEW_RYXDT, ID_VIEW_FL_NONE);

  TSTOCK_SELLBUY_ID = (ID_FL_SC, // 放量上涨
    ID_FL_ZC, // 放量滞胀
    ID_FL_XD, // 放量下跌
    ID_SL_ZD, // 缩量止跌
    ID_SL_XD, // 缩量下跌
    ID_SL_SZ // 缩量上涨
    );

  TTableFieldProcCallBack = function(): string;

  TStockFieldInfor = packed record
    Titlename: string;
    DataID: TStockDataName;
    SortID: TStockSortMode;
    Visible: Boolean;
    CallBack: TTableFieldProcCallBack;
    ColumnRec: TRect;
  end;

  TStockblockInfor = packed record
    Name: string;
    LocakFilePath: string;
    BlockID: TSTOCK_BLOCK_ID;
  end;

  TBillboardMessage = packed record
    DataID: TStockDataName;
    MessageStr: string;
  end;

  TBillboardInfor = packed record
    Name: string;
    BillboardMessage: TBillboardMessage;
    FieldValue: single;
    IsChanged: Boolean;
    Date: string;
  end;

  TSellBuyMessage = packed record
    ID: TSTOCK_SELLBUY_ID;
    Description: string;
  end;

  // PTStockKLineDrawArray = ^TStockKLineDrawArray;
  // TStockKLineDrawArray = array of TStockKLineDraw;

  // PTDynamicSingleArray = ^TDynamicSingleArray;
  // TDynamicSingleArray = array of single;

  // PTDynamicExtendedArray = ^TDynamicExtendedArray;
  // TDynamicExtendedArray = array of Extended;

  PTDynamicDoubleArray = ^TDynamicDoubleArray;
  TDynamicDoubleArray = array of Double;

  PTStockDayInfoDynamicArray = ^TStockDayInfoDynamicArray;
  TStockDayInfoDynamicArray = array of TStockDayInfo;

  PTStockDealInfoDynamicArray = ^TStockDealInfoDynamicArray;
  TStockDealInfoDynamicArray = array of TStockDealInfo; // 仅仅只有交易数据

  PT3KFENXINGDynamicArray = ^T3KFENXINGDynamicArray;
  T3KFENXINGDynamicArray = array of T3KFENXING;
  PTPointArray = ^TPointArray;
  TPointArray = array of TPoint;

implementation

end.

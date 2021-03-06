unit GlobalConst;

interface

uses SysUtils, Classes, Windows, Math, Messages, Contnrs, Graphics,
  GlobalTypes,System.SyncObjs, Winapi.GDIPAPI, Winapi.GDIPOBJ, Winapi.GDIPUTIL;

const
  InfoNum = 9;
  InfoStr: array [1 .. InfoNum] of string = ('ProductName', 'ProductVersion', 'FileDescription', 'LegalCopyright', 'FileVersion', 'CompanyName', 'LegalTradeMarks', 'InternalName', 'OriginalFileName');

  APPLICATION_TITLE_NAME = '兆科音视频坐席管理系统'; // '逐潮股票数据挖掘终端 1.0';

  STRING_SINGLEFORMAT = '%.02f';
  WM_MYMESSAGE_THREAD = WM_USER + 10; //
  WM_MYMESSAGE_THREAD_CONTENT = WM_USER + 11;
  WM_MYMESSAGE_VKEY = WM_USER + 12;
  WM_MYMESSAGE_DATAENGINE_WORKING_DONE = WM_USER + 13;
  WM_MYMESSAGE_DATAENGINE_CREATE = WM_USER + 14;
  WM_MYMESSAGE_UPDATE_ZSLX = WM_USER + 15;
  WM_MYMESSAGE_REGISTER = WM_USER + 16;
  WM_MYMESSAGE_LOGIN = WM_USER + 17;
  WM_MYMESSAGE_EXIT = WM_USER + 18;
  WM_MYMESSAGE_UPDATADATABASE = WM_USER + 19;
  WM_MYMESSAGE_PKDATAENGINE = WM_USER + 20;
  WM_MYMESSAGE_UPDATE_UI = WM_USER + 21;

  WM_MYMESSAGE_TASK_COMPLETE = WM_USER + 22;
  WM_MYMESSAGE_TASK_COMPLETEOK = WM_USER + 23;

  ColorMatrixArray: TColorMatrix = ((1.0, 0.0, 0.0, 0.0, 0.0), (0.0, 1.0, 0.0, 0.0, 0.0), (0.0, 0.0, 1.0, 0.0, 0.0), (0.0, 0.0, 0.0, 1.0, 0.0), (0.0, 0.0, 0.0, 0.0, 1.0));
  DeviceTypeStr: array [0 .. 8] of string = ('未知','编码器', '解码器', 'IPC', '麦克', '音响', '录播', '中控', 'KVM');
  DayOfWeekStr: array [1 .. 8] of string = ('八', '一', '二', '三', '四', '五', '六', '日');

  KLineDateModeStr: array [KD_MIN .. KD_YEAR] of string = ('1分钟', '5分钟', '10分钟', '15分钟', '30分钟', '60分钟', '120分钟', '日线', '周线', '月线', '45日线', '季线', '年线');
  KLineJiBieDataStr: array [KD_MIN .. KD_YEAR] of string = ('1', '5', '10', '15', '30', '60', '120', 'D', 'W', 'M', '45', 'S', 'Y');

  CZSC_BUFFER_MAX_RECORD_NUMBER = 1 * 365 * 24 * 60; // 1个记录年
  CZSC_MAX_CROSS_NUMBER = 10;
  CZSC_DATA_BASE_FILE_NAME_1F = 'CZSC1F.DATA';
  CZSC_DATA_BASE_FILE_NAME_30F = 'CZSC30F.DATA';

  DEFAULT_LOADLOCALDRECORDCOUNT = 600;
  DEFAULT_MONI_K_NUMBER = 12;
  DEFAULT_JUNXIAN_XUANGU_KLINE_NUMBER = 100;
  DEFAULT_JUNXIAN_ZS_LINE = 3;

  /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////
  ///
  CZSC_INVALID = -1;
  CZSC_NONE = 0;
  CZSC_OBJECT_NORMAL = 0;

  RELATION_NONE = 0; // 关系不明确
  RELATION_CONTAINER1 = 1; // 被前面的（上一个周期）包含 ////被包含
  RELATION_CONTAINER2 = 2; // 包含前面的（上一个周期）

  RELATION_2KFENXING = 3;
  RELATION_UP = 4;
  RELATION_DOWN = 5;

  RELATION_3KFENXING = 6; // 笔分型类型
  RELATION_GFENXING = 7; // 顶分型
  RELATION_DFENXING = 8; // 底分型

  // 这里数字必须连续
  RELATION_ZHONGSHU_UP = 9;
  RELATION_ZHONGSHU_DOWN = 10;
  RELATION_ZHONGSHU_PDOWN = 11;
  RELATION_ZHONGSHU_PUP = 12;
  RELATION_ZHONGSHU_DOWNP = 13;
  RELATION_ZHONGSHU_UPP = 14;

  /// ///////////////////////////////////////////////////////////////////
  RELATION_DIRECTION_UP = 30; // 数组搜索方向
  RELATION_DIRECTION_DOWN = 31;
  /// ///////////////////////////////////////////////////////////////////
  ZHONGSHU_TYPE_BI = 50;
  ZHONGSHU_TYPE_XIANDUAN = 51;
  ZHONGSHU_TYPE_ZOUSHILEIXING = 52;
  /// ///////////////////////////////////////////////////////////////////
  CZSC_OBJECT_FENXING = 100;
  CZSC_OBJECT_BI = 101;
  CZSC_OBJECT_XIANDUAN = 102;
  CZSC_OBJECT_ZHONGSHU = 103;
  CZSC_OBJECT_ZOUSHILEIXING = 104;

  CZSC_OBJECT_XIANDUAN_UP_CONTAINER = 150;
  CZSC_OBJECT_XIANDUAN_DOWN_CONTAINER = 151;

  ERROR_NONE = 200;
  ERROR_FENXING = 201;
  ERROR_BI_CONNECTION = 202;
  ERROR_XIANDUAN_CONNECTION = 203;
  ERROR_ZOUSHIZHONGSHU_CONNECTION = 204;
  ERROR_ZOUSHILEIXING_CONNECTION = 205;

  CZSC_DATA_FILE_APPEND = 300;
  CZSC_DATA_FILE_REWRITE = 301;

  CZSC_DATASOURCE_LOCALFILE = 302;
  CZSC_DATASOURCE_INTERNER = 303;
  CZSC_DATASOURCE_GDAT = 304;

  VOLUME_QUJIAN_NONE = 500;
  VOLUME_QUJIAN_FLUP = 501;
  VOLUME_QUJIAN_FLDOWN = 502;
  VOLUME_QUJIAN_SLUP = 503;
  VOLUME_QUJIAN_SLDOWN = 504;
  VOLUME_QUJIAN_FL = 505; // 不最终输出
  VOLUME_QUJIAN_SL = 506; // 不最终输出

  CZSC_MARKET_TYPE_NONE = 0;
  CZSC_MARKET_TYPE_KONGTOUSHICHANG_AND_DUOTOUQUSHI = 1; // 空头市场多头趋势，抄底
  CZSC_MARKET_TYPE_KONGTOUSHICHANG_AND_KONGTOUQUSHI = 2; // 空头市场空头趋势，观望
  CZSC_MARKET_TYPE_DUOTOUSHICHANG_AND_DUOTOUQUSHI = 3; // 多头市场多头趋势，持股
  CZSC_MARKET_TYPE_DUOTOUSHICHANG_AND_KONGTOUQUSHI = 4; // 多头市场空头趋势，逃顶

  // CZSC_STOCK_SELECTEDBYPE_ZHUIZHANG = 0
  CZSCBI_KP = 400;
  CZSCBI_SP = 401;
  CZSCBI_ZG = 402;
  CZSCBI_ZD = 403;
  CZSCBI_JL = 404;
  CZSCBI_JE = 405;
  CZSCBI_DT = 406;
  /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  POLICY_OP_NONE = 0;
  POLICY_OP_BUY = 1;
  POLICY_OP_SEL = 2;
  /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  DATAENGINE_KLDATA_DELAY = 1;
  DATAENGINE_DATASOURCE_DAY_IFENG = 2; // 凤凰数据源
  DATAENGINE_DATASOURCE_DAY_SINA = 3; // 新浪数据源
  DATAENGINE_DATASOURCE_DAY_IFIND = 4; // 同花顺数据源
  /// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ZSCATEGORYSTR: array [0 .. 5] of String = ('', '放大中枢', '收敛中枢', '反转平台中枢', '顺势平台中枢', '平衡平台中枢');
  ZSLXITEMSTR: array [0 .. 3] of String = ('价格', '力度', '成交量', 'BIAS');
  ZSLXPOLICYSTR: array [0 .. 4] of String = ('价格突破成交量背驰', '价格突破力度背驰', '未突破力度背驰', '未突破成交量背驰', '中枢震荡');
  ZSLXBSA: array [0 .. 2] of String = ('', '买入', '卖出');
  ZSLXBSFX: array [0 .. 16] of String = ('', '买一', '买二', '买三', '一卖', '二卖', '三卖', '', '', '', '', '', '', '', '', '', '');
  ZSLXCategory: array [0 .. 16] of String = ('', '盘整下跌', '盘整上涨', '下跌盘整', '上涨盘整', '盘整下跌V', '盘整下跌N', '盘整上涨V', '盘整上涨N', '下跌盘整上V', '下跌盘整上N', '下跌盘整下V', '下跌盘整下N', '上涨盘整上V', '上涨盘整上N', '上涨盘整下V', '上涨盘整下N');

  VolumeStatusString: array [0 .. 6] of String = ('', '放量上涨 持仓', '放量滞涨 卖出', '放量下跌 空仓', '缩量下跌 买入', '缩量上涨 卖出', '梯度缩量');
  MACDStatusString: array [0 .. 5] of String = ('', '弱势反弹', '空市空头趋势 空仓', '多市多头趋势 持仓', '多头回调', '');

  /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  BillboardMessage: array [0 .. 12] of TBillboardMessage = ((DataID: STOCK_DATA_QJFL_TOTALAMOUNT; MessageStr: '区间放量, 历史排名第一.'), (DataID: STOCK_DATA_QJFL_RATIO; MessageStr: '区间放量比,历史排名第一.'),
    (DataID: STOCK_DATA_QJFL_AMOUNT_1; MessageStr: '单日成交金额,历史排名第一.'), (DataID: STOCK_DATA_QJFL_AMOUNT_2; MessageStr: '二日成交金额,历史排名第一.'), (DataID: STOCK_DATA_QJFL_AMOUNT_3;
    MessageStr: '三日成交金额,历史排名第一.'), (DataID: STOCK_DATA_QJFL_AMOUNT_4; MessageStr: '四日成交金额,历史排名第一.'), (DataID: STOCK_DATA_QJFL_AMOUNT_5; MessageStr: '五日成交金额,历史排名第一.'),
    (DataID: STOCK_DATA_VOLUME_RATIO_1; MessageStr: '单日成交量比,历史排名第一.'), (DataID: STOCK_DATA_VOLUME_RATIO_2; MessageStr: '二日成交量比,历史排名第一.'), (DataID: STOCK_DATA_VOLUME_RATIO_3;
    MessageStr: '三日成交量比,历史排名第一.'), (DataID: STOCK_DATA_VOLUME_RATIO_4; MessageStr: '四日成交量比,历史排名第一.'), (DataID: STOCK_DATA_VOLUME_RATIO_5; MessageStr: '五日成交量比,历史排名第一.'), (DataID: STOCK_DATA_NONE;
    MessageStr: ''));

  StockTableFieldArray: array [0 .. 56] of TStockFieldInfor = ((Titlename: '   序号'; DataID: STOCK_DATA_TITLE_MENU; SortID: STOCK_SORT_NONE; Visible: True; CallBack: nil;
    ), (Titlename: '股票名称'; DataID: STOCK_DATA_NAME; SortID: STOCK_SORT_NAME; Visible: True; CallBack: nil;), (Titlename: '股票代码'; DataID: STOCK_DATA_CODE; SortID: STOCK_SORT_CODE; Visible: True;
    CallBack: nil;), (Titlename: '股票价格'; DataID: STOCK_DATA_CLOSE; SortID: STOCK_SORT_PRICE; Visible: True; CallBack: nil;),

    (Titlename: '走势幅度'; DataID: STOCK_DATA_BI_FUDU; SortID: STOCK_SORT_BI_FUDU; Visible: True; CallBack: nil;), // 笔
    (Titlename: '走势速度'; DataID: STOCK_DATA_BI_SUDU; SortID: STOCK_SORT_BI_SUDU; Visible: True; CallBack: nil;), // 笔
    (Titlename: '走势成交量'; DataID: STOCK_DATA_BI_TOTALVOLUME; SortID: STOCK_SORT_BI_TOTALVOLUME; Visible: True; CallBack: nil;), // 笔
    (Titlename: '走势买入度'; DataID: STOCK_DATA_BI_UPLIDU; SortID: STOCK_SORT_BI_UPLIDU; Visible: True; CallBack: nil;), // 笔
    (Titlename: '走势卖出度'; DataID: STOCK_DATA_BI_DOWNLIDU; SortID: STOCK_SORT_BI_DOWNLIDU; Visible: True; CallBack: nil;), // 笔
    (Titlename: '趋势'; DataID: STOCK_DATA_ZS_QS; SortID: STOCK_SORT_ZSQS; Visible: True; CallBack: nil;), // 中枢
    (Titlename: '数量'; DataID: STOCK_DATA_ZS_ELEMENTCOUNT; SortID: STOCK_SORT_ZSELEMENTCOUNT; Visible: True; CallBack: nil;), // 中枢
    (Titlename: '位置'; DataID: STOCK_DATA_CZSC_WC; SortID: STOCK_SORT_ZSWC; Visible: True; CallBack: nil;), (Titlename: '趋势幅度'; DataID: STOCK_DATA_ZSZF; SortID: STOCK_SORT_ZSZF; Visible: True;
    CallBack: nil;),

    (Titlename: '区缩量比'; DataID: STOCK_DATA_QJ_SL_RATIO; SortID: STOCK_SORT_QJ_SL_RATIO; Visible: True; CallBack: nil;), // 区间
    (Titlename: '区缩量周期'; DataID: STOCK_DATA_QJ_SLCount; SortID: STOCK_SORT_QJ_SLCount; Visible: True; CallBack: nil;), (Titlename: '区缩量涨跌'; DataID: STOCK_DATA_QJSL_DF; SortID: STOCK_SORT_QJ_SLZF;
    Visible: True; CallBack: nil;),

    (Titlename: '区放量和'; DataID: STOCK_DATA_QJFL_TOTALVOLUME; SortID: STOCK_SORT_QJFL_TOTALVOLUME; Visible: True; CallBack: nil;), // 区间
    (Titlename: '区放量比'; DataID: STOCK_DATA_QJFL_RATIO; SortID: STOCK_SORT_QJFL_RATIO; Visible: True; CallBack: nil;), // 区间
    (Titlename: '区放量周期'; DataID: STOCK_DATA_QJ_FLCount; SortID: STOCK_SORT_QJ_FLCount; Visible: True; CallBack: nil;), (Titlename: '区放量涨跌'; DataID: STOCK_DATA_QJFL_ZF; SortID: STOCK_SORT_QJ_FLZF;
    Visible: True; CallBack: nil;),

    (Titlename: '一期放量'; DataID: STOCK_DATA_QJFL_VOLUME_1; SortID: STOCK_SORT_QJFL_VOLUME_1; Visible: True; CallBack: nil;), // 周期
    (Titlename: '一期量比'; DataID: STOCK_DATA_VOLUME_RATIO_1; SortID: STOCK_SORT_VOLUME_RATIO_1; Visible: True; CallBack: nil;
    ), (Titlename: '一期金额'; DataID: STOCK_DATA_QJFL_AMOUNT_1; SortID: STOCK_SORT_QJFL_AMOUNT_1; Visible: True; CallBack: nil;), (Titlename: '1期涨幅'; DataID: STOCK_DATA_DAYS_1; SortID: STOCK_SORT_DAYS_1;
    Visible: True; CallBack: nil;),

    (Titlename: '二期放量'; DataID: STOCK_DATA_QJFL_VOLUME_2; SortID: STOCK_SORT_QJFL_VOLUME_2; Visible: True; CallBack: nil;
    ), (Titlename: '二期量比'; DataID: STOCK_DATA_VOLUME_RATIO_2; SortID: STOCK_SORT_VOLUME_RATIO_2; Visible: True; CallBack: nil;
    ), (Titlename: '二期金额'; DataID: STOCK_DATA_QJFL_AMOUNT_2; SortID: STOCK_SORT_QJFL_AMOUNT_2; Visible: True; CallBack: nil;), (Titlename: '2期涨幅'; DataID: STOCK_DATA_DAYS_2; SortID: STOCK_SORT_DAYS_2;
    Visible: True; CallBack: nil;),

    (Titlename: '三期放量'; DataID: STOCK_DATA_QJFL_VOLUME_3; SortID: STOCK_SORT_QJFL_VOLUME_3; Visible: True; CallBack: nil;
    ), (Titlename: '三期量比'; DataID: STOCK_DATA_VOLUME_RATIO_3; SortID: STOCK_SORT_VOLUME_RATIO_3; Visible: True; CallBack: nil;
    ), (Titlename: '三期金额'; DataID: STOCK_DATA_QJFL_AMOUNT_3; SortID: STOCK_SORT_QJFL_AMOUNT_3; Visible: True; CallBack: nil;), (Titlename: '3期涨幅'; DataID: STOCK_DATA_DAYS_3; SortID: STOCK_SORT_DAYS_3;
    Visible: True; CallBack: nil;),

    (Titlename: '四期放量'; DataID: STOCK_DATA_QJFL_VOLUME_4; SortID: STOCK_SORT_QJFL_VOLUME_4; Visible: True; CallBack: nil;
    ), (Titlename: '四期量比'; DataID: STOCK_DATA_VOLUME_RATIO_4; SortID: STOCK_SORT_VOLUME_RATIO_4; Visible: True; CallBack: nil;
    ), (Titlename: '四期金额'; DataID: STOCK_DATA_QJFL_AMOUNT_4; SortID: STOCK_SORT_QJFL_AMOUNT_4; Visible: True; CallBack: nil;), (Titlename: '5期涨幅'; DataID: STOCK_DATA_DAYS_5; SortID: STOCK_SORT_DAYS_5;
    Visible: True; CallBack: nil;),

    (Titlename: '五期放量'; DataID: STOCK_DATA_QJFL_VOLUME_5; SortID: STOCK_SORT_QJFL_VOLUME_5; Visible: True; CallBack: nil;
    ), (Titlename: '五期量比'; DataID: STOCK_DATA_VOLUME_RATIO_5; SortID: STOCK_SORT_VOLUME_RATIO_5; Visible: True; CallBack: nil;
    ), (Titlename: '五期金额'; DataID: STOCK_DATA_QJFL_AMOUNT_5; SortID: STOCK_SORT_QJFL_AMOUNT_5; Visible: True; CallBack: nil;
    ), (Titlename: '10期涨幅'; DataID: STOCK_DATA_DAYS_10; SortID: STOCK_SORT_DAYS_10; Visible: True; CallBack: nil;),

    (Titlename: '20期涨幅'; DataID: STOCK_DATA_DAYS_20; SortID: STOCK_SORT_DAYS_20; Visible: False; CallBack: nil;), (Titlename: '30期涨幅'; DataID: STOCK_DATA_DAYS_30; SortID: STOCK_SORT_DAYS_30;
    Visible: False; CallBack: nil;), (Titlename: '60期涨幅'; DataID: STOCK_DATA_DAYS_60; SortID: STOCK_SORT_DAYS_60; Visible: False; CallBack: nil;
    ), (Titlename: '120期涨幅'; DataID: STOCK_DATA_DAYS_120; SortID: STOCK_SORT_DAYS_120; Visible: False; CallBack: nil;), (Titlename: '250期涨幅'; DataID: STOCK_DATA_DAYS_250; SortID: STOCK_SORT_DAYS_250;
    Visible: False; CallBack: nil;),

    (Titlename: '预警周期'; DataID: STOCK_DATA_P1; SortID: STOCK_SORT_NONE; Visible: False; CallBack: nil;), // 45
    (Titlename: '走势类型'; DataID: STOCK_DATA_P2; SortID: STOCK_SORT_NONE; Visible: False; CallBack: nil;), (Titlename: '前成交量'; DataID: STOCK_DATA_P3; SortID: STOCK_SORT_NONE; Visible: False;
    CallBack: nil;), (Titlename: '现成交量'; DataID: STOCK_DATA_P4; SortID: STOCK_SORT_NONE; Visible: False; CallBack: nil;), (Titlename: '前力度'; DataID: STOCK_DATA_P5; SortID: STOCK_SORT_NONE;
    Visible: False; CallBack: nil;), (Titlename: '现力度'; DataID: STOCK_DATA_P6; SortID: STOCK_SORT_NONE; Visible: False; CallBack: nil;
    ), (Titlename: '买卖型态'; DataID: STOCK_DATA_P7; SortID: STOCK_SORT_BS; Visible: True; CallBack: nil;), (Titlename: '操作和操作类型      '; DataID: STOCK_DATA_P8; SortID: STOCK_SORT_OP; Visible: True;
    CallBack: nil;), (Titlename: '总共持仓'; DataID: STOCK_DATA_P9; SortID: STOCK_SORT_NONE; Visible: False; CallBack: nil;), (Titlename: '资产余额  '; DataID: STOCK_DATA_P10; SortID: STOCK_SORT_NONE;
    Visible: False; CallBack: nil;), (Titlename: '日期时间    '; DataID: STOCK_DATA_P11; SortID: STOCK_SORT_DATE; Visible: True; CallBack: nil;), // 55

    (Titlename: '所属行业'; DataID: STOCK_DATA_NOTES; SortID: STOCK_SORT_CATEGORY; Visible: True; CallBack: nil;) // 56
    );

  // CZSC_SELECTSTOCK_STATICS_0 = 0;
  CZSC_SELECTSTOCK_STATICS_1 = 1; // 成交量追涨   成交量放量后缩量整理
  CZSC_SELECTSTOCK_STATICS_2 = 2; // 至少连续放量
  CZSC_SELECTSTOCK_STATICS_3 = 3; // 均线
  CZSC_SELECTSTOCK_STATICS_4 = 4; // 均线
  CZSC_SELECTSTOCK_STATICS_5 = 5;
  CZSC_SELECTSTOCK_STATICS_6 = 6;
  CZSC_SELECTSTOCK_STATICS_7 = 7;
  CZSC_SELECTSTOCK_STATICS_8 = 8;
  CZSC_SELECTSTOCK_STATICS_9 = 9; // w形态
  CZSC_SELECTSTOCK_STATICS_10 = 10;
  CZSC_SELECTSTOCK_STATICS_11 = 11;
  CZSC_SELECTSTOCK_STATICS_12 = 12;
  CZSC_SELECTSTOCK_STATICS_13 = 13;
  CZSC_SELECTSTOCK_STATICS_14 = 14;
  CZSC_SELECTSTOCK_STATICS_15 = 15;
  CZSC_SELECTSTOCK_STATICS_16 = 16;
  CZSC_SELECTSTOCK_STATICS_17 = 17;
  CZSC_SELECTSTOCK_STATICS_18 = 18;
  CZSC_SELECTSTOCK_STATICS_19 = 19;
  CZSC_SELECTSTOCK_STATICS_20 = 20; // 均线中枢

  // VOLUME_HIGH_BASE = 2.9;
  // VOLUME_LOW_BASE = 2;
  // VOLUME_FS_RATIO = 0.5;

  // _Buy_Sell_Str_: array[0..1] of array[1..5] of string = (('买①', '买②',
  // '买③', '买④', '买⑤'), ('卖①', '卖②', '卖③', '卖④', '卖⑤'));
  _Buy_Sell_Str_: array [0 .. 1] of array [1 .. 10] of string = (('买一', '买二', '买三', '买四', '买五', '买六', '买七', '买八', '买九', '买十'), ('卖一', '卖二', '卖三', '卖四', '卖五', '卖六', '卖七', '卖八', '卖九', '卖十'));

var
  FILE_DATASOURCE_PATH: string = ''; // 动态设置
  FILE_APP_PATH: string = ''; // 动态设置
  DOCUMENTS_PATH:String = '';
implementation

end.

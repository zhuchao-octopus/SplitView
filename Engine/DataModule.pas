unit DataModule;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef,
  FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Comp.UI, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet,MyMessageQueue,GlobalConst,
  Stock, GlobalFunctions;

type
  TDataModule1 = class(TDataModule)
    FDConnection1: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDCommand1: TFDCommand;
    FDQuery1: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure InitStocksFromDatabase(StringList: TStringList);
    procedure InsertStockToStocksTable(stkCode: string; stkName: string; Market: Integer;
      Category: String);
    procedure InsertStockToMyStocksTable(userName: String; stkCode: string; stkName: string;
      Category: Integer);
    procedure InsertStocksToMyStocksTable(userName: String; Category: Integer; Stocks: TStringList);
    procedure ReadStocksFromMyStocksTable(userName: String; Category: Integer; Stocks: TStringList);
    procedure ReadStockCommentsFromMyStocksTable(userName: string; Category: Integer; stkobj: TStockObject);

   function  RegisterUser(userName,pass,mobile,email: String):Integer;
   function ChechUer(userName,pass: String):Boolean;
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}


function  TDataModule1.RegisterUser(userName,pass,mobile,email: String):Integer;
var
  sqlstr: String;
begin
  Result:=-1;
  FDQuery1.Close;
  FDQuery1.sql.Clear;
  sqlstr := 'select * from tb_users where user = ''' + userName + '''';
  FDQuery1.Open(sqlstr);
  if (FDQuery1.RecordCount <= 0) then
  begin
    FDQuery1.sql.Clear;
    sqlstr := 'INSERT INTO tb_users(user, pass,mobile,email)VALUES';
    sqlstr := sqlstr + '(''' + userName + ''',''' + pass + ''',''' + mobile + ''',''' +  email + ''')';
    FDQuery1.sql.Add(sqlstr);
    FDQuery1.ExecSQL;
    Result:=1;
  end else
  begin
     Result:=0;
  end;
end;

function  TDataModule1.ChechUer(userName: string; pass: string):Boolean;
var
  sqlstr: String;
  //i: Integer;
begin
  Result:=False;
  FDQuery1.Close;
  FDQuery1.sql.Clear;
  sqlstr := 'select * from tb_users where user=' + QuotedStr(userName)+ ' and '+  'pass ='+ QuotedStr(pass);
  FDQuery1.Open(sqlstr);
  if (FDQuery1.RecordCount > 0) then
  begin
     Result:=True;
  end else
  begin
     Result:=False;
  end;
end;

procedure TDataModule1.InsertStockToStocksTable(stkCode: string; stkName: string; Market: Integer;
  Category: String);
var
  sqlstr: String;
  //i: Integer;
begin
  FDQuery1.Close;
  FDQuery1.sql.Clear;
  sqlstr := 'select * from tb_stocks where stkCode = ''' + stkCode + '''';
  FDQuery1.Open(sqlstr);
  if (FDQuery1.RecordCount <= 0) then
  begin
    FDQuery1.sql.Clear;
    sqlstr := 'INSERT INTO tb_stocks(stkCode, stkName,Market,Category)VALUES';
    sqlstr := sqlstr + '(''' + stkCode + ''',''' + stkName + ''',' + IntToStr(Market) + ',''' +
      Category + ''')';
    FDQuery1.sql.Add(sqlstr);
    FDQuery1.ExecSQL;
  end;
end;

procedure TDataModule1.InsertStockToMyStocksTable(userName: String; stkCode: string;
  stkName: string; Category: Integer);
var
  sqlstr: String;
  //i: Integer;
begin
  FDQuery1.Close;
  FDQuery1.sql.Clear;
  sqlstr := 'select * from tb_mystocks where userName = ''' + userName + '''+stkCode = ''' + stkCode +
    '''+ category=' + IntToStr(Category) + '';
  FDQuery1.Open(sqlstr);
  if (FDQuery1.RecordCount <= 0) then
  begin
    FDQuery1.sql.Clear;
    sqlstr := 'INSERT INTO tb_mystocks(userName,stkCode, stkName,Category)VALUES';
    sqlstr := sqlstr + '(''' + userName + ''',''' + stkCode + ''',''' + stkName + ''',' +
      IntToStr(Category) + ')';
    FDQuery1.sql.Add(sqlstr);
    FDQuery1.ExecSQL;
  end;
end;

{ INSERT INTO MyStocks(userName ,stkCode,stkName,category
  ) SELECT 'System','SH000001','上证指数',0
  FROM DUAL WHERE NOT EXISTS(
  SELECT * FROM MyStocks WHERE stkCode= 'SH000001'
  ); }
procedure TDataModule1.InsertStocksToMyStocksTable(userName: String; Category: Integer;
  Stocks: TStringList);
var
  sql: String;
  i: Integer;
  stkobj: TStockObject;
begin
  if(Stocks.Count <= 0) then Exit;
  //FDCommand1.Active:=True;
  sql:='delete from tb_mystocks where userName=' + QuotedStr(userName)+ ' and '+  'category ='+ IntToStr(Category);
  FDCommand1.CommandText.Clear;
  FDCommand1.CommandText.Add(sql);

  try
  FDCommand1.Execute();
  except
  Exit;
  end;

  for i := 0 to Stocks.Count - 1 do
  begin
    stkobj := TStockObject(Stocks.Objects[i]);
    FDCommand1.CommandText.Clear;
    FDCommand1.CommandText.Add('INSERT INTO tb_mystocks(userName ,stkCode,stkName,category,comments) SELECT ');
    FDCommand1.CommandText.Add(QuotedStr(userName)+',');
    FDCommand1.CommandText.Add(QuotedStr(stkobj.StkCode)+',');
    FDCommand1.CommandText.Add(QuotedStr(stkobj.StkName)+',');
    FDCommand1.CommandText.Add(IntToStr(Category)+', ');
    FDCommand1.CommandText.Add(QuotedStr(stkobj.Comments)+'');

    FDCommand1.CommandText.Add('FROM DUAL WHERE NOT EXISTS(SELECT * FROM tb_mystocks WHERE ');
    FDCommand1.CommandText.Add('userName='+QuotedStr(userName)+' and ');
    FDCommand1.CommandText.Add('stkCode='+QuotedStr(stkobj.StkCode)+' and ');
    FDCommand1.CommandText.Add('category='+IntToStr(category)+' ); ');

    sql:= FDCommand1.CommandText.Text;
    FDCommand1.Execute();
    MQueue.SendMessage(TMyMessage.Create(WM_MYMESSAGE_UPDATADATABASE, i, ''));
  end;
  FDCommand1.CloseAll;
end;
procedure TDataModule1.ReadStocksFromMyStocksTable(userName: string; Category: Integer; Stocks: TStringList);
var
  i: Integer;
  sql,stkCode, stkName,Comments: String;
begin
  FDQuery1.Close;
  FDQuery1.sql.Clear;
  sql := 'select * from tb_mystocks where userName=' + QuotedStr(userName)+ ' and '+  'category ='+ IntToStr(Category);
  FDQuery1.Open(sql);
  if FDQuery1.RecordCount <= 0 then
    Exit;
  i:=0;
  FDQuery1.First;
  while not FDQuery1.Eof do
  begin
    stkCode := FDQuery1.FieldByName('stkCode').Value; // Fields[1].AsString;
    stkName := FDQuery1.FieldByName('stkName').Value;
    Category := FDQuery1.FieldByName('category').Value;
    Comments := FDQuery1.FieldByName('comments').Value;

    Stocks.Add(stkCode+'@'+stkName+'@'+'D');
    FDQuery1.Next;
    MQueue.SendMessage(TMyMessage.Create(WM_MYMESSAGE_UPDATADATABASE, i, ''));
    INC(i);
  end;
  FDQuery1.Close;
end;
procedure TDataModule1.ReadStockCommentsFromMyStocksTable(userName: string; Category: Integer;stkobj: TStockObject);
var
  i: Integer;
  sql,stkCode, stkName,Comments: String;
begin
  FDQuery1.Close;
  FDQuery1.sql.Clear;
  sql := 'select * from tb_mystocks where userName=' + QuotedStr(userName)+ ' and '{+  'category ='+ IntToStr(Category) + ' and '}
          + 'stkCode=' +   QuotedStr(stkobj.StkCode);
  FDQuery1.Open(sql);
  if FDQuery1.RecordCount <> 1 then
    Exit;

  FDQuery1.First;
  Comments := FDQuery1.FieldByName('comments').Value;

  FDQuery1.Close;
end;

procedure TDataModule1.InitStocksFromDatabase(StringList: TStringList);
var
  sql, stkCode, stkName: String;
  Category: String;
  Market: Byte;
  i: Integer;
  stkobj: TStockObject;
begin
  FDQuery1.Close;
  FDQuery1.sql.Clear;
  sql := 'select * from tb_stocks ';
  FDQuery1.Open(sql);
  if FDQuery1.RecordCount <= 0 then
    Exit;

  FDQuery1.First;
  while not FDQuery1.Eof do
  begin
    stkCode := FDQuery1.FieldByName('stkCode').Value; // Fields[1].AsString;
    stkName := FDQuery1.FieldByName('stkName').Value;
    Market := FDQuery1.FieldByName('market').Value;
    Category := FDQuery1.FieldByName('category').Value;
    stkobj := TStockObject.Create(stkCode, stkName); // 创建股票对象  后续加入证券池

    stkobj.Market := Market;
    stkobj.Category := Category;
    StringList.AddObject(stkobj.GetLevelKey(), stkobj);
    FDQuery1.Next;
  end;
  FDQuery1.Close;
end;

end.

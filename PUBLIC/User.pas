unit User;

interface

uses System.IniFiles,
  System.SysUtils;

type
  TUser = class
  private
    FName: String;
    FPassWord: String;
  protected
  public
    constructor Create(name: String; PassWord: String; FilePath: String);
    destructor Destroy;

    function getUserName(FilePath: String): String;

    property Name: String read FName;
    property PassWord: String read FPassWord;

  end;

implementation

constructor TUser.Create(name: String; PassWord: String; FilePath: String);
var
  IniFile: TIniFile;
begin
  FName := name;
  FPassWord := PassWord;
  if (FName <> '') then
  begin
    try
      IniFile := TIniFile.Create(FilePath);
      IniFile.WriteString('', 'UserName', FName);
    finally
      IniFile.Free;
    end
  end
  else 
  begin
    FName := getUserName(FilePath);
  end;
end;

destructor TUser.Destroy;
begin
end;

function TUser.getUserName(FilePath: String): String;
var
  IniFile: TIniFile;
  a, b, c, d, e, f,g: Integer;
begin
  result := '';
  try
    IniFile := TIniFile.Create(FilePath);
    FName := IniFile.ReadString('', 'UserName', '');
    if (FName = '') then
    begin
      Randomize; // 初始化，也可以将值赋予 RandSeed
      a := Random(9); // 生成 大于等于0且小于1000 的随机数
      b := Random(9);
      c := Random(9);
      d := Random(9);
      e := Random(9);
      f := Random(9);
      g := Random(9);
      FName := IntToStr(a) + IntToStr(b) + IntToStr(c) + IntToStr(d) +  IntToStr(e) + IntToStr(f)+ IntToStr(g);
      IniFile.WriteString('', 'UserName', FName);
    end;
  finally
    IniFile.Free;
    result := Name;
  end;

end;

end.

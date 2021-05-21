unit DataEngine;

interface

uses SysUtils, Classes, Windows,
  ExtCtrls, MATH, Messages, SyncObjs, System.Threading,
   GlobalConst, GlobalTypes, GlobalFunctions,
   MyMessageQueue, ClientObject;

type
  TProc = procedure() of object;

  TDataEngineManager = class(TThread)
  private
    FThreadPool: TThreadPool;
    FWorkingStatus: Integer;
    FTaskIndex: Integer; // 正在工作的线程计数
    FTaskWorkingCount: Integer;

    FTaskOBJList: TStringList;
    DataSourceCriticalSection: TCriticalSection;
    Procedure CreateTasksInPool();
    procedure TaskFunction();
    procedure CallActionInterface(IP: String);
  protected
    procedure Execute; override; { 执行 }
  public
    Constructor Create();
    Destructor Destroy; override;
    procedure Stop();

    procedure DoIt(task: TProc);

    function Add(name: String; obj: TObject): TObject;
    function Get(name: String): TObject;
    function Has(name: String): Boolean;
  end;

var
  DataEngineManager: TDataEngineManager;

implementation

Constructor TDataEngineManager.Create();
begin
  inherited Create(true);
  FreeOnTerminate := true;
  FThreadPool := TThreadPool.Create();
  FThreadPool.SetMinWorkerThreads(200);
  FThreadPool.SetMaxWorkerThreads(2000);
  // FMaxTaskCount:=256;
  FTaskIndex := 0;
  FTaskWorkingCount := 0;
  FWorkingStatus := 0;
  // FHandle := Handle;

  FTaskOBJList := TStringList.Create;
  FTaskOBJList.OwnsObjects := true; // 清空列表自动释放里面的项目
  DataSourceCriticalSection := TCriticalSection.Create;
end;

Destructor TDataEngineManager.Destroy;
begin
  inherited;
  FThreadPool.CleanupInstance;
  FThreadPool.Free;
  Terminate;
  FTaskOBJList.CleanupInstance;
  FTaskOBJList.Clear;
  FTaskOBJList.Free;
  DataSourceCriticalSection.Free;
end;

procedure TDataEngineManager.Stop;
var
  i: Integer;
  ClientObject: TClientObject;
begin
  for i := 0 to FTaskOBJList.Count - 1 do
  begin
    ClientObject := TClientObject(FTaskOBJList.Objects[i]);
    if ClientObject <> nil then
      ClientObject.Free;
  end;
  Self.Terminate;
end;

procedure TDataEngineManager.DoIt(task: TProc);
begin
  TTask.Create(task, FThreadPool).start;
end;

procedure TDataEngineManager.Execute;
begin
  while not Terminated do
  begin
    case FWorkingStatus of
      0: // 状态选择默认模式
        begin
        end;
      1: // 工作模式 1
        begin // update K Line

        end;
      2: // 工作模式 2
        begin
          CreateTasksInPool();
          // Sleep(60000);
          FWorkingStatus := 0; // 目标数据源反爬虫每天只能刷新一遍
        end;
    else
      begin
        Sleep(1000);
      end;
    end;

  end; // while not Self.Terminated and FRunning do

end;

// 线程池批量处理入口
Procedure TDataEngineManager.CreateTasksInPool();
var
  task: ITask;
  i: Integer;
begin
  FTaskWorkingCount := FTaskOBJList.Count;
  for i := FTaskIndex to FTaskOBJList.Count - 1 do
  begin
    task := TTask.Create(TaskFunction, FThreadPool);
    task.start;
  end;

end;

/// //////////////////////////////////////////////////////////////////////////////////////////////////
// 线程池批量处理函数
procedure TDataEngineManager.TaskFunction();
var
  IP: String;
begin
  IP := '';

  DataSourceCriticalSection.Enter;
  if (FTaskIndex < FTaskOBJList.Count) and (FTaskIndex >= 0) then
  begin
    IP := FTaskOBJList.Strings[FTaskIndex];
  end;
  INC(FTaskIndex);
  DataSourceCriticalSection.Leave;

  MQueue.SendMessage(TMyMessage.Create(WM_MYMESSAGE_DATAENGINE_CREATE, FTaskIndex, ''));

  /// //////////////////////////////////////////////////////////////////////////////////
  /// 调用特定功能函数
  CallActionInterface(IP);
  /// //////////////////////////////////////////////////////////////////////////////////

end;

/// //////////////////////////////////////////////////////////////////////////////////
/// //////////////////////////////////////////////////////////////////////////////////
/// //////////////////////////////////////////////////////////////////////////////////
// 线程池批量最终数据源函数
procedure TDataEngineManager.CallActionInterface(IP: String);
begin

  MQueue.SendMessage(TMyMessage.Create(WM_MYMESSAGE_DATAENGINE_WORKING_DONE, FTaskOBJList.Count - FTaskWorkingCount, IP));
end;

function TDataEngineManager.Add(name: String; obj: TObject): TObject;
begin
  if FTaskOBJList.IndexOf(name) < 0 then
  begin
    FTaskOBJList.AddObject(name, obj);
  end;
end;

function TDataEngineManager.Get(name: String): TObject;
var
  i: Integer;
begin
  Result := nil;
  i := FTaskOBJList.IndexOf(name);
  if i >= 0 then
  begin
    Result := FTaskOBJList.Objects[i];
  end;
end;

function TDataEngineManager.Has(name: String): Boolean;
var
  i: Integer;
begin
  Result := false;
  i := FTaskOBJList.IndexOf(name);
  if i >= 0 then
  begin
    Result := true;
  end;
end;

initialization

DataEngineManager := TDataEngineManager.Create();

finalization
DataEngineManager.Stop;
//DataEngineManager.Free;

end.

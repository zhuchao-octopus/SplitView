unit DataEngine;

interface

uses SysUtils, Classes, Windows,
  ExtCtrls, MATH, Messages, SyncObjs, System.Threading,
  System.json, GlobalConst, GlobalTypes, GlobalFunctions,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdHTTP, IdSSLOpenSSL, MyMessageQueue, WinInet, Ping;

type
  TDataEngineManager = class(TThread)
  private
    FThreadPool: TThreadPool;
    FWorkingStatus: Integer;
    FTaskIndex: Integer; // 正在工作的线程计数
    FTaskWorkingCount: Integer;

    FHandle: HWND;
    // FMaxTaskCount:Integer;

    FTaskOBJList: TStringList;
    procedure Execute; override; { 执行 }
    Procedure CreateTaskInPool();
    procedure TaskFunction();
    procedure CallActionInterface(IP: String);

  protected
  public
    Constructor Create(Handle: HWND);
    Destructor Destroy; override;
    procedure StartScan();
  end;

var
  DataSourceCriticalSection: TCriticalSection;

implementation

Constructor TDataEngineManager.Create(Handle: HWND);
begin
  inherited Create(true);
  FThreadPool := TThreadPool.Create();
  FThreadPool.SetMinWorkerThreads(200);
  FThreadPool.SetMaxWorkerThreads(2000);
  // FMaxTaskCount:=256;
  FTaskIndex := 0;
  FTaskWorkingCount := 0;
  FWorkingStatus := 0;
  FHandle := Handle;

  FTaskOBJList := TStringList.Create;
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
          CreateTaskInPool();
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
Procedure TDataEngineManager.CreateTaskInPool();
var
  Task: ITask;
  i: Integer;
begin
  FTaskWorkingCount := FTaskOBJList.Count;
  for i := FTaskIndex to FTaskOBJList.Count - 1 do
  begin
    Task := TTask.Create(TaskFunction, FThreadPool);
    Task.Start;
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

  CallActionInterface(IP);
end;

/// //////////////////////////////////////////////////////////////////////
// 线程池批量最终数据源函数
procedure TDataEngineManager.CallActionInterface(IP: String);
var
  port: Integer;
  b: boolean;
  //rr: String;
begin
  port := 554;
  b := false;
  // iIP := IPToInt64(IP);
  if IsValidIP(IP) then
    b := CheckIpPort(IP, port);
  if (b) then
    MQueue.SendMessage(TMyMessage.Create(WM_MYMESSAGE_TASK_COMPLETEOK, port, IP));

  // 任务返回
  DataSourceCriticalSection.Enter;
  DEC(FTaskWorkingCount);
  DataSourceCriticalSection.Leave;


  MQueue.SendMessage(TMyMessage.Create(WM_MYMESSAGE_DATAENGINE_WORKING_DONE,FTaskOBJList.Count - FTaskWorkingCount, IP));
end;

procedure TDataEngineManager.StartScan();
var
  i: Integer;
  IP: String;
begin

  if FWorkingStatus <> 0 then
  begin
    exit;
  end;

  if FTaskWorkingCount >0 then
  begin
    Exit;
  end;
  if (FWorkingStatus = 0) then
  begin
    FTaskWorkingCount := 0;
    FTaskIndex :=0;
    FTaskOBJList.Clear;
  end;

  if FTaskOBJList.Count <= 0 then
  begin
    for i := 0 to 255 do
    begin
      IP := '192.168.0.' + IntToStr(i);
      FTaskOBJList.Add(IP);
    end;
  end;
  // FTaskOBJList.Add('192.168.0.34');
  // FTaskOBJList.Add('192.168.0.63');
  if FWorkingStatus <> 2 then
  begin
    FWorkingStatus := 2;
  end;
  if Suspended then
  begin
    Start;
  end;
end;

initialization

DataSourceCriticalSection := TCriticalSection.Create;

finalization
DataSourceCriticalSection.Free;
end.

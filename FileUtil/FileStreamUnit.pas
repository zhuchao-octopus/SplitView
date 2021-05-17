unit FileStreamUnit;

interface
uses
    Windows, Messages, Classes,SysUtils;






Procedure BufferSaveToFile(Const pBuff;FileName:String;Count: Longint);
Procedure BufferReadFromFile(var Buffer;FileName:String;Count: Longint);

implementation


Procedure BufferSaveToFile(Const pBuff;FileName:String;Count: Longint);
var
   FileStream:TFileStream;
begin
  try
   FileStream:=TFileStream.Create(FileName,fmCreate);

   FileStream.WriteBuffer(pBuff,Count);
   
  finally
   FileStream.Free;
  end;
   
end;

Procedure BufferReadFromFile(var Buffer;FileName:String;Count: Longint);
var
   FileStream:TFileStream;
begin

  try
   FileStream:=TFileStream.Create(FileName,fmOpenRead);
   FileStream.Seek(17374,soFromBeginning);
   FileStream.ReadBuffer(Buffer,17374);
  finally
   if(FileStream<>nil) then
   FileStream.Free;
  end;
   
end;

function GetFileSize(sFileName: string;
  FileStream: TFileStream = nil): Int64;
begin
  Result := 0;
  try
    if (FileStream = nil) then
    begin
      if not FileExists(sFileName) then
        Exit;
      FileStream := TFileStream.Create(sFileName, fmOpenRead);
    end;

    FileStream.Seek(0, soFromEnd);
    Result := FileStream.Size;

  finally
    FileStream.Free;
  end;

end;

function RecordReadFromFile(var RecordBuffer; RecordSize: integer;
  RemainRecordCount: integer; FileStream: TFileStream; sFileName: string;
  RecordIndex: Int64 = 0): TFileStream;
begin
  Result := nil;
  try
    if (FileStream = nil) then
    begin
      if not FileExists(sFileName) then
        Exit;
      FileStream := TFileStream.Create(sFileName, fmOpenRead);
    end;

    FileStream.Seek(RecordIndex * RecordSize, soFromBeginning);

    FileStream.ReadBuffer(RecordBuffer, RecordSize);

    if (RemainRecordCount > 0) then
      Result := FileStream
    else
    begin
      FileStream.Free;
      Result := nil;
    end;
  except
    Result := nil;
    FileStream.Free;
  end;

end;

end.

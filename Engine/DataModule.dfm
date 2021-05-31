object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 390
  Width = 459
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=oplayer'
      'User_Name=oplayer'
      'Password=4TFRMir7RafSisxY'
      'Server=47.106.172.94'
      'CharacterSet=utf8'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 160
    Top = 56
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    ScreenCursor = gcrNone
    Left = 56
    Top = 56
  end
  object FDCommand1: TFDCommand
    Connection = FDConnection1
    Left = 136
    Top = 288
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from tb_stocks')
    Left = 224
    Top = 160
  end
end

object GSettingfrm: TGSettingfrm
  Left = 0
  Top = 0
  Margins.Top = 8
  Caption = #23631#24149#25340#25509
  ClientHeight = 488
  ClientWidth = 1052
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = #26032#23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 16
  object GroupBox5: TGroupBox
    Left = 452
    Top = 35
    Width = 565
    Height = 430
    Caption = #22352#24109#25340#25509#25511#21046
    TabOrder = 0
    object StringGrid1: TStringGrid
      AlignWithMargins = True
      Left = 10
      Top = 26
      Width = 545
      Height = 394
      Margins.Left = 8
      Margins.Top = 8
      Margins.Right = 8
      Margins.Bottom = 8
      Align = alClient
      ColCount = 6
      DefaultColWidth = 80
      DefaultRowHeight = 60
      FixedCols = 0
      RowCount = 6
      FixedRows = 0
      GridLineWidth = 2
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goAlwaysShowEditor, goFixedRowDefAlign]
      ParentColor = True
      TabOrder = 0
      OnKeyPress = StringGrid1KeyPress
    end
  end
  object GroupBox3: TGroupBox
    Left = 32
    Top = 35
    Width = 385
    Height = 182
    Caption = #35270#39057#22681#25340#25509#22823#23567#23610#23544#35774#32622
    TabOrder = 1
    object Label6: TLabel
      Left = 32
      Top = 54
      Width = 72
      Height = 16
      Caption = #35270#39057#22681#34892':'
    end
    object Label7: TLabel
      Left = 32
      Top = 91
      Width = 80
      Height = 16
      Caption = #35270#39057#22681#21015#65306
    end
    object SpinEdit1: TSpinEdit
      Left = 120
      Top = 51
      Width = 121
      Height = 26
      MaxValue = 15
      MinValue = 1
      TabOrder = 0
      Value = 2
    end
    object SpinEdit2: TSpinEdit
      Left = 120
      Top = 88
      Width = 121
      Height = 26
      MaxValue = 15
      MinValue = 1
      TabOrder = 1
      Value = 2
    end
    object Button16: TButton
      Left = 264
      Top = 51
      Width = 75
      Height = 63
      Caption = #35774#32622
      TabOrder = 2
      OnClick = Button16Click
    end
  end
  object Button19: TButton
    Left = 113
    Top = 304
    Width = 160
    Height = 59
    Caption = #30830#35748#25340#25509
    TabOrder = 2
    OnClick = Button19Click
  end
end

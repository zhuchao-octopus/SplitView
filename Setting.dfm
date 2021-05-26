object frmSetting: TfrmSetting
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #20806#31185#38899#35270#39057#22352#24109#31649#29702#35774#32622
  ClientHeight = 529
  ClientWidth = 1046
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = #26032#23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object PageControl1: TPageControl
    AlignWithMargins = True
    Left = 5
    Top = 5
    Width = 1036
    Height = 519
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    ActivePage = TabSheet2
    Align = alClient
    TabOrder = 0
    object TabSheet2: TTabSheet
      Caption = #22352#24109#20027#26426#36830#25509#26435#38480
      ImageIndex = 1
      object ListView1: TListView
        AlignWithMargins = True
        Left = 291
        Top = 3
        Width = 286
        Height = 481
        Align = alLeft
        BorderStyle = bsNone
        Checkboxes = True
        Columns = <
          item
            Caption = 'ID'
            Width = 80
          end
          item
            Caption = #20027#26426'TX'#21517#31216
            Width = 200
          end>
        GridLines = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
      end
      object ListView2: TListView
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 282
        Height = 481
        Align = alLeft
        BorderStyle = bsNone
        Checkboxes = True
        Columns = <
          item
            Caption = 'ID'
            Width = 80
          end
          item
            Caption = #20027#26426'TX'#21517#31216
            Width = 200
          end>
        GridLines = True
        RowSelect = True
        TabOrder = 1
        ViewStyle = vsReport
      end
      object ListView3: TListView
        AlignWithMargins = True
        Left = 583
        Top = 3
        Width = 250
        Height = 481
        Align = alLeft
        BorderStyle = bsNone
        Checkboxes = True
        Columns = <
          item
            Caption = 'ID'
            Width = 80
          end
          item
            Caption = #20027#26426'TX'#21517#31216
            Width = 200
          end>
        GridLines = True
        ReadOnly = True
        RowSelect = True
        TabOrder = 2
        ViewStyle = vsReport
      end
      object Button4: TButton
        Left = 832
        Top = 29
        Width = 185
        Height = 40
        Caption = #21047#26032#22352#24109
        TabOrder = 3
        OnClick = Button4Click
      end
      object Button5: TButton
        Left = 832
        Top = 75
        Width = 185
        Height = 40
        Caption = #20445#23384#22352#24109
        TabOrder = 4
        OnClick = Button5Click
      end
    end
    object TabSheet3: TTabSheet
      Caption = #22352#24109#20027#26426#25512#36865#26435#38480
      ImageIndex = 2
      object Button6: TButton
        Left = 832
        Top = 75
        Width = 185
        Height = 40
        Caption = #20445#23384#22352#24109
        TabOrder = 0
        OnClick = Button6Click
      end
      object Button7: TButton
        Left = 832
        Top = 29
        Width = 185
        Height = 40
        Caption = #21047#26032#22352#24109
        TabOrder = 1
        OnClick = Button7Click
      end
      object ListView4: TListView
        AlignWithMargins = True
        Left = 515
        Top = 3
        Width = 294
        Height = 481
        Align = alLeft
        BorderStyle = bsNone
        Checkboxes = True
        Columns = <
          item
            Caption = #22352#24109'ID'
            Width = 80
          end
          item
            Caption = #22352#24109#21517#31216
            Width = 200
          end>
        GridLines = True
        ReadOnly = True
        RowSelect = True
        TabOrder = 2
        ViewStyle = vsReport
      end
      object ListView5: TListView
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 250
        Height = 481
        Align = alLeft
        BorderStyle = bsNone
        Checkboxes = True
        Columns = <
          item
            Caption = #22352#24109'ID'
            Width = 80
          end
          item
            Caption = #22352#24109#21517#31216
            Width = 200
          end>
        GridLines = True
        ReadOnly = True
        RowSelect = True
        TabOrder = 3
        ViewStyle = vsReport
      end
      object ListView6: TListView
        AlignWithMargins = True
        Left = 259
        Top = 3
        Width = 250
        Height = 481
        Align = alLeft
        BorderStyle = bsNone
        Checkboxes = True
        Columns = <
          item
            Caption = #22352#24109'ID'
            Width = 80
          end
          item
            Caption = #22352#24109#21517#31216
            Width = 200
          end>
        GridLines = True
        ReadOnly = True
        RowSelect = True
        TabOrder = 4
        ViewStyle = vsReport
      end
    end
    object TabSheet4: TTabSheet
      Caption = #22352#24109#25509#31649#26435#38480
      ImageIndex = 3
      object Button8: TButton
        Left = 832
        Top = 75
        Width = 185
        Height = 40
        Caption = #20445#23384#22352#24109
        TabOrder = 0
        OnClick = Button8Click
      end
      object Button9: TButton
        Left = 832
        Top = 29
        Width = 185
        Height = 40
        Caption = #21047#26032#22352#24109
        TabOrder = 1
        OnClick = Button9Click
      end
      object ListView7: TListView
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 286
        Height = 481
        Align = alLeft
        BorderStyle = bsNone
        Checkboxes = True
        Columns = <
          item
            Caption = #22352#24109'ID'
            Width = 80
          end
          item
            Caption = #22352#24109#21517#31216
            Width = 200
          end>
        GridLines = True
        ReadOnly = True
        RowSelect = True
        TabOrder = 2
        ViewStyle = vsReport
      end
      object ListView8: TListView
        AlignWithMargins = True
        Left = 295
        Top = 3
        Width = 282
        Height = 481
        Align = alLeft
        BorderStyle = bsNone
        Checkboxes = True
        Columns = <
          item
            Caption = #22352#24109'ID'
            Width = 80
          end
          item
            Caption = #22352#24109#21517#31216
            Width = 200
          end>
        GridLines = True
        ReadOnly = True
        RowSelect = True
        TabOrder = 3
        ViewStyle = vsReport
      end
      object ListView9: TListView
        AlignWithMargins = True
        Left = 583
        Top = 3
        Width = 282
        Height = 481
        Align = alLeft
        BorderStyle = bsNone
        Checkboxes = True
        Columns = <
          item
            Caption = #22352#24109'ID'
            Width = 80
          end
          item
            Caption = #22352#24109#21517#31216
            Width = 200
          end>
        GridLines = True
        ReadOnly = True
        RowSelect = True
        TabOrder = 4
        ViewStyle = vsReport
      end
    end
    object TabSheet5: TTabSheet
      Caption = #22352#24109#36328#23631#35774#32622
      ImageIndex = 5
    end
    object TabSheet8: TTabSheet
      Caption = #20854#23427
      ImageIndex = 7
      object GroupBox1: TGroupBox
        Left = 19
        Top = 19
        Width = 366
        Height = 134
        Caption = #20462#25913' IP'
        TabOrder = 0
        object Label1: TLabel
          Left = 16
          Top = 40
          Width = 96
          Height = 16
          Caption = #26032' IP '#22320#22336#65306
        end
        object Button1: TButton
          Left = 238
          Top = 78
          Width = 81
          Height = 33
          Caption = #24212#29992#20462#25913
          TabOrder = 0
          OnClick = Button1Click
        end
        object Edit1: TEdit
          Left = 118
          Top = 37
          Width = 201
          Height = 24
          TabOrder = 1
          OnKeyPress = Edit1KeyPress
        end
      end
      object GroupBox2: TGroupBox
        Left = 448
        Top = 19
        Width = 321
        Height = 134
        Caption = 'LED '#28783#24320#20851#27979#35797
        TabOrder = 1
        object Button2: TButton
          Left = 24
          Top = 38
          Width = 81
          Height = 80
          Caption = #24320' LED'
          TabOrder = 0
          OnClick = Button2Click
        end
        object Button3: TButton
          Left = 128
          Top = 38
          Width = 81
          Height = 80
          Caption = #20851' LED'
          TabOrder = 1
          OnClick = Button3Click
        end
      end
    end
  end
end

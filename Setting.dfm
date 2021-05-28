object frmSetting: TfrmSetting
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #20806#31185#38899#35270#39057#22352#24109#31649#29702#35774#32622
  ClientHeight = 539
  ClientWidth = 1100
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = #26032#23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object PageControl1: TPageControl
    AlignWithMargins = True
    Left = 10
    Top = 10
    Width = 1080
    Height = 519
    Margins.Left = 10
    Margins.Top = 10
    Margins.Right = 10
    Margins.Bottom = 10
    ActivePage = TabSheet4
    Align = alClient
    TabOrder = 0
    object TabSheet2: TTabSheet
      Caption = #22352#24109#20027#26426#36830#25509#26435#38480
      ImageIndex = 1
      OnShow = TabSheet2Show
      object ListView1: TListView
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 290
        Height = 481
        Align = alLeft
        BorderStyle = bsNone
        Checkboxes = True
        Columns = <
          item
            Caption = #20027#26426'ID'
            Width = 80
          end
          item
            Caption = #20027#26426' TX OSD '#21517#31216
            Width = 200
          end>
        GridLines = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
        OnDblClick = ListView1DblClick
      end
      object ListView2: TListView
        AlignWithMargins = True
        Left = 299
        Top = 3
        Width = 290
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
            Caption = #20027#26426' TX OSD '#21517#31216
            Width = 200
          end>
        GridLines = True
        RowSelect = True
        TabOrder = 1
        ViewStyle = vsReport
        OnDblClick = ListView2DblClick
      end
      object ListView3: TListView
        AlignWithMargins = True
        Left = 595
        Top = 3
        Width = 290
        Height = 481
        Align = alLeft
        BorderStyle = bsNone
        Checkboxes = True
        Columns = <
          item
            Caption = #20027#26426'ID'
            Width = 80
          end
          item
            Caption = #20027#26426' TX OSD '#21517#31216
            Width = 200
          end>
        GridLines = True
        ReadOnly = True
        RowSelect = True
        TabOrder = 2
        ViewStyle = vsReport
        OnDblClick = ListView3DblClick
      end
      object Button4: TButton
        Left = 918
        Top = 42
        Width = 120
        Height = 40
        Caption = #21047#26032#20027#26426
        TabOrder = 3
        OnClick = Button4Click
      end
      object Button5: TButton
        Left = 918
        Top = 88
        Width = 120
        Height = 40
        Caption = #20445#23384#20027#26426
        TabOrder = 4
        OnClick = Button5Click
      end
      object Button10: TButton
        Left = 918
        Top = 344
        Width = 120
        Height = 40
        Caption = #21453#36873
        TabOrder = 5
        OnClick = Button10Click
      end
      object Button11: TButton
        Left = 918
        Top = 390
        Width = 120
        Height = 40
        Caption = #20840#36873
        TabOrder = 6
        OnClick = Button11Click
      end
    end
    object TabSheet3: TTabSheet
      Caption = #22352#24109#25512#36865#26435#38480
      ImageIndex = 2
      OnShow = TabSheet3Show
      object Button6: TButton
        Left = 918
        Top = 88
        Width = 120
        Height = 40
        Caption = #20445#23384#22352#24109
        TabOrder = 0
        OnClick = Button6Click
      end
      object Button7: TButton
        Left = 918
        Top = 42
        Width = 120
        Height = 40
        Caption = #21047#26032#22352#24109
        TabOrder = 1
        OnClick = Button7Click
      end
      object ListView4: TListView
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 290
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
        OnDblClick = ListView4DblClick
      end
      object ListView5: TListView
        AlignWithMargins = True
        Left = 299
        Top = 3
        Width = 290
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
        OnDblClick = ListView5DblClick
      end
      object ListView6: TListView
        AlignWithMargins = True
        Left = 595
        Top = 3
        Width = 290
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
        OnDblClick = ListView6DblClick
      end
      object Button12: TButton
        Left = 918
        Top = 344
        Width = 120
        Height = 40
        Caption = #21453#36873
        TabOrder = 5
        OnClick = Button12Click
      end
      object Button13: TButton
        Left = 918
        Top = 390
        Width = 120
        Height = 40
        Caption = #20840#36873
        TabOrder = 6
        OnClick = Button13Click
      end
    end
    object TabSheet4: TTabSheet
      Caption = #22352#24109#25509#31649#26435#38480
      ImageIndex = 3
      OnShow = TabSheet4Show
      object Button8: TButton
        Left = 918
        Top = 88
        Width = 120
        Height = 40
        Caption = #20445#23384#22352#24109
        TabOrder = 0
        OnClick = Button8Click
      end
      object Button9: TButton
        Left = 918
        Top = 42
        Width = 120
        Height = 40
        Caption = #21047#26032#22352#24109
        TabOrder = 1
        OnClick = Button9Click
      end
      object ListView7: TListView
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 290
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
        OnDblClick = ListView7DblClick
      end
      object ListView8: TListView
        AlignWithMargins = True
        Left = 299
        Top = 3
        Width = 290
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
        OnDblClick = ListView8DblClick
      end
      object ListView9: TListView
        AlignWithMargins = True
        Left = 595
        Top = 3
        Width = 290
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
        OnDblClick = ListView9DblClick
      end
      object Button14: TButton
        Left = 918
        Top = 344
        Width = 120
        Height = 40
        Caption = #21453#36873
        TabOrder = 5
        OnClick = Button14Click
      end
      object Button15: TButton
        Left = 918
        Top = 390
        Width = 120
        Height = 40
        Caption = #20840#36873
        TabOrder = 6
        OnClick = Button15Click
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
        Left = 43
        Top = 35
        Width = 486
        Height = 374
        Caption = #20462#25913#35774#22791#20449#24687
        TabOrder = 0
        object Label1: TLabel
          Left = 16
          Top = 119
          Width = 64
          Height = 16
          Caption = 'IP'#22320#22336#65306
        end
        object Label2: TLabel
          Left = 16
          Top = 46
          Width = 80
          Height = 16
          Caption = #35774#22791#21517#31216#65306
        end
        object Label3: TLabel
          Left = 16
          Top = 82
          Width = 64
          Height = 16
          Caption = #20027#26426'ID'#65306
        end
        object Label4: TLabel
          Left = 16
          Top = 155
          Width = 80
          Height = 16
          Caption = #23376#32593#25513#30721#65306
        end
        object Label5: TLabel
          Left = 16
          Top = 192
          Width = 80
          Height = 16
          Caption = #32593#20851#22320#22336#65306
        end
        object Button1: TButton
          Left = 380
          Top = 43
          Width = 88
          Height = 170
          Caption = #24212#29992#20462#25913
          TabOrder = 0
          OnClick = Button1Click
        end
        object Edit1: TEdit
          Left = 94
          Top = 43
          Width = 250
          Height = 24
          Color = clBtnFace
          Enabled = False
          TabOrder = 1
          OnKeyPress = Edit1KeyPress
        end
        object Edit2: TEdit
          Left = 94
          Top = 79
          Width = 250
          Height = 24
          TabOrder = 2
          Text = 'Edit2'
          OnKeyPress = Edit2KeyPress
        end
        object Edit3: TEdit
          Left = 94
          Top = 116
          Width = 250
          Height = 24
          TabOrder = 3
          Text = 'Edit3'
          OnKeyPress = Edit3KeyPress
        end
        object Edit4: TEdit
          Left = 94
          Top = 152
          Width = 250
          Height = 24
          Color = clBtnFace
          Enabled = False
          TabOrder = 4
          Text = '255.255.0.0'
          OnKeyPress = Edit4KeyPress
        end
        object Edit5: TEdit
          Left = 94
          Top = 189
          Width = 250
          Height = 24
          Color = clBtnFace
          Enabled = False
          TabOrder = 5
          Text = 'Edit5'
          OnKeyPress = Edit5KeyPress
        end
      end
      object GroupBox2: TGroupBox
        Left = 547
        Top = 35
        Width = 366
        Height = 374
        Caption = #35774#22791'LED '#28783#24320#20851#27979#35797
        TabOrder = 1
        object Button2: TButton
          Left = 162
          Top = 43
          Width = 80
          Height = 80
          Caption = #24320' LED'
          TabOrder = 0
          OnClick = Button2Click
        end
        object Button3: TButton
          Left = 266
          Top = 43
          Width = 80
          Height = 80
          Caption = #20851' LED'
          TabOrder = 1
          OnClick = Button3Click
        end
      end
    end
  end
end

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
    Left = 3
    Top = 3
    Width = 1040
    Height = 523
    ActivePage = TabSheet2
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 1013
    ExplicitHeight = 522
    object TabSheet2: TTabSheet
      Caption = #22352#24109#20027#26426#36830#25509#26435#38480
      ImageIndex = 1
      ExplicitWidth = 1005
      ExplicitHeight = 490
      object ListView1: TListView
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 250
        Height = 485
        Align = alLeft
        BorderStyle = bsNone
        Checkboxes = True
        Columns = <
          item
            Caption = #24207#21495
          end
          item
            Caption = #22352#24109#21517#31216
            Width = 200
          end>
        TabOrder = 0
        ViewStyle = vsReport
        ExplicitLeft = 96
        ExplicitTop = 144
        ExplicitHeight = 150
      end
      object ListView2: TListView
        AlignWithMargins = True
        Left = 259
        Top = 3
        Width = 250
        Height = 485
        Align = alLeft
        BorderStyle = bsNone
        Checkboxes = True
        Columns = <
          item
            Caption = #24207#21495
          end
          item
            Caption = #22352#24109#21517#31216
            Width = 200
          end>
        TabOrder = 1
        ViewStyle = vsReport
        ExplicitLeft = 368
        ExplicitTop = 144
        ExplicitHeight = 150
      end
      object ListView3: TListView
        AlignWithMargins = True
        Left = 515
        Top = 3
        Width = 250
        Height = 485
        Align = alLeft
        BorderStyle = bsNone
        Checkboxes = True
        Columns = <
          item
            Caption = #24207#21495
          end
          item
            Caption = #22352#24109#21517#31216
            Width = 200
          end>
        TabOrder = 2
        ViewStyle = vsReport
        ExplicitLeft = 728
        ExplicitTop = 200
        ExplicitHeight = 150
      end
      object Button4: TButton
        Left = 832
        Top = 24
        Width = 185
        Height = 40
        Caption = #21047#26032#22352#24109
        TabOrder = 3
        OnClick = Button4Click
      end
      object Button5: TButton
        Left = 832
        Top = 80
        Width = 185
        Height = 40
        Caption = #20445#23384#22352#24109
        TabOrder = 4
      end
    end
    object TabSheet3: TTabSheet
      Caption = #22352#24109#20027#26426#25512#36865#26435#38480
      ImageIndex = 2
      ExplicitWidth = 1005
      ExplicitHeight = 490
    end
    object TabSheet4: TTabSheet
      Caption = #22352#24109#25509#31649#26435#38480
      ImageIndex = 3
      ExplicitWidth = 722
      ExplicitHeight = 340
    end
    object TabSheet5: TTabSheet
      Caption = #22352#24109#20027#26426'OSD'#31649#29702
      ImageIndex = 4
      ExplicitWidth = 1005
      ExplicitHeight = 490
    end
    object TabSheet6: TTabSheet
      Caption = #22352#24109#36328#23631#35774#32622
      ImageIndex = 5
      ExplicitWidth = 1005
      ExplicitHeight = 490
    end
    object TabSheet7: TTabSheet
      Caption = #22352#24109#36830#25509#20027#26426#31649#29702
      ImageIndex = 6
      ExplicitWidth = 1005
      ExplicitHeight = 490
    end
    object TabSheet8: TTabSheet
      Caption = #20854#23427
      ImageIndex = 7
      ExplicitLeft = 0
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

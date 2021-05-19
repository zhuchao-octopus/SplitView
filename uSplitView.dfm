object SplitViewForm: TSplitViewForm
  Left = 0
  Top = 0
  Caption = #20806#31185#38899#35270#39057#22352#24109#31649#29702#31995#32479
  ClientHeight = 663
  ClientWidth = 1112
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 17
  object SV: TSplitView
    Left = 862
    Top = 0
    Width = 250
    Height = 663
    OpenedWidth = 250
    Placement = svpRight
    TabOrder = 0
    ExplicitLeft = 0
    object cbxVclStyles: TComboBox
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 244
      Height = 25
      Align = alTop
      Style = csDropDownList
      TabOrder = 0
      OnChange = cbxVclStylesChange
    end
    object GroupBox1: TGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 34
      Width = 244
      Height = 151
      Align = alTop
      TabOrder = 1
      object Label1: TLabel
        Left = 3
        Top = 18
        Width = 80
        Height = 17
        Caption = #21457#23556#31471' ID'#65306
      end
      object Label2: TLabel
        Left = 6
        Top = 50
        Width = 80
        Height = 17
        Caption = #25509#25910#31471' ID'#65306
      end
      object Edit1: TEdit
        Left = 81
        Top = 10
        Width = 156
        Height = 25
        TabOrder = 0
        Text = 'Edit1'
        OnKeyPress = Edit1KeyPress
      end
      object Edit2: TEdit
        Left = 81
        Top = 42
        Width = 156
        Height = 25
        TabOrder = 1
        Text = 'Edit2'
        OnKeyPress = Edit2KeyPress
      end
      object Button1: TButton
        Left = 3
        Top = 78
        Width = 234
        Height = 48
        Caption = #36830#25509#21305#37197
        TabOrder = 2
      end
    end
  end
  object Notebook1: TNotebook
    Left = 0
    Top = 0
    Width = 862
    Height = 663
    Align = alClient
    TabOrder = 1
    ExplicitLeft = 200
    ExplicitTop = 50
    ExplicitWidth = 894
    ExplicitHeight = 721
    object TPage
      Left = 0
      Top = 0
      Caption = #33410#28857#35774#22791#31649#29702
      ExplicitWidth = 894
      ExplicitHeight = 721
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 862
        Height = 663
        Align = alClient
        BevelOuter = bvNone
        Color = clWindow
        ParentBackground = False
        TabOrder = 0
        object Splitter1: TSplitter
          Left = 0
          Top = 495
          Width = 862
          Height = 3
          Cursor = crVSplit
          Align = alBottom
          Color = clBtnFace
          ParentColor = False
          ExplicitTop = 96
          ExplicitWidth = 432
        end
        object ListView1: TListView
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 408
          Height = 489
          Margins.Right = 1
          Align = alLeft
          Columns = <
            item
              Caption = #21517#31216
              Width = 100
            end
            item
              Caption = #26631#35760
            end
            item
              Caption = #32593#32476#22320#22336
              Width = 100
            end
            item
              Caption = #31471#21475
            end
            item
              Caption = #32593#21345#22320#22336
              Width = 100
            end
            item
              Caption = #31867#22411
            end
            item
              Caption = #29366#24577
              Width = 100
            end>
          FlatScrollBars = True
          GridLines = True
          HideSelection = False
          GroupView = True
          ReadOnly = True
          RowSelect = True
          TabOrder = 0
          ViewStyle = vsReport
        end
        object Panel3: TPanel
          Left = 0
          Top = 498
          Width = 862
          Height = 165
          Align = alBottom
          BevelOuter = bvNone
          Caption = 'Panel3'
          Ctl3D = False
          ParentBackground = False
          ParentColor = True
          ParentCtl3D = False
          TabOrder = 1
          object Memo1: TMemo
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 856
            Height = 159
            Align = alClient
            Lines.Strings = (
              'Memo1')
            TabOrder = 0
          end
        end
        object ListView2: TListView
          AlignWithMargins = True
          Left = 413
          Top = 3
          Width = 446
          Height = 489
          Margins.Left = 1
          Align = alClient
          Columns = <
            item
              Caption = #21517#31216
              Width = 100
            end
            item
              Caption = #26631#35760
            end
            item
              Caption = #32593#32476#22320#22336
              Width = 100
            end
            item
              Caption = #31471#21475
            end
            item
              Caption = #32593#21345#22320#22336
              Width = 100
            end
            item
              Caption = #31867#22411
            end
            item
              Caption = #29366#24577
              Width = 100
            end>
          FlatScrollBars = True
          GridLines = True
          HideSelection = False
          GroupView = True
          ReadOnly = True
          RowSelect = True
          TabOrder = 2
          ViewStyle = vsReport
        end
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = '1'
      ExplicitWidth = 894
      ExplicitHeight = 721
    end
    object TPage
      Left = 0
      Top = 0
      Caption = '2'
      ExplicitWidth = 894
      ExplicitHeight = 721
    end
    object TPage
      Left = 0
      Top = 0
      Caption = '3'
      ExplicitWidth = 894
      ExplicitHeight = 721
    end
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 80
    Top = 682
  end
  object IdUDPServer1: TIdUDPServer
    Bindings = <>
    DefaultPort = 0
    Left = 128
    Top = 200
  end
  object IdIPMCastClient1: TIdIPMCastClient
    Bindings = <>
    DefaultPort = 0
    MulticastGroup = '224.0.0.1'
    Left = 40
    Top = 200
  end
  object IdTCPClient1: TIdTCPClient
    ConnectTimeout = 0
    Port = 0
    ReadTimeout = -1
    Left = 32
    Top = 264
  end
end

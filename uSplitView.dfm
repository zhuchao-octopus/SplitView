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
  Font.Height = -16
  Font.Name = #26032#23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 16
  object SV: TSplitView
    Left = 862
    Top = 0
    Width = 250
    Height = 663
    OpenedWidth = 250
    Placement = svpRight
    TabOrder = 0
    object cbxVclStyles: TComboBox
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 244
      Height = 24
      Align = alTop
      Style = csDropDownList
      TabOrder = 0
      OnChange = cbxVclStylesChange
    end
    object GroupBox1: TGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 33
      Width = 244
      Height = 128
      Align = alTop
      TabOrder = 1
      object Label1: TLabel
        Left = 3
        Top = 18
        Width = 88
        Height = 16
        Caption = #21457#23556#31471' ID'#65306
      end
      object Label2: TLabel
        Left = 6
        Top = 50
        Width = 88
        Height = 16
        Caption = #25509#25910#31471' ID'#65306
      end
      object Edit1: TEdit
        Left = 81
        Top = 10
        Width = 156
        Height = 24
        TabOrder = 0
        Text = 'Edit1'
        OnKeyPress = Edit1KeyPress
      end
      object Edit2: TEdit
        Left = 81
        Top = 42
        Width = 156
        Height = 24
        TabOrder = 1
        Text = 'Edit2'
        OnKeyPress = Edit2KeyPress
      end
      object Button1: TButton
        Left = 3
        Top = 74
        Width = 235
        Height = 48
        Caption = #36830#25509#21305#37197
        TabOrder = 2
      end
    end
    object GroupBox2: TGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 167
      Width = 244
      Height = 194
      Align = alTop
      TabOrder = 2
      object Label3: TLabel
        Left = 6
        Top = 15
        Width = 56
        Height = 16
        Caption = #22320#22336'IP:'
      end
      object Edit4: TEdit
        Left = 72
        Top = 9
        Width = 121
        Height = 24
        TabOrder = 0
        Text = '225.1.0.0'
      end
    end
    object Button2: TButton
      Left = 6
      Top = 272
      Width = 235
      Height = 46
      Caption = #21457#36865#25968#25454
      TabOrder = 3
      OnClick = Button2Click
    end
    object Edit3: TEdit
      Left = 40
      Top = 224
      Width = 193
      Height = 24
      TabOrder = 4
      Text = '01 00 00 0d'
    end
    object Button3: TButton
      Left = 48
      Top = 367
      Width = 75
      Height = 25
      Caption = 'Button3'
      TabOrder = 5
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 64
      Top = 424
      Width = 75
      Height = 25
      Caption = 'Button4'
      TabOrder = 6
      OnClick = Button4Click
    end
  end
  object Notebook1: TNotebook
    Left = 0
    Top = 0
    Width = 862
    Height = 663
    Align = alClient
    TabOrder = 1
    object TPage
      Left = 0
      Top = 0
      Caption = #33410#28857#35774#22791#31649#29702
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
          Checkboxes = True
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
          ReadOnly = True
          RowSelect = True
          SortType = stBoth
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
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = #26032#23435#20307
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            ScrollBars = ssBoth
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
    end
    object TPage
      Left = 0
      Top = 0
      Caption = '2'
    end
    object TPage
      Left = 0
      Top = 0
      Caption = '3'
    end
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 80
    Top = 682
  end
  object IdUDPServer1: TIdUDPServer
    Active = True
    BroadcastEnabled = True
    Bindings = <>
    DefaultPort = 3334
    ThreadedEvent = True
    OnUDPRead = IdUDPServer1UDPRead
    Left = 304
    Top = 248
  end
  object IdTCPClient1: TIdTCPClient
    ConnectTimeout = 0
    IPVersion = Id_IPv4
    Port = 0
    ReadTimeout = -1
    Left = 32
    Top = 264
  end
end

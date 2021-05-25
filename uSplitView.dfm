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
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 16
  object SV: TSplitView
    AlignWithMargins = True
    Left = 859
    Top = 3
    Width = 250
    Height = 636
    OpenedWidth = 250
    ParentBackground = True
    ParentColor = True
    Placement = svpRight
    TabOrder = 0
    object Notebook2: TNotebook
      Left = 0
      Top = 0
      Width = 250
      Height = 609
      Align = alClient
      Ctl3D = False
      PageIndex = 1
      ParentCtl3D = False
      TabOrder = 0
      object TPage
        Left = 0
        Top = 0
        Caption = #22352#24109#31649#29702
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
          Height = 240
          Align = alTop
          TabOrder = 1
          object Label1: TLabel
            Left = 6
            Top = 16
            Width = 80
            Height = 16
            Caption = #21457#23556#31471'ID'#65306
          end
          object Label2: TLabel
            Left = 6
            Top = 47
            Width = 80
            Height = 16
            Caption = #25509#25910#31471'ID'#65306
          end
          object Edit1: TEdit
            Left = 85
            Top = 10
            Width = 155
            Height = 22
            TabOrder = 0
            OnKeyPress = Edit1KeyPress
          end
          object Edit2: TEdit
            Left = 85
            Top = 42
            Width = 155
            Height = 22
            TabOrder = 1
            OnKeyPress = Edit2KeyPress
          end
          object Button1: TButton
            Left = 3
            Top = 73
            Width = 239
            Height = 40
            Caption = #36830#25509#21305#37197#33410#28857
            TabOrder = 2
          end
          object Button4: TButton
            Left = 123
            Top = 115
            Width = 118
            Height = 40
            Caption = #25628#32034#21457#23556#33410#28857
            TabOrder = 3
            OnClick = Button4Click
          end
          object Button5: TButton
            Left = 3
            Top = 116
            Width = 118
            Height = 40
            Caption = #25628#32034#25509#25910#33410#28857
            TabOrder = 4
            OnClick = Button5Click
          end
          object Button8: TButton
            Left = 3
            Top = 157
            Width = 239
            Height = 40
            Caption = #25628#32034#25152#26377#33410#28857#35774#22791
            TabOrder = 5
            OnClick = Button8Click
          end
        end
      end
      object TPage
        Left = 0
        Top = 0
        Caption = #32593#32476#37197#32622
        object Button3: TButton
          Left = 0
          Top = 489
          Width = 250
          Height = 40
          Align = alBottom
          Caption = #33719#21462#26412#26426#20449#24687
          TabOrder = 0
          OnClick = Button3Click
        end
        object GroupBox3: TGroupBox
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 244
          Height = 134
          Align = alTop
          Caption = #26412#26426#20449#24687
          TabOrder = 1
          object Label4: TLabel
            Left = 6
            Top = 64
            Width = 80
            Height = 16
            Caption = #26412#26426#22320#22336#65306
          end
          object Label5: TLabel
            Left = 6
            Top = 98
            Width = 80
            Height = 16
            Caption = #26412#22320#31471#21475#65306
          end
          object Label8: TLabel
            Left = 6
            Top = 33
            Width = 80
            Height = 16
            Caption = #26412#26426#21517#31216#65306
          end
          object ComboBox1: TComboBox
            Left = 86
            Top = 61
            Width = 155
            Height = 24
            Style = csDropDownList
            Color = clBtnFace
            TabOrder = 0
          end
          object Edit6: TEdit
            Left = 86
            Top = 31
            Width = 155
            Height = 22
            Color = clBtnFace
            ReadOnly = True
            TabOrder = 1
            Text = 'Edit6'
            OnKeyPress = Edit6KeyPress
          end
          object Edit7: TEdit
            Left = 86
            Top = 94
            Width = 155
            Height = 22
            TabOrder = 2
            Text = '3334'
            OnKeyPress = Edit7KeyPress
          end
        end
        object GroupBox2: TGroupBox
          AlignWithMargins = True
          Left = 3
          Top = 143
          Width = 244
          Height = 153
          Align = alTop
          TabOrder = 2
          object Label3: TLabel
            Left = 3
            Top = 16
            Width = 80
            Height = 16
            Caption = #36828#31243#22320#22336#65306
          end
          object Label6: TLabel
            Left = 6
            Top = 49
            Width = 80
            Height = 16
            Caption = #36828#31243#31471#21475#65306
          end
          object Label9: TLabel
            Left = 6
            Top = 80
            Width = 80
            Height = 16
            Caption = #36890#35759#31867#22411#65306
          end
          object Edit5: TEdit
            Left = 86
            Top = 45
            Width = 155
            Height = 22
            TabOrder = 0
            Text = '24'
            OnKeyPress = Edit5KeyPress
          end
          object ComboBox3: TComboBox
            Left = 86
            Top = 11
            Width = 155
            Height = 24
            TabOrder = 1
            Text = '225.1.0.0'
            OnKeyPress = ComboBox3KeyPress
            Items.Strings = (
              '225.1.0.0')
          end
          object ComboBox2: TComboBox
            Left = 92
            Top = 76
            Width = 155
            Height = 24
            Style = csDropDownList
            ItemIndex = 2
            TabOrder = 2
            Text = 'TCP '
            OnChange = ComboBox2Change
            Items.Strings = (
              'UDP'
              'UDP '#26381#21153
              'TCP '
              'TCP '#26381#21153)
          end
          object Button9: TButton
            Left = 6
            Top = 106
            Width = 238
            Height = 40
            Caption = #36830#25509
            TabOrder = 3
            OnClick = Button9Click
          end
        end
        object Button6: TButton
          Left = 0
          Top = 529
          Width = 250
          Height = 40
          Align = alBottom
          Caption = #28165#26970#35774#22791#21015#34920
          TabOrder = 3
          OnClick = Button6Click
        end
        object Button7: TButton
          Left = 0
          Top = 569
          Width = 250
          Height = 40
          Align = alBottom
          Caption = #28165#26970#21382#21490#35760#24405
          TabOrder = 4
          OnClick = Button7Click
        end
        object Button2: TButton
          Left = 3
          Top = 431
          Width = 239
          Height = 46
          Caption = #21457#36865#25968#25454
          TabOrder = 5
          OnClick = Button2Click
        end
        object Memo2: TMemo
          Left = 6
          Top = 303
          Width = 238
          Height = 122
          Lines.Strings = (
            'root'
            'e e_devfind_off')
          ScrollBars = ssVertical
          TabOrder = 6
        end
      end
    end
    object TabSet1: TTabSet
      Left = 0
      Top = 609
      Width = 250
      Height = 27
      Align = alBottom
      DitherBackground = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #26032#23435#20307
      Font.Style = []
      SoftTop = True
      Style = tsModernTabs
      TabHeight = 22
      Tabs.Strings = (
        #22352#24109#31649#29702
        #32593#32476#35843#35797)
      TabIndex = 0
      OnChange = TabSet1Change
    end
  end
  object Notebook1: TNotebook
    Left = 0
    Top = 0
    Width = 856
    Height = 642
    Align = alClient
    TabOrder = 1
    object TPage
      Left = 0
      Top = 0
      Caption = #33410#28857#35774#22791#31649#29702
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 856
        Height = 642
        Align = alClient
        BevelOuter = bvNone
        Color = clWindow
        ParentBackground = False
        TabOrder = 0
        object Splitter1: TSplitter
          Left = 0
          Top = 560
          Width = 856
          Height = 8
          Cursor = crVSplit
          Align = alBottom
          ExplicitTop = 563
          ExplicitWidth = 862
        end
        object Panel3: TPanel
          Left = 0
          Top = 568
          Width = 856
          Height = 74
          Align = alBottom
          ParentColor = True
          TabOrder = 0
          object Memo1: TMemo
            AlignWithMargins = True
            Left = 4
            Top = 4
            Width = 848
            Height = 66
            Align = alClient
            BorderStyle = bsNone
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
        object Panel2: TPanel
          Left = 0
          Top = 0
          Width = 856
          Height = 560
          Align = alClient
          ParentColor = True
          TabOrder = 1
          object Splitter2: TSplitter
            AlignWithMargins = True
            Left = 416
            Top = 4
            Width = 10
            Height = 552
            Color = clBtnFace
            ParentColor = False
          end
          object ListView1: TListView
            AlignWithMargins = True
            Left = 4
            Top = 4
            Width = 408
            Height = 552
            Margins.Right = 1
            Align = alLeft
            BorderStyle = bsNone
            Checkboxes = True
            Columns = <
              item
                Caption = #24207#21495
                Width = -2
                WidthType = (
                  -2)
              end
              item
                Caption = #21517#31216
                Width = -1
                WidthType = (
                  -1)
              end
              item
                Caption = #35774#22791'ID'
                Width = -2
                WidthType = (
                  -2)
              end
              item
                Caption = #32593#32476#22320#22336' IP'
                Width = -1
                WidthType = (
                  -1)
              end
              item
                Caption = #31471#21475
                Width = -1
                WidthType = (
                  -1)
              end
              item
                Caption = #32593#21345#22320#22336' MAC'
                Width = -1
                WidthType = (
                  -1)
              end
              item
                Caption = #31867#22411
                Width = -2
                WidthType = (
                  -2)
              end
              item
                Caption = #29366#24577
                Width = -1
                WidthType = (
                  -1)
              end
              item
                Caption = #38899#39057'TX ID'
                Width = -2
                WidthType = (
                  -2)
              end
              item
                Caption = #35270#39057'TX ID'
                Width = -2
                WidthType = (
                  -2)
              end>
            FlatScrollBars = True
            GridLines = True
            HideSelection = False
            ReadOnly = True
            RowSelect = True
            SortType = stBoth
            TabOrder = 0
            ViewStyle = vsReport
            OnClick = ListView1Click
            OnDblClick = ListView1DblClick
          end
          object ListView2: TListView
            AlignWithMargins = True
            Left = 430
            Top = 4
            Width = 422
            Height = 552
            Margins.Left = 1
            Align = alClient
            BorderStyle = bsNone
            Checkboxes = True
            Columns = <
              item
                Caption = #24207#21495
                Width = -2
                WidthType = (
                  -2)
              end
              item
                Caption = #21517#31216
                Width = -1
                WidthType = (
                  -1)
              end
              item
                Caption = #35774#22791'ID'
                Width = -2
                WidthType = (
                  -2)
              end
              item
                Caption = #32593#32476#22320#22336' IP'
                Width = -1
                WidthType = (
                  -1)
              end
              item
                Caption = #31471#21475
                Width = -1
                WidthType = (
                  -1)
              end
              item
                Caption = #32593#21345#22320#22336' MAC'
                Width = -1
                WidthType = (
                  -1)
              end
              item
                Caption = #31867#22411
                Width = -2
                WidthType = (
                  -2)
              end
              item
                Caption = #29366#24577
                Width = -1
                WidthType = (
                  -1)
              end>
            FlatScrollBars = True
            GridLines = True
            HideSelection = False
            ReadOnly = True
            RowSelect = True
            ShowWorkAreas = True
            TabOrder = 1
            ViewStyle = vsReport
            OnClick = ListView2Click
          end
        end
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = '1'
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
    object TPage
      Left = 0
      Top = 0
      Caption = '2'
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
    object TPage
      Left = 0
      Top = 0
      Caption = '3'
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 642
    Width = 1112
    Height = 21
    Panels = <
      item
        Text = '.'
        Width = 100
      end
      item
        Width = 200
      end>
  end
  object IdTCPClient1: TIdTCPClient
    OnStatus = IdTCPClient1Status
    OnDisconnected = IdTCPClient1Disconnected
    OnConnected = IdTCPClient1Connected
    ConnectTimeout = 3000
    IPVersion = Id_IPv4
    Port = 0
    ReadTimeout = -1
    Left = 216
    Top = 248
  end
  object IdAntiFreeze1: TIdAntiFreeze
    Left = 376
    Top = 248
  end
  object Timer1: TTimer
    Interval = 5000
    OnTimer = Timer1Timer
    Left = 144
    Top = 168
  end
  object MessageTimer: TTimer
    Interval = 10
    OnTimer = MessageTimerTimer
    Left = 192
    Top = 160
  end
  object Timer3: TTimer
    Enabled = False
    OnTimer = Timer3Timer
    Left = 240
    Top = 160
  end
end

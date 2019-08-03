object Form1: TForm1
  Left = 221
  Top = 157
  Width = 700
  Height = 325
  Caption = 'MBUS TESTER'
  Color = clBtnFace
  Constraints.MinHeight = 325
  Constraints.MinWidth = 600
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pgConfig: TPageControl
    Left = 0
    Top = 0
    Width = 305
    Height = 293
    ActivePage = TabSheet2
    Align = alLeft
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'COM Setup'
      object Label5: TLabel
        Left = 8
        Top = 8
        Width = 23
        Height = 13
        Caption = 'Port'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 8
        Top = 32
        Width = 59
        Height = 13
        Caption = 'Baud Rate'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 8
        Top = 56
        Width = 52
        Height = 13
        Caption = 'Data Bits'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 8
        Top = 80
        Width = 51
        Height = 13
        Caption = 'Stop Bits'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label9: TLabel
        Left = 8
        Top = 104
        Width = 33
        Height = 13
        Caption = 'Parity'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label10: TLabel
        Left = 8
        Top = 128
        Width = 71
        Height = 13
        Caption = 'Flow Control'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object cbCOMPortSetting: TFlatComboBox
        Left = 86
        Top = 8
        Width = 145
        Height = 21
        Style = csDropDownList
        Color = clWindow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        TabOrder = 0
        ItemIndex = -1
        OnChange = cbCOMPortSettingChange
      end
      object cbCOMBaudrateSetting: TFlatComboBox
        Left = 86
        Top = 32
        Width = 145
        Height = 21
        Style = csDropDownList
        Color = clWindow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        Items.Strings = (
          'Custom'
          '110'
          '300'
          '600'
          '1200'
          '2400'
          '4800'
          '9600'
          '14400'
          '19200'
          '38400'
          '56000'
          '57600'
          '115200')
        ParentFont = False
        TabOrder = 1
        ItemIndex = -1
        OnChange = cbCOMBaudrateSettingChange
      end
      object cbCOMDatabitSetting: TFlatComboBox
        Left = 86
        Top = 56
        Width = 145
        Height = 21
        Style = csDropDownList
        Color = clWindow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        Items.Strings = (
          '5'
          '6'
          '7'
          '8')
        ParentFont = False
        TabOrder = 2
        ItemIndex = -1
        OnChange = cbCOMDatabitSettingChange
      end
      object cbCOMStopBitsetting: TFlatComboBox
        Left = 86
        Top = 80
        Width = 145
        Height = 21
        Style = csDropDownList
        Color = clWindow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        Items.Strings = (
          '1'
          '1.5'
          '2')
        ParentFont = False
        TabOrder = 3
        ItemIndex = -1
        OnChange = cbCOMStopBitsettingChange
      end
      object cbCOMParitySetting: TFlatComboBox
        Left = 86
        Top = 104
        Width = 145
        Height = 21
        Style = csDropDownList
        Color = clWindow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        Items.Strings = (
          'None'
          'Odd'
          'Even'
          'Mark'
          'Space')
        ParentFont = False
        TabOrder = 4
        ItemIndex = -1
        OnChange = cbCOMParitySettingChange
      end
      object cbCOMFlowCtrlSetting: TFlatComboBox
        Left = 86
        Top = 128
        Width = 145
        Height = 21
        Style = csDropDownList
        Color = clWindow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        Items.Strings = (
          'Hardware'
          'Software'
          'None'
          'Custom')
        ParentFont = False
        TabOrder = 5
        ItemIndex = -1
        OnChange = cbCOMFlowCtrlSettingChange
      end
      object FlatButton1: TFlatButton
        Left = 86
        Top = 152
        Width = 75
        Height = 25
        ColorFocused = clYellow
        Caption = '&Save'
        TabOrder = 6
        OnClick = FlatButton1Click
      end
    end
    object TabSheet6: TTabSheet
      Caption = 'Data Log'
      ImageIndex = 2
      object Label15: TLabel
        Left = 8
        Top = 8
        Width = 105
        Height = 13
        Caption = 'Data View Log File'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label16: TLabel
        Left = 8
        Top = 48
        Width = 120
        Height = 13
        Caption = 'Stream View Log File'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label17: TLabel
        Left = 8
        Top = 92
        Width = 54
        Height = 13
        Caption = 'Log Mode'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object edModbusDataViewLogFile: TFlatEdit
        Left = 8
        Top = 24
        Width = 281
        Height = 19
        ColorFocused = clYellow
        ColorFlat = clBtnFace
        ParentColor = True
        TabOrder = 0
        OnDblClick = edModbusDataViewLogFileDblClick
      end
      object edModbusStreamViewLogFile: TFlatEdit
        Left = 8
        Top = 64
        Width = 281
        Height = 19
        ColorFocused = clYellow
        ColorFlat = clBtnFace
        ParentColor = True
        TabOrder = 1
        OnDblClick = edModbusDataViewLogFileDblClick
      end
      object btnSaveLogOption: TFlatButton
        Left = 8
        Top = 120
        Width = 75
        Height = 25
        ColorFocused = clYellow
        Caption = '&Save'
        TabOrder = 2
        OnClick = FlatButton1Click
      end
      object cbModbusLogViewMode: TFlatComboBox
        Left = 78
        Top = 88
        Width = 145
        Height = 21
        Style = csDropDownList
        Color = clWindow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        Items.Strings = (
          'Normal Ascii Mode'
          'Extended Ascii Mode'
          'Hex Mode'
          'Decimal Mode')
        ParentFont = False
        TabOrder = 3
        Text = 'Normal Ascii Mode'
        ItemIndex = 0
        OnChange = cbCOMPortSettingChange
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Modbus Setup'
      ImageIndex = 1
      object Label1: TLabel
        Left = 8
        Top = 8
        Width = 28
        Height = 13
        Caption = 'Type'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 8
        Top = 32
        Width = 50
        Height = 13
        Caption = 'Slave ID'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 8
        Top = 56
        Width = 81
        Height = 13
        Caption = 'Function Code'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 8
        Top = 109
        Width = 109
        Height = 13
        Caption = 'Start Data Address'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label11: TLabel
        Left = 8
        Top = 133
        Width = 92
        Height = 13
        Caption = 'Number of Point'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label12: TLabel
        Left = 8
        Top = 157
        Width = 52
        Height = 13
        Caption = 'CRC Key'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label13: TLabel
        Left = 8
        Top = 181
        Width = 89
        Height = 13
        Caption = 'Scan Rate (ms)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label14: TLabel
        Left = 8
        Top = 205
        Width = 66
        Height = 13
        Caption = 'Timeout (s)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object cbModbusType: TFlatComboBox
        Left = 126
        Top = 8
        Width = 145
        Height = 21
        Style = csDropDownList
        Color = clWindow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ItemHeight = 13
        Items.Strings = (
          'RTU MODBUS'
          'ASCII MODDBUS')
        ParentFont = False
        TabOrder = 0
        ItemIndex = -1
      end
      object cbModbusFunctionCode: TFlatComboBox
        Left = 126
        Top = 56
        Width = 145
        Height = 21
        Style = csDropDownList
        Color = clWindow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ItemHeight = 13
        Items.Strings = (
          '01 : Read multiple bit'
          '02 : Read multiple bit'
          '03 : Read multiple 16/32 bit register'
          '04 : Read multiple 16/32 bit register'
          '05 : Write single bit'
          '06 : Write single 16 bit register'
          '07 : Read exception status'
          '08 : Loopback test'
          '15 : Write multiple bits'
          '16 : Write multiple 16/32 bit register'
          '65 : Read ascii buffer'
          '66 : Write ascii buffer ')
        ParentFont = False
        TabOrder = 2
        ItemIndex = -1
        OnChange = cbModbusFunctionCodeChange
      end
      object spModbusStartAddress: TFlatSpinEditInteger
        Left = 126
        Top = 108
        Width = 145
        Height = 20
        ColorFlat = clBtnFace
        AutoSize = False
        MaxValue = 65535
        MinValue = 0
        ParentColor = True
        TabOrder = 4
        Value = 0
      end
      object spModbusNumberPoint: TFlatSpinEditInteger
        Left = 126
        Top = 132
        Width = 145
        Height = 20
        ColorFlat = clBtnFace
        AutoSize = False
        MaxValue = 256
        MinValue = 1
        ParentColor = True
        TabOrder = 5
        Value = 1
      end
      object spModbusCRCKey: TFlatSpinEditInteger
        Left = 126
        Top = 156
        Width = 145
        Height = 20
        ColorFlat = clBtnFace
        AutoSize = False
        MaxValue = 65535
        MinValue = 0
        ParentColor = True
        TabOrder = 6
        Value = 40961
      end
      object spModbusSlaveID: TFlatSpinEditInteger
        Left = 126
        Top = 32
        Width = 145
        Height = 20
        ColorFlat = clBtnFace
        AutoSize = False
        MaxValue = 255
        MinValue = 0
        ParentColor = True
        TabOrder = 1
        Value = 0
      end
      object btnModbusAddFunctionCode: TFlatButton
        Left = 126
        Top = 80
        Width = 75
        Height = 25
        ColorFocused = clYellow
        Caption = 'Add &New'
        TabOrder = 3
      end
      object spModbusScanRate: TFlatSpinEditInteger
        Left = 126
        Top = 180
        Width = 145
        Height = 20
        ColorFlat = clBtnFace
        AutoSize = False
        MaxValue = 60000
        MinValue = 50
        ParentColor = True
        TabOrder = 7
        Value = 500
        OnChange = spModbusScanRateChange
      end
      object spModbusTimeout: TFlatSpinEditInteger
        Left = 126
        Top = 204
        Width = 145
        Height = 20
        ColorFlat = clBtnFace
        AutoSize = False
        MaxValue = 59
        MinValue = 1
        ParentColor = True
        TabOrder = 8
        Value = 1
        OnChange = spModbusTimeoutChange
      end
      object btnStartStopPoll: TFlatButton
        Left = 126
        Top = 228
        Width = 75
        Height = 25
        ColorFocused = clYellow
        Caption = 'Start &Poll'
        TabOrder = 9
        OnClick = btnStartStopPollClick
      end
    end
  end
  object pgDataView: TPageControl
    Left = 305
    Top = 0
    Width = 387
    Height = 293
    ActivePage = TabSheet4
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object TabSheet3: TTabSheet
      Caption = 'Data View'
      object lvDataView: TListView
        Left = 0
        Top = 0
        Width = 379
        Height = 265
        Align = alClient
        BorderStyle = bsNone
        Color = clWhite
        Columns = <
          item
            AutoSize = True
            Caption = 'Address'
          end
          item
            AutoSize = True
            Caption = 'Dec'
          end
          item
            AutoSize = True
            Caption = 'Hex'
          end>
        FlatScrollBars = True
        GridLines = True
        ReadOnly = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Stream View'
      ImageIndex = 1
      object memoLogModbus: TFlatMemo
        Left = 0
        Top = 0
        Width = 379
        Height = 265
        ColorFocused = clYellow
        ColorFlat = clBtnFace
        ParentColor = True
        Align = alClient
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
        OnChange = memoLogModbusChange
      end
    end
  end
  object comSerial1: TComPort
    BaudRate = br9600
    Port = 'COM1'
    Parity.Bits = prNone
    StopBits = sbOneStopBit
    DataBits = dbEight
    Events = [evRxChar, evTxEmpty, evRxFlag, evRing, evBreak, evCTS, evDSR, evError, evRLSD, evRx80Full]
    Buffer.InputSize = 8192
    Buffer.OutputSize = 8192
    FlowControl.OutCTSFlow = False
    FlowControl.OutDSRFlow = False
    FlowControl.ControlDTR = dtrDisable
    FlowControl.ControlRTS = rtsDisable
    FlowControl.XonXoffOut = False
    FlowControl.XonXoffIn = False
    OnAfterOpen = comSerial1AfterOpen
    OnAfterClose = comSerial1AfterClose
    OnRxChar = comSerial1RxChar
    Left = 317
    Top = 72
  end
  object tmrModbusScanRate: TTimer
    Enabled = False
    Interval = 500
    OnTimer = tmrModbusScanRateTimer
    Left = 317
    Top = 104
  end
  object tmrModbusTimeout: TTimer
    Enabled = False
    OnTimer = tmrModbusTimeoutTimer
    Left = 349
    Top = 104
  end
  object tmrWaktu: TTimer
    Left = 317
    Top = 136
  end
  object SaveDialog1: TSaveDialog
    Options = [ofReadOnly, ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Left = 348
    Top = 72
  end
end

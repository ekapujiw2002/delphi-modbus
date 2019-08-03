object Form1: TForm1
  Left = 453
  Top = 170
  Width = 309
  Height = 413
  Caption = 'Modbus Test'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 0
    Top = 256
    Width = 11
    Height = 13
    Caption = 'ID'
  end
  object Label2: TLabel
    Left = 0
    Top = 280
    Width = 25
    Height = 13
    Caption = 'Code'
  end
  object Label3: TLabel
    Left = 0
    Top = 304
    Width = 22
    Height = 13
    Caption = 'Addr'
  end
  object Label4: TLabel
    Left = 0
    Top = 328
    Width = 24
    Height = 13
    Caption = 'Point'
  end
  object Label5: TLabel
    Left = 0
    Top = 352
    Width = 38
    Height = 13
    Caption = 'Timeout'
  end
  object btnCOMCfg: TButton
    Left = 0
    Top = 0
    Width = 75
    Height = 25
    Caption = 'COM Config'
    TabOrder = 0
    OnClick = btnCOMCfgClick
  end
  object btnCOMOpen: TButton
    Left = 80
    Top = 0
    Width = 75
    Height = 25
    Caption = 'COM Open'
    TabOrder = 1
    OnClick = btnCOMOpenClick
  end
  object memoDataRX: TMemo
    Left = 0
    Top = 32
    Width = 297
    Height = 185
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object edCmd: TEdit
    Left = 0
    Top = 224
    Width = 297
    Height = 21
    TabOrder = 3
    OnKeyPress = edCmdKeyPress
  end
  object spSlaveID: TSpinEdit
    Left = 48
    Top = 248
    Width = 57
    Height = 22
    MaxValue = 255
    MinValue = 0
    TabOrder = 4
    Value = 1
  end
  object spCodeID: TSpinEdit
    Left = 48
    Top = 272
    Width = 57
    Height = 22
    MaxValue = 255
    MinValue = 0
    TabOrder = 5
    Value = 1
  end
  object spAddrStart: TSpinEdit
    Left = 48
    Top = 296
    Width = 57
    Height = 22
    MaxValue = 65535
    MinValue = 0
    TabOrder = 6
    Value = 1
  end
  object spNumPoint: TSpinEdit
    Left = 48
    Top = 320
    Width = 57
    Height = 22
    MaxValue = 255
    MinValue = 0
    TabOrder = 7
    Value = 1
  end
  object spTimeout: TSpinEdit
    Left = 48
    Top = 344
    Width = 57
    Height = 22
    MaxValue = 60000
    MinValue = 100
    TabOrder = 8
    Value = 100
  end
  object cbNonModbus: TCheckBox
    Left = 112
    Top = 248
    Width = 121
    Height = 17
    Caption = 'Non Modbus Mode'
    TabOrder = 9
  end
  object ComPort1: TComPort
    BaudRate = br9600
    Port = 'COM1'
    Parity.Bits = prNone
    StopBits = sbOneStopBit
    DataBits = dbEight
    Events = [evRxChar, evTxEmpty, evRxFlag, evRing, evBreak, evCTS, evDSR, evError, evRLSD, evRx80Full]
    FlowControl.OutCTSFlow = False
    FlowControl.OutDSRFlow = False
    FlowControl.ControlDTR = dtrDisable
    FlowControl.ControlRTS = rtsDisable
    FlowControl.XonXoffOut = False
    FlowControl.XonXoffIn = False
    OnAfterOpen = ComPort1AfterOpen
    OnAfterClose = ComPort1AfterClose
    Left = 160
  end
end

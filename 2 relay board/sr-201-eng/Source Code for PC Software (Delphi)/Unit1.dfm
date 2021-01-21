object Form1: TForm1
  Left = 274
  Top = 208
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'PC Software for Ethernet Relay - V1.1'
  ClientHeight = 303
  ClientWidth = 378
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poDefaultPosOnly
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 73
    Height = 13
    AutoSize = False
    Caption = 'Mode'
  end
  object Label2: TLabel
    Left = 16
    Top = 48
    Width = 81
    Height = 13
    AutoSize = False
    Caption = 'IP Addr'
  end
  object Label3: TLabel
    Left = 248
    Top = 48
    Width = 41
    Height = 13
    AutoSize = False
    Caption = 'Port'
  end
  object Label4: TLabel
    Left = 16
    Top = 208
    Width = 105
    Height = 13
    AutoSize = False
    Caption = 'Text Received'
  end
  object Label5: TLabel
    Left = 16
    Top = 176
    Width = 113
    Height = 13
    AutoSize = False
    Caption = 'Text To Send'
  end
  object Label6: TLabel
    Left = 16
    Top = 80
    Width = 73
    Height = 13
    AutoSize = False
    Caption = 'Operation'
  end
  object Label7: TLabel
    Left = 16
    Top = 112
    Width = 65
    Height = 13
    AutoSize = False
    Caption = 'Duration'
  end
  object Label8: TLabel
    Left = 160
    Top = 112
    Width = 201
    Height = 13
    AutoSize = False
    Caption = 'second(s), keep state if 0'
  end
  object btnExit: TButton
    Left = 238
    Top = 245
    Width = 89
    Height = 25
    Caption = 'Exit'
    TabOrder = 11
    OnClick = btnExitClick
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 283
    Width = 378
    Height = 20
    Panels = <>
    SimplePanel = True
  end
  object btnConnect: TButton
    Left = 51
    Top = 245
    Width = 81
    Height = 25
    Caption = 'Connect'
    TabOrder = 9
    OnClick = btnConnectClick
  end
  object edtServerAddr: TEdit
    Left = 96
    Top = 40
    Width = 129
    Height = 21
    TabOrder = 2
    Text = '192.168.1.100'
  end
  object edtPort: TEdit
    Left = 304
    Top = 40
    Width = 57
    Height = 21
    Color = clInfoBk
    ReadOnly = True
    TabOrder = 3
  end
  object btnSendData: TButton
    Left = 144
    Top = 245
    Width = 81
    Height = 25
    Caption = 'Send'
    TabOrder = 10
    OnClick = btnSendDataClick
  end
  object edtReceiveText: TEdit
    Left = 136
    Top = 200
    Width = 217
    Height = 21
    Color = clInfoBk
    ReadOnly = True
    TabOrder = 8
  end
  object edtSendText: TEdit
    Left = 136
    Top = 168
    Width = 217
    Height = 21
    Color = clInfoBk
    ReadOnly = True
    TabOrder = 7
  end
  object edtDelay: TEdit
    Left = 96
    Top = 104
    Width = 57
    Height = 21
    TabOrder = 5
    Text = '0'
    OnChange = edtDelayChange
  end
  object rbTcp: TRadioButton
    Left = 96
    Top = 16
    Width = 49
    Height = 17
    Caption = 'TCP'
    Checked = True
    TabOrder = 0
    TabStop = True
    OnClick = rbTcpClick
  end
  object rbUdp: TRadioButton
    Left = 160
    Top = 16
    Width = 49
    Height = 17
    Caption = 'UDP'
    TabOrder = 1
    OnClick = rbUdpClick
  end
  object cbOperation: TComboBox
    Left = 96
    Top = 72
    Width = 129
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 4
    OnChange = cbOperationChange
    Items.Strings = (
      'Reteieve status'
      'Turn on CH1'
      'Turn off CH1'
      'Turn on CH2'
      'Turn off CH2'
      'Turn on CH3'
      'Turn off CH3'
      'Turn on CH4'
      'Turn off CH4'
      'Turn on CH5'
      'Turn off CH5'
      'Turn on CH6'
      'Turn off CH6'
      'Turn on CH7'
      'Turn off CH7'
      'Turn on CH8'
      'Turn off CH8'
      'Turn on all'
      'Turn off all')
  end
  object CheckBox1: TCheckBox
    Left = 96
    Top = 138
    Width = 57
    Height = 17
    Caption = 'Jog'
    TabOrder = 6
    OnClick = CheckBox1Click
  end
  object CheckBox2: TCheckBox
    Left = 176
    Top = 138
    Width = 161
    Height = 17
    Caption = 'Simulate key press'
    TabOrder = 13
    OnClick = CheckBox2Click
  end
  object ClientSocket: TClientSocket
    Active = False
    ClientType = ctNonBlocking
    Port = 6722
    OnConnect = ClientSocketConnect
    OnDisconnect = ClientSocketDisconnect
    OnRead = ClientSocketRead
    OnError = ClientSocketError
    Left = 236
    Top = 8
  end
  object UdpSocket: TUdpSocket
    RemotePort = '6723'
    Left = 272
    Top = 8
  end
end

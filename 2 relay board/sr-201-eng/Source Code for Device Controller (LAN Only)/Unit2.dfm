object Form2: TForm2
  Left = 787
  Top = 260
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Settings'
  ClientHeight = 190
  ClientWidth = 250
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 24
    Width = 73
    Height = 13
    AutoSize = False
    Caption = 'IP Address'
  end
  object Label5: TLabel
    Left = 16
    Top = 121
    Width = 89
    Height = 13
    AutoSize = False
    Caption = 'Num of Channels'
  end
  object edtAddress: TEdit
    Left = 104
    Top = 16
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object bbOK: TBitBtn
    Left = 48
    Top = 152
    Width = 75
    Height = 25
    TabOrder = 2
    Kind = bkOK
  end
  object bbCancel: TBitBtn
    Left = 128
    Top = 152
    Width = 75
    Height = 25
    TabOrder = 3
    Kind = bkCancel
  end
  object rgKeyMode: TRadioGroup
    Left = 16
    Top = 48
    Width = 217
    Height = 57
    Caption = 'Key Press Mode'
    Columns = 2
    Ctl3D = True
    ItemIndex = 0
    Items.Strings = (
      'Keep State'
      'Jog')
    ParentCtl3D = False
    TabOrder = 1
  end
  object cbChNum: TComboBox
    Left = 112
    Top = 113
    Width = 73
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 3
    TabOrder = 4
    Text = '8'
    Items.Strings = (
      '1'
      '2'
      '4'
      '8')
  end
end

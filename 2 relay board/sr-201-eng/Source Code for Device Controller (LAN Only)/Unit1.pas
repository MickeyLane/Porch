unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ExtCtrls, ImgList, StdCtrls, Unit2, ScktComp, ComCtrls, Registry;

const
  StepCmd: array [0..15] of String = ('11', '21', '12', '22', '13', '23', '14', '24', '15', '25', '16', '26', '17', '27', '18', '28');

type
  TForm1 = class(TForm)
    sbCH1: TSpeedButton;
    sbCH2: TSpeedButton;
    ilBtnState: TImageList;
    sbCH3: TSpeedButton;
    sbCH4: TSpeedButton;
    sbCH5: TSpeedButton;
    sbCH6: TSpeedButton;
    lblTitle: TLabel;
    lblConfig: TLabel;
    tcpClient: TClientSocket;
    Timer1: TTimer;
    Bevel1: TBevel;
    lblState: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Timer2: TTimer;
    sbCH7: TSpeedButton;
    sbCH8: TSpeedButton;
    Label7: TLabel;
    Label8: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure tcpClientRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure Timer1Timer(Sender: TObject);
    procedure tcpClientConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure tcpClientError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure sbCH1Click(Sender: TObject);
    procedure sbCH2Click(Sender: TObject);
    procedure sbCH3Click(Sender: TObject);
    procedure sbCH4Click(Sender: TObject);
    procedure sbCH5Click(Sender: TObject);
    procedure sbCH6Click(Sender: TObject);
    procedure sbCH7Click(Sender: TObject);
    procedure sbCH8Click(Sender: TObject);
    procedure lblConfigClick(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    CurrentState: array [1..8] of integer;
    EnableTest: Boolean;
    TestStep: Integer;
    NumOfChannels: Integer;
    Connecting: Boolean;
    PendingIPChange: Boolean;
    KeyMode: Integer;
    procedure SendCmd(channel: integer);
    procedure SetSBState(ReceiveText: string; i: integer; sb: TSpeedButton);
    procedure ShowExtChannels();
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.ShowExtChannels();
begin
  if NumOfChannels = 8 then
  begin
    Width := 570;

    lblTitle.Left := 80;
    lblConfig.Left := 416;

    sbCH1.Left := 32;
    sbCH2.Left := 96;
    sbCH3.Left := 160;
    sbCH4.Left := 224;

    Label1.Left := 32;
    Label2.Left := 96;
    Label3.Left := 160;
    Label4.Left := 224;

    sbCH2.Visible := true;
    sbCH3.Visible := true;
    sbCH4.Visible := true;
    sbCH5.Visible := true;
    sbCH6.Visible := true;
    sbCH7.Visible := true;
    sbCH8.Visible := true;

    Label2.Visible := True;
    Label3.Visible := True;
    Label4.Visible := True;
    Label5.Visible := True;
    Label6.Visible := True;
    Label7.Visible := True;
    Label8.Visible := True;
  end
  else
  begin
    Width := 447;

    lblTitle.Left := 8;
    lblConfig.Left := 344;

    if NumOfChannels = 2 then
    begin
      sbCH1.Left := 96;
      sbCH2.Left := 288;

      Label1.Left := 96;
      Label2.Left := 288;

      sbCH2.Visible := true;
      sbCH3.Visible := false;
      sbCH4.Visible := false;

      Label2.Visible := true;
      Label3.Visible := false;
      Label4.Visible := false;
    end
    else
      if NumOfChannels = 4 then
      begin
        sbCH1.Left := 50;
        sbCH2.Left := 146;
        sbCH3.Left := 242;
        sbCH4.Left := 338;

        Label1.Left := 50;
        Label2.Left := 146;
        Label3.Left := 242;
        Label4.Left := 338;

        sbCH2.Visible := true;
        sbCH3.Visible := true;
        sbCH4.Visible := true;

        Label2.Visible := true;
        Label3.Visible := true;
        Label4.Visible := true;
      end
      else
      begin
        sbCH1.Left := 192;
        Label1.Left := 192;

        sbCH2.Visible := false;
        sbCH3.Visible := false;
        sbCH4.Visible := false;

        Label2.Visible := false;
        Label3.Visible := false;
        Label4.Visible := false;
      end;

      sbCH5.Visible := false;
      sbCH6.Visible := false;
      sbCH7.Visible := false;
      sbCH8.Visible := false;

      Label5.Visible := false;
      Label6.Visible := false;
      Label7.Visible := false;
      Label8.Visible := false;
  end;
end;

procedure TForm1.SetSBState(ReceiveText: string; i: integer; sb: TSpeedButton);
var
  NewState: Integer;
begin
  if StrLen(PChar(ReceiveText)) >= i then
  begin
    if ReceiveText[i] = '1' then
      NewState := 1
    else
      NewState := 0;

    if CurrentState[i] <> NewState then
    begin
      sb.Glyph := nil;

      if NewState = 1 then
        ilBtnState.GetBitmap(1, sb.Glyph)
      else
        ilBtnState.GetBitmap(0, sb.Glyph);

      CurrentState[i] := NewState;
    end;
  end;
end;

procedure TForm1.SendCmd(channel: integer);
var
  MsgText: String;
begin
  if not Timer2.Enabled then
    if tcpClient.Socket.Connected then
    begin
      if CurrentState[channel] = 0 then
        MsgText := '1' + IntToStr(channel)
      else
        MsgText := '2' + IntToStr(channel);

      if KeyMode = 1 then
        MsgText := MsgText + '*';

      tcpClient.Socket.SendText(MsgText);
    End;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  Reg: TRegistry;
  i: integer;
begin
  Connecting := false;
  PendingIPChange := false;

  Reg := TRegistry.Create;
  if Reg.OpenKey('Software\Lee Software\SR-201 Control', False) then
  begin
    try
      tcpClient.Host := Reg.ReadString('Host')
    except
      tcpClient.Host := '192.168.1.100'
    end;

    try
      EnableTest := Reg.ReadInteger('Enable Test') = 1
    except
      EnableTest := False;
    end;

    try
      NumOfChannels := Reg.ReadInteger('Number Of Channels')
    except
      NumOfChannels := 8;
    end;

    try
      KeyMode := Reg.ReadInteger('Key Mode')
    except
      KeyMode := 0;
    end;

    Reg.CloseKey;
  end
  else
  begin
    tcpClient.Host := '192.168.1.100';
    NumOfChannels := 8;
    KeyMode := 0;
  end;
  Reg.Free;

  for i := 1 to 8 do
    CurrentState[i] := 0;

  ShowExtChannels;

  ilBtnState.GetBitmap(0, sbCH1.Glyph);
  ilBtnState.GetBitmap(0, sbCH2.Glyph);
  ilBtnState.GetBitmap(0, sbCH3.Glyph);
  ilBtnState.GetBitmap(0, sbCH4.Glyph);
  ilBtnState.GetBitmap(0, sbCH5.Glyph);
  ilBtnState.GetBitmap(0, sbCH6.Glyph);
  ilBtnState.GetBitmap(0, sbCH7.Glyph);
  ilBtnState.GetBitmap(0, sbCH8.Glyph);
end;

procedure TForm1.tcpClientRead(Sender: TObject; Socket: TCustomWinSocket);
var
  ReceiveText: string;
begin
  ReceiveText := Socket.ReceiveText;

  SetSBState(ReceiveText, 1, sbCH1);
  SetSBState(ReceiveText, 2, sbCH2);
  SetSBState(ReceiveText, 3, sbCH3);
  SetSBState(ReceiveText, 4, sbCH4);
  SetSBState(ReceiveText, 5, sbCH5);
  SetSBState(ReceiveText, 6, sbCH6);
  SetSBState(ReceiveText, 7, sbCH7);
  SetSBState(ReceiveText, 8, sbCH8);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  if tcpClient.Socket.Connected then
  begin
    if not Timer2.Enabled then
      tcpClient.Socket.SendText('00')
  end
  else
    if not tcpClient.Active then
      if not Connecting then
        try
          if PendingIPChange then
            tcpClient.Host := Form2.edtAddress.Text;

          tcpClient.active := true;
          Connecting := true;
        except
          lblTitle.Font.Color := clGrayText;
          lblState.Caption :=  'Wrong parameters, please check your settings';
        end;
end;

procedure TForm1.tcpClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  Connecting := False;
  lblTitle.Font.Color := clWindowText;
  lblState.Caption :=  'Connected to ' + tcpClient.Host;
  tcpClient.Socket.SendText('00');
end;

procedure TForm1.tcpClientError(Sender: TObject; Socket: TCustomWinSocket;
  ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  if Connecting then
    Connecting := False;

  tcpClient.Active := False;
  lblTitle.Font.Color := clGrayText;
  lblState.Caption :=  'Not connected';
  ErrorCode := 0;
end;

procedure TForm1.sbCH1Click(Sender: TObject);
begin
  SendCmd(1);
end;

procedure TForm1.sbCH2Click(Sender: TObject);
begin
  SendCmd(2);
end;

procedure TForm1.sbCH3Click(Sender: TObject);
begin
  SendCmd(3);
end;

procedure TForm1.sbCH4Click(Sender: TObject);
begin
  SendCmd(4);
end;

procedure TForm1.sbCH5Click(Sender: TObject);
begin
  SendCmd(5);
end;

procedure TForm1.sbCH6Click(Sender: TObject);
begin
  SendCmd(6);
end;

procedure TForm1.sbCH7Click(Sender: TObject);
begin
  SendCmd(7);
end;

procedure TForm1.sbCH8Click(Sender: TObject);
begin
  SendCmd(8);
end;

procedure TForm1.lblConfigClick(Sender: TObject);
var
  Reg: TRegistry;
begin
  Form2.edtAddress.Text := tcpClient.Host;
  Form2.rgKeyMode.ItemIndex := KeyMode;
  Form2.cbChNum.ItemIndex := Form2.cbChNum.Items.IndexOf(IntToStr(NumOfChannels));
  if Form2.ShowModal = mrOK then
  begin
    Timer1.Enabled := False;

    Form2.edtAddress.Text := Trim(Form2.edtAddress.Text);
    if tcpClient.Host <> Form2.edtAddress.Text then
    begin
      if Connecting then
        lblState.Caption := 'Terminating current connect request'
      else
      begin
        tcpClient.Close;
        lblTitle.Font.Color := clGrayText;
        lblState.Caption := 'Not connected';
      end;
      
      PendingIPChange := True;
    end;

    Reg := TRegistry.Create;
    if Reg.OpenKey('Software\Lee Software\SR-201 Control', True) then
    begin
      Reg.WriteString('Host', Form2.edtAddress.Text);
      Reg.WriteInteger('Key Mode', Form2.rgKeyMode.ItemIndex);
      Reg.WriteInteger('Number Of Channels', NumOfChannels);        
      Reg.CloseKey;
    end;
    Reg.Free;

    Timer1.Enabled := True;

    KeyMode := Form2.rgKeyMode.ItemIndex;
    NumOfChannels := StrToInt(Form2.cbChNum.text);
    ShowExtChannels;
  end;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
  lblTitle.Visible := not lblTitle.Visible;

  if tcpClient.Socket.Connected then
  begin
    tcpClient.Socket.SendText(StepCmd[TestStep]);
    
    if TestStep < 15 then
      TestStep := TestStep + 1
    else
      TestStep := 0;
  end;
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 84) and (ssCtrl in Shift) then
    if Timer2.Enabled then
    begin
      Timer2.Enabled := False;
      lblTitle.Visible := True;
    end
    else
    begin
      if EnableTest then
      begin
        TestStep := 0;
        Timer2.Enabled := true;
      end;
    end;
end;

end.

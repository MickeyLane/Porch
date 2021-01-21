unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ScktComp, Sockets, ShellAPI, Registry, StrUtils;

type
  TForm1 = class(TForm)
    btnExit: TButton;
    StatusBar1: TStatusBar;
    ClientSocket: TClientSocket;
    btnConnect: TButton;
    Label1: TLabel;
    Label2: TLabel;
    edtServerAddr: TEdit;
    Label3: TLabel;
    edtPort: TEdit;
    btnSendData: TButton;
    Label4: TLabel;
    Label5: TLabel;
    edtReceiveText: TEdit;
    edtSendText: TEdit;
    UdpSocket: TUdpSocket;
    Label6: TLabel;
    Label7: TLabel;
    edtDelay: TEdit;
    Label8: TLabel;
    rbTcp: TRadioButton;
    rbUdp: TRadioButton;
    cbOperation: TComboBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnExitClick(Sender: TObject);
    procedure ClientSocketConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocketRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure btnConnectClick(Sender: TObject);
    procedure btnSendDataClick(Sender: TObject);
    procedure rbTcpClick(Sender: TObject);
    procedure rbUdpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ClientSocketError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure cbOperationChange(Sender: TObject);
    procedure edtDelayChange(Sender: TObject);
    procedure ClientSocketDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
  private
    { Private declarations }
    function IsNumeric(Data: string) : boolean;
    function PrepareSendData(ShowMsg: Boolean): Boolean;
  public
    { Public declarations }

  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function TForm1.IsNumeric(Data: String): Boolean;
var i, code : integer;
begin
    val(data, i, code);
    if code = 0 then
        result := true
    else
        result := false;
end;

function TForm1.PrepareSendData(ShowMsg: Boolean): Boolean;
var
  txtDelay: String;
begin
  result := False;

  if not CheckBox1.Checked then
  begin
    txtDelay := Trim(edtDelay.Text);
    If ShowMsg Then
    begin
      If txtDelay = '' Then
        txtDelay := '0';

      If Not IsNumeric(txtDelay) Then
      begin
        showmessage('Duration should be an integer between 1 and 65535');
        edtDelay.SetFocus;
        Exit;
      End;

      If StrToInt(txtDelay) > 65535 Then
      begin
        showmessage('Duration should be an integer between 1 and 65535');
        edtDelay.SetFocus;
        Exit;
      End;

      edtDelay.Text := IntToStr(StrToInt(txtDelay))
    end;
  end;

  case cbOperation.ItemIndex of
    0: edtSendText.Text := '00';
    1: edtSendText.Text := '11';
    2: edtSendText.Text := '21';
    3: edtSendText.Text := '12';
    4: edtSendText.Text := '22';
    5: edtSendText.Text := '13';
    6: edtSendText.Text := '23';
    7: edtSendText.Text := '14';
    8: edtSendText.Text := '24';
    9: edtSendText.Text := '15';
    10: edtSendText.Text := '25';
    11: edtSendText.Text := '16';
    12: edtSendText.Text := '26';
    13: edtSendText.Text := '17';
    14: edtSendText.Text := '27';
    15: edtSendText.Text := '18';
    16: edtSendText.Text := '28';
    17: edtSendText.Text := '1X';
    18: edtSendText.Text := '2X';
  end;

  if CheckBox1.Checked then
  begin
    If cbOperation.ItemIndex mod 2 <> 0 Then
      edtSendText.Text := edtSendText.Text + '*';
  end
  else
  begin
    if CheckBox2.Checked then
    begin
      If cbOperation.ItemIndex mod 2 <> 0 Then
        edtSendText.Text := edtSendText.Text + 'K';
    end
    else
    begin
      If txtDelay <> '' Then
        If IsNumeric(txtDelay) Then
          If (StrToInt(txtDelay) > 0) And (StrToInt(txtDelay) < 65536) Then
            If cbOperation.ItemIndex <> 0 Then
              edtSendText.Text := edtSendText.Text + ':' + IntToStr(StrToInt(txtDelay));
    end;
  end;
  
  result := True;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
var
  Reg: TRegistry;
begin
  clientsocket.Active := false;
  clientsocket.close;

      Reg := TRegistry.Create;
      if Reg.OpenKey('Software\Lee Software\SR-201', True) then
      begin
        Reg.WriteString('Remote Address', edtServerAddr.Text);
        Reg.CloseKey;
      end;
      Reg.Free;
end;

procedure TForm1.btnExitClick(Sender: TObject);
begin
  close;
end;

procedure TForm1.ClientSocketConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  btnSendData.Enabled := True;
  StatusBar1.SimpleText:='Connected';
end;

procedure TForm1.ClientSocketRead(Sender: TObject;
  Socket: TCustomWinSocket);
begin
    edtReceiveText.Text := socket.ReceiveText;
end;

procedure TForm1.btnConnectClick(Sender: TObject);
begin
  if rbTcp.Checked then
  begin
    if clientsocket.Socket.Connected then
    begin
       clientsocket.Active:=false;
       statusbar1.SimpleText:='Not connected';
       btnConnect.Caption:='Connect';

       rbTcp.Enabled := True;
       rbUdp.Enabled := true;
       btnSendData.Enabled := false;
    end
    else
      try
        ClientSocket.Address := edtServerAddr.text;
        clientsocket.active := true;
        btnConnect.Caption := 'Disconnect';

        rbTcp.Enabled := false;
        rbUdp.Enabled := false;
      except
        showmessage('Wrong parameters');
      end;
  end
  else
  begin
    btnConnect.Enabled := false;
  end;
end;

procedure TForm1.btnSendDataClick(Sender: TObject);
var
  ts: TMemoryStream;
begin
  if not PrepareSendData(true) then
    exit;

  if rbTcp.Checked then
  begin
    if clientsocket.Socket.Connected then
       clientsocket.Socket.SendText(edtSendText.Text)
    else showmessage('Not connected');
  end
  else
  begin
    if cbOperation.ItemIndex = 0 then
      ShowMessage('UDP mode does not support retrieving relay status')
    else
    begin
      ts := TMemoryStream.Create;
      ts.WriteBuffer(edtSendText.Text[1], Length(edtSendText.Text));
      ts.Seek(0, soFromBeginning);

      UdpSocket.RemoteHost := edtServerAddr.Text;
      UdpSocket.Active := True;
      UdpSocket.SendStream(ts);
      UdpSocket.Active := false;

      ts.Free;
    end;
  end;
end;

procedure TForm1.rbTcpClick(Sender: TObject);
begin
  edtPort.Text := IntToStr(ClientSocket.Port);
  btnConnect.Enabled := true;
  btnSendData.Enabled := false;
  statusbar1.SimpleText:='Not connected';
  Label4.Visible := True;
  edtReceiveText.Visible := True;
end;

procedure TForm1.rbUdpClick(Sender: TObject);
begin
  edtPort.Text := UdpSocket.RemotePort;
  btnConnect.Enabled := false;
  btnSendData.Enabled := true;
  statusbar1.SimpleText:='Send command via UDP, no response will be received';
  Label4.Visible := False;
  edtReceiveText.Visible := False;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  if Reg.OpenKey('Software\Lee Software\SR-201', False) then
  begin
    edtServerAddr.Text := Reg.ReadString('Remote Address');
    Reg.CloseKey;
  end;
  Reg.Free;

  rbTcpClick(self);
  cbOperation.ItemIndex := 0;
  PrepareSendData(false);
end;

procedure TForm1.ClientSocketError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
  if rbTcp.Checked then
  begin
    Socket.Close;
    rbTcp.Enabled := True;
    rbUdp.Enabled := True;
    btnConnect.Caption:='Connect';
  end;
end;

procedure TForm1.cbOperationChange(Sender: TObject);
begin
  PrepareSendData(false);
end;

procedure TForm1.edtDelayChange(Sender: TObject);
begin
  PrepareSendData(false);
end;

procedure TForm1.ClientSocketDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  if rbTcp.Checked then
  begin
    rbTcp.Enabled := True;
    rbUdp.Enabled := True;
    btnConnect.Caption:='Connect';
    btnSendData.Enabled := False;
    StatusBar1.SimpleText := 'Disconnected';
  end;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked then
  begin
    CheckBox2.Checked := false;
    edtDelay.Enabled := false;
    edtDelay.Color := cl3DLight;
  end
  else
  begin
    edtDelay.Enabled := true;
    edtDelay.Color := clWindow;
  end;

  PrepareSendData(false);
end;

procedure TForm1.CheckBox2Click(Sender: TObject);
begin
  if CheckBox2.Checked then
  begin
    CheckBox1.Checked := false;
    edtDelay.Enabled := false;
    edtDelay.Color := cl3DLight;
  end
  else
  begin
    edtDelay.Enabled := true;
    edtDelay.Color := clWindow;
  end;

  PrepareSendData(false);
end;

end.

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Registry, StrUtils, ExtCtrls, ImgList, Buttons,
  Unit3, DevConfig;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label9: TLabel;
    Edit1: TEdit;
    Panel1: TPanel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    Label12: TLabel;
    Label13: TLabel;
    Panel2: TPanel;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    RadioButton6: TRadioButton;
    Label14: TLabel;
    Panel3: TPanel;
    RadioButton7: TRadioButton;
    RadioButton8: TRadioButton;
    RadioButton9: TRadioButton;
    Label15: TLabel;
    Panel4: TPanel;
    RadioButton10: TRadioButton;
    RadioButton11: TRadioButton;
    RadioButton12: TRadioButton;
    Label16: TLabel;
    Panel5: TPanel;
    RadioButton13: TRadioButton;
    RadioButton14: TRadioButton;
    RadioButton15: TRadioButton;
    Label17: TLabel;
    Panel6: TPanel;
    RadioButton16: TRadioButton;
    RadioButton17: TRadioButton;
    RadioButton18: TRadioButton;
    Label18: TLabel;
    Panel7: TPanel;
    RadioButton19: TRadioButton;
    RadioButton20: TRadioButton;
    RadioButton21: TRadioButton;
    Label19: TLabel;
    Panel8: TPanel;
    RadioButton22: TRadioButton;
    RadioButton23: TRadioButton;
    RadioButton24: TRadioButton;
    ImageList1: TImageList;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    TabSheet3: TTabSheet;
    CheckBox1: TCheckBox;
    TabSheet4: TTabSheet;
    Label1: TLabel;
    Edit4: TEdit;
    GroupBox2: TGroupBox;
    CheckBox3: TCheckBox;
    Label2: TLabel;
    Edit5: TEdit;
    Edit6: TEdit;
    Label3: TLabel;
    Edit2: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    Edit3: TEdit;
    lblVersion: TLabel;
    Label4: TLabel;
    Edit7: TEdit;
    Label5: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure OnConnect(var message: Tmsg); message WM_USER + 123;
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
  private
    { Private declarations }
    TargetAddress: String;
    procedure ResetConnection;
    procedure ReportError(uType: Cardinal);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  if Reg.OpenKey('Software\Lee Software\SR-201 Config Util', True) then
  begin
    Reg.WriteString('Target Address', TargetAddress);
    Reg.CloseKey;
  end;
  Reg.Free;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  if Reg.OpenKey('Software\Lee Software\SR-201 Config Util', False) then
  begin
    TargetAddress := Reg.ReadString('Target Address');
    Reg.CloseKey;
  end;
  Reg.Free;

  if TargetAddress = '' then
    TargetAddress := '192.168.1.100';
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  if Edit1.Enabled then
    ResetConnection
  else
  begin
    ConnectDlg := TConnectDlg.Create(Self);
    ConnectDlg.Edit1.Text := TargetAddress;
    if ConnectDlg.ShowModal = mrOK then
    begin
      TargetAddress := ConnectDlg.Edit1.Text;
      PostMessage(Handle, WM_USER + 123, 0, 0);
    end;
    ConnectDlg.Free;
  end;
end;

procedure TForm1.OnConnect(var message: Tmsg);
var
  Buffer: string;
begin
  SetCursor(LoadCursor(0, IDC_WAIT));

  if ReadDeviceCfg(PChar(TargetAddress)) = 1 then
  begin
    TabSheet4.TabVisible := CanCfgWeb = 1;
    TabSheet2.TabVisible := CanCfgButton = 1;
    TabSheet3.TabVisible := CanCfgMisc = 1;

    SetLength(Buffer, 100);

    if GetIpAddr(PChar(Buffer), 100) = 1 then
      Edit1.Text := Buffer;
    if GetSubMask(PChar(Buffer), 100) = 1 then
      Edit2.Text := Buffer;
    if GetGateway(PChar(Buffer), 100) = 1 then
      Edit3.Text := Buffer;

    if GetVersion(PChar(Buffer), 100) = 1 then
      if Buffer <> '' then
        lblVersion.Caption := 'Firmware version: ' + Buffer;

    if CanCfgWeb = 1 then
    begin
      if GetDeviceId(PChar(Buffer), 100) = 1 then
        Edit4.Text := Buffer;
      if GetDns(PChar(Buffer), 100) = 1 then
        Edit5.Text := Buffer;
      if GetWebServer(PChar(Buffer), 100) = 1 then
        Edit6.Text := Buffer;
      if GetPassword(PChar(Buffer), 100) = 1 then
        Edit7.Text := Buffer;
      CheckBox3.Checked := GetEnableWeb = 1;
      CheckBox3Click(Self);
    end;

    if CanCfgButton = 1 then
    begin
      RadioButton1.Checked := GetButtonCfg(1) = 1;
      RadioButton2.Checked := GetButtonCfg(1) = 2;
      RadioButton3.Checked := GetButtonCfg(1) = 3;
      RadioButton4.Checked := GetButtonCfg(2) = 1;
      RadioButton5.Checked := GetButtonCfg(2) = 2;
      RadioButton6.Checked := GetButtonCfg(2) = 3;
      RadioButton7.Checked := GetButtonCfg(3) = 1;
      RadioButton8.Checked := GetButtonCfg(3) = 2;
      RadioButton9.Checked := GetButtonCfg(3) = 3;
      RadioButton10.Checked := GetButtonCfg(4) = 1;
      RadioButton11.Checked := GetButtonCfg(4) = 2;
      RadioButton12.Checked := GetButtonCfg(4) = 3;
      RadioButton13.Checked := GetButtonCfg(5) = 1;
      RadioButton14.Checked := GetButtonCfg(5) = 2;
      RadioButton15.Checked := GetButtonCfg(5) = 3;
      RadioButton16.Checked := GetButtonCfg(6) = 1;
      RadioButton17.Checked := GetButtonCfg(6) = 2;
      RadioButton18.Checked := GetButtonCfg(6) = 3;
      RadioButton19.Checked := GetButtonCfg(7) = 1;
      RadioButton20.Checked := GetButtonCfg(7) = 2;
      RadioButton21.Checked := GetButtonCfg(7) = 3;
      RadioButton22.Checked := GetButtonCfg(8) = 1;
      RadioButton23.Checked := GetButtonCfg(8) = 2;
      RadioButton24.Checked := GetButtonCfg(8) = 3;
    end;

    CheckBox1.Checked := GetRestoreState = 1;

    Caption := Application.Title + ' - ' + TargetAddress;

    Edit1.Enabled := True;
    Edit2.Enabled := True;
    Edit3.Enabled := True;

    BitBtn1.Caption := 'Disconnect';
    BitBtn2.Enabled := True;
  end
  else
    ReportError(MB_ICONSTOP);
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
begin
  close;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
  SetIpAddr(PChar(Edit1.Text));
  SetSubMask(PChar(Edit2.Text));
  SetGateway(PChar(Edit3.Text));

  if CanCfgWeb = 1 then
    if CheckBox3.Checked then
    begin
      SetEnableWeb(1);

      SetDns(PChar(Edit5.Text));
      SetWebServer(PChar(Edit6.Text));
      SetPassword(PChar(Edit7.Text));
    end
    else
      SetEnableWeb(0);

  if CanCfgButton = 1 then
  begin
    if RadioButton1.Checked then SetButtonCfg(1, 1);
    if RadioButton2.Checked then SetButtonCfg(1, 2);
    if RadioButton3.Checked then SetButtonCfg(1, 3);
    if RadioButton4.Checked then SetButtonCfg(2, 1);
    if RadioButton5.Checked then SetButtonCfg(2, 2);
    if RadioButton6.Checked then SetButtonCfg(2, 3);
    if RadioButton7.Checked then SetButtonCfg(3, 1);
    if RadioButton8.Checked then SetButtonCfg(3, 2);
    if RadioButton9.Checked then SetButtonCfg(3, 3);
    if RadioButton10.Checked then SetButtonCfg(4, 1);
    if RadioButton11.Checked then SetButtonCfg(4, 2);
    if RadioButton12.Checked then SetButtonCfg(4, 3);
    if RadioButton13.Checked then SetButtonCfg(5, 1);
    if RadioButton14.Checked then SetButtonCfg(5, 2);
    if RadioButton15.Checked then SetButtonCfg(5, 3);
    if RadioButton16.Checked then SetButtonCfg(6, 1);
    if RadioButton17.Checked then SetButtonCfg(6, 2);
    if RadioButton18.Checked then SetButtonCfg(6, 3);
    if RadioButton19.Checked then SetButtonCfg(7, 1);
    if RadioButton20.Checked then SetButtonCfg(7, 2);
    if RadioButton21.Checked then SetButtonCfg(7, 3);
    if RadioButton22.Checked then SetButtonCfg(8, 1);
    if RadioButton23.Checked then SetButtonCfg(8, 2);
    if RadioButton24.Checked then SetButtonCfg(8, 3);
  end;

  if Checkbox1.Checked then
    SetRestoreState(1)
  else
    SetRestoreState(0);

  SetCursor(LoadCursor(0, IDC_WAIT));
  if SaveDeviceCfg = 1 then
    ReportError(MB_ICONINFORMATION)
  else
    case GetErrorCode of
      2001:
        begin
          PageControl1.ActivePageIndex := 0;
          Edit1.SetFocus;
          ReportError(MB_ICONINFORMATION);
        end;
      2002:
        begin
          PageControl1.ActivePageIndex := 0;
          Edit2.SetFocus;
          ReportError(MB_ICONINFORMATION);
        end;
      2003:
        begin
          PageControl1.ActivePageIndex := 0;
          Edit3.SetFocus;
          ReportError(MB_ICONINFORMATION);
        end;
      2004:
        begin
          PageControl1.ActivePageIndex := 1;
          Edit5.SetFocus;
          ReportError(MB_ICONINFORMATION);
        end;
      2005:
        begin
          PageControl1.ActivePageIndex := 1;
          Edit6.SetFocus;
          ReportError(MB_ICONINFORMATION);
        end;
      2006:
        begin
          PageControl1.ActivePageIndex := 1;
          Edit7.SetFocus;
          ReportError(MB_ICONINFORMATION);
        end;
      else
        ReportError(MB_ICONSTOP);
    end;

  if DeviceCfgReady = 0 then
    ResetConnection;
end;

procedure TForm1.ResetConnection;
begin
  Caption := Application.Title;
  lblVersion.Caption := '';

  Edit1.Enabled := False;
  Edit2.Enabled := False;
  Edit3.Enabled := False;

  TabSheet2.TabVisible := false;
  TabSheet3.TabVisible := false;
  TabSheet4.TabVisible := false;

  BitBtn1.Caption := 'Connect';
  BitBtn2.Enabled := False;
end;

procedure TForm1.CheckBox3Click(Sender: TObject);
begin
  Edit5.Enabled := CheckBox3.Checked;
  Edit6.Enabled := CheckBox3.Checked;
  Edit7.Enabled := CheckBox3.Checked;
end;

procedure TForm1.ReportError(uType: Cardinal);
var
  ErrorMsg: string;
begin
  SetLength(ErrorMsg, 100);
  GetErrorMsg(PChar(ErrorMsg), 100);
  MessageBox(handle, PChar(ErrorMsg), PChar(Application.Title), uType);
end;

end.

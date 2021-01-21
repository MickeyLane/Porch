unit Unit3;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls;

type
  TConnectDlg = class(TForm)
    Label1: TLabel;
    OKBtn: TButton;
    CancelBtn: TButton;
    Edit1: TEdit;
    Bevel1: TBevel;
    Image1: TImage;
    procedure OKBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function VerifyIpAddr(var IpAddr: String): boolean;
    function VerifyIpEdit(hWnd: HWND; edt: TEdit; ErrorMsg: String): boolean;
  end;

var
  ConnectDlg: TConnectDlg;

implementation

uses Unit1;

{$R *.dfm}

function TConnectDlg.VerifyIpAddr(var IpAddr: String): boolean;
var
  Sections: TStringList;
  Sec1, Sec2, Sec3, Sec4: integer;
begin
  Result := false;

  IpAddr := Trim(IpAddr);
  Sections := TStringList.Create;
  ExtractStrings(['.'], [], PChar(IpAddr), Sections);
  if Sections.Count <> 4 then
  begin
    Sections.Free;
    exit;
  end;

  Sec1 := StrToInt(Trim(Sections[0]));
  Sec2 := StrToInt(Trim(Sections[1]));
  Sec3 := StrToInt(Trim(Sections[2]));
  Sec4 := StrToInt(Trim(Sections[3]));
  Sections.Free;

  if (Sec1 > 255) Or (Sec2 > 255) Or (Sec3 > 255) Or (Sec4 > 255) Or (Sec1 < 0) Or (Sec2 < 0) Or (Sec3 < 0) Or (Sec4 < 0) then
    exit;

  IpAddr := IntToStr(Sec1) + '.' + IntToStr(Sec2) + '.' + IntToStr(Sec3) + '.' + IntToStr(Sec4);
  Result := True;
end;

function TConnectDlg.VerifyIpEdit(hWnd: HWND; edt: TEdit; ErrorMsg: String): boolean;
var
  addr: String;
begin
  addr := edt.Text;

  if VerifyIpAddr(addr) then
    Result := true
  else
  begin
    edt.SetFocus;
    MessageBox(hWnd, PChar(ErrorMsg), PChar(Application.Title), MB_ICONINFORMATION);
    Result := false;
  end;

  edt.Text := addr;
end;

procedure TConnectDlg.OKBtnClick(Sender: TObject);
begin
  if VerifyIpEdit(handle, Edit1, 'IP address is wrong.') then
    ModalResult := mrOK;
end;

end.

program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Unit3 in 'Unit3.pas' {ConnectDlg};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Config Utility for Network Relay';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

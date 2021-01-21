unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    edtAddress: TEdit;
    bbOK: TBitBtn;
    bbCancel: TBitBtn;
    rgKeyMode: TRadioGroup;
    Label5: TLabel;
    cbChNum: TComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

end.

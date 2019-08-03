program mbustester;

uses
  Forms,
  frmMainModbusTester in 'frmMainModbusTester.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'MODBUS TESTER';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

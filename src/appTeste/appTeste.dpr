program appTeste;

uses
  Vcl.Forms,
  UFPrincipal in 'UFPrincipal.pas' {Form2},
  ULog in '..\comum\ULog.pas',
  URotinaProcessamento in '..\comum\URotinaProcessamento.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.

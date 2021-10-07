unit UFPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TForm2 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses
  URotinaProcessamento, ULog;

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin
  TLog.GravarLogExecucao('Iniciar Processamento...');
  try
    try
      if (Processamento = nil) or (not Assigned(Processamento)) then
        Processamento := TProcessamento.Create();

      Processamento.IniciarProcessamento();
      FreeAndNil(Processamento);
    except
      on E: Exception do
      begin
        Tlog.GravarLogErro(E);
      end;
    end;
  finally
    Tlog.GravarLogExecucao('Processamento finalizado!');
  end;
end;

end.

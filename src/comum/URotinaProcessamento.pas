unit URotinaProcessamento;

interface

Type TProcessamento = class
  constructor Create();
  destructor  Destroy();
  public
    procedure IniciarProcessamento();
end;

var
  Processamento: TProcessamento;

implementation




{ TProcessamento }

constructor TProcessamento.Create;
begin
  //se precisar criar algum objeto ou iniciar algo
end;

destructor TProcessamento.Destroy;
begin
  //destruir todos os objetos e encerrar conexões
end;

procedure TProcessamento.IniciarProcessamento;
begin
  //executar o processamento desejado
  //pode usar Treads, lembrando de tratar a concorrencia.
end;

end.

unit ULog;

interface

uses
  Winapi.Windows, System.SysUtils;

type
  TLog = class
  private
    class procedure Gravar(texto: string; erro: boolean = false);
    class function InnerExceptions(erro: Exception): string;
  public
    class procedure GravarLogExecucao(texto: string);
    class procedure GravarLogErro(erro: Exception);
  end;

implementation

{ TLog }

class procedure TLog.Gravar(texto: string; erro: boolean = false);
var
  f: TextFile;
  caminho: string;
  arquivo: string;
begin
  try
    caminho := 'd:\Logs\';
    if erro then
      arquivo := FormatDateTime('yyyymmdd', Now) + '.erro'
    else
      arquivo := FormatDateTime('yyyymmdd', Now) + '.log';

    if not DirectoryExists(caminho) then
      ForceDirectories(caminho);

    { open a text file }
    AssignFile(f, caminho + arquivo);
    if FileExists(caminho+arquivo) then
        Append(f)
    else
      Rewrite(f);

    Writeln(f, texto);
    Flush(f);
    CloseFile(f);
  except
  end;
end;

class procedure TLog.GravarLogErro(erro: Exception);
var
  texto: string;
begin
  texto := FormatDateTime('DD/MM/YYYY HH:SS', Now) + ' ' + erro.Message + #13;
  if erro.InnerException <> nil then
    texto := texto + InnerExceptions(erro.InnerException);

  Gravar(texto, true);
end;

class procedure TLog.GravarLogExecucao(texto: string);
begin
  Gravar(FormatDateTime('dd/mm/yyyy hh:nn',now)+' '+texto);
end;

class function TLog.InnerExceptions(erro: Exception): string;
var
  texto: string;
begin

  if erro.InnerException <> nil then
    texto := InnerExceptions(erro.InnerException)
  else
    texto := erro.Message + #13;

  Result := texto;
end;

end.

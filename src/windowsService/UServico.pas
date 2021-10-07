unit UServico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.SvcMgr, Vcl.Dialogs,
  URotinaProcessamento, Vcl.ExtCtrls;

type
  TWindowsServiceDelphi = class(TService)
    Timer1: TTimer;
    procedure ServiceAfterInstall(Sender: TService);
    procedure ServiceAfterUninstall(Sender: TService);
    procedure ServiceBeforeInstall(Sender: TService);
    procedure ServiceBeforeUninstall(Sender: TService);
    procedure ServiceContinue(Sender: TService; var Continued: Boolean);
    procedure ServiceCreate(Sender: TObject);
    procedure ServiceDestroy(Sender: TObject);
    procedure ServiceExecute(Sender: TService);
    procedure ServicePause(Sender: TService; var Paused: Boolean);
    procedure ServiceShutdown(Sender: TService);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  WindowsServiceDelphi: TWindowsServiceDelphi;
  executando: Boolean = false;

implementation

uses
  ULog;

{$R *.dfm}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  WindowsServiceDelphi.Controller(CtrlCode);
end;

function TWindowsServiceDelphi.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TWindowsServiceDelphi.ServiceAfterInstall(Sender: TService);
begin
  TLog.GravarLogExecucao('ServiceAfterInstall');
end;

procedure TWindowsServiceDelphi.ServiceAfterUninstall(Sender: TService);
begin
  TLog.GravarLogExecucao('ServiceAfterUninstall');
end;

procedure TWindowsServiceDelphi.ServiceBeforeInstall(Sender: TService);
begin
  TLog.GravarLogExecucao('ServiceBeforeInstall');
end;

procedure TWindowsServiceDelphi.ServiceBeforeUninstall(Sender: TService);
begin
  TLog.GravarLogExecucao('ServiceBeforeUninstall');
end;

procedure TWindowsServiceDelphi.ServiceContinue(Sender: TService;
  var Continued: Boolean);
begin
  TLog.GravarLogExecucao('ServiceContinue');
end;

procedure TWindowsServiceDelphi.ServiceCreate(Sender: TObject);
begin
  TLog.GravarLogExecucao('ServiceCreate');
end;

procedure TWindowsServiceDelphi.ServiceDestroy(Sender: TObject);
begin
  TLog.GravarLogExecucao('ServiceDestroy');
end;

procedure TWindowsServiceDelphi.ServiceExecute(Sender: TService);
begin
  TLog.GravarLogExecucao('ServiceExecute');
  while not Terminated do
  begin
    ServiceThread.ProcessRequests(True);
  end;
end;

procedure TWindowsServiceDelphi.ServicePause(Sender: TService;
  var Paused: Boolean);
begin
  Paused := True;
  TLog.GravarLogExecucao('ServicePause');
end;

procedure TWindowsServiceDelphi.ServiceShutdown(Sender: TService);
begin
  TLog.GravarLogExecucao('ServiceShutdown');
end;

procedure TWindowsServiceDelphi.ServiceStart(Sender: TService;
  var Started: Boolean);
begin
  Timer1.Enabled := True;
  TLog.GravarLogExecucao('ServiceStart');
end;

procedure TWindowsServiceDelphi.ServiceStop(Sender: TService;
  var Stopped: Boolean);
begin
  TLog.GravarLogExecucao('ServiceStop');
end;

procedure TWindowsServiceDelphi.Timer1Timer(Sender: TObject);
begin
  if not executando then
  begin
    TLog.GravarLogExecucao('Iniciar Processamento...');
    executando := True;
    try
      try
        if (Processamento = nil) or (not Assigned(Processamento)) then
            Processamento := TProcessamento.Create();

        Processamento.IniciarProcessamento();
        FreeAndNil(Processamento);
      except
        on E: Exception do
        begin
          Tlog.GravarLogErro(e);
        end;
      end;
    finally
      executando := false;
      TLog.GravarLogExecucao('Processamento finalizado!');
    end;
  end;
end;

end.

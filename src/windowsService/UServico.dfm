object WindowsServiceDelphi: TWindowsServiceDelphi
  OldCreateOrder = False
  OnCreate = ServiceCreate
  OnDestroy = ServiceDestroy
  DisplayName = 'Windows Service Delphi'
  BeforeInstall = ServiceBeforeInstall
  AfterInstall = ServiceAfterInstall
  BeforeUninstall = ServiceBeforeUninstall
  AfterUninstall = ServiceAfterUninstall
  OnContinue = ServiceContinue
  OnExecute = ServiceExecute
  OnPause = ServicePause
  OnShutdown = ServiceShutdown
  OnStart = ServiceStart
  OnStop = ServiceStop
  Height = 454
  Width = 656
  object Timer1: TTimer
    Interval = 10000
    OnTimer = Timer1Timer
    Left = 312
    Top = 208
  end
end

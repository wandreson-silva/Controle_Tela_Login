# Desativar Facilidade de Acesso (neutralizando Utilman.exe)
New-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Utilman.exe' -Force
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Utilman.exe' -Name 'Debugger' -Value '0'

# Desativar botão de energia
New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'ShutdownWithoutLogon' -Value 0 -PropertyType DWord -Force

# Desativar rede na tela de logon
New-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System' -Name 'DontDisplayNetworkSelectionUI' -Value 1 -PropertyType DWord -Force

# Atualizar políticas
gpupdate /force

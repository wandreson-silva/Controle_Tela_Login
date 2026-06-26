# Restaurar Facilidade de Acesso
Remove-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Utilman.exe' -Recurse -ErrorAction SilentlyContinue

# Restaurar botão de energia
New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'ShutdownWithoutLogon' -Value 1 -PropertyType DWord -Force

# Restaurar rede na tela de logon
New-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System' -Name 'DontDisplayNetworkSelectionUI' -Value 0 -PropertyType DWord -Force

# Atualizar políticas
gpupdate /force

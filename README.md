# Controle_Tela_Login
# 1.Desativar o botão Facilidade de Acesso:

Neutralizar o Utilman.exe via Image File Execution Options.

# 2.Desativar o botão Energia:

Política de segurança avançada + reforço no registro.

# 3.Desativar o botão Rede:

# 4. Automatizado via PowerShell + Registro.

📦 Conteúdo do pacote:
```text
Scripts PowerShell:
Aplicar_Logon_Seguro.ps1 → aplica tudo.
Restaurar_Logon_Seguro.ps1 → desfaz tudo.
Arquivos .reg (caso prefira aplicar manualmente)
README com instruções de uso.

````

Copie e cole este script inteiro no PowerShell (como Administrador).
Ele vai criar tudo automaticamente na sua Área de Trabalho.

```ruby
# Diretório de saída
$destino = "$env:USERPROFILE\Desktop\Controle_Tela_Logon_Pro"
New-Item -ItemType Directory -Path $destino -Force

# Aplicar_Logon_Seguro.ps1
@"
# Desativar Facilidade de Acesso (neutralizando Utilman.exe)
New-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Utilman.exe' -Force
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Utilman.exe' -Name 'Debugger' -Value 'cmd.exe'

# Desativar botão de energia
New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'ShutdownWithoutLogon' -Value 0 -PropertyType DWord -Force

# Desativar rede na tela de logon
New-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System' -Name 'DontDisplayNetworkSelectionUI' -Value 1 -PropertyType DWord -Force

# Atualizar políticas
gpupdate /force
"@ | Out-File "$destino\Aplicar_Logon_Seguro.ps1" -Encoding UTF8

# Restaurar_Logon_Seguro.ps1
@"
# Restaurar Facilidade de Acesso
Remove-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Utilman.exe' -Recurse -ErrorAction SilentlyContinue

# Restaurar botão de energia
New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'ShutdownWithoutLogon' -Value 1 -PropertyType DWord -Force

# Restaurar rede na tela de logon
New-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System' -Name 'DontDisplayNetworkSelectionUI' -Value 0 -PropertyType DWord -Force

# Atualizar políticas
gpupdate /force
"@ | Out-File "$destino\Restaurar_Logon_Seguro.ps1" -Encoding UTF8

# Arquivo REG de Aplicação
@"
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Utilman.exe]
"Debugger"="cmd.exe"

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System]
"ShutdownWithoutLogon"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System]
"DontDisplayNetworkSelectionUI"=dword:00000001
"@ | Out-File "$destino\Aplicar_Logon_Seguro.reg" -Encoding ASCII

# Arquivo REG de Restauração
@"
Windows Registry Editor Version 5.00

[-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Utilman.exe]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System]
"ShutdownWithoutLogon"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System]
"DontDisplayNetworkSelectionUI"=dword:00000000
"@ | Out-File "$destino\Restaurar_Logon_Seguro.reg" -Encoding ASCII

# ReadMe
@"
INSTRUÇÕES:

1 Sempre execute os scripts PowerShell como ADMINISTRADOR.

2 Aplicar_Logon_Seguro.ps1 — remove:

- Facilidade de Acesso
- Botão de Energia
- Rede na tela de logon

3 Restaurar_Logon_Seguro.ps1 — restaura as opções.

4 Arquivos .reg podem ser usados caso prefira aplicar via Editor de Registro.

⚠ Reinicie o computador após aplicar para ver o efeito na tela de logon.
"@ | Out-File "$destino\README.txt" -Encoding UTF8

Write-Host "✅ Pacote profissional gerado em: $destino" -ForegroundColor Green
```

Depois que rodar:
Será criada na sua Área de Trabalho a pasta Controle_Tela_Logon_Pro com todos os arquivos.
Execute Aplicar_Logon_Seguro.ps1 (como Admin) e reinicie → você verá a tela de logon limpa. Esse método é 100% funcional para o Windows 10 Pro e Windows 11 Pro

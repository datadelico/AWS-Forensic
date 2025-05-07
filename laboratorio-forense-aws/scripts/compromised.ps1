# Crear archivos sospechosos
$maliciousContent = "Este es un archivo sospechoso para análisis forense"
Set-Content -Path "C:\suspicious_file.txt" -Value $maliciousContent
Set-Content -Path "C:\Windows\Temp\hidden_backdoor.txt" -Value "backdoor simulada"

# Crear entradas sospechosas en el registro
New-Item -Path "HKCU:\SOFTWARE\MaliciousSoftware" -Force
Set-ItemProperty -Path "HKCU:\SOFTWARE\MaliciousSoftware" -Name "LastConnection" -Value "198.51.100.123"

# Crear archivo de fondo rojo con texto
$wallpaperPath = "C:\Windows\Temp\compromised.bmp"

# Crear una imagen de fondo roja usando .NET
Add-Type -AssemblyName System.Drawing
$width = 1920
$height = 1080
$bmp = New-Object System.Drawing.Bitmap $width,$height
$graphics = [System.Drawing.Graphics]::FromImage($bmp)
$brush = [System.Drawing.Brushes]::Red
$graphics.FillRectangle($brush, 0, 0, $width, $height)
$font = New-Object System.Drawing.Font("Arial", 72)
$textBrush = [System.Drawing.Brushes]::White
$stringFormat = New-Object System.Drawing.StringFormat
$stringFormat.Alignment = [System.Drawing.StringAlignment]::Center
$stringFormat.LineAlignment = [System.Drawing.StringAlignment]::Center
$graphics.DrawString("SISTEMA COMPROMETIDO", $font, $textBrush, [System.Drawing.RectangleF]::FromLTRB(0, 0, $width, $height), $stringFormat)
$bmp.Save($wallpaperPath)

# Cambiar el fondo de pantalla para indicar sistema comprometido
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name WallPaper -Value $wallpaperPath
RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters

# Establecer fondo de escritorio
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name WallPaper -Value $wallpaperPath
RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters

# Simular búsquedas sospechosas en el historial
$historyFile = "$env:USERPROFILE\Documents\search_history.txt"
"cómo borrar evidencias digitales",
"exploit windows vulnerabilidad",
"contraseñas admin por defecto",
"herramientas hacking windows",
"cómo acceder a servidor sin permiso" | Out-File -FilePath $historyFile

# Crear tareas programadas sospechosas
$action = New-ScheduledTaskAction -Execute "cmd.exe" -Argument "/c echo 'backdoor check' > C:\Windows\Temp\check.log"
$trigger = New-ScheduledTaskTrigger -Daily -At 3am
Register-ScheduledTask -TaskName "SuspiciousTask" -Action $action -Trigger $trigger -Description "Suspicious scheduled task for forensic analysis" -Force

# Agregar usuario sospechoso (desactivado por seguridad)
# Agregar usuario sospechoso
$password = ConvertTo-SecureString "P@ssw0rd123!" -AsPlainText -Force
try {
    New-LocalUser -Name "backdoor_user" -Password $password -Description "Usuario sospechoso para análisis forense" -AccountNeverExpires -ErrorAction Stop
    Write-Host "Usuario backdoor_user creado exitosamente" -ForegroundColor Green
} catch {
    Write-Warning "No se pudo crear el usuario: $_"
}

# Opcional: Agregar el usuario al grupo de administradores
Add-LocalGroupMember -Group "Administrators" -Member "backdoor_user" -ErrorAction SilentlyContinue
New-LocalUser -Name "backdoor_user" -Password $password -Description "Usuario sospechoso para análisis forense" -AccountNeverExpires
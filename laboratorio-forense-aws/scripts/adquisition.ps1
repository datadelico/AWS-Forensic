# ------------------------------
# CONFIGURACIÓN INICIAL
# ------------------------------

# Definir rutas de carpetas para el entorno forense
$forensicVolume = "C:\EinesForenses"         # Simula el volumen "eines-forenses"
$evidenceDir   = "C:\Evidencies"              # Carpeta para guardar las evidencias adquiridas
$toolsDir      = "$forensicVolume\Tools"      # Carpeta para almacenar las herramientas forenses

# Crear carpetas si no existen
foreach ($folder in @($forensicVolume, $evidenceDir, $toolsDir)) {
    if (!(Test-Path $folder)) {
        New-Item -ItemType Directory -Path $folder | Out-Null
        Write-Host "[+] Carpeta creada: $folder"
    }
}

# ------------------------------
# DESCARGA AUTOMÁTICA DE HERRAMIENTAS
# ------------------------------

# URLs de descarga
$winpmemUrl   = "https://github.com/Velocidex/WinPmem/releases/download/v2.1.1/winpmem_mini_x64.exe"
$disk2vhdUrl  = "https://download.sysinternals.com/files/Disk2vhd.zip"

# Rutas locales para guardar las herramientas
$winpmemPath   = Join-Path $toolsDir "winpmem_mini_x64.exe"
$disk2vhdZip   = Join-Path $toolsDir "Disk2vhd.zip"
$disk2vhdFolder= Join-Path $toolsDir "Disk2vhd"

# Descargar WinPMEM si no existe
if (!(Test-Path $winpmemPath)) {
    Write-Host "[+] Descargando WinPMEM..."
    Invoke-WebRequest -Uri $winpmemUrl -OutFile $winpmemPath
    Write-Host "[+] WinPMEM descargado en: $winpmemPath"
} else {
    Write-Host "[*] WinPMEM ya existe en: $winpmemPath"
}

# Descargar Disk2vhd si no existe
if (!(Test-Path $disk2vhdFolder)) {
    Write-Host "[+] Descargando Disk2vhd..."
    Invoke-WebRequest -Uri $disk2vhdUrl -OutFile $disk2vhdZip
    Write-Host "[+] Extrayendo Disk2vhd..."
    Expand-Archive -Path $disk2vhdZip -DestinationPath $disk2vhdFolder -Force
    Write-Host "[+] Disk2vhd extraído en: $disk2vhdFolder"
} else {
    Write-Host "[*] Disk2vhd ya existe en: $disk2vhdFolder"
}

# ------------------------------
# ACQUISICIÓN DE EVIDENCIAS
# (Seguir l'ordre de volatilitat per preservar la integritat)
# ------------------------------

# Generar timestamp para nombrar archivos de forma única
$timestamp = Get-Date -Format "yyyyMMdd-HHmmss"

# 1. Adquisición de RAM
$ramImage = Join-Path $evidenceDir "RAM_$timestamp.raw"
Write-Host "------------------------------------------"
Write-Host "[1] Capturando la memoria RAM..."
$winpmemArgs = "--output `"$ramImage`""
Start-Process -FilePath $winpmemPath -ArgumentList $winpmemArgs -Wait -NoNewWindow
Write-Host "[+] Imagen de RAM guardada en: $ramImage"

# Calcular hash de la imagen de RAM (SHA256)
$ramHash = Get-FileHash -Path $ramImage -Algorithm SHA256
# Calcular hash de la imagen de RAM (MD5)
$ramHashMD5 = Get-FileHash -Path $ramImage -Algorithm MD5

# Guardar el hash de la imagen de RAM en un archivo
$ramHashFile = Join-Path $evidenceDir "RAM_$timestamp.hash"
$ramHash | Out-File -FilePath $ramHashFile -Encoding UTF8
Write-Host "[+] Hash de la imagen RAM guardado en: $ramHashFile"
# Guardar el hash MD5 de la imagen de RAM en un archivo
$ramHashMD5File = Join-Path $evidenceDir "RAM_$timestamp_MD5.hash"
$ramHashMD5 | Out-File -FilePath $ramHashMD5File -Encoding UTF8
Write-Host "[+] Hash MD5 de la imagen RAM guardado en: $ramHashMD5File"

# ------------------------------

# 2. Adquisición del disco (persistent evidence)
# Se simula la creación de una copia del disco usando el snapshot previo.
# Aquí usamos Disk2vhd para crear una imagen VHD del disco físico principal (PHYSICALDRIVE0).
$diskImage = Join-Path $evidenceDir "DISCO_$timestamp.vhd"
$disk2vhdPath = Join-Path $disk2vhdFolder "Disk2vhd.exe"
Write-Host "------------------------------------------"
Write-Host "[2] Capturando imagen del disco (PHYSICALDRIVE0) con Disk2vhd..."
# Parámetros:
# -accepteula : Acepta el EULA sin interacción.
# -o           : Sobrescribe si ya existe.
# -r           : Incluye volúmenes de solo lectura (opcional, según necesidad).
$disk2vhdArgs = "-accepteula -o -r \\.\PHYSICALDRIVE0 `"$diskImage`""
Start-Process -FilePath $disk2vhdPath -ArgumentList $disk2vhdArgs -Wait -NoNewWindow
Write-Host "[+] Imagen del disco guardada en: $diskImage"

# Calcular hash de la imagen de disco (SHA256)
$diskHash = Get-FileHash -Path $diskImage -Algorithm SHA256
Write-Host "[*] Hash de la imagen de disco (SHA256): $($diskHash.Hash)"

# ------------------------------
# REGISTRO DE LAS EVIDENCIAS ADQUIRIDAS
# ------------------------------

$logFile = Join-Path $evidenceDir "Registro_Evidencias_$timestamp.txt"
$logContent = @"
Fecha: $(Get-Date)
Imagen RAM: $ramImage
Hash RAM (SHA256): $($ramHash.Hash)

Imagen Disco: $diskImage
Hash Disco (SHA256): $($diskHash.Hash)

Notas:
- Las imágenes se han adquirido siguiendo el orden de volatilitat.
- Se recomienda verificar estos hashes antes y después de transferir las evidencias.
"@

$logContent | Out-File -FilePath $logFile -Encoding UTF8
Write-Host "------------------------------------------"
Write-Host "[+] Registro de evidencias creado en: $logFile"

# ------------------------------
# CONCLUSIÓN DEL PROCESO
# ------------------------------
Write-Host "=========================================="
Write-Host "[OK] Proceso forense completado."
Write-Host "    Revisar las imágenes y el registro en:"
Write-Host "       Evidencias: $evidenceDir"
Write-Host "       Herramientas: $toolsDir"
Write-Host "=========================================="

# FIN DEL SCRIPT

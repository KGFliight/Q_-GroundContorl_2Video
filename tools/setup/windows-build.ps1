param(
  [string]$QtVersion = "6.9.2",
  [ValidateSet('Release','Debug')]
  [string]$Config = 'Release'
)

$ErrorActionPreference = 'Stop'

Write-Host "Installing build tools (cmake, ninja, git)..."
choco install -y cmake ninja git 7zip | Out-Null

Write-Host "Installing Python aqtinstall..."
pip install --upgrade aqtinstall | Out-Null

Write-Host "Installing GStreamer (MSVC x86_64 runtime + devel)..."
$runtimeUrl = 'https://gstreamer.freedesktop.org/data/pkg/windows/1.24.10/msvc/gstreamer-1.0-msvc-x86_64-1.24.10.msi'
$develUrl   = 'https://gstreamer.freedesktop.org/data/pkg/windows/1.24.10/msvc/gstreamer-1.0-devel-msvc-x86_64-1.24.10.msi'
Invoke-WebRequest $runtimeUrl -OutFile gstreamer-runtime.msi
Invoke-WebRequest $develUrl   -OutFile gstreamer-devel.msi
Start-Process msiexec -ArgumentList '/i','gstreamer-runtime.msi','/qn','/norestart' -Wait
Start-Process msiexec -ArgumentList '/i','gstreamer-devel.msi','/qn','/norestart' -Wait
$env:GSTREAMER_1_0_ROOT_MSVC_X86_64 = 'C:\gstreamer\1.0\msvc_x86_64'

Write-Host "Installing Qt $QtVersion (MSVC 2022)..."
aqt install-qt windows desktop $QtVersion win64_msvc2022_64 --outputdir C:\Qt
$env:QT_ROOT_DIR = "C:\Qt\$QtVersion\msvc2022_64"

Write-Host "Configuring..."
cmake --preset Windows

Write-Host "Building ($Config)..."
if ($Config -eq 'Release') {
  cmake --build --preset Windows
} else {
  cmake --build --preset Windows-debug
}

Write-Host "Packaging..."
cmake --build --preset Windows --target package

Write-Host "Done. Artifacts in build/qt6-Windows" -ForegroundColor Green


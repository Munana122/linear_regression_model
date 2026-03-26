$ErrorActionPreference = "Stop"

$repoRoot = $PSScriptRoot
$apiPath = Join-Path $repoRoot "summative\API"
$flutterPath = Join-Path $repoRoot "summative\FlutterApp"

Write-Host "Starting FastAPI server in a new terminal..." -ForegroundColor Cyan
$apiCommand = "Set-Location '$apiPath'; pip install -r requirements.txt; uvicorn main:app --reload"
Start-Process powershell -ArgumentList "-NoExit", "-Command", $apiCommand | Out-Null

Start-Sleep -Seconds 4

Write-Host "Starting Flutter app..." -ForegroundColor Cyan
Set-Location $flutterPath

if (!(Test-Path (Join-Path $flutterPath "pubspec.lock"))) {
    flutter pub get
}

flutter run

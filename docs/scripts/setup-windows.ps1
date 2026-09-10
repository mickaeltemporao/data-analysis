# ==============================================================================
# Setup Script for Windows — Data Analysis (Sciences Po Bordeaux)
# Installs VS Code, Python, Jupyter extensions, and data science libraries.
# ==============================================================================

$ErrorActionPreference = "Continue"

Write-Host "🚀 Starting Data Analysis Windows Setup..." -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan

# 1. Check for Winget or Chocolatey
$useWinget = $false
try {
    $wingetVer = winget --version 2>$null
    if ($wingetVer) {
        $useWinget = $true
        Write-Host "✅ Winget detected." -ForegroundColor Green
    }
} catch {}

if ($useWinget) {
    Write-Host "💻 Installing Visual Studio Code via Winget..." -ForegroundColor Yellow
    winget install Microsoft.VisualStudioCode --silent --accept-package-agreements --accept-source-agreements

    Write-Host "🐍 Installing Python via Winget..." -ForegroundColor Yellow
    winget install Python.Python.3.12 --silent --accept-package-agreements --accept-source-agreements
} else {
    # Check for Chocolatey
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "🍫 Installing Chocolatey..." -ForegroundColor Yellow
        Set-ExecutionPolicy Bypass -Scope Process -Force
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    }

    Write-Host "💻 Installing Visual Studio Code via Chocolatey..." -ForegroundColor Yellow
    choco install -y vscode

    Write-Host "🐍 Installing Python via Chocolatey..." -ForegroundColor Yellow
    choco install -y python3
}

# Update environment path for current session
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# 2. Install VS Code extensions
if (Get-Command code -ErrorAction SilentlyContinue) {
    Write-Host "🧩 Installing VS Code extensions (Python, Jupyter)..." -ForegroundColor Yellow
    code --install-extension ms-python.python --force
    code --install-extension ms-toolsai.jupyter --force
} else {
    Write-Host "⚠️ VS Code installed. If 'code' command is not found, launch VS Code and install the Python and Jupyter extensions." -ForegroundColor Yellow
}

# 3. Install Core Python Libraries (including vl-convert-python for Altair image exports)
Write-Host "📚 Installing data analysis packages (pandas, statsmodels, altair, vl-convert-python)..." -ForegroundColor Yellow
python -m pip install --upgrade pip --quiet
python -m pip install --quiet pandas statsmodels altair vega_datasets vl-convert-python

Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "🎉 Setup complete! You are ready for Data Analysis." -ForegroundColor Green
Write-Host "👉 Open VS Code, press Ctrl+Shift+P, and select 'Python: Create Environment' (.venv) for your course folder." -ForegroundColor Green

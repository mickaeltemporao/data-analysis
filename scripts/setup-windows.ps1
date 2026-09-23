# ==============================================================================
# Setup Script for Windows — Data Analysis (Sciences Po Bordeaux)
# Installs VS Code, Python, Jupyter extensions, sets up data-analysis environment, and data science libraries.
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

# 3. Set up Course Workspace Directory and data-analysis environment
$docsPath = [System.Environment]::GetFolderPath('MyDocuments')
$targetDir = Join-Path $docsPath "data-analysis"
if ((Get-Location).Path -ne $HOME -and ((Test-Path ".git") -or (Test-Path "pyproject.toml") -or (Test-Path "mkdocs.yml"))) {
    $targetDir = (Get-Location).Path
}

Write-Host "📁 Setting up course workspace in $targetDir..." -ForegroundColor Yellow
if (-not (Test-Path $targetDir)) {
    New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
}

$venvPath = Join-Path $targetDir "data-analysis"
Write-Host "⚡ Creating Python virtual environment (data-analysis)..." -ForegroundColor Yellow
if (-not (Test-Path (Join-Path $venvPath "Scripts\python.exe"))) {
    python -m venv --prompt data-analysis $venvPath
}

Write-Host "📚 Installing core data analysis packages into data-analysis environment (pandas, altair, statsmodels, vl-convert-python)..." -ForegroundColor Yellow
$venvPython = Join-Path $venvPath "Scripts\python.exe"
& $venvPython -m pip install --upgrade pip --quiet
& $venvPython -m pip install --quiet pandas altair statsmodels vega_datasets vl-convert-python

# 4. Configure Sane VS Code Defaults (Disable tutorials, disable Copilot, enable word wrap & auto-save)
Write-Host "⚙️ Configuring beginner-friendly VS Code settings..." -ForegroundColor Yellow
$pyConfig = @"
import json, os
from pathlib import Path

appdata = os.environ.get("APPDATA")
if appdata:
    settings_path = Path(appdata) / "Code" / "User" / "settings.json"
    settings_path.parent.mkdir(parents=True, exist_ok=True)
    data = {}
    if settings_path.exists():
        try:
            with open(settings_path, "r", encoding="utf-8") as f:
                data = json.load(f)
        except Exception:
            data = {}
    data.update({
        "workbench.startupEditor": "none",
        "workbench.welcomePage.walkthroughs.openOnInstall": False,
        "github.copilot.enable": {"*": False},
        "github.copilot.editor.enableAutoCompletions": False,
        "editor.wordWrap": "on",
        "files.autoSave": "afterDelay",
        "files.autoSaveDelay": 1000,
        "python.REPL.sendToNativeREPL": True,
        "python.terminal.activateEnvironment": True,
        "python.terminal.executeInFileDir": True,
        "python.defaultInterpreterPath": "${workspaceFolder}/data-analysis/Scripts/python.exe",
        "notebook.lineNumbers": "on",
        "notebook.output.textLineLimit": 150,
        "notebook.insertToolbarLocation": "betweenCells"
    })
    with open(settings_path, "w", encoding="utf-8") as f:
        json.dump(data, f, indent=4)
"@
try {
    $pyConfig | python - 2>$null
} catch {}

Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "🎉 Setup complete! You are ready for Data Analysis." -ForegroundColor Green
Write-Host "👉 Course workspace and data-analysis environment are ready at: $targetDir" -ForegroundColor Green
Write-Host "👉 Launch VS Code and open your course folder: code `"$targetDir`"" -ForegroundColor Green

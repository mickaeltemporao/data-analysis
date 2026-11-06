# ==============================================================================
# Setup Script for Windows — Data Analysis (Sciences Po Bordeaux)
# Installs VS Code, Python, Jupyter extensions, sets up .venv-da environment, and data science libraries.
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

# 3. Set up Course Workspace Directory and .venv-da environment
$docsPath = [System.Environment]::GetFolderPath('MyDocuments')
$targetDir = Join-Path $docsPath "data-analysis"
if ((Get-Location).Path -ne $HOME -and ((Test-Path ".git") -or (Test-Path "pyproject.toml") -or (Test-Path "mkdocs.yml"))) {
    $targetDir = (Get-Location).Path
}

Write-Host "📁 Setting up course workspace in $targetDir..." -ForegroundColor Yellow
if (-not (Test-Path $targetDir)) {
    New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
}

$oldVenvPath1 = Join-Path $targetDir "data-analysis"
$oldVenvPath2 = Join-Path $targetDir ".env-da"
$venvPath = Join-Path $targetDir ".venv-da"

# Migrate old environment to '.venv-da' if it exists
if (Test-Path $oldVenvPath2) {
    Write-Host "🔄 Found existing '.env-da' environment. Migrating to '.venv-da'..." -ForegroundColor Yellow
    if (-not (Test-Path $venvPath)) {
        Rename-Item -Path $oldVenvPath2 -NewName ".venv-da" -Force -ErrorAction SilentlyContinue
    } else {
        Remove-Item -Recurse -Force $oldVenvPath2 -ErrorAction SilentlyContinue
    }
} elseif (Test-Path $oldVenvPath1) {
    Write-Host "🔄 Found existing 'data-analysis' environment. Migrating to '.venv-da'..." -ForegroundColor Yellow
    if (-not (Test-Path $venvPath)) {
        Rename-Item -Path $oldVenvPath1 -NewName ".venv-da" -Force -ErrorAction SilentlyContinue
    } else {
        Remove-Item -Recurse -Force $oldVenvPath1 -ErrorAction SilentlyContinue
    }
}

# Resolve system Python command
$sysPython = $null
if (Get-Command py -ErrorAction SilentlyContinue) {
    $testPy = try { & py -3 -c "import sys; print(sys.executable)" 2>$null } catch { $null }
    if ($testPy) { $sysPython = "py -3" }
}
if (-not $sysPython -and (Get-Command python -ErrorAction SilentlyContinue)) {
    $testPy = try { & python -c "import sys; print(sys.executable)" 2>$null } catch { $null }
    if ($testPy) { $sysPython = "python" }
}
if (-not $sysPython) {
    $candidates = @(
        "$env:LOCALAPPDATA\Programs\Python\Python312\python.exe",
        "$env:ProgramFiles\Python312\python.exe",
        "C:\Python312\python.exe",
        "$env:LOCALAPPDATA\Programs\Python\Python311\python.exe",
        "$env:ProgramFiles\Python311\python.exe",
        "C:\Python311\python.exe"
    )
    foreach ($cand in $candidates) {
        if (Test-Path $cand) {
            $sysPython = "`"$cand`""
            break
        }
    }
}
if (-not $sysPython) { $sysPython = "python" }

Write-Host "⚡ Configuring Python virtual environment (.venv-da)..." -ForegroundColor Yellow
if (-not (Test-Path (Join-Path $venvPath "Scripts\python.exe"))) {
    Invoke-Expression "$sysPython -m venv --prompt .venv-da `"$venvPath`""
} else {
    Invoke-Expression "$sysPython -m venv --prompt .venv-da `"$venvPath`""
}

Write-Host "📚 Installing core packages into .venv-da environment (ipykernel, pandas, altair, statsmodels, vl-convert-python)..." -ForegroundColor Yellow
$venvPython = Join-Path $venvPath "Scripts\python.exe"
& $venvPython -m pip install --upgrade pip --quiet
& $venvPython -m pip install --quiet ipykernel pandas altair statsmodels vega_datasets vl-convert-python
& $venvPython -m ipykernel install --user --name venv-da --display-name "Python (.venv-da)" 2>$null

# Clean up old environment directories if they still exist
if (Test-Path $oldVenvPath1) {
    Remove-Item -Recurse -Force $oldVenvPath1 -ErrorAction SilentlyContinue
}
if (Test-Path $oldVenvPath2) {
    Remove-Item -Recurse -Force $oldVenvPath2 -ErrorAction SilentlyContinue
}

# 4. Configure Workspace Settings (.vscode/settings.json in targetDir)
$vscodeDir = Join-Path $targetDir ".vscode"
if (-not (Test-Path $vscodeDir)) {
    New-Item -ItemType Directory -Path $vscodeDir -Force | Out-Null
}
$tempWsScript = Join-Path $env:TEMP "setup_da_ws.py"
@'
import sys, json
from pathlib import Path

target_dir = Path(sys.argv[1])
ws_path = target_dir / ".vscode" / "settings.json"
ws_path.parent.mkdir(parents=True, exist_ok=True)
data = {}
if ws_path.exists():
    try:
        with open(ws_path, "r", encoding="utf-8") as f:
            data = json.load(f)
    except Exception:
        data = {}
data.update({
    "python.defaultInterpreterPath": "${workspaceFolder}/.venv-da/Scripts/python.exe",
    "python.terminal.activateEnvironment": True,
    "python.terminal.executeInFileDir": True,
    "python.REPL.sendToNativeREPL": True
})
with open(ws_path, "w", encoding="utf-8") as f:
    json.dump(data, f, indent=4)
'@ | Set-Content -Path $tempWsScript -Encoding UTF8

try {
    & $venvPython $tempWsScript "$targetDir"
} catch {}
Remove-Item $tempWsScript -Force -ErrorAction SilentlyContinue

# 5. Configure Sane VS Code Defaults (Disable tutorials, disable Copilot, disable Restricted Mode, enable word wrap & auto-save)
Write-Host "⚙️ Configuring beginner-friendly VS Code settings..." -ForegroundColor Yellow
$tempUserScript = Join-Path $env:TEMP "setup_da_user.py"
@'
import sys, json, os
from pathlib import Path

target_dir = Path(sys.argv[1])
folder_uri = target_dir.resolve().as_uri()

appdata = os.environ.get("APPDATA")
if appdata:
    user_dir = Path(appdata) / "Code" / "User"
    settings_path = user_dir / "settings.json"
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
        "security.workspace.trust.enabled": False,
        "security.workspace.trust.emptyWindow": True,
        "security.workspace.trust.untrustedFiles": "open",
        "github.copilot.enable": {"*": False},
        "github.copilot.editor.enableAutoCompletions": False,
        "editor.wordWrap": "on",
        "files.autoSave": "afterDelay",
        "files.autoSaveDelay": 1000,
        "window.restoreWindows": "all",
        "python.REPL.sendToNativeREPL": True,
        "python.terminal.activateEnvironment": True,
        "python.terminal.executeInFileDir": True,
        "python.defaultInterpreterPath": "${workspaceFolder}/.venv-da/Scripts/python.exe",
        "notebook.lineNumbers": "on",
        "notebook.output.textLineLimit": 150,
        "notebook.insertToolbarLocation": "betweenCells"
    })
    with open(settings_path, "w", encoding="utf-8") as f:
        json.dump(data, f, indent=4)

    # Pre-seed globalStorage/storage.json so launching VS Code directly opens the course folder
    storage_path = user_dir / "globalStorage" / "storage.json"
    storage_path.parent.mkdir(parents=True, exist_ok=True)
    s_data = {}
    if storage_path.exists():
        try:
            with open(storage_path, "r", encoding="utf-8") as sf:
                s_data = json.load(sf)
        except Exception:
            s_data = {}

    win_state = s_data.get("windowsState", {})
    if not win_state.get("lastActiveWindow") and not win_state.get("openedWindows"):
        win_state["lastActiveWindow"] = {"folder": folder_uri}
        win_state["openedWindows"] = [{"folderUri": folder_uri}]
        s_data["windowsState"] = win_state
        try:
            with open(storage_path, "w", encoding="utf-8") as sf:
                json.dump(s_data, sf, indent=4)
        except Exception:
            pass
'@ | Set-Content -Path $tempUserScript -Encoding UTF8

try {
    & $venvPython $tempUserScript "$targetDir"
} catch {}
Remove-Item $tempUserScript -Force -ErrorAction SilentlyContinue

Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "🎉 Setup complete! You are ready for Data Analysis." -ForegroundColor Green
Write-Host "👉 Course workspace and .venv-da environment are ready at: $targetDir" -ForegroundColor Green
Write-Host "🚀 Opening Visual Studio Code in your course workspace..." -ForegroundColor Green
if (Get-Command code -ErrorAction SilentlyContinue) {
    Start-Process code -ArgumentList "`"$targetDir`""
} else {
    $vscodeCandidates = @(
        "$env:LOCALAPPDATA\Programs\Microsoft VS Code\Code.exe",
        "$env:ProgramFiles\Microsoft VS Code\Code.exe",
        "${env:ProgramFiles(x86)}\Microsoft VS Code\Code.exe"
    )
    foreach ($vpath in $vscodeCandidates) {
        if (Test-Path $vpath) {
            Start-Process $vpath -ArgumentList "`"$targetDir`""
            break
        }
    }
}

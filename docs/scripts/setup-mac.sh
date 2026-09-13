#!/usr/bin/env bash
# ==============================================================================
# Setup Script for macOS — Data Analysis (Sciences Po Bordeaux)
# Installs Homebrew, VS Code, Python, Jupyter extensions, and data science libraries.
# ==============================================================================

set -e

echo "🚀 Starting Data Analysis macOS Setup..."
echo "============================================================"

# 1. Check / Install Xcode Command Line Tools
if ! xcode-select -p &>/dev/null; then
    echo "📦 Installing Xcode Command Line Tools..."
    xcode-select --install || true
    echo "⚠️ If a pop-up appeared, please complete the installation and re-run this script."
fi

# 2. Check / Install Homebrew
if ! command -v brew &>/dev/null; then
    echo "🍺 Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Configure PATH for current session
    if [[ $(uname -m) == "arm64" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        eval "$(/usr/local/bin/brew shellenv)"
    fi
else
    echo "✅ Homebrew is already installed."
fi

# 3. Install VS Code and Python via Homebrew
echo "💻 Installing Visual Studio Code..."
brew install --cask visual-studio-code || true

echo "🐍 Installing Python..."
brew install python || true

# 4. Configure 'code' CLI path if needed
if ! command -v code &>/dev/null; then
    export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"
fi

# 5. Install VS Code Extensions
if command -v code &>/dev/null; then
    echo "🧩 Installing VS Code extensions (Python, Jupyter)..."
    code --install-extension ms-python.python --force || true
    code --install-extension ms-toolsai.jupyter --force || true
else
    echo "⚠️ Note: Could not find 'code' command in PATH. Please launch VS Code manually and install extensions: Python, Jupyter."
fi

# 6. Install Core Python Libraries (including vl-convert-python for Altair image exports)
echo "📚 Installing core data analysis packages (pandas, altair, statsmodels, vl-convert-python)..."
python3 -m pip install --upgrade pip --quiet || true
python3 -m pip install --quiet pandas altair statsmodels vega_datasets vl-convert-python || true

# 7. Configure Sane VS Code Defaults (Disable tutorials, disable Copilot, enable word wrap & auto-save)
echo "⚙️ Configuring beginner-friendly VS Code settings..."
python3 - << 'EOF' || true
import json, os
from pathlib import Path

settings_path = Path.home() / "Library" / "Application Support" / "Code" / "User" / "settings.json"
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
    "notebook.lineNumbers": "on",
    "notebook.output.textLineLimit": 150,
    "notebook.insertToolbarLocation": "betweenCells"
})

with open(settings_path, "w", encoding="utf-8") as f:
    json.dump(data, f, indent=4)
EOF

echo "============================================================"
echo "🎉 Setup complete! You are ready for Data Analysis."
echo "👉 Open VS Code, press Cmd+Shift+P, and select 'Python: Create Environment' (.venv) for your course folder."

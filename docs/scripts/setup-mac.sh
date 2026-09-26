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
# 2. Check / Install Homebrew
if ! command -v brew &>/dev/null; then
    if [ -x "/opt/homebrew/bin/brew" ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [ -x "/usr/local/bin/brew" ]; then
        eval "$(/usr/local/bin/brew shellenv)"
    else
        echo "🍺 Homebrew not found. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        if [[ $(uname -m) == "arm64" ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        else
            eval "$(/usr/local/bin/brew shellenv)"
        fi
    fi
else
    echo "✅ Homebrew is already installed."
fi

# Ensure brew shellenv is in .zprofile so future terminal sessions have brew in PATH
if [[ $(uname -m) == "arm64" ]] && [ -x "/opt/homebrew/bin/brew" ]; then
    if ! grep -qs 'brew shellenv' "$HOME/.zprofile" 2>/dev/null; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
    fi
elif [ -x "/usr/local/bin/brew" ]; then
    if ! grep -qs 'brew shellenv' "$HOME/.zprofile" 2>/dev/null; then
        echo 'eval "$(/usr/local/bin/brew shellenv)"' >> "$HOME/.zprofile"
    fi
fi

# 3. Install VS Code, Python, and uv via Homebrew
echo "💻 Installing Visual Studio Code..."
brew install --cask visual-studio-code || true

echo "🐍 Installing Python and uv..."
brew install python uv || brew install python || true

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

# 6. Set up Course Workspace Directory and .env-da environment
TARGET_DIR="$HOME/Documents/data-analysis"
if [ "$PWD" != "$HOME" ] && [ -d "$PWD/.git" -o -f "$PWD/pyproject.toml" -o -f "$PWD/mkdocs.yml" ]; then
    TARGET_DIR="$PWD"
fi

echo "📁 Setting up course workspace in $TARGET_DIR..."
mkdir -p "$TARGET_DIR"

# Migrate old 'data-analysis' environment to '.env-da' if it exists
if [ -d "$TARGET_DIR/data-analysis" ]; then
    echo "🔄 Found existing 'data-analysis' environment. Migrating to '.env-da'..."
    if [ ! -d "$TARGET_DIR/.env-da" ]; then
        mv "$TARGET_DIR/data-analysis" "$TARGET_DIR/.env-da"
    else
        rm -rf "$TARGET_DIR/data-analysis"
    fi
fi

echo "⚡ Configuring Python virtual environment (.env-da)..."
if command -v uv &>/dev/null; then
    uv venv --seed "$TARGET_DIR/.env-da" --prompt .env-da
    echo "📚 Installing core packages into .env-da environment (ipykernel, pandas, altair, statsmodels, vl-convert-python)..."
    uv pip install --python "$TARGET_DIR/.env-da/bin/python" pip ipykernel pandas altair statsmodels vega_datasets vl-convert-python
else
    python3 -m venv --prompt .env-da "$TARGET_DIR/.env-da"
    echo "📚 Installing core packages into .env-da environment (ipykernel, pandas, altair, statsmodels, vl-convert-python)..."
    "$TARGET_DIR/.env-da/bin/python" -m pip install --upgrade pip --quiet || true
    "$TARGET_DIR/.env-da/bin/python" -m pip install --quiet ipykernel pandas altair statsmodels vega_datasets vl-convert-python || true
fi

# Clean up any leftover old 'data-analysis' directory if it exists
if [ -d "$TARGET_DIR/data-analysis" ]; then
    rm -rf "$TARGET_DIR/data-analysis"
fi

# Register ipykernel for Jupyter / VS Code Native REPL
"$TARGET_DIR/.env-da/bin/python" -m ipykernel install --user --name env-da --display-name "Python (.env-da)" &>/dev/null || true

# 7. Configure Workspace Settings (.vscode/settings.json in TARGET_DIR)
mkdir -p "$TARGET_DIR/.vscode"
"$TARGET_DIR/.env-da/bin/python" - "$TARGET_DIR" << 'EOF' || true
import sys, json
from pathlib import Path

target_dir = Path(sys.argv[1])
ws_settings = target_dir / ".vscode" / "settings.json"
ws_settings.parent.mkdir(parents=True, exist_ok=True)
data = {}
if ws_settings.exists():
    try:
        with open(ws_settings, "r", encoding="utf-8") as f:
            data = json.load(f)
    except Exception:
        data = {}

data.update({
    "python.defaultInterpreterPath": "${workspaceFolder}/.env-da/bin/python",
    "python.terminal.activateEnvironment": True,
    "python.terminal.executeInFileDir": True,
    "python.REPL.sendToNativeREPL": True
})

with open(ws_settings, "w", encoding="utf-8") as f:
    json.dump(data, f, indent=4)
EOF

# 8. Configure Sane VS Code Defaults (Disable tutorials, disable Copilot, disable Restricted Mode, enable word wrap & auto-save)
echo "⚙️ Configuring beginner-friendly VS Code settings..."
"$TARGET_DIR/.env-da/bin/python" - << 'EOF' || true
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
    "security.workspace.trust.enabled": False,
    "security.workspace.trust.emptyWindow": True,
    "security.workspace.trust.untrustedFiles": "open",
    "github.copilot.enable": {"*": False},
    "github.copilot.editor.enableAutoCompletions": False,
    "editor.wordWrap": "on",
    "files.autoSave": "afterDelay",
    "files.autoSaveDelay": 1000,
    "python.REPL.sendToNativeREPL": True,
    "python.terminal.activateEnvironment": True,
    "python.terminal.executeInFileDir": True,
    "python.defaultInterpreterPath": "${workspaceFolder}/.env-da/bin/python",
    "notebook.lineNumbers": "on",
    "notebook.output.textLineLimit": 150,
    "notebook.insertToolbarLocation": "betweenCells"
})

with open(settings_path, "w", encoding="utf-8") as f:
    json.dump(data, f, indent=4)
EOF

echo "============================================================"
echo "🎉 Setup complete! You are ready for Data Analysis."
echo "👉 Course workspace and .env-da environment are ready at: $TARGET_DIR"
echo "👉 Launch VS Code and open your course folder: code $TARGET_DIR"

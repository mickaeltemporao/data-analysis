#!/usr/bin/env bash
# ==============================================================================
# Setup Script for Arch Linux — Data Analysis (Sciences Po Bordeaux)
# Installs VS Code, Python, uv, sets up .venv, extensions, and sane defaults.
# ==============================================================================

set -e

echo "🚀 Starting Data Analysis Arch Linux Setup..."
echo "============================================================"

# 1. Check for pacman
if ! command -v pacman &>/dev/null; then
    echo "❌ Error: pacman not found. This script is intended for Arch Linux or Arch-based distributions."
    exit 1
fi

# 2. Install Python, uv, git, and base development tools
echo "📦 Installing Python, uv, git, and base tools via pacman..."
sudo pacman -S --needed --noconfirm python python-pip uv base-devel git

# Ensure uv is in PATH for current shell
if [ -f "$HOME/.local/bin/env" ]; then
    source "$HOME/.local/bin/env"
fi

# 3. Check / Install Visual Studio Code
if command -v code &>/dev/null; then
    echo "✅ VS Code is already installed."
elif command -v visual-studio-code-bin &>/dev/null; then
    echo "✅ Visual Studio Code (AUR) is already installed."
else
    echo "💻 Installing Visual Studio Code..."
    if command -v yay &>/dev/null; then
        echo "Detected yay — installing visual-studio-code-bin from AUR..."
        yay -S --needed --noconfirm visual-studio-code-bin || sudo pacman -S --needed --noconfirm code
    elif command -v paru &>/dev/null; then
        echo "Detected paru — installing visual-studio-code-bin from AUR..."
        paru -S --needed --noconfirm visual-studio-code-bin || sudo pacman -S --needed --noconfirm code
    else
        echo "Installing code (Code - OSS) from official extra repository..."
        sudo pacman -S --needed --noconfirm code
    fi
fi

# 4. Install VS Code Extensions
if command -v code &>/dev/null; then
    echo "🧩 Installing VS Code extensions (Python, Jupyter)..."
    code --install-extension ms-python.python --force || true
    code --install-extension ms-toolsai.jupyter --force || true
else
    echo "⚠️ Note: 'code' binary not found in PATH yet. You can launch VS Code and install the Python extension manually."
fi

# 5. Set up Course Workspace Directory and .venv using uv
TARGET_DIR="$HOME/Documents/data-analysis"
if [ "$PWD" != "$HOME" ] && [ -d "$PWD/.git" -o -f "$PWD/pyproject.toml" -o -f "$PWD/mkdocs.yml" ]; then
    TARGET_DIR="$PWD"
fi

echo "📁 Setting up course workspace in $TARGET_DIR..."
mkdir -p "$TARGET_DIR"

echo "⚡ Creating Python virtual environment (.venv) using uv..."
uv venv "$TARGET_DIR/.venv"

echo "📚 Installing core data analysis packages into .venv with uv (pandas, altair, statsmodels, vl-convert-python)..."
uv pip install --python "$TARGET_DIR/.venv/bin/python" pandas altair statsmodels vega_datasets vl-convert-python

# 6. Configure Sane VS Code Defaults (Disable tutorials, disable Copilot, enable word wrap & auto-save)
echo "⚙️ Configuring beginner-friendly VS Code settings..."
python3 - << 'EOF' || true
import json
from pathlib import Path

# Paths for official VS Code, Code - OSS, and VSCodium
candidate_paths = [
    Path.home() / ".config" / "Code" / "User" / "settings.json",
    Path.home() / ".config" / "Code - OSS" / "User" / "settings.json",
    Path.home() / ".config" / "VSCodium" / "User" / "settings.json",
]

settings_to_apply = {
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
    "python.defaultInterpreterPath": "${workspaceFolder}/.venv/bin/python",
    "notebook.lineNumbers": "on",
    "notebook.output.textLineLimit": 150,
    "notebook.insertToolbarLocation": "betweenCells",
}

for settings_path in candidate_paths:
    settings_path.parent.mkdir(parents=True, exist_ok=True)
    data = {}
    if settings_path.exists():
        try:
            with open(settings_path, "r", encoding="utf-8") as f:
                data = json.load(f)
        except Exception:
            data = {}
    data.update(settings_to_apply)
    with open(settings_path, "w", encoding="utf-8") as f:
        json.dump(data, f, indent=4)
EOF

echo "============================================================"
echo "🎉 Setup complete! You are ready for Data Analysis."
echo "👉 Course workspace and .venv are ready at: $TARGET_DIR"
echo "👉 Launch VS Code and open your course folder: code $TARGET_DIR"

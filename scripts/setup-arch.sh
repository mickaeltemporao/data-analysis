#!/usr/bin/env bash
# ==============================================================================
# Setup Script for Arch Linux — Data Analysis (Sciences Po Bordeaux)
# Installs VS Code, Python, uv, sets up .env-da environment, extensions, and sane defaults.
# ==============================================================================

set -e

echo "🚀 Starting Data Analysis Arch Linux Setup..."
echo "ℹ️  (I use Arch, btw.)"
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
    echo "💻 Installing Visual Studio Code from AUR (building manually via makepkg)..."
    BUILD_DIR=$(mktemp -d)
    trap 'rm -rf "$BUILD_DIR"' EXIT
    echo "Cloning visual-studio-code-bin from AUR..."
    git clone https://aur.archlinux.org/visual-studio-code-bin.git "$BUILD_DIR/visual-studio-code-bin"
    (
        cd "$BUILD_DIR/visual-studio-code-bin"
        makepkg -si --noconfirm
    )
    rm -rf "$BUILD_DIR"
    trap - EXIT
fi

# 4. Install VS Code Extensions
if command -v code &>/dev/null; then
    echo "🧩 Installing VS Code extensions (Python, Jupyter)..."
    code --install-extension ms-python.python --force || true
    code --install-extension ms-toolsai.jupyter --force || true
else
    echo "⚠️ Note: 'code' binary not found in PATH yet. You can launch VS Code and install the Python extension manually."
fi

# 5. Set up Course Workspace Directory and .env-da environment using uv
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

echo "⚡ Configuring Python virtual environment (.env-da) using uv..."
uv venv --seed "$TARGET_DIR/.env-da" --prompt .env-da

echo "📚 Installing core packages into .env-da environment with uv (ipykernel, pandas, altair, statsmodels, vl-convert-python)..."
uv pip install --python "$TARGET_DIR/.env-da/bin/python" pip ipykernel pandas altair statsmodels vega_datasets vl-convert-python

# Clean up any leftover old 'data-analysis' directory if it exists
if [ -d "$TARGET_DIR/data-analysis" ]; then
    rm -rf "$TARGET_DIR/data-analysis"
fi

# Register ipykernel for Jupyter / VS Code Native REPL
"$TARGET_DIR/.env-da/bin/python" -m ipykernel install --user --name env-da --display-name "Python (.env-da)" &>/dev/null || true

# 6. Configure Workspace Settings (.vscode/settings.json in TARGET_DIR)
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

# 7. Configure Sane VS Code Defaults (Disable tutorials, disable Copilot, disable Restricted Mode, enable word wrap & auto-save)
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
echo "👉 Course workspace and .env-da environment are ready at: $TARGET_DIR"
echo "👉 Launch VS Code and open your course folder: code $TARGET_DIR"

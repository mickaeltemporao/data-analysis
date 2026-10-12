#!/usr/bin/env bash
# ==============================================================================
# Setup Script for Arch Linux — Data Analysis (Sciences Po Bordeaux)
# Installs VS Code, Python, uv, sets up .venv-da environment, extensions, and sane defaults.
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

# 5. Set up Course Workspace Directory and .venv-da environment using uv
TARGET_DIR="$HOME/Documents/data-analysis"
if [ "$PWD" != "$HOME" ] && [ -d "$PWD/.git" -o -f "$PWD/pyproject.toml" -o -f "$PWD/mkdocs.yml" ]; then
    TARGET_DIR="$PWD"
fi

echo "📁 Setting up course workspace in $TARGET_DIR..."
mkdir -p "$TARGET_DIR"

# Migrate old 'data-analysis' or '.env-da' environment to '.venv-da' if it exists
if [ -d "$TARGET_DIR/.env-da" ]; then
    echo "🔄 Found existing '.env-da' environment. Migrating to '.venv-da'..."
    if [ ! -d "$TARGET_DIR/.venv-da" ]; then
        mv -f "$TARGET_DIR/.env-da" "$TARGET_DIR/.venv-da"
    else
        rm -rf "$TARGET_DIR/.env-da"
    fi
elif [ -d "$TARGET_DIR/data-analysis" ]; then
    echo "🔄 Found existing 'data-analysis' environment. Migrating to '.venv-da'..."
    if [ ! -d "$TARGET_DIR/.venv-da" ]; then
        mv -f "$TARGET_DIR/data-analysis" "$TARGET_DIR/.venv-da"
    else
        rm -rf "$TARGET_DIR/data-analysis"
    fi
fi

echo "⚡ Configuring Python virtual environment (.venv-da) using uv..."
uv venv --seed "$TARGET_DIR/.venv-da" --prompt .venv-da

echo "📚 Installing core packages into .venv-da environment with uv (ipykernel, pandas, altair, statsmodels, vl-convert-python)..."
uv pip install --python "$TARGET_DIR/.venv-da/bin/python" pip ipykernel pandas altair statsmodels vega_datasets vl-convert-python || {
    echo "⚠️ uv pip install encountered an issue; falling back to standard pip..."
    "$TARGET_DIR/.venv-da/bin/python" -m pip install --upgrade pip --quiet || true
    "$TARGET_DIR/.venv-da/bin/python" -m pip install --quiet ipykernel pandas altair statsmodels vega_datasets vl-convert-python || true
}

# Clean up any leftover old 'data-analysis' or '.env-da' directory if it exists
if [ -d "$TARGET_DIR/.env-da" ]; then
    rm -rf "$TARGET_DIR/.env-da"
fi
if [ -d "$TARGET_DIR/data-analysis" ]; then
    rm -rf "$TARGET_DIR/data-analysis"
fi

# Register ipykernel for Jupyter / VS Code Native REPL
"$TARGET_DIR/.venv-da/bin/python" -m ipykernel install --user --name venv-da --display-name "Python (.venv-da)" &>/dev/null || true

# 6. Configure Workspace Settings (.vscode/settings.json in TARGET_DIR)
mkdir -p "$TARGET_DIR/.vscode"
"$TARGET_DIR/.venv-da/bin/python" - "$TARGET_DIR" << 'EOF' || true
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
    "python.defaultInterpreterPath": "${workspaceFolder}/.venv-da/bin/python",
    "python.terminal.activateEnvironment": True,
    "python.terminal.executeInFileDir": True,
    "python.REPL.sendToNativeREPL": True
})

with open(ws_settings, "w", encoding="utf-8") as f:
    json.dump(data, f, indent=4)
EOF

# 7. Configure Sane VS Code Defaults (Disable tutorials, disable Copilot, disable Restricted Mode, enable word wrap & auto-save)
echo "⚙️ Configuring beginner-friendly VS Code settings..."
"$TARGET_DIR/.venv-da/bin/python" - "$TARGET_DIR" << 'EOF' || true
import sys, json
from pathlib import Path

target_dir = Path(sys.argv[1])
folder_uri = target_dir.resolve().as_uri()

# User directories for official VS Code, Code - OSS, and VSCodium
candidate_dirs = [
    Path.home() / ".config" / "Code" / "User",
    Path.home() / ".config" / "Code - OSS" / "User",
    Path.home() / ".config" / "VSCodium" / "User",
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
    "window.restoreWindows": "all",
    "python.REPL.sendToNativeREPL": True,
    "python.terminal.activateEnvironment": True,
    "python.terminal.executeInFileDir": True,
    "python.defaultInterpreterPath": "${workspaceFolder}/.venv-da/bin/python",
    "notebook.lineNumbers": "on",
    "notebook.output.textLineLimit": 150,
    "notebook.insertToolbarLocation": "betweenCells",
}

for user_dir in candidate_dirs:
    settings_path = user_dir / "settings.json"
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
EOF

echo "============================================================"
echo "🎉 Setup complete! You are ready for Data Analysis."
echo "👉 Course workspace and .venv-da environment are ready at: $TARGET_DIR"
echo "🚀 Opening Visual Studio Code in your course workspace..."
if command -v code &>/dev/null; then
    code "$TARGET_DIR" || true
fi

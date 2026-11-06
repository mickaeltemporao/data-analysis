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
if [ -x "/opt/homebrew/bin/brew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x "/usr/local/bin/brew" ]; then
    eval "$(/usr/local/bin/brew shellenv)"
elif command -v brew &>/dev/null; then
    eval "$(brew shellenv)"
else
    echo "🍺 Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if [ -x "/opt/homebrew/bin/brew" ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [ -x "/usr/local/bin/brew" ]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
fi
echo "✅ Homebrew is ready."

# Ensure brew and code are in PATH for future terminal sessions (supports both zsh and bash shells on Intel and Apple Silicon)
for profile_file in "$HOME/.zprofile" "$HOME/.bash_profile"; do
    if [ -x "/opt/homebrew/bin/brew" ]; then
        if ! grep -qs 'brew shellenv' "$profile_file" 2>/dev/null; then
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$profile_file"
        fi
    elif [ -x "/usr/local/bin/brew" ]; then
        if ! grep -qs 'brew shellenv' "$profile_file" 2>/dev/null; then
            echo 'eval "$(/usr/local/bin/brew shellenv)"' >> "$profile_file"
        fi
    fi
    if [ -d "/Applications/Visual Studio Code.app/Contents/Resources/app/bin" ]; then
        if ! grep -qs 'Visual Studio Code.app/Contents/Resources/app/bin' "$profile_file" 2>/dev/null; then
            echo 'export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"' >> "$profile_file"
        fi
    fi
done

# 3. Install VS Code, Python, and uv via Homebrew (speed up on older Intel Macs by avoiding lengthy git auto-updates)
export HOMEBREW_NO_AUTO_UPDATE=1
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

# 6. Set up Course Workspace Directory and .venv-da environment
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
        /bin/mv -f "$TARGET_DIR/.env-da" "$TARGET_DIR/.venv-da" 2>/dev/null || mv -f "$TARGET_DIR/.env-da" "$TARGET_DIR/.venv-da"
    else
        rm -rf "$TARGET_DIR/.env-da"
    fi
elif [ -d "$TARGET_DIR/data-analysis" ]; then
    echo "🔄 Found existing 'data-analysis' environment. Migrating to '.venv-da'..."
    if [ ! -d "$TARGET_DIR/.venv-da" ]; then
        /bin/mv -f "$TARGET_DIR/data-analysis" "$TARGET_DIR/.venv-da" 2>/dev/null || mv -f "$TARGET_DIR/data-analysis" "$TARGET_DIR/.venv-da"
    else
        rm -rf "$TARGET_DIR/data-analysis"
    fi
fi

echo "⚡ Configuring Python virtual environment (.venv-da)..."
if command -v uv &>/dev/null && uv venv --seed "$TARGET_DIR/.venv-da" --prompt .venv-da; then
    echo "📚 Installing core packages into .venv-da environment (ipykernel, pandas, altair, statsmodels, vl-convert-python)..."
    uv pip install --python "$TARGET_DIR/.venv-da/bin/python" pip ipykernel pandas altair statsmodels vega_datasets vl-convert-python || {
        echo "⚠️ uv pip install encountered an issue; falling back to standard pip..."
        "$TARGET_DIR/.venv-da/bin/python" -m pip install --upgrade pip --quiet || true
        "$TARGET_DIR/.venv-da/bin/python" -m pip install --quiet ipykernel pandas altair statsmodels vega_datasets vl-convert-python || true
    }
else
    python3 -m venv --prompt .venv-da "$TARGET_DIR/.venv-da"
    echo "📚 Installing core packages into .venv-da environment (ipykernel, pandas, altair, statsmodels, vl-convert-python)..."
    "$TARGET_DIR/.venv-da/bin/python" -m pip install --upgrade pip --quiet || true
    "$TARGET_DIR/.venv-da/bin/python" -m pip install --quiet ipykernel pandas altair statsmodels vega_datasets vl-convert-python || true
fi

# Clean up any leftover old 'data-analysis' or '.env-da' directory if it exists
if [ -d "$TARGET_DIR/.env-da" ]; then
    rm -rf "$TARGET_DIR/.env-da"
fi
if [ -d "$TARGET_DIR/data-analysis" ]; then
    rm -rf "$TARGET_DIR/data-analysis"
fi

# Register ipykernel for Jupyter / VS Code Native REPL
"$TARGET_DIR/.venv-da/bin/python" -m ipykernel install --user --name venv-da --display-name "Python (.venv-da)" &>/dev/null || true

# 7. Configure Workspace Settings (.vscode/settings.json in TARGET_DIR)
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

# 8. Configure Sane VS Code Defaults (Disable tutorials, disable Copilot, disable Restricted Mode, enable word wrap & auto-save)
echo "⚙️ Configuring beginner-friendly VS Code settings..."
"$TARGET_DIR/.venv-da/bin/python" - "$TARGET_DIR" << 'EOF' || true
import sys, json, os
from pathlib import Path

target_dir = Path(sys.argv[1])
folder_uri = target_dir.resolve().as_uri()

user_dir = Path.home() / "Library" / "Application Support" / "Code" / "User"
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
    "python.defaultInterpreterPath": "${workspaceFolder}/.venv-da/bin/python",
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
EOF

echo "============================================================"
echo "🎉 Setup complete! You are ready for Data Analysis."
echo "👉 Course workspace and .venv-da environment are ready at: $TARGET_DIR"
echo "🚀 Opening Visual Studio Code in your course workspace..."
if command -v code &>/dev/null; then
    code "$TARGET_DIR" || true
elif [ -d "/Applications/Visual Studio Code.app" ]; then
    open -a "Visual Studio Code" "$TARGET_DIR" || true
fi

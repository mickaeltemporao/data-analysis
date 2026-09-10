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
echo "📚 Installing core data analysis packages (pandas, statsmodels, altair, vl-convert-python)..."
python3 -m pip install --upgrade pip --quiet || true
python3 -m pip install --quiet pandas statsmodels altair vega_datasets vl-convert-python || true

echo "============================================================"
echo "🎉 Setup complete! You are ready for Data Analysis."
echo "👉 Open VS Code, press Cmd+Shift+P, and select 'Python: Create Environment' (.venv) for your course folder."

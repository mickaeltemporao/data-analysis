# :fontawesome-regular-paper-plane: Onboarding

!!! tip inline end "Need help?"
    Don't worry if any tool is unfamiliar. We will review the setup together in the hands-on lab. If you run into issues, post a screenshot on the WhatsApp chat!

Before our second class meeting, please complete the following onboarding steps to get your computer ready for data science.

---

## 1. Join the Class WhatsApp Community

- Join via [:fontawesome-brands-whatsapp: **WhatsApp**](https://chat.whatsapp.com/Ie9P3jBaaHB2xPRJNztNRB).
- Send a short hello message in the General channel once you've joined.

---

## 2. Create a Typst Account

We will use [**Typst**](https://typst.app/) throughout the course for authoring reproducible scientific papers, milestone reports, and formatted tables.

- Sign up for a free account at [**typst.app**](https://typst.app/).
- Typst is a modern, fast, and intuitive alternative to LaTeX that lets you produce publication-quality PDFs with ease.

---

## 3. Install Your Data Science Environment (Automated Script)

We provide an automated setup script that installs **Visual Studio Code**, **Python**, the required **VS Code extensions** (Python & Jupyter Notebooks), and the core **data science packages** (`pandas` for data management, `statsmodels` for modeling, `altair` for data visualization, and `vl-convert-python` for exporting figures).

=== ":fontawesome-brands-apple: macOS"

    Open the **Terminal** app (press ++cmd+space++, type `Terminal`, and press ++enter++), then paste the following command and press ++enter++:

    ```bash
    curl -fsSL https://raw.githubusercontent.com/mickaeltemporao/data-analysis/main/scripts/setup-mac.sh | bash
    ```

    *If prompted for your Mac password, type it in (characters won't appear on screen) and press ++enter++. The script will configure Homebrew, VS Code, Python, and the Jupyter environment automatically.*

=== ":fontawesome-brands-windows: Windows"

    Open **PowerShell as Administrator** (right-click the Start Menu :fontawesome-brands-windows:, select **Terminal (Admin)** or **Windows PowerShell (Admin)**), then paste the following command and press ++enter++:

    ```powershell
    irm https://raw.githubusercontent.com/mickaeltemporao/data-analysis/main/scripts/setup-windows.ps1 | iex
    ```

    *The script will detect Winget or Chocolatey, install VS Code and Python, and configure your Jupyter notebook workflow automatically.*

=== ":fontawesome-brands-linux: Linux"

    Simply use your package manager to download and install VS Code, Python, and the required data science packages. (*I use Arch btw!* :fontawesome-brands-linux:)

    ```bash
    # Ubuntu / Debian example:
    sudo apt update && sudo apt install -y python3 python3-pip python3-venv
    pip install pandas statsmodels altair vega_datasets vl-convert-python
    code --install-extension ms-python.python
    code --install-extension ms-toolsai.jupyter
    ```

---

## 4. Managing Your Project Python Environment in VS Code

In data science, creating an **isolated virtual environment (`.venv`)** inside your project folder ensures that your libraries and code remain stable and reproducible across projects.

### Step 1: Create a Course Workspace Folder
1. Create a dedicated folder on your computer (e.g., `Documents/data-analysis`).
2. Open **Visual Studio Code**, then go to **File** > **Open Folder...** and select your `data-analysis` folder.

### Step 2: Create Your Virtual Environment
In VS Code, you can create a local environment in two clicks:

1. Open the Command Palette (++cmd+shift+p++ on macOS, ++ctrl+shift+p++ on Windows).
2. Type `Python: Create Environment...` and press ++enter++.
3. Select **Venv** (.venv), then select your installed Python interpreter.
4. VS Code will create a hidden `.venv` directory in your folder and activate it automatically for any terminal or notebook inside this workspace.

*(Alternative via Terminal)*: You can also open the integrated terminal in VS Code (++ctrl+grave++) and run:
```bash
python3 -m venv .venv
```

### Step 3: Select the Kernel for Jupyter Notebooks
Whenever you open or create a `.ipynb` notebook file in VS Code:
1. Look at the **top-right corner** of the notebook window for the kernel selector (it might say *Select Kernel*).
2. Click **Select Kernel** > **Python Environments...**
3. Choose the interpreter with **`('.venv': venv)`** next to it.
4. Your notebook is now running in your isolated project environment!

---

## 5. How to Verify Your Setup

To verify that your installation and environment are completely operational:

1. In VS Code with your `data-analysis` folder open, press ++cmd+shift+p++ (or ++ctrl+shift+p++) and select `Create: New Jupyter Notebook`.
2. Save the file as `test.ipynb`.
3. In the first code cell, paste the following test script:

```python
import pandas as pd
import statsmodels.formula.api as sm
import altair as alt
import vl_convert as vlc

print("🎉 Environment successfully configured for Data Analysis!")
```

4. Click the **Run** button :fontawesome-solid-play: next to the cell. If it displays the success message without errors, you are ready for class!


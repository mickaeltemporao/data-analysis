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

We provide an automated setup script that installs **Visual Studio Code**, **Python**, the required **VS Code extensions** (Python & Jupyter Notebooks), and the core **data science packages** (`pandas` for data management, `altair` for data visualization, `statsmodels` for modeling, and `vl-convert-python` for exporting figures).

=== ":fontawesome-brands-apple: macOS"

    1. Open the **Terminal** app:
        - Press ++cmd+space++ to open Spotlight search.
        - Type `Terminal` and press ++enter++.

    2. Copy and paste the following command into Terminal, then press ++enter++:

        ```bash
        curl -fsSL https://raw.githubusercontent.com/mickaeltemporao/data-analysis/main/scripts/setup-mac.sh | bash
        ```

    3. **Important details during installation:**
        - **Xcode Tools pop-up:** If a pop-up window appears asking to install "Command Line Developer Tools", click **Install** and wait for it to complete. Once finished, run the command above once more in Terminal.
        - **Password prompt:** When the script asks for your Mac password (`Password: 🔑`), type your computer password and press ++enter++. *Note: For security reasons, characters will not appear on screen as you type—just type your password normally and press Enter.*
        
    4. **Verify Success:**
        Run the script until you see this final confirmation message at the bottom of the Terminal:
        
        ```text
        🎉 Setup complete! You are ready for Data Analysis.
        ```
        
        > [!IMPORTANT]
        > If you do not see this final success message, re-run the command in your Terminal.

=== ":fontawesome-brands-windows: Windows"

    1. Open **PowerShell as Administrator**:
        - Right-click the Windows Start Menu button :fontawesome-brands-windows:.
        - Select **Terminal (Admin)** or **Windows PowerShell (Admin)**.
        - Click **Yes** if Windows prompts you to allow changes.

    2. Copy and paste the following command into PowerShell, then press ++enter++:

        ```powershell
        irm https://raw.githubusercontent.com/mickaeltemporao/data-analysis/main/scripts/setup-windows.ps1 | iex
        ```

    3. **Verify Success:**
        Keep the window open while it downloads and configures your environment. Run the script until you see this final confirmation message:

        ```text
        🎉 Setup complete! You are ready for Data Analysis.
        ```

        > [!IMPORTANT]
        > If you do not see this final success message, or if any download was interrupted, simply paste and run the command again.

=== ":fontawesome-brands-linux: Arch Linux"

    *(I use Arch, btw! :fontawesome-brands-linux:)*

    1. Open your **Terminal** app.
    2. Copy and paste the following command into Terminal, then press ++enter++:

        ```bash
        curl -fsSL https://raw.githubusercontent.com/mickaeltemporao/data-analysis/main/scripts/setup-arch.sh | bash
        ```

    3. **What this automated script does:**
        - Installs Python, `uv`, `git`, and base tools via `pacman`.
        - Installs Visual Studio Code (`visual-studio-code-bin` built from AUR).
        - Sets up an isolated course virtual environment (`.venv`) using **`uv`** and installs all required packages (`pandas`, `altair`, `statsmodels`, `vega_datasets`, `vl-convert-python`).
        - Installs VS Code Python extensions and applies beginner-friendly sane defaults (disables Copilot, enables Native REPL Smart Send, enables auto-save and word wrap).

    4. **Verify Success:**
        Run the script until you see this final confirmation message at the bottom of the Terminal:

        ```text
        🎉 Setup complete! You are ready for Data Analysis.
        ```

        > [!IMPORTANT]
        > If you do not see this final success message, simply paste and run the command again.

---

## 4. Set Up Your Course Workspace in VS Code

Now that your software is installed, you need to open **Visual Studio Code** and configure a dedicated workspace folder for the course.

### Step 1: Create and Open Your Course Folder in VS Code
1. If you haven't already, create a dedicated folder on your computer named `data-analysis` inside your `Documents` directory (e.g., `Documents/data-analysis`).
2. Open the **Visual Studio Code** application.
3. In the top menu of VS Code, click **File** > **Open Folder...** (on macOS, click **File** > **Open...**).
4. Navigate to your `Documents` folder, select your `data-analysis` folder, and click **Open**.
*(If VS Code displays a pop-up asking "Do you trust the authors of the files in this folder?", click **Yes, I trust the authors**).*

### Step 2: Create Your Virtual Environment (.venv)
In data science, a **virtual environment** keeps your course packages isolated and stable. To create one directly inside VS Code:

1. Open the **Command Palette** (the search bar at the very top of VS Code):
    - **macOS:** press ++cmd+shift+p++
    - **Windows:** press ++ctrl+shift+p++
2. In the search box that appears at the top of the window, type:
    ```text
    Python Create Env
    ```
3. In the dropdown list, look for the option named **`Python: Create Environment...`**, and click on it (or highlight it and press ++enter++).
4. When asked for the environment type, choose **Venv** (it will show `.venv`).
5. Select the recommended Python interpreter listed on your screen.
6. VS Code will now configure your environment in the background. A hidden `.venv` folder will be created inside your `data-analysis` workspace.

---

## 5. Verify Your Setup with an Interactive Python Script

In this course, we work directly with clean Python script files (`.py`) and an interactive line-by-line execution workflow, paired with [**Typst**](https://typst.app/) for scientific writing.

Let's test your environment to confirm that everything is working properly.

### Step 1: Open Your Course Folder in VS Code
1. Open **Visual Studio Code**.
2. Make sure your `data-analysis` folder is currently open (you should see `DATA-ANALYSIS` listed at the top of the left sidebar under *Explorer*). If not, click **File** > **Open Folder...** (or **File** > **Open...** on macOS) and select your `data-analysis` folder.

### Step 2: Create a New Python Script
1. In the top menu of VS Code, click **File** > **New File...** (or click the **New File** icon next to `DATA-ANALYSIS` in the left Explorer sidebar).
2. Type `test.py` as the filename and press ++enter++.
3. If VS Code prompts you where to save it, choose your `data-analysis` folder.

### Step 3: Paste the Test Code
Paste the following test code directly into your `test.py` editor window:

```python
import pandas as pd
import altair as alt
import statsmodels.formula.api as sm
import vl_convert as vlc

print("🎉 Environment successfully configured for Data Analysis!")
```

### Step 4: Run Your Code Line-by-Line with ++shift+enter++
In VS Code, you can execute code interactively one line at a time:

1. Click on the very first line of code (`import pandas as pd`) to place your blinking cursor there.
2. Press ++shift+enter++.
3. A **Python REPL** terminal panel will automatically pop up at the bottom of VS Code, execute the line, and advance your cursor to the next line.
4. Keep pressing ++shift+enter++ to step through each line of code (or highlight all lines with ++cmd+a++ on macOS / ++ctrl+a++ on Windows and press ++shift+enter++).

### Step 5: Confirm Success!
In the Python REPL terminal at the bottom of your screen, you should see the final confirmation message:

```text
🎉 Environment successfully configured for Data Analysis!
```

If you see this message printed in the terminal without errors, your computer is 100% ready for the course!


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

=== ":fontawesome-brands-linux: Linux"

    Simply use your package manager to download and install VS Code, Python, and the required data science packages. (*I use Arch btw!* :fontawesome-brands-linux:)

    ```bash
    # Ubuntu / Debian example:
    sudo apt update && sudo apt install -y python3 python3-pip python3-venv
    pip install pandas altair statsmodels vega_datasets vl-convert-python
    code --install-extension ms-python.python
    code --install-extension ms-toolsai.jupyter
    ```

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

## 5. Verify Your Setup with a Test Notebook

Let's test your environment to confirm that everything is working properly.

### Step 1: Open Your Course Folder in VS Code
1. Open **Visual Studio Code**.
2. Make sure your `data-analysis` folder is currently open (you should see `DATA-ANALYSIS` listed at the top of the left sidebar under *Explorer*). If not, click **File** > **Open Folder...** (or **File** > **Open...** on macOS) and select your `data-analysis` folder.

### Step 2: Create a New Jupyter Notebook
1. Open the Command Palette:
    - **macOS:** press ++cmd+shift+p++
    - **Windows:** press ++ctrl+shift+p++
2. Type into the top search bar:
    ```text
    Create Jupyter
    ```
3. In the search results, click on **`Create: New Jupyter Notebook`**.
4. A new tab named `Untitled-1.ipynb` will open on your screen.
5. Save this file:
    - **macOS:** press ++cmd+s++
    - **Windows:** press ++ctrl+s++
    - Name the file `test.ipynb` and click **Save** (make sure it is saved inside your `data-analysis` folder).

### Step 3: What is a Notebook and What is a Cell?
- **Jupyter Notebook**: An interactive document where you can write notes, run Python code, and display charts all in one place.
- **Code Cell**: Inside your new notebook, you will see a rectangular box in the main window with a small play icon (:fontawesome-solid-play:) or bracket `[ ]` on its left side. This box is called a **code cell**. It is the place where you type and run Python code.

### Step 4: Paste and Run the Test Code
1. Click directly inside the rectangular code cell (you will see a blinking text cursor).
2. Paste the following test code into the cell:

    ```python
    import pandas as pd
    import altair as alt
    import statsmodels.formula.api as sm
    import vl_convert as vlc

    print("🎉 Environment successfully configured for Data Analysis!")
    ```

3. **Run the code:**
    - Click the triangular **Play** icon (:fontawesome-solid-play:) on the left edge of the cell, **OR**
    - Click inside the cell and press ++shift+enter++.
    *(If VS Code prompts you to select a kernel or Python environment in the top right, select your `.venv` environment).*

### Step 5: Confirm Success!
Directly underneath the cell, you should see the confirmation output:

```text
🎉 Environment successfully configured for Data Analysis!
```

A green checkmark will also appear next to the cell. If you see this message without any errors, your computer is 100% ready for the course!


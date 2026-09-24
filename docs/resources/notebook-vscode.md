# 📘 Tutorial: Running Python Scripts in VS Code

Follow these simple steps to download, open, and interactively run Python scripts (`.py` files) using **Visual Studio Code (VS Code)**.

---

## What is a Python Script?

A **Python script** is a simple text file ending in `.py` containing lines of Python code. Unlike notebooks that run inside divided blocks or web browsers, a Python script allows you to write, edit, and run code line-by-line directly in VS Code's editor, sending results to an interactive terminal (**REPL**—Read-Eval-Print Loop) at the bottom of your screen.

---

## 1. Open Your Course Workspace in VS Code

1. Launch **Visual Studio Code**.
2. Open your course project folder:
    - Click **File → Open Folder...** (or press ++cmd+o++ on macOS / ++ctrl+k++ ++ctrl+o++ on Windows).
    - Select your course workspace folder (e.g., `data-analysis`).
    - Click **Open**.
3. You will see your project files listed in the **Explorer** sidebar on the left.

---

## 2. Verify Your Python Environment

Make sure VS Code is using the `data-analysis` environment set up during onboarding:

1. Open the Command Palette:
    - On macOS: Press ++cmd+shift+p++
    - On Windows: Press ++ctrl+shift+p++
2. In the top search bar, type `Python Select Interpreter` and click on **Python: Select Interpreter**.
3. In the dropdown list, click on the environment labeled **`data-analysis`** (or `.venv`).
4. **Success Check:** Look at the bottom-right status bar of VS Code. You should see `Python 3.12... ('data-analysis': venv)` displayed.

---

## 3. Download a Course Python Script

1. Open the course materials repository on GitHub:
    - [:fontawesome-solid-file-code: **Course Python Materials (`materials/src`)**](https://github.com/mickaeltemporao/materials/tree/main/src)
2. Click on the script you wish to open (for example, [`01_getting_started.py`](https://github.com/mickaeltemporao/materials/blob/main/src/01_getting_started.py) or [`02_data_types_and_structures.py`](https://github.com/mickaeltemporao/materials/blob/main/src/02_data_types_and_structures.py)).
3. Click the **Download raw file** button (the downward arrow icon at the top right of the code view).
4. Save or move the downloaded `.py` file into your course workspace folder.

---

## 4. Open and Run Code Interactively (**Smart Send**)

1. In the VS Code Explorer sidebar on the left, click on the script file (e.g., `01_getting_started.py`) to open it in the editor.
2. Place your cursor on the first line of code you want to run (or highlight multiple lines).
3. Execute the code using **Smart Send**:
    - On macOS: Press ++shift+enter++ (or ++cmd+enter++)
    - On Windows: Press ++shift+enter++ (or ++ctrl+enter++)
4. **Success Check:** 
    - An **Interactive Python Terminal** will automatically open at the bottom of your screen.
    - Your code line will appear in the terminal, followed immediately by the evaluated result or output.
    - The cursor in your editor will automatically advance to the next runnable line.

---

## 5. Working with Your Data and Variables

- **Variables stay in memory:** Once you run a line that defines a variable (like `df = pd.read_csv(...)`), that variable remains loaded in your Python session. You can inspect it anytime by typing its name in the terminal below or selecting it and pressing ++shift+enter++.
- **Saving your work:** Save your modifications anytime using:
    - On macOS: Press ++cmd+s++
    - On Windows: Press ++ctrl+s++
- **Restarting fresh:** If your code encounters an error and you want to start clean, click the trash can icon at the top-right of the terminal panel to close the terminal, then press ++shift+enter++ again on line 1 to launch a fresh session.



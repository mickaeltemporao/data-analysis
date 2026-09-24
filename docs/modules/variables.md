# From Concepts to Variables

## Agenda
- [ ] Theory
    - Presentation & Discussion
    - Dependent and Independent Variables
- [ ] Application
    - Concepts, & Variables
    - ANES Data Overview
- [ ] Code 
    - Student Group Live Demo: Typst for Scientific Writing (Group 1)
    - Environment & Configuration Check
    - First Steps in Python (`01_getting_started.py`)

## Theory

- [Warm-up :fontawesome-solid-square-poll-vertical:](https://app.wooclap.com/events/OHTNXA/)

### Presentation & Discussion
- [Dassonneville, R., & McAllister, I. (2018). Gender, political knowledge, and descriptive representation: The impact of long‐term socialization. *American Journal of Political Science*, 62(2), 249-265.](https://onlinelibrary.wiley.com/doi/full/10.1111/ajps.12353?casa_token=tlAw257HPaYAAAAA%3AS1xclhUDJ-Fp7qYb9qCVW_WRBb8lMltfTKpC8UTPSosAovXYGDF2HE75gmHNUFjF528w2K-l7pX0WVk)

### Concepts & variables, and indicators?

Political participation, ideology, partisanship, polarization, among other, are common phenomena studied in Political Science. 
There is no clear definition of each of those concepts and how they are defined will vary across researchers.

**Concepts** provide the overarching themes or ideas that guide political analysis, while **variables** are the measurable elements that allow researchers to explore and examine these concepts empirically.

The process of turning abstract concepts into measurable variables is called **operationalization**. We'll talk more about this next week!

There are two important types of variables for your research projects: 

![Variables](../images/variables-iv-dv.svg)

- The dependent variable (DV) is the effect. Its value depends on changes in the independent variable. It is also called the explained variable or the outcome variable.
- The independent variable (IV) is the cause. Its value is independent of other variables in your study. It is also know as the explanatory variable or exogenous variable(s).

### Operationalization
Operationalization means turning abstract concepts into measurable observations. Although some concepts, like age, turnout or party affiliation can more easily be measured, others, like political ideology, knowledge, or cynicism can be more difficult.

Through operationalization, you can systematically collect data on processes and phenomena that aren't directly observable.

#### Operationalization example

The concept of political ideology can't be directly measured, but it can be operationalized in many different ways. For example:

- self-rating scores on an ideological scale (e.g., from very liberal to very conservative)
- aggregating attitudes on key political issues (e.g., taxation, healthcare, immigration)
- recent votes cast for candidates from specific political parties

## Application

### Explore the relationship between concepts

1. Identify and explore the relationship between the concepts in your first Milestone.  When you have identified and slightly defined your concepts you can analyzed them in following ways:
    - Strength of relationship: degree to which two or more concepts are related.
    - Sign of relationship: are concepts positively or negatively related to each other?
    - Direction of relationship: the types of relationship that categories exhibit. *
        - "If X then Y"
        - "X implies Y"
        - "X occurs before Y"
        - "X is the primary cause of Y"
        - "X motivates Y"
        - ...

2. With regards to your identified concepts, identify potential variables that you could use in the ANES codebook.
    - [ANES Question Search](https://electionstudies.org/data-tools/anes-question-search/)
    - [About the ANES 2024](https://electionstudies.org/data-center/2024-time-series-study/)
    - [ANES 2024 Documentation](https://sda.berkeley.edu/sdaweb/docs/anes2024prelim/DOC/hcbk.htm)

## Code: Live Demo & Hands-on Lab

### :fontawesome-solid-chalkboard-user: Student Group Live Demo (Group 1)
- **Topic:** Typst for Scientific Writing (syntax, document structure, `.bib` citations, exporting PDF).
- Review the [Live Demo Guidelines & Schedule](../activities/participation.md#live-demo-schedule).

### :fontawesome-solid-screwdriver-wrench: Configuration & Environment Check
Before running code, let's verify that everyone's local programming setup works seamlessly:

1. **Verify VS Code and Environment:**
    - Open VS Code and open your course folder (`File → Open Folder...`).
    - Open the Command Palette (++cmd+shift+p++ on macOS / ++ctrl+shift+p++ on Windows).
    - Type `Python Select Interpreter` and ensure **`data-analysis`** (or `.venv`) is selected.
    - Look at the bottom-right status bar: it should display `Python 3.12... ('data-analysis': venv)`.
2. **Test Smart Send (Interactive Terminal):**
    - Create a new file named `test.py` or open [`01_getting_started.py`](https://github.com/mickaeltemporao/materials/blob/main/src/01_getting_started.py).
    - Place your cursor on the first line and run it using **Smart Send** (++shift+enter++).
    - **Success check:** An interactive Python terminal opens at the bottom of your screen and executes the code.

### Hands-on Practice: Getting Started with Python
- Follow [📘 Running Python Scripts in VS Code](../resources/notebook-vscode.md) to practice working with interactive Python scripts.
- Download and open [`01_getting_started.py`](https://github.com/mickaeltemporao/materials/blob/main/src/01_getting_started.py) from the [**course materials**](https://github.com/mickaeltemporao/materials/tree/main/src).
- Practice running code line-by-line using Smart Send (++shift+enter++).
- **Connecting Theory to Data:** Work with your group to search candidate variables in the ANES 2024 codebook that can operationalize your project's theoretical concepts.


## Get Ready for Next Session: Think. Explore. Practice.

### Think
- How are the different concepts in your project interrelated? Translate them into concrete variables (DV, IV, CV) and reflect on how existing scientific literature supports those theoretical mechanisms.
- Identify candidate survey variables from the ANES 2024 codebook to measure these concepts.
- **Suggested Reading:** [Brady, H. E., Verba, S., & Schlozman, K. L. (1995). Beyond SES: A resource model of political participation. *American Political Science Review*, 89(2), 271-294.](https://www.cambridge.org/core/journals/american-political-science-review/article/beyond-ses-aresource-model-of-political-participation/CE74BA78807755F0A09E589D631EB03E) - A foundational paper on operationalizing multi-dimensional concepts into measurable survey variables.

### Explore
- **Live Demo (Group 2):** Python & Pandas Data Structures (variables, lists, dictionaries, Series & DataFrames basics). Group 2 prepares a 10–15 min demonstration and shares the handout on WhatsApp before class (groups can [book a meeting](https://cal.com/mickaeltemporao/1-1-meeting) with the instructor to get direction).
- The class should review the [**course materials**](https://github.com/mickaeltemporao/materials/tree/main/src) ([`02_data_types_and_structures.py`](https://github.com/mickaeltemporao/materials/blob/main/src/02_data_types_and_structures.py)) and the [Pandas Data Structures Introduction](https://pandas.pydata.org/docs/user_guide/dsintro.html) to follow along and lead the peer discussion.

### Practice
- Refine your research puzzle based on instructor feedback from Milestone 1 and keep your `.bib` references organized.
- Download and run [`01_getting_started.py`](https://github.com/mickaeltemporao/materials/blob/main/src/01_getting_started.py) in VS Code to gain confidence executing Python code interactively.






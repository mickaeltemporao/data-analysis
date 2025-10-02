# From Concepts to Variables

## Agenda
- [ ] Theory
    - Presentation & Discussion
    - Dependent and Independent Variables
- [ ] Application
    - Concepts, & Variables
    - ANES Data Overview
- [ ] Code 
    - Scientific Writing - Citing 
    - Package Manager Setup & Github

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
    - [About the ANES 2024](https://electionstudies.org/data-center/2024-time-series-study/)
    - [ANES 2024 Documentation](https://sda.berkeley.edu/sdaweb/docs/anes2024prelim/DOC/hcbk.htm)

## Code

### Citing?
- [📚 Academic Citations in typst](../resources/writing.md#academic-citations-in-typst)

### Installing a Package Manager
- This will make installing software much easier!
    - **Windows**: [Chocolatey](https://chocolatey.org/install)  
    - **Mac**: [Homebrew](https://brew.sh/)  
    - **Linux**: You already have a package manager (e.g., `apt`, `dnf`, `pacman`).  
- Can you install :fontawesome-solid-laptop-code: VS Code using your package manager ?
- Can you install :fontawesome-brands-python: Python using your package manager ?

### Put your paper on GitHub
- In GitHub 
  - Create a new public or private repository.
  - Upload the pdf.
  - Add a commit changes: “My first commit, horray!”
  - Push your changes to GitHub.


## For next time

- :fontawesome-solid-brain: Start Thinking About :
    - how the different concepts of your project are interrelated, translate them into variables (DV, IV, CV) and how the scientific literature supports those relationships.
    - how to measure such concepts with survey data and which variables from ANES you can use.
- :fontawesome-solid-book: Mandatory Reading, Reading Note & Presentation
    - [Brady, H. E., Verba, S., & Schlozman, K. L. (1995). Beyond SES: A resource model of political participation. American political science review, 89(2), 271-294.](https://www.cambridge.org/core/journals/american-political-science-review/article/beyond-ses-aresource-model-of-political-participation/CE74BA78807755F0A09E589D631EB03E)
- :fontawesome-solid-house-laptop: Recommended Practice
    - :fontawesome-solid-pen-nib: Update the bibliography/references in your Milestone 1 using typst and a `.bib` file
    - [:fontawesome-solid-file-code: Getting Started with Python](https://colab.research.google.com/github/mickaeltemporao/itds/blob/main/materials/01-getting-started.ipynb)


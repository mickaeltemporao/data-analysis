# From Comparisons to Transformations

This module marks a shift from **describing data** to **actively transforming it**. You will learn how to reshape raw survey data into analytically meaningful variables using Python.

!!! tip inline end "Reminder"
    Good quantitative analysis is not just about running models, it starts with **careful decisions about how concepts become variables**.

## **Theory**

### Where We Are in the Course

- Milestone 3 & Upcoming milestones 
    - Moving beyond exploration toward transformations and modeling
- [:fontawesome-solid-file-code: Playground Notebooks](https://github.com/mickaeltemporao/materials/tree/main/notebooks) 

## **Application**
### Retrospective

In agile project management, a retrospective is a brief meeting held, at the end of an iteration (e.g. sprint), to look for ways to improve the process for the next iteration ([Beck, K., et al. 2001](http://agilemanifesto.org/)).

- [Retrospective](https://miro.com/app/board/uXjVJg_KYis=/?share_link_id=582096732525)

## **Code**

### Data Wrangling & Cleaning

!!! tip inline end
    To load and use a notebook in VS Code follow the steps 3-5 in [📘 Notebooks in VS Code](../resources/notebook-vscode.md)

#### What You’ll Practice
Using ANES 2020 data, you will learn how to:

- Recode categorical survey variables
- Create new variables from existing ones
- Handle missing values explicitly
- Prepare data for statistical modeling and visualization

#### Notebooks
- Download and open **Notebooks 5 & 6** in VS Code:
    - Get the [:fontawesome-solid-file-code: **Notebooks**](https://github.com/mickaeltemporao/materials/tree/main/notebooks) from the GitHub repository

## **Get Ready for Next Session: Think. Explore. Practice.**

:fontawesome-solid-brain: **Thinking Ahead**

- Inspect how negative codes (-9: Refused, -8: Don't Know, -1: Inapplicable) are encoded in your variables. Why would running summary statistics or regressions without converting these to `NaN` fundamentally bias your results?
- Which categorical variables need to be recoded into binary indicator dummies (0/1) or multi-item additive scales?

:fontawesome-solid-chalkboard-user: **Live Demo Spotlight: Survey Data Recoding & Variable Creation**

- 🎤 **Group 1 on Deck:** Prepare a 10–15 min demonstration showing how to replace survey missing values (`-9`/`-8`) with `np.nan`, apply conditional masks (`np.where`), and construct binary/indicator variables. Distribute your handout on WhatsApp before class.
- 👥 **Class Preparation:** Skim the [Pandas Working with Missing Data Guide](https://pandas.pydata.org/docs/user_guide/missing_data.html). Cleaning survey codes is mandatory for Milestone 4, and your group will provide feedback using *"I like, I wish, I wonder"*.

:fontawesome-solid-book-open-reader: **Suggested Reading**

- [Allamong, M. B. (2024). Political alienation and the Trump vote in the 2016 and 2020 US presidential elections. *Public Opinion Quarterly*, 88(1), 1-21.](https://academic.oup.com/poq/article/88/1/1/7636367)
    - *Why read it:* Demonstrates how survey items measuring complex psychological attitudes are operationalized and recoded across multiple presidential election cycles.

:fontawesome-solid-house-laptop: **Practice & Deadlines**

- :fontawesome-solid-laptop-code: Practice recoding your project's DV and IV using [:fontawesome-solid-file-code: Notebooks #05 & #06](https://github.com/mickaeltemporao/materials/tree/main/notebooks).
- :fontawesome-solid-calendar-check: *Looking Ahead:* [Milestone 4 - Analysis](../activities/milestone-4.md) will be due in Session 9 (Feb 05 at 08:00).


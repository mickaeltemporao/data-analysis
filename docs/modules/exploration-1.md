# From Data to Insights

## **Theory**
### Suggested Conceptual Reading & Discussion

- [Mason, L. (2018). Ideologues without issues: The polarizing consequences of ideological identities. *Public Opinion Quarterly*, 82(S1), 866-887.](https://academic.oup.com/poq/article/82/S1/866/4951269?login=true)


## **Code: Live Demo & Hands-on Lab**

### :fontawesome-solid-chalkboard-user: Student Group Live Demo (Group 3)
- **Topic:** Data Acquisition & Column Inspection (reading ANES data, `.shape`, `.info()`, `.describe()`, column subsetting).
- Review the [Live Demo Guidelines & Schedule](../activities/participation.md#live-demo-schedule).

### The Data Science Pipeline
![Variables](../images/ds-pipeline.svg)



## **Application**
!!! tip inline end
    To run Python scripts in VS Code, follow [📘 Running Python Scripts in VS Code](../resources/notebook-vscode.md).
### Working with Data

- Let's open and run [`04_data_exploration_columns.py`](https://github.com/mickaeltemporao/materials/blob/main/src/04_data_exploration_columns.py) in VS Code:
    - [:fontawesome-solid-file-code: **Course Materials**](https://github.com/mickaeltemporao/materials/tree/main/src)
- Practice reading data files with pandas, inspecting dataset structure (`.shape`, `.info()`, `.columns`), calculating summary statistics (`.describe()`), and selecting columns.


## Get Ready for Next Session: Think. Explore. Practice.

### Think
- What are the empirical distributions of your key variables? Think about what a histogram or bar chart of your DV and IV should look like, and watch out for non-substantive response categories (e.g., "Don't know" or refused).
- How will you filter your survey sample to ensure your empirical analysis focuses on the relevant target population?
- **Suggested Reading:** [Barber, M., & Pope, J. C. (2019). Does Party Trump Ideology? Disentangling Party and Ideology in America. *American Political Science Review*, 113(1), 38–54.](https://www.cambridge.org/core/journals/american-political-science-review/article/does-party-trump-ideology-disentangling-party-and-ideology-in-america/B5BAD0AE947BD3CF18D51D399263C8D3) - An outstanding example of using survey data and clean graphical displays to disentangle competing political identities.

### Explore
- **Live Demo (Group 4):** Filtering Survey Rows & Univariate Charts (boolean masks, `.value_counts()`, distributions with Altair). Group 4 prepares a 10–15 min demonstration and shares the handout on WhatsApp before class (groups can [book a meeting](https://cal.com/mickaeltemporao/1-1-meeting) with the instructor to get direction).
- The class should review the [**course materials**](https://github.com/mickaeltemporao/materials/tree/main/src) ([`05_data_exploration_rows.py`](https://github.com/mickaeltemporao/materials/blob/main/src/05_data_exploration_rows.py)) and the [Altair Simple Charts Documentation](https://altair-viz.github.io/gallery/index.html#simple-charts) to follow along and lead the peer discussion.

### Practice
- In your group project folder, create an exploratory Python script (`exploration.py`) to inspect your DV and IV using [`04_data_exploration_columns.py`](https://github.com/mickaeltemporao/materials/blob/main/src/04_data_exploration_columns.py).
- *Looking Ahead:* Milestone 3 - Exploration will be due in Session 6 (Nov 20 at 23:59).




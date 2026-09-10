# From Cleaned Data to Hypotheses

This module bridges the gap between transformed survey data and empirical hypothesis testing. Using grouped comparisons and cross-tabulations, we examine whether observed differences between groups are substantively meaningful.

## **Theory**

### Suggested Conceptual Reading & Discussion

- [Chetty, R., Jackson, M. O., Kuchler, T., Stroebel, J., Hendren, N., Fluegge, R. B., ... & Wernerfelt, N. (2022). Social capital I: measurement and associations with economic mobility. *Nature*, 608(7921), 108-121.](https://www.nature.com/articles/s41586-022-04996-4.pdf)

## **Code: Live Demo & Hands-on Lab**

### :fontawesome-solid-chalkboard-user: Student Group Live Demo (Group 2)
- **Topic:** Subgroup Analysis & Cross-Tabulations (`groupby()`, comparing group means, `pd.crosstab(..., normalize='index')`).
- Review the [Live Demo Guidelines & Schedule](../activities/participation.md#live-demo-schedule).

### Hands-on Practice
- Download and open [:fontawesome-solid-file-code: Notebook #06](https://github.com/mickaeltemporao/materials/tree/main/notebooks) to compute grouped means and two-way cross-tabulations on your project variables.

## **Application**

### Milestone 4 Check-in & Review
- Share initial bivariate patterns and receive peer and instructor feedback on your subgroup comparisons.

---

## Get Ready for Next Session: Think. Explore. Practice.

### Think
- How does your research hypothesis translate into a formal econometric model ($Y = \beta_0 + \beta_1 X + \epsilon$)? What is the expected sign (+ / -) of the slope coefficient $\beta_1$?
- For categorical predictors (e.g., race, religion, region), what is your reference/baseline category, and how will you interpret differences relative to that baseline?

### Explore
- **Live Demo (Group 3):** Linear Regression & Categorical Predictors. Group 3 prepares a 10–15 min demonstration and shares the handout on WhatsApp before class. The class should review the [Statsmodels Formula API Guide](https://www.statsmodels.org/stable/example_formulas.html) to follow along and lead the peer discussion.
- **Suggested Reading:** [Argyle, L. P., Busby, E. C., Fulda, N., Gubler, J. R., Rytting, C., & Wingate, D. (2023). Out of one, many: Using language models to simulate human samples. *Political Analysis*, 31(3), 337-351.](https://www.cambridge.org/core/services/aop-cambridge-core/content/view/035D7C8A55B237942FB6DBAD7CAA4E49/S1047198723000025a.pdf/out_of_one_many_using_language_models_to_simulate_human_samples.pdf) — Illustrates rigorous regression model specifications and how contemporary computational methods interface with empirical political behavior.

### Practice
- Start a modeling notebook (`modeling.ipynb`) in your group repository and fit a baseline univariate regression ($DV \sim IV$) with `smf.ols`.
- *Looking Ahead:* Milestone 5 - Modeling will be due in Session 11 (Mar 05 at 08:00).




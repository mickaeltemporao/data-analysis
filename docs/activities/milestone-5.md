# Milestone 5 - Modeling

## 🎯 Objectives

By the end of this milestone, you should be able to:

* **Specify and estimate** a linear regression model using `statsmodels`.
* **Interpret regression coefficients** in relation to your hypothesis.
* **Export regression tables and visualisations** into a research paper.


## 🧠 Tips for Success

- **Use the formula API.** Specify models using `DV ~ IV + CV_1 + CV_2` syntax.
- **Interpret with context.** Focus on what the coefficients mean for your hypothesis, not just statistical significance.
- **Compare across models.** Notice how coefficients change as you add controls.

## 🧩 The Milestone

Building on Milestone 4's exploratory analysis, you will now **test your hypotheses** using simple regression models. This milestone emphasizes moving from visualization to statistical inference.

You need to:

- Use your previous Milestone 4 (.typst file and .ipynb) as a starting point, incorporating any feedback received.

- Apply linear regression techniques learned in recent in :
    - [`07-data-modeling-insights.ipynb`](https://github.com/mickaeltemporao/materials/tree/main/notebooks)
    - [the data modeling lab](https://github.com/mickaeltemporao/data-analysis/blob/main/docs/materials/lab-modeling.ipynb)
- Estimate a sequence of nested regression models to test your hypothesis.
- Export your regression table using the `make_table()` function from `mmisc`.
- Interpret your results in relation to your theoretical expectations.

### What is expected from a **manuscript** perspective

Your Milestone 5 typst file is an updated Milestone 4 typst file that:

- **Does not exceed 4000 words** (excluding references/bibliography).
- **Integrates a regression table**: Use `make_table()` to create your regression summary table.
- **Includes a results section**: 
    - **Assesses coefficient stability**: Note how IV coefficients and the R-squared values changes across models.
    - **Connects results to hypothesis**: Explain what the coefficients reveal about your theoretical expectations (SSS).
    - **Discusses limitations**: Acknowledge potential model limitation and potential threats to causal inference (e.g., omitted variable bias, reciprocal causation, ...)
    - Revisit your DAG (optional): If you created a DAG for Milestone 2, you can use it to help you reflect on how your thinking has evolved. No need to create a new DAG unless you want to.

### What is expected from a **coding** perspective

Similarly, your Milestone 5 ipynb file is an updated Milestone 4 ipynb file that contains:

1. Model Specification
    - **Baseline model**: Estimates a simple regression with your main IV predicting the DV
    - **Control model**: Estimates a model with theoretically relevant control variables (CVs) predicting the DV but WITHOUT your main IV
    - **Full model**: Estimates a full model with CVs and your main IV predicting the DV

2. Model Comparison
    - **List of models**: Create a list of models that you will use with `make_table()` and `summary_col()`
    - **Use `summary_col()`**: Compare coefficients and estimates across models in the notebook.
    - **Export models with `make_table()`**: Generate a publication-ready table for your typst document

3. Visualization (Bonus)
    - **Use a modern visualization libraries** (e.g., Altair, seaborn, Plotly, ...)
    - **Create a plot to visualize the effects** of your final model result.
    - **Discuss/comment the figure** leverage the figure in your paper.


## 💾 Submission Guidelines

1. Export final files from both Typst and your notebook:
    - `da-milestone5-group0.typ`
    - `da-milestone5-group0.pdf`
    - `da-m5-notebook-group0.ipynb`
2. Keep file names consistent for organization.
3. Submit **three files** in the General Chat.
4. Manuscript length must not exceed **4000 words** (excluding references).

---

This milestone marks the transition from exploratory analysis to hypothesis testing, bringing you closer to your final research paper. Well, your final research paper is just going to be some minor finishing touches.


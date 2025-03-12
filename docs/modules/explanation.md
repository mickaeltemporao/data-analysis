# From Predictions to Explanations

## Agenda
- [ ] Theory
    - Presentation & Discussion
- [ ] Code 
    - Creating Quantities of Interest 
- [ ] Application
    - Exploring Affective Polarization & Political Knowledge

## Theory

- [Argyle, L. P., Busby, E. C., Fulda, N., Gubler, J. R., Rytting, C., & Wingate, D. (2023). Out of one, many: Using language models to simulate human samples. *Political Analysis*, 31(3), 337-351.](https://www.cambridge.org/core/services/aop-cambridge-core/content/view/035D7C8A55B237942FB6DBAD7CAA4E49/S1047198723000025a.pdf/out_of_one_many_using_language_models_to_simulate_human_samples.pdf)

## Code 

- [:fontawesome-solid-file-code: Introduction to Data Exploration](https://colab.research.google.com/github/mickaeltemporao/itds/blob/main/materials/04-data-exploration-columns.ipynb)

## Application

- ...

## What's Next?
- :fontawesome-solid-book: Mandatory Reading, Reading Note & Presentation
    - [Chetty, R., Jackson, M. O., Kuchler, T., Stroebel, J., Hendren, N., Fluegge, R. B., ... & Wernerfelt, N. (2022). Social capital I: measurement and associations with economic mobility. *Nature*, 608(7921), 108-121.](https://www.nature.com/articles/s41586-022-04996-4.pdf)
- :fontawesome-solid-brain: Integrate your model summary table in your final project.
- :fontawesome-solid-house-laptop: Recommended Practice



# Module 1: Creating Quantities of Interest

This module focuses on constructing variables that help us understand political behavior. We will be creating a political knowledge scale and an affective polarization variable.

## Political Knowledge Scale

The political knowledge scale is created by summing up the correct responses to several political knowledge questions.

```python
import pandas as pd
from data_cleaning import load_and_clean_data

df = load_and_clean_data()

political_knowledge_vars = [
    "political_knowledge_senate_term",
    "political_knowledge_least_spending",
    "political_knowledge_house_majority",
    "political_knowledge_senate_majority"
]

df['political_knowledge_scale'] = df[political_knowledge_vars].sum(axis=1)
```

## Affective Polarization

Affective polarization is measured by the absolute difference in feeling thermometer scores for Democrats and Republicans.

```python
import numpy as np

mask = (df['feeling_democrat'] >= 0) & (df['feeling_republican'] >= 0)
df = df[mask]

df['affective_polarization'] = np.abs(df['feeling_democrat'] - df['feeling_republican'])

```


### Module 2: Modeling & Exporting Regression Tables

This module will guide students through building a regression model and exporting the results to LaTeX for academic reporting.

**Markdown Page: `modeling_regression.md`**
```markdown
# Module 2: Modeling & Exporting Regression Tables to LaTeX

In this module, we will build a regression model to examine how political knowledge affects affective polarization. We will also learn how to export the regression results to LaTeX.

## Building the Regression Model

We will use ordinary least squares (OLS) regression to model the relationship between affective polarization and political knowledge.

```python
import statsmodels.formula.api as sm
from data_cleaning import load_and_clean_data

df = load_and_clean_data()

# Define the regression formula
formula = "affective_polarization ~ political_knowledge_scale + age + sex + education + ideology"

# Fit the regression model
model = sm.ols(formula=formula, data=df).fit()
print(model.summary())
```

## Exporting to LaTeX

We can use `statsmodels` to export our regression table to LaTeX format.

```python
from statsmodels.iolib.summary2 import summary_col

latex_output = summary_col([model]).as_latex()
print(latex_output)
```

This output can be included in your academic papers to present the regression results clearly and professionally.
```

### Module 3: Making Visualizations

This module will cover how to visualize the results of our analyses, including plotting polarization by state.

**Markdown Page: `visualizations.md`**
```markdown
# Module 3: Making Visualizations

Visualizations are powerful tools for communicating research findings. This module focuses on creating visualizations to illustrate the impact of political knowledge on affective polarization.

## Visualizing Affective Polarization

We will create density plots to visualize the distribution of affective polarization.

```python
import seaborn as sns
import matplotlib.pyplot as plt
from data_cleaning import load_and_clean_data

df = load_and_clean_data()

sns.kdeplot(
   data=df, x="affective_polarization", hue="sex",
   fill=True, common_norm=False, palette="crest",
   alpha=.5, linewidth=0,
)
plt.title('Density Plot of Affective Polarization')
plt.show()
```

## Visualizing Regression Coefficients

Plotting regression coefficients with confidence intervals helps in understanding the significance of predictors.

```python
coef_df = pd.DataFrame({
    'coef': model.params,
    'lower_ci': model.conf_int()[0],
    'upper_ci': model.conf_int()[1],
    'pval': model.pvalues
}).drop('Intercept')

plt.figure(figsize=(8, 10))
plt.errorbar(coef_df['coef'], coef_df.index, xerr=(coef_df['coef'] - coef_df['lower_ci'], coef_df['upper_ci'] - coef_df['coef']), fmt='o', color='b', elinewidth=2, capsize=4)
plt.axvline(x=0, color='grey', linestyle='--')
plt.title('Regression Coefficients with Confidence Intervals')
plt.xlabel('Coefficient')
plt.ylabel('Variables')
plt.grid(axis='x', linestyle='--', alpha=0.7)
plt.tight_layout()
plt.show()
```

These visualizations will help in interpreting the results of our analyses and in communicating findings effectively.
```

These modules will provide a comprehensive framework for students to learn about creating quantities of interest, modeling, and visualizing political behavior data using Python.

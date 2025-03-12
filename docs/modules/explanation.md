# From Predictions to Explanations

## Agenda
- [ ] Theory
    - Presentation & Discussion
- [ ] Code 
    - Modeling & Exporting Regression Tables 
- [ ] Application
    - Interpreting Regression Coefficients

## Theory

- [Argyle, L. P., Busby, E. C., Fulda, N., Gubler, J. R., Rytting, C., & Wingate, D. (2023). Out of one, many: Using language models to simulate human samples. *Political Analysis*, 31(3), 337-351.](https://www.cambridge.org/core/services/aop-cambridge-core/content/view/035D7C8A55B237942FB6DBAD7CAA4E49/S1047198723000025a.pdf/out_of_one_many_using_language_models_to_simulate_human_samples.pdf)

## Code 

We will build a regression model to examine how political knowledge affects affective polarization. We will also learn how to export the regression results to Markdown (& LaTeX).

### Building the Regression Model

We will use ordinary least squares (OLS) regression to model the relationship between affective polarization and political knowledge.

```python
import pandas as pd
import statsmodels.formula.api as sm

df = pd.read_csv("../data/clean_anes.csv")

# Define the regression formula
formula = "affective_polarization ~ political_knowledge_scale + age + sex + education + ideology"

# Fit the regression model
model = sm.ols(formula=formula, data=df).fit()
print(model.summary())
```

### Exporting to Mardown or LaTeX

We can use `statsmodels` to export our regression table to LaTeX format.

```python
from statsmodels.iolib.summary2 import summary_col

latex_output = summary_col([model]).as_latex()
print(latex_output)
```

This output can be directly included in your academic papers written in markdown to present the regression results clearly and professionally.


## Application

Let's head to Github and open our codespace (text editor)

- [GitHub :fontawesome-brands-github:](https://github.com/)

## What's Next?
- :fontawesome-solid-book: Mandatory Reading, Reading Note & Presentation
    - [Chetty, R., Jackson, M. O., Kuchler, T., Stroebel, J., Hendren, N., Fluegge, R. B., ... & Wernerfelt, N. (2022). Social capital I: measurement and associations with economic mobility. *Nature*, 608(7921), 108-121.](https://www.nature.com/articles/s41586-022-04996-4.pdf)


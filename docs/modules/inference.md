# From Models to Explanations

Today we will focus on **interpreting statistical models** and **making inferences** from your analysis. You have learned how to build regression models. Now the key question is: What do the results tell us?

Statistical inference allows us to move from describing patterns in our sample to making claims about the broader population. We use regression coefficients, confidence intervals, and hypothesis tests to answer: Can we confidently say there is a relationship between variables?

By the end of this module, you will be able to:

- Interpret regression coefficients and their uncertainty
- Understand and communicate statistical significance
- Connect empirical findings back to your theoretical hypothesis
- Visualize model results effectively


## Theory

### Reading Regression Output

When you estimate a regression model, you get three key pieces of information for each coefficient:

1. **The estimate (β)**: The expected change in Y for a one-unit change in X
2. **Standard error (SE)**: A measure of uncertainty around the estimate
3. **p-value**: The probability of observing this result if the true effect were zero

### Understanding Statistical Significance

A coefficient is statistically significant at the conventional 0.05 threshold when p < 0.05. This means there is less than a 5% probability of observing an effect this large (or larger) if the true effect were actually zero.

!!! warning
    Statistical significance does not equal practical importance. Always consider the magnitude of the effect alongside its significance.

### Confidence Intervals

Confidence intervals provide a range of plausible values for the coefficient. A 95% CI means that if we repeated this study many times, 95% of the constructed intervals would contain the true population value.

**Key insight:** When a confidence interval does not include zero, we consider the effect statistically significant.

### From Model to Explanation

!!! tip inline end 
    Always interpret your results in the context of your research question and hypothesis.

Interpreting regression results requires connecting numbers back to theory:

1. **Significance**: Is the result statistically reliable?
2. **Sign**: Is the coefficient positive or negative?
3. **Strength**: How large is the effect in practical terms?
4. **Causality**: Does this coefficient support your theoretical mechanism?


## Code


### Extracting insights

#### Notebook
- Download and open **Notebook 7 & 8** in VS Code:
    - **[:fontawesome-solid-file-code: Notebooks 7 & 8](https://github.com/mickaeltemporao/materials/tree/main/notebooks)**

### Creating Quantities of Interest

Before interpreting models, we need to construct meaningful variables. We will create a political knowledge scale and an affective polarization variable.

#### Affective Polarization

Affective polarization is measured by the absolute difference in feeling thermometer scores for Democrats and Republicans.

```python
import pandas as pd

df  # contains some data

mask = (df['feeling_democrat'] >= 0) & (df['feeling_republican'] >= 0)
df = df[mask]

df['affective_polarization'] = abs(df['feeling_democrat'] - df['feeling_republican'])
```

#### Political Knowledge Scale

The political knowledge scale is created by summing the correct responses to four political knowledge questions.

```python
import numpy as np

political_knowledge_vars = [
    "political_knowledge_senate_term",
    "political_knowledge_least_spending",
    "political_knowledge_house_majority",
    "political_knowledge_senate_majority"
]

def clean_knowledge_variable(series, correct_values):
    # Replace invalid codes with NaN
    series_cleaned = series.replace([-9, -5, -4, -1], np.nan)
    # Recode correct answers as 1, others as 0
    series_cleaned = series_cleaned.apply(lambda x: 1 if x in correct_values else 0)
    return series_cleaned

# Apply the function to clean the variable
df['political_knowledge_senate_term'] = clean_knowledge_variable(df['political_knowledge_senate_term'], [6])
df['political_knowledge_least_spending'] = clean_knowledge_variable(df['political_knowledge_least_spending'], [1])
df['political_knowledge_house_majority'] = clean_knowledge_variable(df['political_knowledge_house_majority'], [1])
df['political_knowledge_senate_majority'] = clean_knowledge_variable(df['political_knowledge_senate_majority'], [2])

df['political_knowledge_scale'] = df[political_knowledge_vars].sum(axis=1)
```

### Visualizing Model Results

Visualizations help communicate complex results more effectively than tables alone. Coefficient plots show estimates alongside their confidence intervals.

```python
import pandas as pd
import matplotlib.pyplot as plt

# Extract coefficients and confidence intervals
coef_df = pd.DataFrame({
    'coef': model.params,
    'lower_ci': model.conf_int()[0],
    'upper_ci': model.conf_int()[1],
    'pval': model.pvalues
}).drop('Intercept')

# Create coefficient plot
plt.figure(figsize=(8, 4))
plt.errorbar(
    coef_df['coef'], 
    coef_df.index, 
    xerr=(coef_df['coef'] - coef_df['lower_ci'], 
          coef_df['upper_ci'] - coef_df['coef']),
    fmt='o', color='b', elinewidth=2, capsize=4
)
plt.axvline(x=0, color='grey', linestyle='--')
plt.title('Regression Coefficients with Confidence Intervals')
plt.xlabel('Coefficient')
plt.ylabel('Variables')
plt.tight_layout()
```

**Reading the plot:**

- Points show coefficient estimates
- Bars show 95% confidence intervals
- If the interval crosses zero (the dashed line), the effect is not statistically significant

### Exporting Regression Results

To integrate regression tables into your Typst document:

```python
from mmisc.typst import make_table

# Create a list of models to compare
my_models = [model1, model2]

# Export to Typst format
make_table(my_models)

# Or save to file
make_table(my_models, as_file=True)
```

## Application

### Data Modeling Lab

Download the lab file and open it in VSCode

- [**LAB Modeling**](https://github.com/mickaeltemporao/data-analysis/blob/main/docs/materials/lab-modeling.ipynb)

Focus on *understanding how each IV (predictors) is related to the DV (outcome)*. Ask yourself:

- What does each coefficient tell me about my hypothesis?
- Is the effect statistically significant?
- What is the magnitude of the effect in practical terms?

!!! tip inline end
    To load and use a notebook in VS Code, follow steps 3 to 5 in
    [📘 Notebooks in VS Code](../resources/notebook-vscode.md)

---

## **Get Ready for Next Week: Think. Read. Practice.**

:fontawesome-solid-house-laptop: **Practice**

- :fontawesome-solid-award: **Complete** [**Milestone 5**](../activities/milestone-5.md)


# From Models to Explanations

## Agenda
- [ ] Theory
    - 
- [ ] Code 
    - Creating Quantities of Interest 
- [ ] Application
    - Exploring Affective Polarization & Political Knowledge

## Theory

...

## Code 

For this part we will focus on constructing some quantities of interest. We will be creating a political knowledge scale and an affective polarization variable.

### Affective Polarization

Affective polarization is measured by the absolute difference in feeling thermometer scores for Democrats and Republicans.

```python
import pandas as pd

df = pd.read_csv("../data/clean_anes.csv")

mask = (df['feeling_democrat'] >= 0) & (df['feeling_republican'] >= 0)
df = df[mask]

df['affective_polarization'] = abs(df['feeling_democrat'] - df['feeling_republican'])

```

### Political Knowledge Scale

The political knowledge scale is created by summing up the correct responses to four political knowledge questions.

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

## Application

### Data Modeling Lab
<a href="materials/modeling-lab.ipynb" download>Download Modeling L</a>

- Download the following modeling lab file and open it in VSCode: [lab-modeling.ipynb](https://github.com/mickaeltemporao/data-analysis/blob/main/docs/materials/lab-modeling.ipynb)

We will use contents mostly from from **[Notebook 7 & 8](https://github.com/mickaeltemporao/materials/tree/main/notebooks)**. 

!!! tip inline end
    To load and use a notebook in VS Code, follow steps 3 to 5 in
    [📘 Notebooks in VS Code](../resources/notebook-vscode.md)

Focus on *understanding how each IV (predictors) is related to the DV (outcome)*. Ask yourself:

- How does each variable help me explain the outcome (DV)?
- What is the causal mechanism behind it? 
- What is the hypothetical direction of the effect (+/-)?


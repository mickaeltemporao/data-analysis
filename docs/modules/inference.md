# From Models to Predictions

## Agenda
- [ ] Theory
    - Presentation & Discussion
- [ ] Code 
    - Creating Quantities of Interest 
- [ ] Application
    - Exploring Affective Polarization & Political Knowledge

## Theory

- [Pradel, F., Zilinsky, J., Kosmidis, S., & Theocharis, Y. (2024). Toxic speech and limited demand for content moderation on social media. *American Political Science Review*, 1-18.](https://www.cambridge.org/core/services/aop-cambridge-core/content/view/405333D7072585903E81BEF1729378F8/S000305542300134Xa.pdf/toxic-speech-and-limited-demand-for-content-moderation-on-social-media.pdf)


## Code 

For this part we will focus on constructing some quantities of interest. We will be creating a political knowledge scale and an affective polarization variable.

### Affective Polarization

Affective polarization is measured by the absolute difference in feeling thermometer scores for Democrats and Republicans.

```python
import pandas as pd

df = pd.read_csv("../data/clean_anes.csv")

mask = (df['feeling_democrat'] >= 0) & (df['feeling_republican'] >= 0)
df = df[mask]

df['affective_polarization'] = np.abs(df['feeling_democrat'] - df['feeling_republican'])

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

Let's head to Github and open our codespace (text editor)

- [GitHub :fontawesome-brands-github:](https://github.com/)

## What's Next?
- :fontawesome-solid-book: Mandatory Reading, Reading Note & Presentation
    - [Argyle, L. P., Busby, E. C., Fulda, N., Gubler, J. R., Rytting, C., & Wingate, D. (2023). Out of one, many: Using language models to simulate human samples. *Political Analysis*, 31(3), 337-351.](https://www.cambridge.org/core/services/aop-cambridge-core/content/view/035D7C8A55B237942FB6DBAD7CAA4E49/S1047198723000025a.pdf/out_of_one_many_using_language_models_to_simulate_human_samples.pdf)


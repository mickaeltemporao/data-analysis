# From Explanations to Communication

## Agenda
- [ ] Theory
    - Presentation & Discussion
- [ ] Code 
    - Improving Visualizations 
- [ ] Application
    - 

## Theory

### Presentation & Discussion

- [Chetty, R., Jackson, M. O., Kuchler, T., Stroebel, J., Hendren, N., Fluegge, R. B., ... & Wernerfelt, N. (2022). Social capital I: measurement and associations with economic mobility. *Nature*, 608(7921), 108-121.](https://www.nature.com/articles/s41586-022-04996-4.pdf)


## Code 

This module will cover how to visualize the results of our analyses, including plotting polarization by state.

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
plt.errorbar(
    coef_df['coef'], 
    coef_df.index, 
    xerr=(
        coef_df['coef'] - coef_df['lower_ci'], 
        coef_df['upper_ci'] - coef_df['coef']
    ), 
    fmt='o', 
    color='b', 
    elinewidth=2, 
    capsize=4
)
plt.axvline(x=0, color='grey', linestyle='--')
plt.title('Regression Coefficients with Confidence Intervals')
plt.xlabel('Coefficient')
plt.ylabel('Variables')
plt.grid(axis='x', linestyle='--', alpha=0.7)
plt.tight_layout()
plt.show()
```

These visualizations will help in interpreting the results of our analyses and in communicating findings effectively.


## Application

Let's head to Github and open our codespace (text editor)
- [GitHub :fontawesome-brands-github:](https://github.com/)


## For next time
- :fontawesome-solid-award: **Complete** [**Milestone 3**](https://colab.research.google.com/github/mickaeltemporao/data-analysis/blob/main/materials/assignment-3.ipynb)
- :fontawesome-solid-house-laptop: Recommended Practice
    - [:fontawesome-solid-file-code: Exploring Variable Relationships](https://colab.research.google.com/github/mickaeltemporao/itds/blob/main/materials/05-data-exploration-rows.ipynb)


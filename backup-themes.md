# Backup & Extension Live Demo Themes
# Course: Data Analysis in Political Science

This document serves as an instructor planning resource and theme repository (similar to `outline.md`). It is kept outside the `docs/` folder and is not rendered on the public website.

These themes can be deployed as substitute live demos, optional extension workshops, student presentation prompts, or hack-time lab demos.

---

## 1. Scale Construction & Composite Indices (Additive Scales)

### Methodological Rationale
In survey research, individual survey items (single questions) often suffer from measurement error. Political scientists construct composite indices (e.g., political knowledge scales, institutional trust indices, authoritarianism scales) by combining multiple related items.

### Key Python & Pandas Tools
- Handling missing data across battery items: `.replace([-9, -8, -5], pd.NA)`
- Reverse coding items: `df['item_reversed'] = max_val + min_val - df['item']`
- Summing / averaging across rows: `df[battery_items].sum(axis=1)`
- Min-Max normalization (scaling to $0–1$ or $0–100$):
  $$(X - X_{\min}) / (X_{\max} - X_{\min}) \times 100$$

### Pedagogical Code Recipe
```python
import numpy as np
import pandas as pd

# Battery of political trust questions (1 = None at all, 5 = A great deal)
trust_items = ['trust_parliament', 'trust_courts', 'trust_police', 'trust_politicians']

# 1. Recode negative survey codes
df[trust_items] = df[trust_items].replace([-9, -8, -7, -1], np.nan)

# 2. Require respondents to have answered at least 3 of the 4 items
valid_responses = df[trust_items].notna().sum(axis=1) >= 3

# 3. Create normalized 0-100 additive scale
df['trust_index'] = np.where(
    valid_responses,
    (df[trust_items].mean(axis=1) - 1) / (5 - 1) * 100,
    np.nan
)
```

**Curriculum Links:** `materials/notebooks/06-data-management-existing-values.ipynb`, `docs/modules/wrangling-2.md`, Milestone 4.

---

## 2. Visualizing Regression Results (Coefficient & Forest Plots)

### Methodological Rationale
Undergraduate students often struggle to interpret raw regression printouts and tables. Leading political science journals (APSR, AJPS, BJPolS) encourage graphical presentation of regression coefficients with 95% confidence intervals, allowing readers to immediately grasp effect sizes, direction, and uncertainty.

### Key Python & Visualization Tools
- `model.params`, `model.conf_int()`, `model.pvalues`
- Storing estimates in a clean plotting DataFrame
- Plotting with error bars (`plt.errorbar` or Altair `mark_point()` + `mark_rule()`)
- Reference null line at $x = 0$

### Pedagogical Code Recipe
```python
import matplotlib.pyplot as plt
import pandas as pd
import statsmodels.formula.api as smf

model = smf.ols("affective_polarization ~ political_knowledge + age + female + education + ideology", data=df).fit()

# Extract model estimates
coef_df = pd.DataFrame({
    'coef': model.params,
    'ci_lower': model.conf_int()[0],
    'ci_upper': model.conf_int()[1]
}).drop('Intercept')

# Clean display names for publication
coef_df.index = [
    'Political Knowledge',
    'Age (years)',
    'Female (1=Yes)',
    'College Degree',
    'Ideology (Conservative)'
]

fig, ax = plt.subplots(figsize=(7, 4.5))
y_positions = range(len(coef_df))

ax.errorbar(
    coef_df['coef'], y_positions,
    xerr=[coef_df['coef'] - coef_df['ci_lower'], coef_df['ci_upper'] - coef_df['coef']],
    fmt='o', color='#1f77b4', ecolor='#1f77b4', elinewidth=2, capsize=4
)
ax.axvline(x=0, color='grey', linestyle='--', alpha=0.7)
ax.set_yticks(y_positions)
ax.set_yticklabels(coef_df.index)
ax.set_xlabel('Estimated Regression Coefficient (95% CI)')
ax.set_title('Predictors of Affective Polarization (ANES 2020)', fontweight='bold')
ax.grid(axis='x', linestyle=':', alpha=0.6)
plt.tight_layout()
```

**Curriculum Links:** `materials/src/playground-polarization.py` (lines 188–208), `docs/modules/communication.md`.

---

## 3. Polishing Altair Plots for Academic Papers & Typst Integration

### Methodological Rationale
Exploratory charts are meant for the researcher; publication charts are meant for the reader. This theme focuses on converting raw Altair charts into polished, standalone figures with descriptive labels, custom palettes, and vector export.

### Key Python & Altair Tools
- `.properties(title=..., width=..., height=...)`
- Custom axis formatting: `alt.Axis(title=..., format=..., labelAngle=0)`
- Discrete color schemes: `alt.Scale(domain=..., range=...)`
- Chart configuration: `.configure_view()`, `.configure_axis()`
- Vector export to SVG/PNG using `vl-convert-python`: `chart.save("figure1.svg")`

### Pedagogical Code Recipe
```python
import altair as alt

chart = alt.Chart(df.dropna(subset=['party_id', 'affective_polarization'])).mark_boxplot(
    size=35, extent='min-max'
).encode(
    x=alt.X('party_id:N', title='Party Identification', axis=alt.Axis(labelAngle=0)),
    y=alt.Y('affective_polarization:Q', title='Affective Polarization Score (0–100)'),
    color=alt.Color('party_id:N', scale=alt.Scale(
        domain=['Democrat', 'Independent', 'Republican'],
        range=['#2E5B88', '#7F7F7F', '#D9381E']
    ), legend=None)
).properties(
    title=alt.TitleParams(
        text='Affective Polarization by Partisan Attachment',
        subtitle='Source: American National Election Studies (ANES 2020)',
        anchor='start',
        fontSize=14,
        subtitleFontSize=11,
        subtitleColor='gray'
    ),
    width=420,
    height=280
).configure_view(strokeWidth=0)

# Export for Typst
chart.save("figures/figure1.svg")
```

**Curriculum Links:** `materials/notebooks/08-visualization-insights.ipynb`, Milestone 3, Milestone 4.

---

## 4. Reading ANES Codebooks, Skip Logic & Survey Sampling Weights

### Methodological Rationale
Survey respondents are rarely a pure simple random sample of the general population. In public opinion research, understanding sampling weights (e.g., post-stratification survey weights `V200010b`) is essential to prevent over-representing specific demographics.

### Key Python & Statistical Tools
- Reading codebook documentation (skip patterns, filter questions, interview mode)
- Comparing unweighted means vs. survey-weighted means
- Using `numpy.average(..., weights=...)` for descriptive statistics
- Estimating weighted least squares via `statsmodels.formula.api.wls`

### Pedagogical Code Recipe
```python
import numpy as np
import statsmodels.formula.api as smf

# Unweighted mean of political interest
unweighted_mean = df['political_interest'].mean()

# Survey-weighted mean using ANES post-stratification weight (e.g. V200010b)
weights = df['weight_post']
weighted_mean = np.average(df['political_interest'].dropna(), weights=weights.loc[df['political_interest'].dropna().index])

print(f"Unweighted Mean: {unweighted_mean:.2f} vs. Weighted Mean: {weighted_mean:.2f}")

# Weighted Regression
weighted_model = smf.wls(
    "affective_polarization ~ political_knowledge + age + education",
    data=df,
    weights=df['weight_post']
).fit()
```

**Curriculum Links:** `materials/data/raw/ESS10 codebook.html`, ANES 2020/2024 codebooks.

---

## 5. Substantive Effects & Marginal Predictions from Regression

### Methodological Rationale
A regression slope of $\beta = 0.042$ ($p < 0.01$) is mathematically significant, but what does it actually mean for a voter? Translating model coefficients into predicted values across a realistic range of an explanatory variable makes empirical findings intuitive and convincing.

### Key Python & Modeling Tools
- Generating synthetic counterfactual data (`pd.DataFrame`)
- Holding controls constant at their sample mean or reference modal category
- Generating model predictions: `model.predict(counterfactual_df)`
- Plotting prediction lines with uncertainty bands

### Pedagogical Code Recipe
```python
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import statsmodels.formula.api as smf

model = smf.ols("affective_polarization ~ political_knowledge + age + female", data=df).fit()

# Create counterfactual grid: vary political knowledge across its full range (0 to 10)
# while holding age at mean and female at 1 (women)
knowledge_grid = np.linspace(0, 10, 50)
counterfactual = pd.DataFrame({
    'political_knowledge': knowledge_grid,
    'age': df['age'].mean(),
    'female': 1
})

# Predict expected polarization
counterfactual['predicted_polarization'] = model.predict(counterfactual)

plt.figure(figsize=(7, 4))
plt.plot(counterfactual['political_knowledge'], counterfactual['predicted_polarization'], color='darkred', lw=2)
plt.title('Predicted Affective Polarization by Political Knowledge Level', fontweight='bold')
plt.xlabel('Political Knowledge Score (0–10)')
plt.ylabel('Expected Affective Polarization')
plt.grid(True, linestyle=':', alpha=0.6)
plt.tight_layout()
```

**Curriculum Links:** `materials/src/playground-polarization.py` (lines 210–224), `docs/modules/inference.md`.

---

## 6. Testing Interaction Effects in OLS (Moderation Analysis)

### Methodological Rationale
Political science hypotheses are often conditional: *"The effect of political knowledge on affective polarization is stronger among strong partisans than among independents."* Specifying and interpreting multiplicative interaction terms is a signature skill in quantitative political research.

### Key Python & Formula Tools
- Formula notation: `"DV ~ IV * Moderator + Controls"`
- Interpreting constitutive terms vs. interaction coefficients
- Avoiding common misinterpretations of the main effect when an interaction is present

### Pedagogical Code Recipe
```python
import statsmodels.formula.api as smf

# Formula with interaction term: knowledge * strong_partisan
formula = "affective_polarization ~ political_knowledge * strong_partisan + age + education"
interaction_model = smf.ols(formula=formula, data=df).fit()

print(interaction_model.summary().tables[1])
# Key parameter: political_knowledge:strong_partisan (tests whether slopes differ significantly)
```

**Curriculum Links:** `materials/notebooks/lab-modeling.ipynb`, `docs/modules/modeling.md`.

---

## 7. Contextual / Multi-Level Data Merging

### Methodological Rationale
Individual survey attitudes are deeply influenced by institutional and geographic context (e.g., living in a battleground state vs. a non-competitive state, or district unemployment rate). Political scientists frequently merge individual survey data with state- or district-level datasets.

### Key Python & Pandas Tools
- `pd.merge(left_df, right_df, on='state_fips', how='left')`
- Checking merge success with `indicator=True`
- Handling missing matches and validating row count preservation

### Pedagogical Code Recipe
```python
import pandas as pd

# Ingest survey respondents with state codes
survey_df = ...  # has 'state_id'

# Ingest state-level institutional dataset
state_context = pd.DataFrame({
    'state_id': ['PA', 'MI', 'WI', 'FL', 'CA', 'TX'],
    'battleground_state': [1, 1, 1, 0, 0, 0],
    'unemployment_rate': [4.1, 4.3, 3.8, 3.2, 5.1, 4.0]
})

# Left join to preserve all survey respondents
merged_df = survey_df.merge(state_context, on='state_id', how='left', indicator=True)
print(merged_df['_merge'].value_counts())
```

**Curriculum Links:** `docs/modules/communication.md` (geospatial mapping).

---

## 8. Automated Typst Regression Tables with `make_table`

### Methodological Rationale
Students must present models with controls side by side (e.g., Baseline $\rightarrow$ Demographic Controls $\rightarrow$ Attitudinal Controls) in their final research project to evaluate coefficient stability. Copy-pasting numbers from Python into a report introduces human error and breaks reproducibility. Exporting directly to Typst tables ensures professional presentation.

### Key Python & Typst Tools
- `statsmodels.iolib.summary2.summary_col`
- Formatting stars ($^*p<0.05, ^{**}p<0.01, ^{***}p<0.001$)
- Generating native Typst `#table(...)` code via helper scripts or `mmisc.typst.make_table`

### Pedagogical Code Recipe
```python
import statsmodels.formula.api as smf
from statsmodels.iolib.summary2 import summary_col

# Estimate 3 models with progressive controls
m1 = smf.ols("affective_polarization ~ political_knowledge", data=df).fit()
m2 = smf.ols("affective_polarization ~ political_knowledge + age + female", data=df).fit()
m3 = smf.ols("affective_polarization ~ political_knowledge + age + female + ideology", data=df).fit()

# Collate models into a comparative summary
table = summary_col(
    [m1, m2, m3],
    model_names=['Model 1 (Bivariate)', 'Model 2 (Demographics)', 'Model 3 (Full)'],
    stars=True,
    float_format='%0.3f',
    info_dict={'N': lambda x: f"{int(x.nobs)}", 'R2': lambda x: f"{x.rsquared:.3f}"}
)

print(table)
```

**Curriculum Links:** `docs/modules/inference.md`, `docs/modules/communication.md`, Milestone 5, Research Paper.

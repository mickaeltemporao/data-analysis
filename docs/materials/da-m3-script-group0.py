"""
Milestone 3 – Data Exploration Script Template
Data Analysis | Sciences Po Bordeaux

This script helps your group create the two required figures for Milestone 3:
1. One figure visualizing your Dependent Variable (DV) distribution.
2. One figure visualizing your Main Independent Variable (IV) distribution.

Instructions:
- Run code interactively in VS Code using Smart Send (Shift+Enter).
- Adapt the example code below with your project's chosen ANES 2024 variables.
- Export your figures as PNG or SVG and insert them into your Typst manuscript.
"""

# -----------------------------------------------------------------------------
# 1. Load Libraries
# -----------------------------------------------------------------------------
import pandas as pd
import altair as alt

# -----------------------------------------------------------------------------
# 2. Load the ANES 2024 Dataset
# -----------------------------------------------------------------------------
data_url = "https://raw.githubusercontent.com/datamisc/ts-2024/main/data.csv"
df = pd.read_csv(data_url, compression="gzip")

# Inspect the dataset dimensions and columns
df.shape
df.head()

# -----------------------------------------------------------------------------
# 3. Dependent Variable (DV) Exploration
# -----------------------------------------------------------------------------
# Replace 'V241043' with your project's dependent variable name from ANES 2024
dv_name = "V241043"

# Inspect unique values and distribution
df[dv_name].value_counts(dropna=False)

# Example visualization: Nominal / Categorical Bar Chart using Altair
dv_chart = (
    alt.Chart(df)
    .mark_bar(color="#3b82f6")
    .encode(
        x=alt.X(dv_name, type="nominal", title="Party Identification (DV)"),
        y=alt.Y("count()", type="quantitative", title="Number of Respondents"),
    )
    .properties(
        title="Distribution of Dependent Variable",
        width=500,
        height=300
    )
)

# Display chart
dv_chart

# To save the figure for Typst:
# dv_chart.save("dv_distribution.png")

# -----------------------------------------------------------------------------
# 4. Main Independent Variable (IV) Exploration
# -----------------------------------------------------------------------------
# Replace 'V241177' with your project's independent variable name from ANES 2024
iv_name = "V241177"

# Inspect unique values and distribution
df[iv_name].value_counts(dropna=False).sort_index()

# Example visualization: Ordinal / Scale Bar Chart using Altair
iv_chart = (
    alt.Chart(df)
    .mark_bar(color="#ef4444")
    .encode(
        x=alt.X(iv_name, type="ordinal", title="Ideology 7-Point Scale (IV)"),
        y=alt.Y("count()", type="quantitative", title="Number of Respondents"),
    )
    .properties(
        title="Distribution of Independent Variable",
        width=500,
        height=300
    )
)

# Display chart
iv_chart

# To save the figure for Typst:
# iv_chart.save("iv_distribution.png")

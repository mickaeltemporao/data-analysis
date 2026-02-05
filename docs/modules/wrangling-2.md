# From Transformations to Cleaned Data

This module focuses on the crucial step of transforming raw survey responses into clean, analytically meaningful variables. You will learn systematic approaches to data management that prepare your dataset for rigorous analysis.

!!! tip inline end "Clean Data?"
    Well, if you ever see clean data... run away.

## **Theory**

### Where We Are in the Course

- Preparing for **Milestone 4: Analysis**
    - Moving from basic exploration to more sophisticated variable transformation
- **Data cleaning principles** vs. **data wrangling techniques**
    - Understanding when to filter vs. when to recode
    - Preserving data while improving analytical quality

### Key Concepts in Data Transformation

1. **Recoding vs. Filtering**
    - **Filtering**: Removes observations from analysis
    - **Recoding**: Transforms values while preserving cases
    - **Trade-offs**: Data preservation vs. analytical clarity

2. **Variable Creation Strategies**
    - **Binary variables**: From categorical responses
    - **Categorical bins**: From continuous measurements
    - **Composite scales**: Combining related items

## **Application**

### In-Class Exercise

Working together on data transformation challenges using ANES 2020 data. We'll explore systematic approaches to:

- Handle missing and invalid responses appropriately
- Create analytically useful variables from raw survey items
- Document transformation decisions for research transparency

### Workshop Session

Interactive coding session where we apply transformation techniques to prepare data for hypothesis testing.

## **Code**

### Data Management & Variable Creation

!!! tip inline end
    To load and use a notebook in VS Code follow the steps 3-5 in [📘 Notebooks in VS Code](../resources/notebook-vscode.md)

#### What You'll Practice
Using ANES 2020 data, you will master:

- **Recoding variables** using both mask-based and dictionary methods
- **Creating new variables** through binary transformations
- **Binning continuous data** using `pd.cut()` for categorical analysis
- **Comparing filtering vs. recoding approaches**
- **Preparing cleaned datasets** for analysis

#### Key Techniques Covered

**1. Mask-Based Recoding**
```python
# Create masks for specific values
mask = df['variable'] == target_value
df.loc[mask, 'variable'] = new_value
```

**2. List-Based Replacement**
```python
# Using lists as a recoding tool
old_labels = [1, 2, 3]
new_labels = ["Low", "Medium", "High"]
df['variable'] = df['variable'].replace(old_labels, new_labels)
```

**3. Variable Creation**
```python
# Binary variables
df['binary_var'] = (df['categorical_var'] == target_value).astype(int)

# Categorical bins
df['age_groups'] = pd.cut(df['age'], bins=[0, 35, 50, 65, 100], 
                         labels=["Young", "Middle-aged", "Senior", "Elder"])
```

**4. Additive Scale Creation**
```python
# Combine related survey items into an additive scale
scale_items = ['V242417', 'V242418', 'V242419']  # trust-related items

df[scale_items] = df[scale_items].replace([-9, -8, -7, -6, -5], pd.NA)  # recode missing
df[scale_items] = 5 - df[scale_items]  # Reverse values so higher = more trust
df['trust_scale'] = df[scale_items].sum(axis=1)/12  # create new scale variable

```

Additive scales combine multiple related survey items into a single measure by summing responses across rows.

---

**Remember**: The goal is not just to transform data, but to do so **systematically and transparently**. Every recoding decision should be defensible and documented.

#### Notebook
- Download and open **Notebook 6** in VS Code:
    - [:fontawesome-solid-file-code: **06-data-management-existing-values.ipynb**](https://github.com/mickaeltemporao/materials/tree/main/notebooks)

#### Practice Problems

1. **Vote Intention Transformation**
    - Clean the voting intention variable
    - Create binary variables for major candidates
    - Compare filtering vs. recoding approaches

2. **Feeling Thermometer Analysis**
    - Recode COVID approval responses
    - Create age categorical variables
    - Generate cross-tabulations for analysis

3. **Data Quality Assessment**
    - Compare filtered vs. recoded datasets
    - Assess impact on analytical conclusions
    - Document transformation decisions

## **Get Ready for Next Week: Think. Read. Practice.**

<!-- :fontawesome-solid-brain: **Thinking Ahead** -->
<!---->
<!-- - Begin thinking about **Milestone 4 requirements** -->
<!--     - How do transformation choices affect your hypothesis? -->
<!--     - What academic literature supports your data preparation decisions? -->
<!---->
<!-- :fontawesome-solid-book: **Optional Reading** -->


:fontawesome-solid-house-laptop: **Practice**

<!-- - Start applying transformation techniques to your own research data -->
<!-- - Prepare variable cleaning documentation for **Milestone 4** -->
- :fontawesome-solid-award: **Complete** [**Milestone 4**](../activities/milestone-2.md)


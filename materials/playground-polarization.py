# Load Pandas
import pandas as pd
import statsmodels.api as sm
import matplotlib.pyplot as plt
import seaborn as sns

### Step 1: Load, select & rename Variables
data_url = "https://raw.githubusercontent.com/datamisc/ts-2020/main/data.csv"
anes_data  = pd.read_csv(data_url, compression='gzip')

my_vars = [
    "V201033",  # vote-int 
    "V201507x",  # age
    "V201600",  # sex
    "V201511x",  # educ
    "V201617x",  # income
    "V201231x",  # party-id
    "V201200",  # ideology
    "V201156",  # PRE: Feeling Thermometer: Democratic Party
    "V201157",  # PRE: Feeling Thermometer: Republican Party
    "V201641",  # PRE: Political knowledge intro
    "V201642",  # PRE: Political knowledge catch question
    "V201643",  # PRE: Political knowledge catch question feedback
    "V201644",  # PRE: How many years in full term for US Senator
    "V201645",  # PRE: On which program does Federal government spend the least
    "V201646",  # PRE: Party with most members in House before election
    "V201647",  # PRE: Party with most members in Senate before election
    "V202406",  # POST: CSES5-Q01: How interested in politics is R
    "V202407",  # POST: CSES5-Q02: How closely does R follow politics in media
    "V202408",  # POST: CSES5-Q03: Agree/disagree: R understands most important political issues
]

df = anes_data[my_vars]
var_names = {
    "V201033": "vote_intention",
    "V201507x": "age",
    "V201600": "sex",
    "V201511x": "education",
    "V201617x": "income",
    "V201231x": "party_id",
    "V201200": "ideology",
    "V201156": "feeling_democrat",
    "V201157": "feeling_republican",
    "V201641": "political_knowledge_intro",
    "V201642": "political_knowledge_catch1",
    "V201643": "political_knowledge_catch_feedback",
    "V201644": "political_knowledge_senate_term",
    "V201645": "political_knowledge_least_spending",
    "V201646": "political_knowledge_house_majority",
    "V201647": "political_knowledge_senate_majority",
    "V202406": "interest_in_politics",
    "V202407": "follow_politics_media",
    "V202408": "understand_issues"
}

# Rename variables to make them more descriptive
df = df.rename(columns=var_names)


### Step 2: Clean & Create Relevant Variables
# We will create a political knowledge scale by summing the correct answers to the political knowledge questions.

# Define a function to clean and recode political knowledge responses
def clean_knowledge_variable(series, correct_values):
    # Replace invalid codes with NaN
    series_cleaned = series.replace([-9, -5, -4, -1], np.nan)
    # Recode correct answers as 1, others as 0
    series_cleaned = series_cleaned.apply(lambda x: 1 if x in correct_values else 0)
    return series_cleaned
#

df['political_knowledge_senate_term'] = clean_knowledge_variable(df['political_knowledge_senate_term'], [6])
df['political_knowledge_least_spending'] = clean_knowledge_variable(df['political_knowledge_least_spending'], [1])
df['political_knowledge_house_majority'] = clean_knowledge_variable(df['political_knowledge_house_majority'], [1])
df['political_knowledge_senate_majority'] = clean_knowledge_variable(df['political_knowledge_senate_majority'], [2])

# Apply an Awareness filter
df = df[df["political_knowledge_catch1"].between(1000,2000)]

# Creating a political knowledge scale
political_knowledge_vars = [
    "political_knowledge_senate_term",
    "political_knowledge_least_spending",
    "political_knowledge_house_majority",
    "political_knowledge_senate_majority"
]

df['political_knowledge_scale'] = df[political_knowledge_vars].sum(axis=1)


# Keep major parties
df = df[df['vote_intention'].between(1,2)]


### Step 3: Build Affective Polarization Variable
# Calculate the affective polarization based on feeling thermometer scores.
mask = df['feeling_democrat'] >= 0 
df = df[mask]

mask = df['feeling_republican'] >= 0 
df = df[mask]

df['affective_polarization'] = np.abs(df['feeling_democrat'] - df['feeling_republican'])


## Check DV
sns.kdeplot(
   data=df, x="affective_polarization", hue="political_knowledge_scale",
   fill=True, common_norm=False, palette="crest",
   alpha=.5, linewidth=0,
)


## Check IV

### Step 4: Construct the Regression Model
# Use the cleaned data to build a regression model. We will include control variables such as age, sex, education, income, and ideology.

# Define the independent variables (including control variables)
X = df[['political_knowledge_scale', 'age', 'sex', 'education', 'ideology']]
# Add a constant to the model (intercept)
X = sm.add_constant(X)
# Define the dependent variable
y = df['affective_polarization']
# Fit the regression model
model = sm.OLS(y, X).fit()
# Print the summary of the regression model
print(model.summary())

### Step 5: Visualize Results
# Create a visualization to summarize the results of the regression model.

# Plot the coefficients
coef_df = pd.DataFrame({
    'coef': model.params,
    'pval': model.pvalues
})

coef_df = coef_df.drop('const')

# Plot Reg 1
plt.figure(figsize=(10, 6))
sns.barplot(x=coef_df.index, y='coef', data=coef_df, palette='viridis')
# Annotate p-values
for i, row in coef_df.iterrows():
    plt.text(i, row['coef'], f'p={row["pval"]:.2f}', ha='center', va='bottom')
plt.title('Regression Coefficients for Affective Polarization')
plt.ylabel('Coefficient')
plt.xlabel('Variables')
plt.xticks(rotation=45, ha='right')
plt.tight_layout()

# Plot Reg 2
plt.figure(figsize=(10, 6))
# Create the lollipop chart
plt.stem(coef_df.index, coef_df['coef'], linefmt='-', markerfmt='o', basefmt=' ')
# Annotate p-values
for i, row in coef_df.iterrows():
    plt.text(i, row['coef'], f'p={row["pval"]:.2f}', ha='center', va='bottom')
# Customize the plot
plt.title('Regression Coefficients for Affective Polarization')
plt.ylabel('Coefficient')
plt.xlabel('Variables')
plt.xticks(ticks=range(len(coef_df)), labels=coef_df.index, rotation=45, ha='right')
plt.grid(axis='y', linestyle='--', alpha=0.7)
plt.tight_layout()

# Plot 2
plt.figure(figsize=(10, 6))
sns.lineplot(data=df, x='political_knowledge_scale', y='affective_polarization', marker='o')
# Customize the plot
plt.title('Effect of Political Knowledge Levels on Affective Polarization')
plt.xlabel('Political Knowledge Scale')
plt.ylabel('Average Affective Polarization')
plt.xticks(knowledge_polarization['political_knowledge_scale'])  # Ensure all knowledge levels are shown
plt.grid(True)
plt.tight_layout()


When dealing with discrete variables or a limited number of distinct values, as is the case with the political knowledge scale, traditional scatter plots with regression lines might not be the most effective. Here are a couple of alternative visualization strategies that can provide a clearer picture of the relationship:

### 1. Box Plot with Overlayed Regression Line
A box plot can be used to show the distribution of affective polarization at each level of political knowledge. Overlaying the regression line on top of this can help visualize the trend.


### 2. Violin Plot

A violin plot is similar to a box plot but provides a deeper insight into the distribution by showing the kernel density estimation. This can help visualize the spread of the data and the central tendency.

plt.figure(figsize=(10, 6))
# Create the violin plot
sns.violinplot(
    x='political_knowledge_scale', 
    y='affective_polarization', 
    data=df, 
    inner='quartile', 
    palette='viridis'
)

# Overlay the regression line
sns.lineplot(
    x='political_knowledge_scale', 
    y='affective_polarization', 
    data=df, 
    marker='o', 
    color='red', 
    label='Mean Trend'
)

# Customize the plot
plt.title('Effect of Political Knowledge on Affective Polarization')
plt.xlabel('Political Knowledge Scale')
plt.ylabel('Affective Polarization')
plt.legend()
plt.grid(True)
plt.tight_layout()



import matplotlib.pyplot as plt
# Extracting coefficients and confidence intervals
coef = model.params
conf_int = model.conf_int()
p_values = model.pvalues
# Create a DataFrame for easy plotting
coef_df = pd.DataFrame({
    'coef': coef,
    'lower_ci': conf_int[0],
    'upper_ci': conf_int[1],
    'pval': p_values
}).drop('const')


# Plotting
plt.figure(figsize=(8, 10))
# Plot each coefficient with its confidence interval
plt.errorbar(coef_df['coef'], coef_df.index, xerr=(coef_df['coef'] - coef_df['lower_ci'], coef_df['upper_ci'] - coef_df['coef']), fmt='o', color='b', elinewidth=2, capsize=4)
# Annotate p-values
# for i, row in coef_df.iterrows():
#     plt.text(row['coef'], i, f'p={row["pval"]:.2f}', va='center', ha='right' if row['coef'] < 0 else 'left')
# Customize the plot
plt.axvline(x=0, color='grey', linestyle='--')  # Add a vertical line at zero for reference
plt.title('Regression Coefficients with Confidence Intervals')
plt.xlabel('Coefficient')
plt.ylabel('Variables')
plt.yticks(ticks=range(len(coef_df)), labels=coef_df.index)
plt.grid(axis='x', linestyle='--', alpha=0.7)
plt.tight_layout()

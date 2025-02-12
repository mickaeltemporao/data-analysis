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


### Step 3: Build Affective Polarization Variable
# Calculate the affective polarization based on feeling thermometer scores.
mask = df['feeling_democrat'] >= 0 
df = df[mask]

mask = df['feeling_republican'] >= 0 
df = df[mask]

df['affective_polarization'] = np.abs(df['feeling_democrat'] - df['feeling_republican'])


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

# Plot
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


# Load Pandas
import pandas as pd
import statsmodels.api as sm
import matplotlib.pyplot as plt
import seaborn as sns

# Step 1: Load, select & rename Variables
data_url = "https://raw.githubusercontent.com/datamisc/ts-2020/main/data.csv"
anes_data  = pd.read_csv(data_url, compression='gzip')

selected_vars = [
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

df = anes_data[selected_vars]
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


# Step 2: Clean & Create Relevant Variables
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


# TODO: Quick Data Cleaning

# age
# education
# follow_politics_media
# ideology
# income
# interest_in_politics
# party_id
# sex
# understand_issue
# vote_intention 
df = df[df['vote_intention'].between(1,2)]  # We are keeping intentions for major parties

### Step 3: Build Quantities of Interests
# Build an Affective Polarization Variable
# Calculate the affective polarization based on feeling thermometer scores.
mask = (df['feeling_democrat'] >= 0) & (df['feeling_republican'] >= 0 )
df = df[mask]

df['affective_polarization'] = np.abs(df['feeling_democrat'] - df['feeling_republican'])


## Check DV
sns.kdeplot(
   data=df, x="affective_polarization", hue="political_knowledge_scale",
   fill=True, common_norm=False, palette="crest",
   alpha=.5, linewidth=0,
)

# TODO: Check IV


# Step 4: Modeling - Build a Regression Model
# Use the cleaned data to build a regression model. 
# We will include control variables such as age, sex, education, income, and ideology.

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

# TODO: export to latex/md

# Step 5: Visualize Results
# Create a visualization to summarize the results of the regression model.

# Create a DataFrame with coefficients and confidence intervals
coef_df = pd.DataFrame({
    'coef': model.params,
    'lower_ci': model.conf_int()[0],
    'upper_ci': model.conf_int()[1],
    'pval': model.pvalues
}).drop('const')


# Make the figure
plt.figure(figsize=(8, 10))
# Plot each coefficient with its confidence interval
plt.errorbar(coef_df['coef'], coef_df.index, xerr=(coef_df['coef'] - coef_df['lower_ci'], coef_df['upper_ci'] - coef_df['coef']), fmt='o', color='b', elinewidth=2, capsize=4)
plt.axvline(x=0, color='grey', linestyle='--')  # Add a vertical line at zero for reference
plt.title('Regression Coefficients with Confidence Intervals')
plt.xlabel('Coefficient')
plt.ylabel('Variables')
plt.yticks(ticks=range(len(coef_df)), labels=coef_df.index)
plt.grid(axis='x', linestyle='--', alpha=0.7)
plt.tight_layout()


# TODO: FIX effect plot
# Create a visualization of the predicted values of affective polarization 
# across the range of political knowledge scores, holding other variables
# constant at their mean values.

# Create a range of values for the political knowledge scale
knowledge_range = pd.Series(df['political_knowledge_scale'].unique())
# Create a DataFrame to hold the mean values of the other variables
mean_values = {
    var: df[var].mean() for var in X.columns[1:] if var != 'political_knowledge_scale'
}
mean_values['political_knowledge_scale'] = knowledge_range
# Create a DataFrame from the mean values
prediction_data = pd.DataFrame(mean_values)
# Add a constant to the prediction data 
prediction_data = sm.add_constant(prediction_data, has_constant='add')
# Calculate predicted values
predicted_values = model.predict(prediction_data)

# Make the figure
plt.figure(figsize=(10, 6))
plt.plot(knowledge_range, predicted_values, label='Predicted Affective Polarization', color='b', linewidth=2)
plt.title('Effect of Political Knowledge on Affective Polarization')
plt.xlabel('Political Knowledge Scale')
plt.ylabel('Predicted Affective Polarization')
plt.grid(True, linestyle='--', alpha=0.7)
plt.axhline(y=0, color='grey', linestyle='--', linewidth=1)  # Reference line at zero if needed
plt.legend()
plt.tight_layout()


# Load Pandas
import pandas as pd
import numpy as np
import statsmodels.api as sm
import matplotlib.pyplot as plt
import seaborn as sns

# Import Data
data_url = "https://raw.githubusercontent.com/datamisc/ts-2020/main/data.csv"
anes_data  = pd.read_csv(data_url, compression='gzip')

my_vars = [
    "V201033",  # vote-int 
    "V201507x",  # age
    "V201600",  # sex
    "V201511x",  # educ
    "V201617x",  # income
    "V201231x",  # party-id
    "V201200",  # idl
    "V201151",  # rate-biden
]

df = anes_data[my_vars]
df.columns = ['vote_int', 'age', 'sex', 'educ', 'income', 'party_id', 'ideology', 'approval_rating']


df = df[df >= 0]
df = df.dropna()
df = df[df['ideology'].between(1,7)]
df['vote_int'] = df['vote_int'].apply(lambda x: 1 if x == 1 else 0)
df.describe()
df = pd.get_dummies(df, columns=['sex', 'educ'], drop_first=True, dtype=int)

# Prepare the data for modeling
X = df.drop('vote_int', axis=1)
y = df['vote_int']

# Add a constant for the intercept
X = sm.add_constant(X)
# Fit the logistic regression model
model = sm.Logit(y, X).fit()
# Print the regression table
print(model.summary())

# Visualization of predicted probabilities based on 'ideology'
age_values = np.linspace(df['age'].min(), df['age'].max(), 100)
# Create a DataFrame to store predictions
pred_df = pd.DataFrame({'age': age_values})
# Repeat other variables as their mean or mode for prediction
for col in X.columns:
    if col not in ['age', 'const']:
        pred_df[col] = X[col].mean()
# Add constant
pred_df = sm.add_constant(pred_df, has_constant='add')

# Predict probabilities
pred_probs = model.predict(pred_df)
# Plotting
plt.figure(figsize=(10, 10))
plt.plot(age_values, pred_probs, label='Predicted Probability', linewidth=3)
plt.title('Predicted Probability of Voting Intention by Age', fontsize=30)
plt.xlabel('Age', fontsize=25)
plt.ylabel('Predicted Probability', fontsize=25)
plt.grid(True)
plt.legend(fontsize=20)
plt.yticks(fontsize=20)
plt.xticks(fontsize=20)
plt.legend(fontsize=20)
plt.tight_layout()
plt.show()

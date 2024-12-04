import datetime
import difflib
import matplotlib.pyplot as plt
import mwclient
import nltk
import pandas as pd

from statsmodels.nonparametric.smoothers_lowess import lowess
from nltk.sentiment import SentimentIntensityAnalyzer


nltk.download('vader_lexicon')


def fetch_wikipedia_revisions(page_title, limit=10):
    site = mwclient.Site('en.wikipedia.org')
    page = site.pages[page_title]

    # Fetch revisions
    revisions = []
    for rev in page.revisions(prop='content|timestamp', limit=limit):
        print("Fetched revision", rev)
        revisions.append(rev)
    return revisions


def compare_revisions(rev1, rev2):
    diff = difflib.unified_diff(rev1.splitlines(), rev2.splitlines(), lineterm='')
    change_text = '\n'.join(diff)
    return change_text


def sentiment_analysis(text):
    sia = SentimentIntensityAnalyzer()
    sentiment = sia.polarity_scores(text)
    return sentiment


def plot_sentiment_evolution(timestamps, sentiments, window=3, frac=0.3):
    # Extract compound scores for sentiment evolution
    compound_scores = [s['compound'] for s in sentiments]
    # Convert timestamps to datetime objects directly
    dates = [datetime.datetime(*ts[:6]) for ts in timestamps]
    # Create a DataFrame for rolling average calculation
    df = pd.DataFrame({'date': dates, 'compound_score': compound_scores})
    df.set_index('date', inplace=True)
    # Calculate rolling average
    df['rolling_avg'] = df['compound_score'].rolling(window=window, min_periods=1).mean()
    # Apply Lowess smoothing
    smoothed = lowess(df['compound_score'], df.index, frac=frac, it=0, return_sorted=False)
    plt.figure(figsize=(12, 8))
    # Plot rolling average
    plt.plot(df.index, df['rolling_avg'], marker='o', linestyle='-', linewidth=3, label=f'{window}-Period Rolling Average', color='#AEC6CF')
    # Plot smoothed line
    plt.plot(df.index, smoothed, linestyle='-', linewidth=4, color='#FFB6C1', label='Lowess Smoothed')
    plt.title('Sentiment of Wikipedia Page Changes', fontsize=20)
    plt.xlabel('Date', fontsize=16)
    plt.ylabel('Sentiment Score', fontsize=16)
    plt.grid(True)
    plt.xticks(rotation=45, fontsize=12)
    plt.yticks(fontsize=12)
    plt.legend(fontsize=14)
    plt.tight_layout()

    plt.show()


page_title = 'Some page'
revisions = fetch_wikipedia_revisions(page_title)

timestamps = []
sentiments = []

for i in range(len(revisions) - 1):
    print("Starting ", i, "out of", len(revisions))
    rev1 = revisions[i]['*']
    rev2 = revisions[i + 1]['*']

    changes = compare_revisions(rev1, rev2)
    sentiment = sentiment_analysis(changes)

    timestamps.append(revisions[i]['timestamp'])
    sentiments.append(sentiment)

plot_sentiment_evolution(timestamps, sentiments, window=30, frac=0.5)


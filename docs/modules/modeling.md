# From Transformations to Models
## Agenda

- [ ] Theory
    - What is a model?
    - Identify and quantify variable relationships
    - Interpret results from simple linear regression models
- [ ] Code
    - Train a simple linear regression model 
    - Produce model summary tables 
    - Make predictions using a trained model
- [ ] Application
    - Interpret regression table outputs
    - Integrate regression tables into markdown documents

## Theory

### Data Modeling

We have started to use data to answer questions using descriptive statistics such as `df['some_variable'].mean()`. We have also learned how to use visualizations to identify variable relationships and trends using `df[]()`. People often says that an image is worth a 1000 words. Images are a great tool to convey a message however, our perceptions can be biased [@lewandowsky1989perception]. Let's take a closer look.

#### Relationships between variables can be complex to see

![](../images/relation.png)

#### Adding random lines?
![](../images/lines.png)


#### Is it a Strong relationship?
![](../images/model-1.png)
![](../images/model-2.png)

#### Is the relationship observed due to random chance?

- To avoid such biases, we can quantify the strength of relationships using statistical models (e.g. Linear Regression)

### What is a model?

```python
# Create data
my_data = pd.DataFrame({
    'time_to_iep': [16.93, 19.49, 18.21, 19.09, 17.67, 18.48, 16.37, 17.57, 19.18, 18.74, 17.15, 17.76, 17.2, 19.78, 18.34,
                    17.93, 18.09, 17.14, 19.41, 17.99, 16.54, 18.42, 16.65, 19.83, 18.32, 18.13, 16.72, 18.05, 18.5, 19.45,
                    17.22, 17.32, 19.48, 18.93, 18.69, 18.78, 18.58, 18.8, 18.28, 20.06, 18.12, 18.64, 18.16, 17.44, 18.96,
                    17.55, 19.09, 17.95, 21.01, 18.19]
})

# Visualize
plt.figure(figsize=(8, 6))
sns.histplot(my_data['time_to_iep'])
plt.axvline(my_data['time_to_iep'].mean(), color='red', linestyle='dashed', linewidth=1.5)
plt.text(my_data['time_to_iep'].mean(), 4.5, f"{my_data['time_to_iep'].mean():.2f}", color='red', ha='right')
```

![](../images/time-iep.png)


## Code
- [ ] Code
    - Train a simple linear regression model 
    - Produce model summary tables 
    - Make predictions using a trained model

## Application
- [ ] Application
    - Interpret regression table outputs
    - Integrate regression tables into markdown documents


## For Next Time

- :fontawesome-solid-brain: Use `statsmodels` to create a model related to your final project.
- :fontawesome-solid-book: Mandatory Reading, Note, & Presentation
    - [Pradel, F., Zilinsky, J., Kosmidis, S., & Theocharis, Y. (2024). Toxic speech and limited demand for content moderation on social media. *American Political Science Review*, 1-18.](https://www.cambridge.org/core/services/aop-cambridge-core/content/view/405333D7072585903E81BEF1729378F8/S000305542300134Xa.pdf/toxic-speech-and-limited-demand-for-content-moderation-on-social-media.pdf)



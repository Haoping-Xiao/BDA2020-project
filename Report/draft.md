# BDA - Project

## 1. Project Introduction

Road traffic and safety have become one of the major problems in people's safety concern. According to [WHO](https://www.who.int/publications/i/item/9789241565684), the annual road traffic deaths has reached 1.35 million in 2018, which makes road accident the leading killer of people aged from 5 to 29 years. In the UK, traffic accidents has caused more than 1700 deaths and more than 150,000 injuries in 2019 alone [source](https://www.racfoundation.org/motoring-faqs/safety#a1). Understanding and projecting the trend of growth (decrease) about the number of traffic accidents, could raise the awareness of the general population and call for collaborative effort to address this problem.

In this project, we try to explore the `Road Safety Data` from the Department of Transport in the UK. The dataset accurately presents the time, location, police force, vehicles and number of citizens involved in every accident, and it is publicly available at [Road Safety Data](https://data.gov.uk/dataset/cb7ae6f0-4be6-4935-9277-47e5ce24a11f/road-safety-data). We will try to capture the trend of the number of cases in different areas using a nomal model with linear mean, and provide statistical results in a Bayesian perspective. Concretely, we study the number of accidents in 6 representative areas: Metropolitan Area, Cumbria, Lancashire, Merseyside, Greater Manchester and Cheshire. 

The remaining contents of this report are structured as follows: Section 2 presents the process of data preprocessing and information extraction. It also provides an intuitive overview with the visualization of the elementary statistics. Section 3 introduces the probability models that we choose for this dataset, which includes a separate model, a pooled model and a hierarchical model. Section 4 discusses the fitting results of the three models and evaluates the quality of them based on convergence, cross validation and sensitivity. Finally, Section 5 draws a conclusion for our project and looks into possible methods and outcome of future work.

## 2. Data Preprocess and Visualization

### 2.1 Data Preprocess 

As the first section described, Road Satety Data contains millions of car accident records from 2005 to 2019 in UK. Those records contains much information irrelevant to our goal such as number of vehicles, speed limit, light conditions and many other factors. In addition, the records provide no information on the number of accidents per year directly. Luckily, it is still possible to obtain our interested data by counting car accident records in which dates are the same year. However, there is an extensive difference on the number of car accidents which mainly results from tremendous difference on population. This difference hinders fair comparison on traffic management system in different areas. To eliminate this negative effect,  we perform data normalization, which is  dividing the number of car accidents by the population in each area. Although Road Satety Data does not provide population information, we eventually find `public population information` via UK parkiament.

To sum up:

1. Extract two columns from the original data, including "date" and "police force". Date shows the date of one accident and police force indicates the responsible police office of the accident spot.
2. Count the number of records per police force area in each year(2005-2019).
3. Calculate accident rates per 10,000 people.

### 2.2 Data Visualization

After data preprocess, we can obtain historical accident rates in six different areas. As Table 1 shown, the range of data in each area is close, which will be beneficial for fairly comparing traffic management system in different areas.

Table1. Accident Rates per 10,000 people

| Year               | 05   | 06   | 07   | 08   | 09   | 10   | 11   | 12   | 13   | 14   | 15   | 16   | 17   | 18   | 19   |
| ------------------ | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| Metropolitan       |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |
| Cumbria            |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |
| Lancashire         |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |
| Merseyside         |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |
| Greater Manchester |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |
| Cheshire           |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |

We also visualize our preprocessed data and fit data using least square method.

![preprocessed_data](../Figs/preprocessed_data.jpg)

![fit_data](../Figs/fit_data.jpg)

> Normalize over time by population growth in UK? 
>

## 3. Probability Models 

Generally for these models, we use normal model with linear mean. We assume that in a certain year, number of accidents in a district obeys a normal distribution:
$$
accident \sim Normal(\mu, \sigma)
$$
In the subsequent sections, we setup separate, pooled and hierarchical  model for our data, carry out verification and then make comparisons.

### 3.1 Separate Model

In a separate model, we treat each district as an individual entity, and assign independent parameters to them. Specifically, we assign individual parameters $\alpha_i$ and $\beta_i$ to the $i$th area, and make the mean vary linearly with respect to years. But each district will have a constant variance across all 15 years. The mathematical expression for the separate model can be specified with the following equations:
$$
\begin{aligned}
\alpha_i &\sim Normal(0, 100)\\
\beta_i &\sim Normal(0, 4.85)\\
\sigma_j &\sim uniform \\
\mu_{i,j} &= \alpha_i + \beta_i * year[j] \\
accident[i, j] &\sim Normal(\mu_{i,j}, \sigma_j)
\end{aligned}
$$



### 3.2 Pooled Model

$$
\begin{aligned}
\alpha &\sim Normal(0, 100)\\
\beta &\sim Normal(0, 4.85)\\
\sigma_j &\sim uniform \\
\mu_{j} &= \alpha + \beta * year[j] \\
accident[:, j] &\sim Normal(\mu_{j}, \sigma_j)
\end{aligned}
$$

### 3.3 Hierarchical Model

$$
\begin{aligned}
\mu_\alpha &\sim Normal(-30, 20) \\
\sigma_\alpha &\sim Normal(10, 5) \\
\mu_\beta &\sim Normal(-1, 5) \\
\sigma_\beta &\sim Normal(3, 3) \\
\alpha_i &\sim Normal(\mu_\alpha, \sigma_\alpha)\\
\beta_i &\sim Normal(\mu_\beta, \sigma_\beta)\\
\sigma_j &\sim uniform \\
\mu_{j} &= \alpha + \beta * year[j] \\
accident[:, j] &\sim Normal(\mu_{j}, \sigma_j)
\end{aligned}
$$

## 4. Result Analysis and Model Evaluation

(psis, loo, ks, HMC, sensitivity analysis)


## 5. Conclusion and Future Work
Discussion, findings and possible improvements

## Appendix: Codes and training logs


## References


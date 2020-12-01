# BDA - Project

## 1. Project Introduction

Road traffic and safety have become one of the major problems in people's safety concern. According to [WHO](https://www.who.int/publications/i/item/9789241565684), the annual road traffic deaths has reached 1.35 million in 2018, which makes road accident the leading killer of people aged from 5 to 29 years. In the UK, traffic accidents has caused more than 1700 deaths and more than 150,000 injuries in 2019 alone [source](https://www.racfoundation.org/motoring-faqs/safety#a1). Understanding and projecting the trend of growth (decrease) about the number of traffic accidents, could raise the awareness of the general population and call for collaborative effort to address this problem.

In this project, we try to explore the Road Safety Data from the Department of Transport in the UK. The dataset accurately presents the time, location, police force, vehicles and number of citizens involved in every accident, and it is publicly available at [Road Safety Data](https://data.gov.uk/dataset/cb7ae6f0-4be6-4935-9277-47e5ce24a11f/road-safety-data)   We will try to capture the trend of the number of cases in different areas using a nomal model with linear mean, and provide statistical results in a Bayesian perspective. Concretely, we study the number of accidents in 6 representative areas: Metropolitan Area, Cumbria, Lancashire, Merseyside, Greater Manchester and Cheshire. 

The remaining contents of this report are structured as follows: Section 2 presents the process of data preprocessing and information extraction. It also provides an intuitive overview with the visualization of the elementary statistics. Section 3 introduces the probability models that we choose for this dataset, which includes a separate model, a pooled model and a hierarchical model. Section 4 discusses the fitting results of the three models and evaluates the quality of them based on convergence, cross validation and sensitivity. Finally, Section 5 draws a conclusion for our project and looks into possible methods and outcome of future work.

## 2. Data Preprocess and Visualization

Extract by police force area

Normalize over different areas by [population](https://researchbriefings.files.parliament.uk/documents/SN00634/SN00634.pdf) in different police force area

Normalize over time by population growth in UK? 



In this section we will elaborate on the 

Description, Visualization

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

Based on the fitting result of our models, we can conclude 大部分地区,斜率小于0 => rate 下降,除了什么地区除外. 这个地区应当注意,采取必要的措施.在2020年预测中,哪个地区应当注意,因为他有最大的事故率,乘以人口,哪个地区应当注意,它的事故数为XX(是否突破峰值).

## 5.2 Findings
The accident rate in an area could, to an extend, reflect the efficiency of local traffic management or people's adherence to traffic rules.
Based on the fitting results of our model, we found that the separate model and hierarchical model give similar results, but the pooled model is far different from the other two.
We may conclude that the traffic management strength varies among those areas, and they can not be represented uniformly by a single normal distribution, since the pooled model merely demonstrates pool performance.
Further, we have sufficient reason to believe the variation is quite large, because the hierarchical model and the separate model give similar results, which means there isn't a distinct hierarchical structure in UK's traffic management system.


## Appendix: Codes and training logs


## References


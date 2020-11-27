# BDA - Project

## 1. Project Introduction

Road traffic and safety have become one of the major problems in people's safety concern. According to [WHO](https://www.who.int/publications/i/item/9789241565684), the annual road traffic deaths has reached 1.35 million in 2018, which makes road accident the leading killer of people aged from 5 to 29 years. In the UK, more than ==XXX== traffic accidents have caused ==XXX== casualties from 2005 to 2019. Understanding and projecting the trend of growth (decrease) about the number of traffic accidents, could raise the awareness of the general population and call for collaborative effort to address this problem.

In this project, we try to explore the Road Safety Data from the Department of Transport in the UK. The dataset accurately presents the time, location, police force, vehicles and number of citizens involved in every accident, and it is publicly available at [Road Safety Data](https://data.gov.uk/dataset/cb7ae6f0-4be6-4935-9277-47e5ce24a11f/road-safety-data)   We will try to capture the trend of the number of cases in different areas with a ==XXX== model, and provide statistical results in a Bayesian perspective. Concretely, we study the number of accidents in 6 representative areas: Metropolitan Area, Cumbria, Lancashire, Merseyside, Greater Manchester and Cheshire. 

The remaining contents of this report are structured as follows: Section 2 presents the process of data preprocessing and information extraction. It also provides an intuitive overview with the visualization of the elementary statistics. Section 3 introduces the probability models that we choose for this dataset, which includes a separate model, a pooled model and a hierarchical model. Section 4 discusses the fitting results of the three models and evaluates the quality of them based on convergence, cross validation and sensitivity. Finally, Section 5 draws a conclusion for our project and looks into possible methods and outcome of future work.

## 2. Data Preprocess and Visualization

Extract by police force area

Normalize over different areas by [population](https://researchbriefings.files.parliament.uk/documents/SN00634/SN00634.pdf) in different police force area

Normalize over time by population growth in UK? 



In this section we will elaborate on the 

Description, Visualization

## 3. Probability Models 

justify the choice, give mathematical expression as well as stan code 

### 3.1 Separate Model

current year: $i$,  area number $j$

每个地区有自己的参数alpha和beta， 然后年份从2005到2019年一共15个数据点
$$
y[i, j] \sim Normal (\alpha_j + \beta_j x[i], \sigma_j)
$$


### 3.2 Pooled Model



### 3.3 Hierarchical Model



## 4. Result Analysis and Model Evaluation

(psis, loo, ks, HMC, sensitivity analysis)


## 5. Conclusion and Future Work
Discussion, findings and possible improvements

## Appendix: Codes and training logs


## References


import numpy as np 
import matplotlib.pyplot as plt 
import pystan

data_file = 'data/data.txt'
accident_data = np.loadtxt(data_file)
# print(data.shape)
# mean_value = np.mean(data) # mean value approximately 25 cases per 10,000 people
# # it's very un likely to change 50% of the mean, so 2.57*sigma = mean_value/2
# sigma = mean_value / (2*2.57) 

the_separate_model = """
    // The input data is a vector 'y' of length 'N'.
    data {
      int<lower=0> N; // the number of police force
      int<lower=0> Y; // the number of years has been studied
      matrix[N,Y] accidentData;//accident data
    }

    // The parameters accepted by the model. Our model
    // accepts two parameters 'mu' and 'sigma'.
    parameters {
      vector[N] alpha;
      vector[N] beta;
      vector<lower=0>[N] sigma;
    }

    transformed parameters{
      vector[N] mu;
      for(i in 1:N)
        mu[i]=alpha[i]+beta[i]*i;
    }

    // The model to be estimated. We model the output
    // 'y' to be normally distributed with mean 'mu'
    // and standard deviation 'sigma'.
    model {
      for(i in 1:N){
        alpha[i]~normal(0,100);
      }
      for(i in 1:N){
        beta[i]~normal(0,4.85);
      }
      for(i in 1:N){
        accidentData[i,]~normal(mu[i],sigma[i]);
      }
    }
"""


data_for_separate = dict(
    N = accident_data.shape[0],
    Y = accident_data.shape[1],
    accidentData = accident_data
)

stan_model = pystan.StanModel(model_code=the_separate_model)
stan_results = stan_model.sampling(data=data_for_separate)
print(stan_results)

#####################
# ALL Rhat equals to 1.0, 2020.11.26 finish
#####################
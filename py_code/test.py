import numpy as np 
import matplotlib.pyplot as plt 
import pystan
import arviz as az
from pathlib import Path

model_path = './stan_models'
data_file = 'data/data.txt'
accident_data = np.loadtxt(data_file)
# print(data.shape)
# mean_value = np.mean(data) # mean value approximately 25 cases per 10,000 people
# # it's very un likely to change 50% of the mean, so 2.57*sigma = mean_value/2
# sigma = mean_value / (2*2.57) 

# the_separate_model = """
# // The input data is a vector 'y' of length 'N'.
# data {
#   int<lower=0> N; // the number of police force
#   int<lower=0> Y; // the number of years has been studied
#   matrix[N,Y] accidentData;//accident data
# }

# // The parameters accepted by the model. Our model
# // accepts two parameters 'mu' and 'sigma'.
# parameters {
#   vector[N] alpha;
#   vector[N] beta;
#   vector<lower=0>[N] sigma;
# }

# transformed parameters{
#   matrix[N,Y]mu;
#   // vector[N] mu;
#   for(i in 1:N)
#     for(j in 1:Y)
#       mu[i,j]=alpha[i]+beta[i]*j;
# }

# // The model to be estimated. We model the output
# // 'y' to be normally distributed with mean 'mu'
# // and standard deviation 'sigma'.
# model {
#   for(i in 1:N){
#     alpha[i]~normal(0,100);
#   }
#   for(i in 1:N){
#     beta[i]~normal(0,4.85);
#   }
#   for(i in 1:N){
#     //for each police force
#     for(j in 1:Y){
#      //for each observed year
#      accidentData[i,j]~normal(mu[i,j],sigma[i]);
#     }
#   }
# }
# """
# stan_model = pystan.StanModel(model_code=the_separate_model)


data_for_separate = dict(
    N = accident_data.shape[0],
    Y = accident_data.shape[1],
    accidentData = accident_data,
    years = np.arange(accident_data.shape[1]) + 1
)

model_name = 'accident_hierarchical.stan'
stan_model = pystan.StanModel(file=model_path + '/' + model_name)
print(stan_model.model_code)
stan_results = stan_model.sampling(data=data_for_separate)
print(stan_results)
idata = az.from_pystan(stan_results, log_likelihood="log_lik")
loo = az.loo(idata)
print(loo)


# def result_statistics(stan_results, plot_ks =True, 
#                       font_size=15,num_bins=20, fig_size = (12, 6)):
#   log_lik = stan_results.extract()['log_lik']
#   # According to the comments in psisloo, the first element in the result 
#   # is PSIS-LOO value, the third is ks
#   psis_results = psisloo(log_lik)
#   loo_value = psis_results[0]
#   ks = psis_results[2]
#   num_samples = log_lik.shape[0]
  
#   # Equation 7.5 and 7.15 in BDA3
#   computed_lppd = np.sum(np.log(np.sum(np.exp(log_lik), axis=0)/num_samples))
#   p_loocv = computed_lppd - loo_value
  
#   print("The PSIS-LOO value is {}".format(loo_value))
#   print("the corresponding p_eff is {}".format(p_loocv))
  
#   if plot_ks:
#     plt.figure(figsize=fig_size)
#     _ = plt.scatter(1+np.arange(ks.size), ks, marker="+")
#     plt.ylabel("Number of cases", fontsize=font_size)
#     plt.ylim([0, 1])
#     plt.xlabel(r"Value of $\hat{k}$", fontsize=font_size)
#     plt.show()
    
#   # return loo_value, p_loocv

# result_statistics(stan_results)
#####################
# ALL Rhat equals to 1.0, 2020.11.26 finish
#####################
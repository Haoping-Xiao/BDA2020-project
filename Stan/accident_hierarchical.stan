//
// This Stan program defines a simple model, with a
// vector of values 'y' modeled as normally distributed
// with mean 'mu' and standard deviation 'sigma'.
//
// Learn more about model development with Stan at:
//
//    http://mc-stan.org/users/interfaces/rstan.html
//    https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started
//

data {
  int<lower=0> N; // the number of police force
  int<lower=0> Y; // the number of years has been studied
  matrix[N,Y] accidentData;//accident data
}


parameters {
  real mu_alpha;
  real mu_beta;
  real<lower=0> sigma_alpha;
  real<lower=0> sigma_beta;
  vector[N] alpha;
  vector[N] beta;
  vector<lower=0>[N] sigma;
}


transformed parameters{
  matrix[N,Y]mu;
  for(i in 1:N)
    for(j in 1:Y)
      mu[i,j]=alpha[i]+beta[i]*j;
}


model {
  mu_alpha~normal(30,20);
  mu_beta~normal(-1,5);
  sigma_alpha~normal(10,5);
  sigma_beta~normal(3,3);
  //for each police force
  for(i in 1:N){
    alpha[i]~normal(mu_alpha,sigma_alpha);
    beta[i]~normal(mu_beta,sigma_beta);
  }
  
  //for each police force
  for(i in 1:N){
    //for each observed year
    for(j in 1:Y){
     accidentData[i,j]~normal(mu[i,j],sigma[i]);
    }
  }
}






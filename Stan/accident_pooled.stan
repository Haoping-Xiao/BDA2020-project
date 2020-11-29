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
  real alpha;
  real beta;
  real<lower=0> sigma;
}

transformed parameters{
  vector[Y]mu;
  //linear model
  for(j in 1:Y)
    mu[j]=alpha+beta*j;
}


model {
  //prior
  alpha~normal(0,100);
  beta~normal(0,4.85);
  //for each year, different police force share the same model
  for(j in 1:Y){
    accidentData[,j]~normal(mu[j],sigma);
  }
}

generated quantities{
  //accident prediction in 2020 in different police force
  
  vector[N] pred=normal_rng(alpha+beta*(2020-2005),sigma);
  
  matrix[N,Y] log_lik;
  for(i in 1:N){
    for(j in 1:Y){
      log_lik[i,j]=normal_lpdf(accidentData[i,j]|mu[j],sigma);
      // accidentData[,j]~normal(mu[j],sigma);
    }
  }
  
}


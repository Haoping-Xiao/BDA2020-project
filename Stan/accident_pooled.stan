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
  int<lower=0> Y; // the number of years has been studied, year 2005 corresponds to 1
  matrix[N,Y] accidentData;//accident data
  int prior_choice; // choose different setup for prior distribution
  int xpred; // year of prediction (actual year)
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
  if (prior_choice==3){
    // weaker prior 
    alpha~normal(0,100);
    beta~normal(0,10);
  } else if (prior_choice==2) {
    // uniform prior
  } else {
    // default prior
    alpha~normal(30,20);
    beta~normal(0,4.85);
  }

  //for each year, different police force share the same model
  for(j in 1:Y){
    accidentData[,j]~normal(mu[j],sigma);
  }
}

generated quantities{
  //log likelihood
  matrix[N,Y] log_lik;
  matrix[N,Y] yrep;
  //accident prediction in 2020 in different police force
  vector[N] pred;
  for(i in 1:N){
    // 2005 -> 1, 2006 -> 2, ..., 2020 -> 16 
    pred[i]=normal_rng(alpha+beta*(xpred-2004),sigma);
  }
  
  for(i in 1:N){
    for(j in 1:Y){
      // do posterior sampling and try to reproduce the original data
      yrep[i,j]=normal_rng(mu[j],sigma);
      // prepare log likelihood for PSIS-LOO 
      log_lik[i,j]=normal_lpdf(accidentData[i,j]|mu[j],sigma);
    }
  }
  
}


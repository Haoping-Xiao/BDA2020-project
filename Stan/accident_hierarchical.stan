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
  real mu_alpha;
  real mu_beta;
  real<lower=0> sigma_alpha;
  real<lower=0> sigma_beta;
  vector[N] alpha;
  vector[N] beta;
  // vector<lower=0>[N] sigma;
  real<lower=0> sigma;
}


transformed parameters{
  matrix[N,Y]mu;
  for(i in 1:N)
    for(j in 1:Y)
      mu[i,j]=alpha[i]+beta[i]*j;
}


model {
  if (prior_choice==3){
    // bigger variance
    mu_alpha~normal(30,40);
    mu_beta~normal(0,10);
    //sigma_alpha~normal(10,10);
    //sigma_beta~normal(3,6);
  } else if (prior_choice==2){
    // uniform prior
  } else {
    // default choice with moderate variance
    mu_alpha~normal(30,20);
    mu_beta~normal(0,4.85);
    //sigma_alpha~normal(10,5);
    //sigma_beta~normal(3,3);
  }

  //for each police force
  for(i in 1:N){
    alpha[i]~normal(mu_alpha,sigma_alpha);
    beta[i]~normal(mu_beta,sigma_beta);
  }
  
  //for each police force
  for(i in 1:N){
    //for each observed year
    for(j in 1:Y){
     // accidentData[i,j]~normal(mu[i,j],sigma[i]); 
     accidentData[i,j]~normal(mu[i,j],sigma); // share sigma
    }
  }
}


generated quantities{
  //log likelihood
  matrix[N,Y] log_lik;
  matrix[N,Y] yrep;
  //accident prediction in 2020 in different police force
  vector[N] pred;
  
  //for each police force
  for(i in 1:N){
    // 2005 -> 1, 2006 -> 2, ..., 2020 -> 16 
    // pred[i]=normal_rng(alpha[i]+beta[i]*(xpred-2004),sigma[i]);
    // share sigma
    pred[i]=normal_rng(alpha[i]+beta[i]*(xpred-2004),sigma);
  }
  
  for(i in 1:N){
    for(j in 1:Y){
      // do posterior sampling and try to reproduce the original data
      // yrep[i,j]=normal_rng(mu[i,j],sigma[i]);
      yrep[i,j]=normal_rng(mu[i,j],sigma);
      // prepare log likelihood for PSIS-LOO 
      // log_lik[i,j]=normal_lpdf(accidentData[i,j]|mu[i,j],sigma[i]);
      // share sigma
      log_lik[i,j]=normal_lpdf(accidentData[i,j]|mu[i,j],sigma);
    }
  }
  
}





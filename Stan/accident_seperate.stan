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

// The input data is a vector 'y' of length 'N'.
data {
  int<lower=0> N; // the number of police force
  int<lower=0> Y; // the number of years has been studied, year 2005 corresponds to 1
  matrix[N,Y] accidentData;//accident data
  int prior_choice; // choose different setup for prior distribution
  int xpred; // year of prediction (actual year)
}

// The parameters accepted by the model. Our model
// accepts two parameters 'mu' and 'sigma'.
parameters {
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

// The model to be estimated. We model the output
// 'y' to be normally distributed with mean 'mu'
// and standard deviation 'sigma'.
model {
  // loop over police offices
  if (prior_choice==3){
    for(i in 1:N){
      alpha[i]~normal(0,100);
      beta[i]~normal(0,10);
    }
  } else if (prior_choice==2){
    // uniform prior
  } else {
    // default prior 
    for(i in 1:N){
      alpha[i]~normal(30,20);
      beta[i]~normal(0,4.85);
    }
  }

  //for each police force
  for(i in 1:N){
    //for each observed year
    for(j in 1:Y){
     accidentData[i,j]~normal(mu[i,j],sigma[i]);
    }
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
    pred[i]=normal_rng(alpha[i]+beta[i]*(xpred-2004),sigma[i]);
  }
  
  for(i in 1:N){
    for(j in 1:Y){
      // do posterior sampling and try to reproduce the original data
      yrep[i,j]=normal_rng(mu[i,j],sigma[i]); 
      // prepare log likelihood for PSIS-LOO 
      log_lik[i,j]=normal_lpdf(accidentData[i,j]|mu[i,j],sigma[i]);
    }
  }
  
}



f_GetStockPath <- function( S0 , Sigma , r , T , m ) {
  # This function simulates a stock price path under the binomial model
  # Inputs:
  # S0 ( initial stock price ) , Sigma (annual return stdev) ,
  # r (annual Rf) , T (Time to maturity in years) , m (number of periods)
  # Output: vec_S, the simulated price path with m+1 elements
  
  
  
  # Step 1: Calculate dT , u , d , p and q
  dT <- T / m  # dT is the time for each period in the binomial model
  u <- exp( Sigma * sqrt(dT) ) # u is the rate of return (?) when price goes up
  d <- 1/u # d is the rate of return (?) when price goes down
  p <- ( exp(r*dT) - d ) / (u - d) # p is the risk-neutral prob. to go up
  q <- 1 - p  # q is the risk-neutral prob. to go down
  
  # Step 2: Loop over each period of time to get a random price path
  vec_S <- matrix( 0 , m + 1 , 1 ) # A vector to store stock prices over time
  vec_S[1] <- S0  # Assign the initial stock price
  # for (i in 2 : m + 1){ # For unknown reason this doesn't work.
  for (i in seq(2, m + 1 , by=1) ) {
    # Generate a random return for that round, up with prob p, down with prob q
    if ( runif(1) < p ) {  # runif(1) gives a random number in (0,1)
      # Going up
      vec_S[i] <- vec_S[i-1] * u  # Stock price goes up with prob p
    } else {
      # Going down
      vec_S[i] <- vec_S[i-1] * d  # Stock price goes down with prob q
    } # if statement
  } # for i
  
  
  # Return a single variable to the main program
  return( vec_S )
} # end of the function
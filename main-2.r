# Load data
d <- read.table("d.txt")
Rf <- 0
N <-ncol(d)

Best_Sharpe <- -99
# Set loop parameters
mu_min <- 0
mu_max <- 0.1
mu_step <- 0.0001


plot(0,0, xlim = c(0,0.2), ylim = c(-0.01,0.05))
 
# Main loop
for (mu in seq(mu_min, mu_max, by = mu_step)) {
  
  source("xyz.r")
  # Call function f2 to get optimal weight vector, sigma, and Sharpe ratio
  res <- f2(d, mu, Rf)
  This_vec_w <- res$vec_w
  This_sigma <- res$sigma
  This_Sharpe <- res$Sharpe
  
  # Plot a point on the mean-standard deviation plane
  points(This_sigma, mu)
  
  # Search for the highest Sharpe ratio
  if (This_Sharpe > Best_Sharpe) {
    Best_Sharpe <- This_Sharpe
    vec_Opt_w <- This_vec_w
    Opt_mu <- mu
    Opt_sigma <- This_sigma
  }
}

# Draw the capital allocation line, linking (0 , Rf) to (Opt_sigma , Opt_mu)
segments(0, Rf, Opt_sigma, Opt_mu)

# Extend the line a little farther
segments(Opt_sigma, Opt_mu, 2 * Opt_sigma, 2 * (Opt_mu - Rf) + Rf)






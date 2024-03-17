# This is the main program for the option pricing using simulation project
rm(list = ls());  # Clean up memory.

# Functions need to be sourced: 
source("f_GetStockPath.R")
source("f_Payoff_Structured.R")
source("f_Payoff_Customized.R")
source("f_Payoff_Lookback.R")
source("f_Payoff_Asian.R")
source("f_Payoff_European.R")
source("f_Payoff_Barrier.R")

# Input parameters for options
S0 <- 60  # Stock price now
K <- 65   # Strike price
Is_Call <- 1 # 1 for call; 0 for put
Sigma <- 0.2 # Annual standard deviation of the stock return 
r <- 0.01 # Annual risk-free rate
T <- 1    # Time to maturity in years
m <- 100  # Number of time periods in the binomial model.
N <- 1000 # Number of price paths in the simulation
S_Option_Model <- 4
# 1 for European call/put; 2 for a structured product
# 3 for lookback option; 4 for Asian option; 5 for Barrier option; 
# 6 for other customized options
B <- 80  # The barrier for a barrier option
Is_Knock_In <- 1 # 1 for Knock-in barrier option; 0 for knock-out barrier option

# Initialize before the simulation loop
vec_Payoff <- matrix(0 , N , 1) # This is a vector to store simulated payoffs
# Main loop
for (i in 1 : N){
  # Step 1: Generate one price path randomly
  vec_S <- f_GetStockPath( S0 , Sigma , r , T , m ) # vec_S has m+1 elements
  
  # Step 2: Calculate option payoff based this price path
  if (S_Option_Model == 1) { # European call/put
    vec_Payoff[i] <- f_Payoff_European( vec_S , K , Is_Call )
  }
  if (S_Option_Model == 2) { # A Structured Product
    vec_Payoff[i] <- f_Payoff_Structured( vec_S )
  }
  if (S_Option_Model == 3) { # A lookback option
    vec_Payoff[i] <- f_Payoff_Lookback( vec_S , Is_Call )
  }
  if (S_Option_Model == 4) { # An Asian option
    vec_Payoff[i] <- f_Payoff_Asian( vec_S , K , Is_Call )
  }
  if (S_Option_Model == 5) { # A Barrier option
    vec_Payoff[i] <- f_Payoff_Barrier( vec_S , K , B , Is_Call , Is_Knock_In )
  }
  if (S_Option_Model == 6) { # Other customized options
    vec_Payoff[i] <- f_Payoff_Customized( vec_S )
  }
}  # i loop

Option_Price <- mean(vec_Payoff)
print(Option_Price)

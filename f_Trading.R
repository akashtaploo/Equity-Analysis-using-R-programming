f_Trading <- function( TAS ) {  
  # Objective: Calculate the wealth over time for the active trading strategy
  # as well as the buy-and-hold benchmark strategy.  Also, record daily returns.
  
  # Parameter settings
  Initial_Wealth <- 1   # Initial portfolio wealth to start with
  # We may also consider risk-free rate or transaction costs.
  
  # Collect data from TAS. We need return and signals
  vec_Ret <- TAS$vec_Ret
  vec_Signals <- TAS$vec_Signals
  N_Days <- length(vec_Ret)
  
  # Initialize the output value
  vec_Wealth <- rep(Initial_Wealth , N_Days)  # Wealth over time of the strategy
  vec_BH_Wealth <- rep(Initial_Wealth , N_Days)  # Wealth of the buy-and-hold
  vec_Strategy_Ret <- rep(0 , N_Days)  # Daily strategy return over time
  vec_BH_Ret <- rep(0 , N_Days)  # Daily BH benchmark return over time
  
  
  # Main loop: Grow the wealth based on returns and signals
  Current_Weight <- 1  # 0 for cash and 1 for all stock (long-only strategy)
  for (i in seq( 2 , N_Days , by = 1) ){  # Start from the second day
    # Step 1: Adjust weight (cash or stock) based on today’s trading signal.
    Current_Signal <- vec_Signals[i]
    if (Current_Signal == 1) {
      Current_Weight <- 1     # Receive a buy signal, go all stock
    } # if
    if (Current_Signal == -1) {
      Current_Weight <- 0     # Receive a sell signal, go all cash
    } # if
    if (Current_Signal == 0) {
                              # No signal, don't touch the Current_Weight
    } # if
   
    # Step 2: Calculate wealth based on today's return and weight
    # Also calculate strategy return 
    vec_Wealth[i] <- vec_Wealth[i-1] * (1 + Current_Weight * vec_Ret[i])
    vec_Strategy_Ret[i] <- Current_Weight * vec_Ret[i]
    # Update the wealth and return for the buy-and-hold strategy
    vec_BH_Wealth[i] <- vec_BH_Wealth[i-1] * (1 + vec_Ret[i])
    vec_BH_Ret[i] <- vec_Ret[i]
  }  # for i
  
  
  # Append output into the TAS list
  TAS$vec_Wealth <- vec_Wealth
  TAS$vec_BH_Wealth <- vec_BH_Wealth
  TAS$vec_Strategy_Ret <- vec_Strategy_Ret
  TAS$vec_BH_Ret <- vec_BH_Ret
  
  # Return a single variable to the main program
  return( TAS )
} # end of the function
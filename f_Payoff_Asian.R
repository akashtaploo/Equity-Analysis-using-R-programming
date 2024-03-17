f_Payoff_Asian <- function( vec_S , K , Is_Call ) {
  
  # Calculate the average stock price over the path
  S_avg <- mean(vec_S)
  
  # Determine the Asian option payoff based on whether the option is a call or a put
  if (Is_Call) {
    payoff <- max(S_avg - K , 0) # For Call
  } else {
    payoff <- max(K - S_avg , 0) # For Put
  }
  
  return(payoff)
}

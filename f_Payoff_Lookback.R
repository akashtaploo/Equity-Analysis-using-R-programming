f_Payoff_Lookback <- function(vec_S, Is_Call) {
  
  # Determine the minimum and maximum stock prices in the path
  min_S <- min(vec_S)
  max_S <- max(vec_S)
  
  # Determine the lookback option payoff based on whether the option is a call or a put
  if(Is_Call) {
    payoff <- max(vec_S[length(vec_S)] - min_S, 0) # For Call
  } else {
    payoff <- max(max_S - vec_S[length(vec_S)], 0) # For Put
  }
  return(payoff)
}

  

  
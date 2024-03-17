f_Payoff_European <- function(vec_S, K, Is_Call) {
  
  # Determine the final stock price in the path
  S_T <- vec_S[length(vec_S)]
  
  # Determine the European option payoff based on whether the option is a call or a put
  if (Is_Call) {
    payoff <- max(S_T - K, 0) # For Call
  } else {
    payoff <- max(K - S_T, 0) # For Put
  }
  
  return(payoff)
}


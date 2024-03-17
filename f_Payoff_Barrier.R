f_Payoff_Barrier <- function(vec_S, K, B, Is_Call, Is_Knock_In) {
  
  # Determine if the barrier is touched
  Is_Touched <- (B < max(vec_S)) & (B > min(vec_S))
  
  if (Is_Knock_In) {
    is_valid <- Is_Touched
    
  }else{
    is_valid <- 1 - Is_Touched
  }
  
  
  
  if (is_valid) {
    payoff <- f_Payoff_European(vec_S, K, Is_Call)
  } else {
    payoff <- 0
  }
  
  return(payoff)
}

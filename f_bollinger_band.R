f_bollinger_band <- function(TAS) {
  # The Bollinger Band strategy
  # Algorithm: Starting from the first day, we
  # 1) calculate the SMA and standard deviation of closing prices
  # 2) calculate the upper and lower Bollinger bands
  # 3) buy if the closing price is below the lower Bollinger band
  # 4) sell if the closing price is above the upper Bollinger band
  
  # Parameter settings
  MA_Lag <- 20      # Length of moving average
  Num_SD <- 2       # Number of standard deviations for the bands
  
  # Collect data from TAS. We only need the closing price
  vec_Close <- TAS$vec_Close
  N_Days <- length(vec_Close)
  # Initialize the output value, trading signals, to zero.
  vec_Signals <- rep(0, N_Days)  # 0 for no signal, 1 for buy, and -1 for sell.
  
  # Main loop: Go over everyday to generate trading signals
  for (i in seq(MA_Lag + 1, N_Days, by = 1)) {
    # Step 1: calculate long-term SMA and standard deviation of closing prices
    MA <- mean(vec_Close[(i - MA_Lag):(i - 1)])
    SD <- sd(vec_Close[(i - MA_Lag):(i - 1)])
    
    # Step 2: calculate upper and lower Bollinger bands
    BB_Up <- MA + Num_SD * SD
    BB_Low <- MA - Num_SD * SD
    
    # Step 3: buy if closing price is below lower Bollinger band
    if (vec_Close[i - 1] < BB_Low) {
      vec_Signals[i] <- 1     # Signal is to buy
    }
    
    # Step 4: sell if closing price is above upper Bollinger band
    if (vec_Close[i - 1] > BB_Up) {
      vec_Signals[i] <- -1     # Signal is to sell
    }
  } # for i
  
  # Append vec_Signals into the TAS list
  TAS$vec_Signals <- vec_Signals
  
  # Return a single variable to the main program
  return(TAS)
} # end of the function

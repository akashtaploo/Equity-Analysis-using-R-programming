# This is the main program for the technical analysis project
rm(list = ls());  # Clean up memory.

# Step 1: Setup data structure, i.e., a "list", then load input data into it.
# We can save everything, input or output, into TAS (Technical Analysis Statistics)
source("Script_Load_Input.R")

# Step 2: Generating trading signals (buy or sell) based on a technical trading rule
#source("f_MA.R")
#TAS <- f_MA(TAS)   # The moving average trading rule

#source("f_Momentum.R")
#TAS <- f_Momentum(TAS)   # The momentum/reversal strategy

source("f_bollinger_band.R")
TAS <- f_bollinger_band(TAS)   # The bollinger strategy



# Step 3: Simulate real-time trading based on the signals generated.
source("f_Trading.R")
TAS <- f_Trading(TAS)   # The trading function based on the signals

# Step 4: Summarize tradign performance of the strategy
# Terminal wealth chart: Comparing buy-and-hold strategy vs the active strategy

# Plot terminal wealth chart
plot(TAS$vec_Wealth, type = "l", col = "red", lwd = 2, xlab = "Days", ylab = "Wealth",
     main = "Terminal Wealth Chart (4/19/2017 - 4/18/2022)", ylim = c(0.8, 2))
lines(TAS$vec_BH_Wealth, col = "blue", lwd = 1)
legend("topleft", legend = c("Bollinger Band Strategy", "Buy and Hold"),
       col = c("red", "blue"), lty = 1, lwd = 2)


# Report average raw return, benchmark BH return, Sharpe ratio(assuming rf is 0)
cat("Average return of the strategy:", mean(TAS$vec_Strategy_Ret), "\n")
cat("Average return of BH:", mean(TAS$vec_BH_Ret), "\n")
cat("SD of the strategy:", sd(TAS$vec_Strategy_Ret), "\n")
cat("SD of BH:", sd(TAS$vec_BH_Ret), "\n")
cat("Sharpe ratio of BH:", (mean(TAS$vec_BH_Ret) / sd(TAS$vec_BH_Ret)), "\n")
cat("Sharpe ratio of Strategy:", (mean(TAS$vec_Strategy_Ret) / sd(TAS$vec_Strategy_Ret)), "\n")



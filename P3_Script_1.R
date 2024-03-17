# Load Data, run basic statistics, and draw the Terminal Wealth Chart.

# Step 1: Load the data and prepare data
d <- as.data.frame(read.table("QQQ.txt"))  # Stock raw return from 03/18 to 01/23
# Note for the above: Convert into a data frame for future regression analysis.
Mkt <- as.data.frame(read.table("Market.txt")) # All returns are in percentage
# Column: 1   2    3   4  5
#    Mkt-Rf SMB  HML MOM Rf 
Risk_Premium <- as.data.frame(Mkt[,1] / 100)  # Use data frame to keep the dimension
SMB <- as.data.frame(Mkt[,2] / 100)
HML <- as.data.frame(Mkt[,3] / 100)
MOM <- as.data.frame(Mkt[,4] / 100)
Rf  <- as.data.frame(Mkt[,5] / 100)
colnames(Rf) <- c("Rf")
Mkt_Rt <- Risk_Premium + Rf
colnames(Mkt_Rt) <- c("Mkt_Rt")

# Step 2: Calculate mean return, STDEV of monthly return, excess return,
# abnormal return, Sharpe ratio, etc. These are basic statistics
Stock_Mean <- colMeans(d)  # Mean monthly return of the stock/EFT
Stock_STD <- sapply(d , sd)  # STDEV of the monthly stock/EFT return
Stock_Excess <- colMeans(d - Rf)  # Avg excess return of the stock/EFT
Stock_Sharpe <- Stock_Excess / Stock_STD  # Monthly Sharpe ratio of the stock/ETF
Stock_Abnormal <- colMeans(d - Mkt_Rt) # Abnormal return
Mkt_Sharpe <- colMeans(Risk_Premium) / sapply(Mkt_Rt , sd) # Monthly Sharpe ratio of Market Ret

# Step 3: Terminal Wealth Chart from $1 with three lines:
# 1) the ETF/Stock, 2) the market return, and 3) the risk-free rate (in diff colors).

n_months <- nrow(d) # Total number of months
initial_investment <- 1 # Starting value
wealth_using_stock <- matrix( 0 , n_months , 1 ) # A column vector with all zeros to store wealth using stock return for each month
wealth_using_mktreturn <- matrix( 0 , n_months , 1 ) # A column vector with all zeros to store wealth using market return for each month
wealth_using_rf <- matrix( 0 , n_months , 1 ) # A column vector with all zeros to store wealth using risk free return for each month

# Determine wealth using stock, market return, risk free return for the 1st month and store in respective vector
wealth_using_stock[1] <- initial_investment * (1 + d[1,]/100)
wealth_using_mktreturn[1] <- initial_investment * (1 +  Mkt_Rt[1,]/100)
wealth_using_rf[1] <- initial_investment * (1 + Rf[1,]/100)

# Loop over each month after 1st month to calculate wealth and store in respective vector
for (i in 2: n_months) {
  wealth_using_stock[i] <- wealth_using_stock[i-1,] * (1 + d[i,]/100)
  wealth_using_mktreturn[i] <- wealth_using_mktreturn[i-1,] * (1 + Mkt_Rt[i,])
  wealth_using_rf[i] <- wealth_using_rf[i-1,] * (1 + Rf[i,])
} # End of loop i

# Adding initial_investment to the beginning of three diff vectors
wealth_using_stock <- c(initial_investment, wealth_using_stock)
wealth_using_mktreturn <- c(initial_investment, wealth_using_mktreturn)
wealth_using_rf <- c(initial_investment, wealth_using_rf)

# Plot terminal wealth graph for stock, market and risk free
vec_Index <- ( 0 : n_months )  # x axis values for plotting
#plot and connect dots using lines 
plot(vec_Index, wealth_using_stock, type = "l", col = "red", lwd = 2, xlab = "Months", ylab = "Terminal Wealth", main = "Terminal Wealth Chart (March 2018 - Jan 2023) ")
lines(vec_Index, wealth_using_mktreturn, type = "l", col = "blue")
lines(vec_Index,  wealth_using_rf, type = "l", col = "green")
legend("topleft", legend = c("QQQ return", "Market Return", "Risk free rate return"), col = c("red", "blue","green"), lwd = 1) # Add legend

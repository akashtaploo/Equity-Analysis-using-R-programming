# Load time-series data
# Columns of the input file: Date_ID,	SPY daily closing price,	SPY Return ,	Volume
d <- read.table("SPY.txt")
TAS <- list()

# Assign input data to TAS
TAS$Ticker <- "SPY"
TAS$vec_Date_ID <- d[ , 1]  # The first column is Date_ID
TAS$vec_Close   <- d[ , 2]  # Daily closing price
TAS$vec_Ret     <- d[ , 3]  # Daily return of the stock
TAS$vec_Volume  <- d[ , 4]  # Daily trading volume

# Regression analyses to get 1,3,and 4-factor alphas
# Make sure to run P3_Script_1.R before this one to load all the data.

# Prepare the y variable: y <- ...
y <- d[, 1] - Rf[, 1]

# Prepare the x variables: x1, x2, x3 , x4
x1 <- Mkt_Rt[, 1]
x2 <- SMB[, 1]
x3 <- HML[, 1]
x4 <- MOM[, 1]

# Perform Regression analysis to get 
#1. factor alpha (using market return only)
#
fit1 <- lm(y ~ x1)
print(summary(fit1))

#3-factor alpha (using market return, SMB, and HML)
fit3 <- lm(y ~ x1 + x2 + x3)
print(summary(fit3))

#4-factor alpha (using market return, SMB, HML, and MOM)
fit4 <- lm(y ~ x1 + x2 + x3 + x4)
print(summary(fit4))

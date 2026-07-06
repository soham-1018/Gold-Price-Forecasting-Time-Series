# ==========================================================
# Gold Price Forecasting using ARIMA
# B.Sc. Dissertation Project
# Author: Soham Choudhury
# ==========================================================

# ----------------------------------------------------------
# Clear the R environment
# ----------------------------------------------------------
rm(list = ls())

# ----------------------------------------------------------
# Import the dataset
# ----------------------------------------------------------
gold.csv = read.csv("C:/Users/lenovo/Desktop/Dissertation/monthly_csv.csv")

# Display column names and dataset
names(gold.csv)
gold.csv

# ----------------------------------------------------------
# Create the complete monthly time series (1970–2020)
# ----------------------------------------------------------
gold = ts(gold.csv$Price[241:847],
          start = 1970,
          end = c(2020,7),
          frequency = 12)

plot(gold,
     ylab = "Gold Price (USD)",
     xlab = "Time",
     main = "Monthly Gold Price Time Series")

# ----------------------------------------------------------
# Divide the dataset into Training and Test sets
# ----------------------------------------------------------

# Training data (1970–2014)
gold.train = ts(gold.csv$Price[241:780],
                start = 1970,
                end = c(2014,12),
                frequency = 12)

plot(gold.train,
     xlab = "Time",
     ylab = "Gold Price (USD)",
     main = "Training Dataset")

length(gold.train)

# Test data (2015–2020)
gold.test = ts(gold.csv$Price[781:847],
               start = 2015,
               end = c(2020,7),
               frequency = 12)

plot(gold.test,
     xlab = "Time",
     ylab = "Gold Price (USD)",
     main = "Test Dataset")

length(gold.test)

# ----------------------------------------------------------
# Check Stationarity of the Training Series
# ----------------------------------------------------------
library(tseries)

# Augmented Dickey-Fuller Test
adf.test(gold.train)

# Store training observations for ACF/PACF
train = gold.csv$Price[241:780]

# ACF and PACF plots
acf(train,
    main = "ACF of Training Dataset")

pacf(train,
     main = "PACF of Training Dataset")

# ----------------------------------------------------------
# First Order Differencing
# ----------------------------------------------------------
differenced_series1 = diff(gold.train, differences = 1)

plot(differenced_series1,
     main = "First Order Differenced Series",
     xlab = "Time",
     ylab = "Differenced Gold Price")

# Check stationarity after first differencing
adf.test(differenced_series1)

acf(differenced_series1,
    main = "ACF of First Order Differenced Series")

# ----------------------------------------------------------
# Second Order Differencing
# ----------------------------------------------------------
differenced_series2 = diff(gold.train, differences = 2)

plot(differenced_series2,
     main = "Second Order Differenced Series",
     xlab = "Time",
     ylab = "Differenced Gold Price")

adf.test(differenced_series2)

acf(differenced_series2,
    main = "ACF of Second Order Differenced Series")

# ----------------------------------------------------------
# Model Selection using Auto ARIMA
# ----------------------------------------------------------
library(forecast)

model = auto.arima(gold.train)

summary(model)

# ----------------------------------------------------------
# Fitted Values
# ----------------------------------------------------------
fitted_values = fitted(model)

plot(gold.train,
     main = "Actual vs Fitted Values",
     xlab = "Time",
     ylab = "Gold Price (USD)")

lines(fitted_values, col = "red")

legend("topleft",
       legend = c("Actual","Fitted"),
       col = c("black","red"),
       lty = 1)

# ----------------------------------------------------------
# Residual Diagnostics
# ----------------------------------------------------------
model.residual = residuals(model)

plot(model.residual,
     main = "Residual Plot",
     xlab = "Time",
     ylab = "Residuals")

plot(fitted_values,
     model.residual,
     main = "Residuals vs Fitted Values",
     xlab = "Fitted Values",
     ylab = "Residuals")

acf(model.residual,
    main = "ACF of Residuals")

qqnorm(model.residual)
qqline(model.residual)

# ----------------------------------------------------------
# Runs Test for Randomness of Residuals
# ----------------------------------------------------------
library(randtests)

runs.test(model.residual)

# If residuals are random, the ARIMA model is considered adequate.

# ----------------------------------------------------------
# Forecast Future Gold Prices
# ----------------------------------------------------------
forecast1 = forecast(model,
                     h = length(gold.test))

forecast1

# Extract forecasted values
pred_val = ts(as.data.frame(forecast1)[,1],
              start = 2015,
              end = c(2020,7),
              frequency = 12)

# Extract confidence intervals
ci1 = ts(as.data.frame(forecast1)[,4],
         start = 2015,
         end = c(2020,7),
         frequency = 12)

ci2 = ts(as.data.frame(forecast1)[,5],
         start = 2015,
         end = c(2020,7),
         frequency = 12)

# ----------------------------------------------------------
# Plot Forecast against Test Data
# ----------------------------------------------------------
plot(gold.test,
     ylim = c(0,2500),
     main = "Forecasted vs Actual Gold Prices",
     xlab = "Time",
     ylab = "Gold Price (USD)")

lines(pred_val, col = "red")
lines(ci1, col = "green")
lines(ci2, col = "blue")

legend("topright",
       legend = c("Actual",
                  "Forecast",
                  "Upper Confidence Limit",
                  "Lower Confidence Limit"),
       col = c("black","red","blue","green"),
       lty = 1)

# ----------------------------------------------------------
# Model Performance Evaluation
# ----------------------------------------------------------

# Mean Absolute Percentage Error (MAPE)
et = gold.test - pred_val

mape = sum(abs(et / gold.test) * 100) / length(gold.test)
mape

# Root Mean Squared Error (RMSE)
rmse = sqrt(mean((gold.test - pred_val)^2))
rmse

# ==========================================================
# End of Analysis
# ==========================================================
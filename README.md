# Gold Price Forecasting using Time Series Analysis

> **B.Sc. Dissertation Project**

This project was completed as part of my Bachelor of Science in Statistics at **St. Xavier's College (Autonomous), Kolkata** under the guidance of **Prof. Pallabi Ghosh**. The objective of this study is to forecast monthly gold prices using classical time series techniques in **R**, with a focus on ARIMA modeling.

---

## Project Overview

Gold prices exhibit long-term trends and fluctuations influenced by various economic factors. This project analyzes historical monthly gold prices and develops an ARIMA model to forecast future prices. The model is evaluated using standard forecasting metrics and residual diagnostics.

---

## Dataset

- **Dataset:** Monthly Gold Prices (USD)
- **Period:** January 1970 – July 2020
- **Frequency:** Monthly
- **Source:** https://datahub.io/AcckiyGerman/gold-prices

---

## Objectives

- Analyze historical monthly gold price data
- Perform stationarity testing using the Augmented Dickey-Fuller (ADF) Test
- Identify suitable ARIMA model parameters
- Forecast future gold prices
- Evaluate forecasting performance using RMSE and MAPE

---

## Methodology

1. Data Collection
2. Exploratory Data Analysis
3. Train-Test Split
4. Stationarity Testing (ADF Test)
5. Differencing
6. ACF & PACF Analysis
7. ARIMA Model Selection
8. Residual Diagnostics
9. Forecasting
10. Model Evaluation

---

## Tools & Libraries

- R
- forecast
- tseries
- randtests
- stats

---

## Model Performance

| Metric | Value |
|---------|--------|
| Best Model | ARIMA(1,1,1) |
| RMSE | 131.10 |
| MAPE | 6.14% |

---

## Repository Structure

```
Gold-Price-Forecasting-Time-Series/
│
├── Gold_Price_Forecasting.R
├── README.md
├── LICENSE
├── .gitignore
│
├── data/
│   └── monthly_csv.csv
│
├── figures/
│   ├── forecast_vs_actual.png
│   ├── acf_training.png
│   ├── pacf_training.png
│   └── residual_plot.png
│
└── report/
    └── Gold_Price_Forecasting_Dissertation.pdf
```

---

## How to Run

1. Clone this repository.

```bash
git clone https://github.com/soham-1018/Gold-Price-Forecasting-Time-Series.git
```

2. Open `Gold_Price_Forecasting.R` in RStudio.

3. Install the required packages.

```r
install.packages(c("forecast", "tseries", "randtests"))
```

4. Run the script.

---

## Results

The ARIMA(1,1,1) model successfully captured the underlying trend in the historical gold price series. Forecasted values closely matched the test data, achieving a Mean Absolute Percentage Error (MAPE) of approximately **6.14%**, demonstrating good short-term forecasting performance.

---

## Report

The complete B.Sc. dissertation report is available in the **report/** directory.

---

## Author

**Soham Choudhury**

M.Sc. Statistics & Computing  
Banaras Hindu University

GitHub: https://github.com/soham-1018

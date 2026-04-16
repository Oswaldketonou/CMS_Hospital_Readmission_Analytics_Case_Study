
# ------------------------------------------------------------
# CMS Hospital Readmission Analytics
# 03_cms_linear_model.R
# Author:Waldo Ketonou
# Step 5 — Linear Regression (Interpretability First)
# ------------------------------------------------------------

# 01_setup_and_load.R ----------------------------------------

rm(list = ls())

library(tidyverse)
library(rsample)
library(janitor)
library(yardstick)
library(lmtest)
library(car)
library(broom)

data_path <- "data/processed/cms_modeling_dataset.csv"

cms_mod <- readr::read_csv(data_path) |>
  janitor::clean_names()

glimpse(cms_mod)


# 02_factor_handling.R ----------------------------------------

cms_mod <- cms_mod |>
  mutate(
    city               = as.factor(city),
    state              = as.factor(state),
    county_name        = as.factor(county_name),
    state_region       = as.factor(state_region),
    hospital_type      = as.factor(hospital_type),
    hospital_ownership = as.factor(hospital_ownership),
    emergency_services = factor(emergency_services, levels = c(FALSE, TRUE))
  )

summary(cms_mod$readmission_index)
summary(select(cms_mod, mortality_index, patient_experience_score, timely_effective_care_score))


# 03_train_test_split.R ---------------------------------------

set.seed(123)

split_obj <- initial_split(
  cms_mod,
  prop = 0.8,
  strata = state_region
)

train_data <- training(split_obj)
test_data  <- testing(split_obj)

nrow(train_data); nrow(test_data)


# 04_baseline_model.R -----------------------------------------

baseline_mean <- mean(train_data$readmission_index)

baseline_preds <- tibble(
  truth = test_data$readmission_index,
  pred  = baseline_mean
)

baseline_rmse <- yardstick::rmse(baseline_preds, truth, pred)$.estimate
baseline_mae  <- yardstick::mae(baseline_preds, truth, pred)$.estimate

baseline_rmse
baseline_mae


# 05_linear_model.R -------------------------------------------

lm_formula <- readmission_index ~
  hospital_ownership +
  emergency_services +
  state_region +
  state +
  mortality_index +
  patient_experience_score +
  timely_effective_care_score

lm_fit <- lm(lm_formula, data = train_data)

summary(lm_fit)


# Predictions on clean test set
test_data_clean <- test_data

lm_preds <- tibble(
  truth = test_data_clean$readmission_index,
  pred  = predict(lm_fit, newdata = test_data_clean)
)

# Metrics
lm_rmse <- yardstick::rmse(lm_preds, truth, pred)$.estimate
lm_mae  <- yardstick::mae(lm_preds, truth, pred)$.estimate

lm_rmse
lm_mae


# 05_linear_model_continued.R ---------------------------------
# Assumption checks, diagnostics, coefficients, storage

# Diagnostic plots
plot(lm_fit, which = 1)
plot(lm_fit, which = 2)
plot(lm_fit, which = 3)
plot(lm_fit, which = 5)

# Extract residuals and fitted values
lm_residuals <- resid(lm_fit)
lm_fitted    <- fitted(lm_fit)

# Normality test
shapiro.test(lm_residuals)

# Heteroscedasticity test
bptest(lm_fit)

# VIF (numeric predictors only)
lm_numeric <- lm(
  readmission_index ~ 
    mortality_index +
    patient_experience_score +
    timely_effective_care_score,
  data = train_data
)

vif(lm_numeric)

# Save diagnostic plots
dir.create("visuals/model_diagnostics", recursive = TRUE, showWarnings = FALSE)

png("visuals/model_diagnostics/lm_residuals_vs_fitted.png", width = 900, height = 700)
plot(lm_fit, which = 1)
dev.off()

png("visuals/model_diagnostics/lm_qqplot.png", width = 900, height = 700)
plot(lm_fit, which = 2)
dev.off()

png("visuals/model_diagnostics/lm_scale_location.png", width = 900, height = 700)
plot(lm_fit, which = 3)
dev.off()

png("visuals/model_diagnostics/lm_residuals_vs_leverage.png", width = 900, height = 700)
plot(lm_fit, which = 5)
dev.off()


# Coefficients
lm_coefs <- tidy(lm_fit)
lm_coefs

# Ranked drivers
lm_coefs_ranked <- lm_coefs |>
  filter(term != "(Intercept)") |>
  arrange(desc(abs(estimate)))

lm_coefs_ranked


# Store results for Step 7 evaluation
lm_results <- tibble(
  model          = "Linear Regression",
  rmse           = lm_rmse,
  mae            = lm_mae,
  r_squared      = summary(lm_fit)$r.squared,
  adj_r_squared  = summary(lm_fit)$adj.r.squared
)

lm_results

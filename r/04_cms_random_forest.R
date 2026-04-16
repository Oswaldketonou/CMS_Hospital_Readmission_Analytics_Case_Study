############################################################
# 04_cms_random_forest.R
# CMS Hospital Readmission Analytics
# Author : Waldo Ketonou
# Step 6 — Random Forest Modeling (ranger)
############################################################

library(tidyverse)
library(ranger)
library(yardstick)
library(broom)

############################################################
# 6.1 — Confirm training and test objects
############################################################

# These objects must already exist from:
# 01_setup_and_load.R
# 02_factor_handling.R
# 03_train_test_split.R

ls()
glimpse(train_data)
glimpse(test_data)

############################################################
# 6.2 — Define Random Forest formula
############################################################

rf_formula <- readmission_index ~
  hospital_ownership +
  emergency_services +
  state_region +
  state +
  mortality_index +
  patient_experience_score +
  timely_effective_care_score

rf_formula

############################################################
# 6.3 — Fit Random Forest model
############################################################

set.seed(123)

rf_fit <- ranger(
  formula      = rf_formula,
  data         = train_data,
  num.trees    = 200,
  mtry         = NULL,          # default: sqrt(p)
  importance   = "impurity",
  num.threads  = 1,
  seed         = 123
)

rf_fit

############################################################
# 6.4 — Generate predictions on test set
############################################################

rf_preds <- tibble(
  truth = test_data$readmission_index,
  pred  = predict(rf_fit, data = test_data)$predictions
)

glimpse(rf_preds)

############################################################
# 6.5 — Compute performance metrics
############################################################

rf_rmse <- yardstick::rmse(rf_preds, truth, pred)$.estimate
rf_mae  <- yardstick::mae(rf_preds, truth, pred)$.estimate

rf_rmse
rf_mae

############################################################
# 6.6 — Extract variable importance
############################################################

rf_importance <- rf_fit$variable.importance %>%
  enframe(name = "feature", value = "importance") %>%
  arrange(desc(importance))

rf_importance

############################################################
# 6.7 — Plot and save variable importance
############################################################

dir.create("visuals/random_forest", recursive = TRUE, showWarnings = FALSE)

rf_importance_top20 <- rf_importance %>%
  slice_max(order_by = importance, n = 20)

rf_importance_top20

png("visuals/random_forest/rf_variable_importance.png", width = 900, height = 700)
rf_importance_top20 %>%
  ggplot(aes(x = reorder(feature, importance), y = importance)) +
  geom_col(fill = "#2C3E50") +
  coord_flip() +
  labs(
    title = "Random Forest Variable Importance",
    x = "Feature",
    y = "Importance"
  ) +
  theme_minimal()
dev.off()

############################################################
# 6.8 — Store results for Step 7 evaluation
############################################################

rf_results <- tibble(
  model = "Random Forest",
  rmse  = rf_rmse,
  mae   = rf_mae
)

rf_results

############################################################
# 06 — SCENARIO SIMULATION (WHAT‑IF ANALYSIS)
# CMS Hospital Readmission Analytics
# Author : Waldo Ketonou
# Linear Regression + Random Forest
############################################################

library(tidyverse)

############################################################
# 1 — Confirm required model objects exist
############################################################

ls()

glimpse(test_data)

# Ensure factor levels match training data
test_data$hospital_ownership <- factor(
  test_data$hospital_ownership,
  levels = levels(train_data$hospital_ownership)
)

test_data$emergency_services <- factor(
  test_data$emergency_services,
  levels = levels(train_data$emergency_services)
)

############################################################
# 2 — Define core scenarios
############################################################

scenarios <- tribble(
  ~scenario,                     ~variable,                     ~change_type, ~value,
  "TEC +10%",                    "timely_effective_care_score", "multiply",    "1.10",
  "Mortality -5%",               "mortality_index",             "multiply",    "0.95",
  "Patient Experience +1 point", "patient_experience_score",    "add",         "1",
  "Ownership → Physician",       "hospital_ownership",          "set",         "Physician",
  "Emergency Services → TRUE",   "emergency_services",          "set",         "TRUE"
)

scenarios

############################################################
# 3 — Helper function to apply scenario
############################################################

apply_scenario <- function(data, variable, change_type, value) {
  data_mod <- data
  
  if (change_type %in% c("multiply", "add")) {
    value <- as.numeric(value)
  }
  
  if (change_type == "set" && value %in% c("TRUE", "FALSE")) {
    value <- as.logical(value)
  }
  
  if (change_type == "multiply") {
    data_mod[[variable]] <- data_mod[[variable]] * value
  }
  
  if (change_type == "add") {
    data_mod[[variable]] <- data_mod[[variable]] + value
  }
  
  if (change_type == "set") {
    data_mod[[variable]] <- value
  }
  
  if (variable == "hospital_ownership") {
    data_mod[[variable]] <- factor(
      data_mod[[variable]],
      levels = levels(train_data$hospital_ownership)
    )
  }
  
  if (variable == "emergency_services") {
    data_mod[[variable]] <- factor(
      data_mod[[variable]],
      levels = levels(train_data$emergency_services)
    )
  }
  
  return(data_mod)
}

############################################################
# 4 — Predict using both models
############################################################

predict_both_models <- function(data) {
  tibble(
    lm_pred = predict(lm_fit, newdata = data),
    rf_pred = predict(rf_fit, data = data)$predictions
  )
}

############################################################
# 5 — Run all scenarios
############################################################

scenario_results <- scenarios %>%
  rowwise() %>%
  mutate(
    data_mod = list(apply_scenario(test_data, variable, change_type, value)),
    preds    = list(predict_both_models(data_mod)),
    truth    = list(test_data$readmission_index)
  ) %>%
  unnest(c(preds, truth)) %>%
  mutate(
    lm_delta = lm_pred - truth,
    rf_delta = rf_pred - truth
  )

scenario_results

############################################################
# 6 — Summaries for Tableau
############################################################

scenario_summary <- scenario_results %>%
  group_by(scenario) %>%
  summarise(
    lm_mean_delta = mean(lm_delta),
    rf_mean_delta = mean(rf_delta),
    lm_mean_pred  = mean(lm_pred),
    rf_mean_pred  = mean(rf_pred)
  )

scenario_summary

############################################################
# 7 — Export for Tableau
############################################################

dir.create("data/exports", recursive = TRUE, showWarnings = FALSE)

write_csv(scenario_results, "data/exports/scenario_results_detailed.csv")
write_csv(scenario_summary, "data/exports/scenario_summary.csv")

scenario_summary

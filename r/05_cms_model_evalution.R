############################################################
# 05 — MODEL EVALUATION
# CMS Hospital Readmission Analytics
# Author : Waldo Ketonou
# Baseline vs Linear Regression vs Random Forest
############################################################

library(tidyverse)
library(yardstick)

############################################################
# 5.1 — Confirm required objects exist
############################################################

ls()

baseline_rmse
baseline_mae
lm_results
rf_results

############################################################
# 5.2 — Combine results into a single comparison table
############################################################

model_comparison <- tibble(
  model = c("Baseline", "Linear Regression", "Random Forest"),
  rmse  = c(baseline_rmse, lm_results$rmse, rf_results$rmse),
  mae   = c(baseline_mae,  lm_results$mae,  rf_results$mae)
)

model_comparison

############################################################
# 5.3 — Rank models by RMSE and MAE
############################################################

model_rank_rmse <- model_comparison %>%
  arrange(rmse)

model_rank_mae <- model_comparison %>%
  arrange(mae)

model_rank_rmse
model_rank_mae

############################################################
# 5.4 — Visual comparison
############################################################

dir.create("visuals/model_evaluation", recursive = TRUE, showWarnings = FALSE)

png("visuals/model_evaluation/model_rmse_comparison.png", width = 900, height = 700)
model_comparison %>%
  ggplot(aes(x = reorder(model, rmse), y = rmse, fill = model)) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Model Comparison — RMSE",
    x = "Model",
    y = "RMSE"
  ) +
  theme_minimal() +
  theme(legend.position = "none")
dev.off()

png("visuals/model_evaluation/model_mae_comparison.png", width = 900, height = 700)
model_comparison %>%
  ggplot(aes(x = reorder(model, mae), y = mae, fill = model)) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Model Comparison — MAE",
    x = "Model",
    y = "MAE"
  ) +
  theme_minimal() +
  theme(legend.position = "none")
dev.off()

############################################################
# 5.5 — Export evaluation table for Tableau
############################################################

dir.create("data/exports", recursive = TRUE, showWarnings = FALSE)

write_csv(model_comparison, "data/exports/model_comparison.csv")

model_comparison

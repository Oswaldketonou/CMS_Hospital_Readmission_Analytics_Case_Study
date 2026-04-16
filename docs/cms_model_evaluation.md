# CMS Hospital Readmission Analytics  
## Model Evaluation (Baseline vs Linear Regression vs Random Forest)

This document summarizes the full evaluation workflow for comparing three models used to predict **readmission_index**:

- **Baseline Model** (mean-only benchmark)  
- **Linear Regression Model**  
- **Random Forest Model**

All evaluation steps follow the unified workflow established in the project’s modeling pipeline.

---

## 1. Required Inputs

The evaluation script (`05_cms_model_evaluation.R`) assumes the following objects already exist in the environment:

- `baseline_rmse`, `baseline_mae`  
- `lm_results` (list containing `rmse`, `mae`, `r_squared`, `adj_r_squared`)  
- `rf_results` (list containing `rmse`, `mae`)  

These objects are produced by earlier steps:

- **03_cms_baseline_model.R**  
- **04_cms_linear_model.R**  
- **04_cms_random_forest.R**

---

## 2. Combined Model Comparison Table

A unified tibble is constructed to compare RMSE and MAE across all models:

| Model              | RMSE | MAE |
|-------------------|------|-----|
| Baseline          | baseline_rmse | baseline_mae |
| Linear Regression | lm_results$rmse | lm_results$mae |
| Random Forest     | rf_results$rmse | rf_results$mae |

This table is the foundation for ranking, visualization, and Tableau export.

---

## 3. Model Ranking

Two ranking tables are generated:

- **RMSE Ranking** — lower values indicate better predictive accuracy  
- **MAE Ranking** — lower values indicate better average error magnitude  

These rankings provide a quick, interpretable view of model performance.

---

## 4. Visual Evaluation

Two bar charts are generated and saved to:
visuals/model_evaluation/

            ├── model_rmse_comparison.png
                     
            └── model_mae_comparison.png

Visuals include:

- **RMSE Comparison Plot**  
- **MAE Comparison Plot**

Both use consistent styling (`theme_minimal()`) and flipped coordinates for readability.

---

## 5. Tableau Export

The final comparison table is exported to:
data/exports/model_comparison.csv

This file is used directly in the Tableau dashboard for:

- Model performance visualization  
- Cross-model comparison  
- Executive‑level reporting  

---

## 6. Interpretation Summary

- The **Baseline Model** provides a reference point for evaluating predictive lift.  
- **Linear Regression** offers interpretability and typically improves over baseline.  
- **Random Forest** captures nonlinear relationships and often reduces error further.  

The evaluation workflow ensures that all models are assessed consistently using the same metrics, ranking logic, and export structure.

---
and is part of the unified modeling pipeline:

1. 01_healthcare_aligned_eda.R  
2. 02_modeling_dataset.R  
3. 03_cms_linear_model.R  
4. 04_cms_random_forest.R  
5. **05_cms_model_evaluation.R**  

---

**Author:** Waldo Ketonou  
**Project:** CMS Hospital Readmission Analytics






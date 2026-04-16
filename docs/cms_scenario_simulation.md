# CMS Hospital Readmission Analytics  
## Scenario Simulation (What‑If Analysis)

This document describes the scenario simulation workflow used to evaluate how changes in key CMS hospital quality metrics influence predicted **readmission_index**. The simulation engine applies controlled modifications to the test dataset and generates predictions using **both** the Linear Regression and Random Forest models.

---

## 1. Purpose of Scenario Simulation

Scenario simulation enables stakeholders to explore how targeted improvements—or declines—in hospital performance metrics may affect readmission outcomes. This supports:

- Strategic planning  
- Quality improvement initiatives  
- Executive decision‑making  
- Sensitivity analysis for model behavior  

The simulation engine is fully reproducible and aligned with the project’s modeling pipeline.

---

## 2. Required Inputs

The script (`06_scenario_simulation.R`) assumes the following objects already exist:

- `lm_fit` — trained linear regression model  
- `rf_fit` — trained random forest model  
- `test_data` — cleaned test dataset  
- `train_data` — used to enforce factor levels for categorical variables  

Factor alignment is enforced to prevent prediction errors and ensure consistency across models.

---

## 3. Defined Scenarios

Five core scenarios are implemented:

| Scenario                       | Variable                     | Change Type | Value     |
|-------------------------------|------------------------------|-------------|-----------|
| TEC +10%                      | timely_effective_care_score  | multiply    | 1.10      |
| Mortality -5%                 | mortality_index              | multiply    | 0.95      |
| Patient Experience +1 point   | patient_experience_score     | add         | 1         |
| Ownership → Physician         | hospital_ownership           | set         | Physician |
| Emergency Services → TRUE     | emergency_services           | set         | TRUE      |

These scenarios represent realistic operational or policy‑driven changes hospitals may consider.

---

## 4. Scenario Application Logic

A helper function applies each scenario to the test dataset by:

- Multiplying or adding numeric changes  
- Setting categorical variables to new values  
- Enforcing factor levels for:
  - `hospital_ownership`
  - `emergency_services`

This ensures compatibility with both models and prevents factor‑level mismatch errors.

---

## 5. Dual‑Model Prediction Engine

For each scenario, predictions are generated using:

- **Linear Regression** (`lm_pred`)  
- **Random Forest** (`rf_pred`)  

The script attaches the true readmission values (`truth`) before unnesting to maintain row alignment.

Delta values are computed:

- `lm_delta = lm_pred - truth`  
- `rf_delta = rf_pred - truth`  

These quantify how each scenario shifts predicted readmission performance.

---

## 6. Scenario Summary for Tableau

A summary table is produced:

| Metric              | Description |
|---------------------|-------------|
| `lm_mean_delta`     | Avg. change in LM predictions |
| `rf_mean_delta`     | Avg. change in RF predictions |
| `lm_mean_pred`      | Avg. LM predicted readmission |
| `rf_mean_pred`      | Avg. RF predicted readmission |

This table is used directly in Tableau dashboards to visualize scenario impacts.

---

## 7. Exported Outputs

Two CSV files are exported:
data/exports/scenario_results_detailed.csv
data/exports/scenario_summary.csv

- **scenario_results_detailed.csv** — row‑level predictions and deltas  
- **scenario_summary.csv** — aggregated scenario impacts  

These files support downstream reporting and interactive visualization.

---

## 8. Script Reference

This documentation corresponds to:
/R/06_scenario_simulation.R

and fits into the modeling workflow:

1. 01_healthcare_aligned_eda.R  
2. 02_modeling_dataset.R  
3. 03_cms_linear_model.R  
4. 04_cms_random_forest.R  
5. 05_cms_model_evaluation.R  
6. **06_scenario_simulation.R**

---

**Author:** Waldo Ketonou  
**Project:** CMS Hospital Readmission Analytics





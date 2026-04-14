# r_modeling_strategy.md  
CMS Hospital Readmission Modeling Project  
Author: Waldo Ketonou  

## Purpose  
This document defines the modeling strategy for predicting hospital readmission performance using the CMS Hospital Quality dataset. It serves as the bridge between the modeling‑ready dataset and the R modeling scripts, ensuring clarity, reproducibility, and alignment with the project’s business objectives.

## Modeling Objective  
Predict hospital readmission performance using the ERR‑based `readmission_index` metric.  
The model should:  
- Identify key drivers of readmission performance  
- Support scenario simulation  
- Provide interpretable, business‑aligned insights  
- Integrate cleanly into the R modeling workflow and Tableau dashboards  

## Target Variable  
**readmission_index**  
- Continuous ERR‑based measure  
- Lower values indicate better performance  
- Only hospitals with valid CMS ERR reporting are included  

## Feature Set  
The following predictors are used in the modeling workflow:

### Hospital Characteristics  
- hospital_type  
- hospital_ownership  
- emergency_services  

### Geography  
- state_region  
- state  
- county_name  

### Quality & Performance Indicators  
- mortality_index  
- patient_experience_score  
- timely_effective_care_score  

All categorical variables are encoded as factors in R.  
All numeric variables remain continuous.

## Modeling Approach  
The modeling workflow will evaluate multiple algorithms to balance interpretability and predictive performance:

### Baseline Model  
- Mean‑only baseline for MAE/RMSE comparison  

### Candidate Models  
- Linear Regression  
- Regularized Regression (LASSO, Ridge, Elastic Net)  
- Random Forest (via `ranger`)  
- Gradient Boosted Trees (XGBoost or LightGBM)  

## Random Forest & OOB Error  
Random Forest models trained with `ranger` will use **Out‑of‑Bag (OOB) error** as an internal validation metric.  
- OOB error is computed automatically by `ranger`  
- Provides an unbiased estimate of model performance  
- Complements the train/test split  
- Helps assess model stability and generalization  
- Used alongside RMSE/MAE for model comparison  

OOB error will be included in the model evaluation summary and stored with model artifacts.

## Data Splitting  
- 80% training  
- 20% testing  
- Stratified by state_region to preserve geographic distribution  

## Evaluation Metrics  
Primary:  
- RMSE  
- MAE  

Secondary:  
- R²  
- Feature importance (model‑specific)  
- Residual diagnostics  
- OOB error (Random Forest only)  

## Assumptions & Constraints  
- CMS ERR is a stable and reliable target metric  
- Missingness has been resolved upstream  
- No hospital‑level temporal data is available  
- Interpretability is required for business stakeholders  

## Modeling Workflow in R  
1. Load modeling dataset (`cms_modeling_dataset.csv`)  
2. Convert categorical variables to factors  
3. Split into training/testing sets  
4. Train baseline model  
5. Train candidate models  
6. Capture OOB error for Random Forest  
7. Evaluate performance  
8. Select final model  
9. Save model objects to `models/`  
10. Generate evaluation outputs for Tableau  

## Output Artifacts  
- Trained model objects (`.rds`)  
- Model performance summary  
- OOB error report (Random Forest)  
- Feature importance tables  
- Residual diagnostics  
- Scenario simulation inputs  

## File Location  
This document is stored in:  
`/docs/r_modeling_strategy.md`

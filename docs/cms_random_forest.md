# CMS Hospital Readmission Analytics 
## Step 6 — Random Forest Modeling (ranger)

### Overview  
This document summarizes the Random Forest modeling workflow used to predict the CMS Hospital-Wide All-Cause Unplanned Readmission Rate. The Random Forest model serves as the performance-oriented complement to the linear regression model, capturing non-linear relationships and interactions between hospital characteristics, quality metrics, and regional factors.

---

## 6.1 — Data Inputs  
The model uses the cleaned and preprocessed training and test datasets produced in:

- 01_setup_and_load.R  
- 02_factor_handling.R  
- 03_train_test_split.R  

Target variable:  
- **readmission_index**

Predictor variables:  
- hospital_ownership  
- emergency_services  
- state_region  
- state  
- mortality_index  
- patient_experience_score  
- timely_effective_care_score  

These features represent structural, operational, and quality-of-care dimensions relevant to CMS readmission performance.

---

## 6.2 — Model Specification  
The Random Forest model is implemented using the **ranger** package.

Configuration:

- **num.trees = 200**  
- **mtry = sqrt(p)** (default)  
- **importance = "impurity"**  
- **num.threads = 1**  
- **seed = 123**

The model formula includes all selected predictors. Random Forest automatically captures non-linearities and interactions without requiring manual feature engineering.

---

## 6.3 — Model Performance  
Predictions were generated on the held-out test set. Performance was evaluated using RMSE and MAE from the yardstick package.

Final metrics:

- **RMSE:** 0.0565  
- **MAE:** 0.0374  

These values outperform both the baseline model and the linear regression model, confirming that Random Forest captures additional structure in the data.

---

## 6.4 — Variable Importance  
Variable importance was extracted from the fitted model and ranked in descending order. The top 20 features were visualized and exported to:
visuals/random_forest/rf_variable_importance.png

High-importance predictors typically include:

- mortality_index  
- patient_experience_score  
- timely_effective_care_score  
- state_region  
- hospital_ownership  

These results align with CMS research indicating that both quality-of-care metrics and structural characteristics influence readmission outcomes.

---

## 6.5 — Outputs for Step 7  
The following objects are produced for downstream evaluation:

- **rf_fit** — trained Random Forest model  
- **rf_preds** — predictions on the test set  
- **rf_importance** — ranked variable importance table  
- **rf_results** — RMSE and MAE packaged for model comparison  

These outputs feed directly into Step 7, where all models are evaluated side-by-side.

---

## Summary  
The Random Forest model provides strong predictive performance and valuable insights into feature importance. Its ability to model non-linear relationships makes it a critical component of the overall modeling strategy, complementing the interpretability of the linear regression model and supporting the scenario simulation work in Step 9.



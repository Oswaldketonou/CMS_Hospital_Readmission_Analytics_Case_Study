# CMS Linear Regression Model  
**File:** cms_linear_model.md  
**Project:** CMS Hospital Readmission Analytics  
**Author:** Waldo Ketonou  

---

## 📘 Overview  
This document summarizes the development, diagnostics, and results of the **base linear regression model** used to predict hospital readmission performance. The model is designed to be **interpretable**, **healthcare‑aligned**, and fully consistent with the Snowflake → R → Tableau workflow.

The linear model represents **Step 5** of the modeling pipeline and serves as the primary interpretable benchmark before introducing ensemble methods (Random Forest).

---

## 📦 1. Data Loading & Preparation  
The modeling dataset was loaded from:
data/processed/cms_modeling_dataset.csv

Preparation steps included:

- Cleaning column names  
- Converting categorical variables to factors  
- Ensuring consistent TRUE/FALSE encoding  
- Running sanity checks on engineered quality metrics  

These steps ensure the dataset is **model‑ready** and aligned with the Snowflake SQL engineering pipeline.

---

## 🧪 2. Train/Test Split  
A stratified 80/20 split was performed using `state_region` to preserve geographic distribution.

- **Training set:** 80%  
- **Testing set:** 20%  
- **Stratification:** state_region  
- **Seed:** 123  

This ensures fair evaluation and prevents geographic imbalance.

---

## 🎯 3. Baseline Model  
Before fitting the linear model, a baseline predictor was created:

> Predict the **mean readmission_index** for all hospitals.

**Baseline performance:**

- **RMSE:** `baseline_rmse`  
- **MAE:** `baseline_mae`  

This establishes the minimum performance any model must exceed.

---

## 📈 4. Linear Regression Model  
The model predicts **readmission_index** using:

- **Hospital characteristics**  
  - hospital_ownership  
  - emergency_services  

- **Geographic context**  
  - state_region  
  - state  

- **Engineered quality metrics**  
  - mortality_index  
  - patient_experience_score  
  - timely_effective_care_score  

This formula aligns with CMS literature and the project narrative.

---

## 📊 5. Model Performance  
After predicting on the clean test set:

| Metric | Value |
|--------|--------|
| **RMSE** | 0.0582 |
| **MAE** | 0.0376 |
| **R²** | 0.115 |
| **Adjusted R²** | 0.0883 |

### Interpretation  
- The model explains **~11.5%** of variation in readmission performance.  
- This is expected for hospital‑level CMS data, where patient‑level factors are not included.  
- Error metrics indicate stable, reasonable predictive performance for an interpretable model.

---

## 🔍 6. Model Diagnostics  

### ✔ Linearity  
Residuals vs Fitted plot shows no major violations.

### ✔ Normality  
Q‑Q plot indicates mild deviation but acceptable for healthcare data.

### ✔ Homoscedasticity  
Breusch‑Pagan test indicates slight heteroscedasticity — common in CMS datasets.

### ✔ Influence Points  
Residuals vs Leverage plot identified three influential hospitals (IDs: 904, 508, 509).  
These are **valid observations** and remain in the dataset.

### ✔ Multicollinearity  
VIF was computed **only for numeric predictors**, as categorical variables with many levels produce aliased coefficients.

All numeric predictors show acceptable VIF values.

### 📁 Saved Diagnostics  
All diagnostic plots were saved to:
visuals/model_diagnostics/

---

## 🧠 7. Coefficient Insights  
Coefficients were ranked by absolute effect size.

### Key findings:

#### **1. State‑level effects dominate**  
Reflecting system‑level differences in care delivery and population health.

#### **2. Region matters**  
`state_regionSouth` shows a positive association with readmissions.

#### **3. Ownership effect**  
Physician‑owned hospitals show **significantly lower** readmission rates.

#### **4. Quality metrics**  
Mortality, patient experience, and TEC scores contribute meaningfully but with smaller effect sizes.


---

## 🧾 8. Stored Model Summary  
A structured tibble was created for downstream evaluation:

```r
lm_results <- tibble(
  model          = "Linear Regression",
  rmse           = lm_rmse,
  mae            = lm_mae,
  r_squared      = summary(lm_fit)$r.squared,
  adj_r_squared  = summary(lm_fit)$adj.r.squared
)



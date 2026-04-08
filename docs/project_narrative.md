# 🏥 CMS Hospital Readmission Analytics
**SQL • R • Tableau • Healthcare Quality Metrics**

This case study analyzes **CMS Hospital Quality** data to identify the key drivers of **hospital readmission performance**. Using Snowflake SQL for data engineering, R for predictive modeling, and Tableau for visualization, the project demonstrates a complete end‑to‑end healthcare analytics workflow aligned with real industry practices.

---

## 📌 Project Objective
Identify which hospital quality factors most influence **readmission rates**, build an interpretable predictive model, and deliver actionable insights that support hospital performance improvement and operational decision‑making.

---

## 🗂️ Data Source
**Centers for Medicare & Medicaid Services (CMS)**  
- Hospital Readmissions Reduction Program (HRRP)  
- Hospital Compare Quality Measures  
- Mortality Measures  
- Patient Experience (HCAHPS) Scores  
- Timely & Effective Care (TEC) Measures  
- Hospital General Information  

These datasets are publicly available and widely used in healthcare quality reporting and reimbursement programs.

---

## 🧭 Workflow Overview
This project follows a structured, bounded workflow to ensure clarity, reproducibility, and analytical rigor:

1. **Snowflake SQL Data Engineering & Feature Engineering**  
2. **R Modeling & Evaluation**  
3. **Tableau Dashboard Development**  
4. **Scenario Simulation & Business Impact Analysis**  
5. **Case Study Write‑Up**

---

# 🗄️ 1. Snowflake SQL Data Engineering & Feature Engineering
All data preparation was performed in **Snowflake** to ensure scalability, reproducibility, and clean separation of pipeline stages.

### ✔ Pipeline Structure
The SQL workflow is organized into five sequential scripts:

1. **01_cms_snowflake_pipeline.sql**  
   Creates database, schema, stages, and file formats for CMS ingestion.

2. **02_snowflake_data_preparation.sql**  
   Loads raw CMS datasets, standardizes fields, cleans identifiers, and prepares base tables.

3. **03_snowflake_data_validation.sql**  
   Performs row count checks, duplicate checks, NULL analysis, and numeric range validation.

4. **04_snowflake_data_modeling.sql**  
   Creates modeling‑ready tables and prepares unified structures for feature engineering.

5. **05_cms_snowflake_feature_engineering.sql**  
   Builds engineered quality metrics across multiple CMS domains.

---

### ✔ Key Data Preparation Steps
- Standardized column names  
- Converted numeric fields  
- Cleaned facility identifiers  
- Mapped hospitals to U.S. Census regions  
- Filtered to hospitals with complete readmission data  
- Removed irrelevant or low‑value measures  
- Handled missing values using domain‑appropriate rules  

---

### ✔ Engineered Features
The project generates four major engineered feature domains:

- **Readmission Index**  
- **Mortality Index**  
- **Patient Experience Score**  
- **Timely & Effective Care (TEC) Score**  
- **Region Assignment** (Northeast, Midwest, South, West)

These features consolidate dozens of CMS measures into interpretable, modeling‑ready metrics.

---

### ✔ Final Unified Dataset
The cleaned and engineered dataset is exported as:
CMS_CLEAN_HOSPITAL_QUALITY_FINAL

This table contains:

- Hospital profile information  
- All engineered quality metrics  
- Region mapping  
- Modeling‑ready numeric fields  
- One row per hospital  

This dataset serves as the foundation for R modeling and Tableau visualization.

---

# 🤖 2. Predictive Modeling in R
A single predictive model is used to maintain interpretability and focus.

### 🎯 Target Variable
- **Readmission Rate**  
or  
- **Excess Readmission Ratio (ERR)**  

### 🧠 Model Types
- **Linear Regression** (interpretable, coefficient‑based insights)  
- **Random Forest** (performance‑oriented, feature importance)  

The goal is not to maximize accuracy, but to understand **which quality factors most influence readmissions**.

---

# 📈 3. Model Evaluation (Healthcare‑Aligned)
Model performance is evaluated using six categories of metrics:

### **1. Error‑Based Metrics**
- RMSE  
- MAE  
- SMAPE  

### **2. Goodness‑of‑Fit Metrics**
- R²  
- Adjusted R²  

### **3. Healthcare‑Specific Metrics**
- Excess Readmission Ratio (ERR)  
- Mortality Index  
- HCAHPS Patient Experience Score  

### **4. Residual Diagnostics**
- Residual plots  
- Normality check  
- Homoscedasticity  
- Influence points  

### **5. Feature Importance**
- Coefficients (linear regression)  
- Variable importance (random forest)  

### **6. Business Impact Simulation**
Example scenario:  
> “If patient experience improves by 10%, predicted readmission rate decreases by X%.”

This section translates analytics into **operational value**.

---

# 📊 4. Tableau Dashboard
A clean, recruiter‑ready dashboard visualizes hospital performance and quality metrics.

### Dashboard Views
1. **KPI Header**  
   - Avg Readmission Rate  
   - Best/Worst Performing Hospital  
   - Avg Patient Experience Score  

2. **Hospital Scorecard Table**  
   - Readmission Rate  
   - Mortality Index  
   - Patient Experience Score  
   - Region  

3. **Geographic Map**  
   - Readmission Rate by State  

4. **Scatter Plot**  
   - Patient Experience Score vs Readmission Rate  
   - Trendline + Insight Annotation  

### Filters
- State  
- Hospital Type  
- Bed Size Category  

---

# 📝 5. Key Insights (To Be Finalized After Modeling)
Preliminary expectations based on CMS literature:

- Patient experience scores often show a strong inverse relationship with readmission rates.  
- Mortality index and readmission index may be correlated, indicating systemic quality issues.  
- Regional variation suggests opportunities for targeted interventions.  

Final insights will be added after modeling.

---

# 🚀 6. Scenario Simulation (Business Impact)
Using the model, several improvement scenarios will be tested:

- A **10% increase** in patient experience score reduces predicted readmissions by **X%**.  
- Improving mortality index by **0.1** reduces readmission risk by **Y%**.  
- Hospitals in the lowest quartile could reduce penalties by **Z%** with targeted improvements.  

These simulations will be completed after modeling.

---

# 📚 7. Project Structure

├── data/

│   ├── raw/

│   └── processed/

│

├── sql/

│   ├── 01_cms_snowflake_pipeline.sql

│   ├── 02_snowflake_data_preparation.sql

│   ├── 03_snowflake_data_validation.sql

│   ├── 04_snowflake_data_modeling.sql

│   └── 05_cms_snowflake_feature_engineering.sql

│

├── r/

│   └── eda_modeling.R

│
├── tableau/

│   └── dashboard.twbx

│

├── docs/

│   └── project_narrative.md (this file)

│

---

# 👤 About the Analyst
**Waldo Ketonou**  
Business & Data Analyst | SQL • R • Tableau  
Focused on transforming healthcare operations and quality metrics into actionable insights.

---

# 📌 Status
**In Progress** — SQL engineering phase completed; modeling and dashboard phases upcoming.
└── README.md

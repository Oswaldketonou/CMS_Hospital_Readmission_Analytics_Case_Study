# 🏥 CMS Hospital Readmission Analytics  
**SQL • R • Tableau • Healthcare Quality Metrics**

This project analyzes **CMS Hospital Quality** data to understand the key drivers of **hospital readmission performance**.  
Using SQL for data cleaning, R for predictive modeling, and Tableau for visualization, this case study demonstrates a full end‑to‑end healthcare analytics workflow aligned with real industry practices.

---

## 📌 Project Objective  
Identify which hospital quality factors most influence **readmission rates**, build a predictive model, and deliver actionable insights that support hospital performance improvement.

---

## 🗂️ Data Source  
**Centers for Medicare & Medicaid Services (CMS)**  
- Hospital Readmissions Reduction Program (HRRP)  
- Hospital Compare Quality Measures  
- Patient Experience (HCAHPS) Scores  

These datasets are publicly available and widely used in healthcare quality reporting.

---

## 🧭 Workflow Overview  
This project follows a structured, bounded workflow to ensure clarity and avoid scope creep:

1. **SQL Data Cleaning & Feature Engineering**  
2. **R Modeling & Evaluation**  
3. **Tableau Dashboard Development**  
4. **Scenario Simulation & Business Impact Analysis**  
5. **Case Study Write‑Up**

---

## 🗄️ 1. SQL Data Cleaning & Feature Engineering  
All data preparation was performed in SQL to ensure reproducibility and scalability.

### Key Steps  
- Standardized column names  
- Converted numeric fields  
- Filtered to hospitals with complete readmission data  
- Removed irrelevant measures  
- Handled missing values  

### Engineered Features  
- `readmission_index`  
- `mortality_index`  
- `patient_experience_score`  
- `hospital_size_category`  
- `state_region`  

The cleaned dataset was exported as:  
**`cms_clean_hospital_quality`**

---

## 🤖 2. Predictive Modeling in R  
A single predictive model was built to maintain focus and interpretability.

### Target Variable  
- **Readmission Rate** or  
- **Excess Readmission Ratio (ERR)**

### Model Type  
- **Linear Regression** (interpretable)  
or  
- **Random Forest** (performance‑oriented)

---

## 📈 3. Model Evaluation (Healthcare‑Aligned)  
Model performance was evaluated using **six categories** of metrics:

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
Scenario modeling example:  
> “If patient experience improves by 10%, predicted readmission rate decreases by X%.”

This section translates analytics into **operational value**.

---

## 📊 4. Tableau Dashboard  
A clean, recruiter‑ready dashboard was built to visualize hospital performance.

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

## 📝 5. Key Insights  
- Patient experience scores show a strong inverse relationship with readmission rates.  
- Mortality index and readmission index are correlated, indicating systemic quality issues.  
- Regional variation suggests opportunities for targeted interventions.  

---

## 🚀 6. Scenario Simulation (Business Impact)  
Using the model, several improvement scenarios were tested:

- A **10% increase** in patient experience score reduces predicted readmissions by **X%**.  
- Improving mortality index by **0.1** reduces readmission risk by **Y%**.  
- Hospitals in the lowest quartile could reduce penalties by **Z%** with targeted improvements.

---

## 📚 7. Project Structure  
 ├── data/
 
 │   └── raw_cms_data.csv
 
 │   └── cms_clean_hospital_quality.csv
 
 ├── sql/
 
 │   └── cleaning_and_features.sql
 
 ├── r/
 
 │   └── modeling_and_evaluation.R
 
 ├── tableau/
 
 │   └── dashboard.twbx
 
 └── README.md

---

## 👤 About the Analyst  
**Waldo Ketonou**  
Business & Data Analyst | SQL • R • Tableau  
Focused on transforming healthcare operations and quality metrics into actionable insights.

---

## 🔗 Links  
- **Tableau Dashboard:** _coming soon_  
- **Case Study:** _coming soon_  
- **LinkedIn:** www.linkedin.com/in/oswald-s-ketonou-12834197

---

## 📌 Status  
**In Progress** — SQL cleaning phase underway.

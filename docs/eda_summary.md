# Exploratory Data Analysis (EDA)
CMS Hospital Quality — Readmission Modeling Project  
**Dataset:** cms_clean_hospital_quality_final.csv  
**Script:** 01_healthcare_aligned_eda.R  
**Author:** Waldo Ketonou  

This EDA follows the project narrative exactly.  
The goal is to understand **hospital readmission performance** (ERR proxy) and the **quality domains** that influence it, using a healthcare‑aligned analytical workflow.

EDA is structured into four required components:

1. Target variable exploration (readmission_index)  
2. Quality domain exploration  
3. Relationship analysis  
4. Regional variation  

All plots referenced below are saved in:  
`visuals/r_plots/eda/`

---

## 1. Target Variable: Readmission Index (ERR Proxy)

### 1.1 Missingness  
- **3,100 hospitals (57.1%)** do not have ERR values.  
- This is **expected** because CMS only reports ERR for hospitals with sufficient qualifying cases.  
- Missingness is **domain‑driven**, not a data quality issue.

### 1.2 Distribution  
- Distribution is centered at **0.999**, matching CMS national patterns.  
- Histogram saved as:  
  `readmission_index_hist.png`

### 1.3 Summary Statistics  
| Metric | Value |
|--------|-------|
| n | 5,426 |
| Missing | 3,100 |
| Mean | 0.999 |
| SD | 0.0578 |
| Min | 0.552 |
| Max | 1.31 |

### 1.4 Outlier Check  
- Mild outliers exist but represent real hospitals.  
- No structural issues.  
- Boxplot saved as:  
  `readmission_index_boxplot.png`

### 1.5 Hospitals With vs Without ERR  
- **Has ERR:** 2,326  
- **Missing ERR:** 3,100  

This confirms the modeling dataset will include only hospitals with ERR available.

---

## 2. Quality Domain Exploration  
The project narrative defines three engineered CMS quality domains:

- **mortality_index**  
- **patient_experience_score** (HCAHPS)  
- **timely_effective_care_score** (TEC)

Each domain was evaluated for missingness, distribution, and summary statistics.

---

### 2.1 Mortality Index  
- Missing: 1,444 hospitals  
- Mean: 4.22  
- SD: 0.559  
- Distribution is stable and model‑friendly.  
- Plot: `mortality_index_hist.png`

---

### 2.2 Patient Experience (HCAHPS)  
- Missing: 1,465 hospitals  
- Mean: 35.3  
- SD: 0.140  
- Known inverse relationship with readmissions.  
- Plot: `patient_experience_hist.png`

---

### 2.3 Timely & Effective Care (TEC)  
- Missing: 979 hospitals  
- Mean: 95.7  
- SD: 29.6  
- Wide variation across hospitals.  
- Plot: `tec_score_hist.png`

---

## 3. Relationship Analysis  
This section answers the narrative’s core question:

> **Which quality factors most influence hospital readmission performance?**

Scatterplots with linear trendlines were used to evaluate relationships.

---

### 3.1 Mortality Index → Readmission Index  
- Positive association.  
- Higher mortality correlates with higher readmissions.  
- Plot: `mortality_vs_readmission.png`

---

### 3.2 Patient Experience → Readmission Index  
- Strong negative association.  
- Better patient experience correlates with lower readmissions.  
- Plot: `patient_experience_vs_readmission.png`

---

### 3.3 TEC Score → Readmission Index  
- Weak but present negative association.  
- Plot: `tec_vs_readmission.png`

---

### 3.4 Correlation Matrix  
Variables included:

- readmission_index  
- mortality_index  
- patient_experience_score  
- timely_effective_care_score  

This matrix supports feature selection and model interpretability.

---

## 4. Regional Variation  
The narrative emphasizes regional differences as a key insight.  
Regions were assigned using **U.S. Census definitions**.

---

### 4.1 Regional Counts  
All four regions (Northeast, Midwest, South, West) are represented.

---

### 4.2 Readmission Index by Region  
- The **South** shows the highest readmission levels.  
- Plot: `readmission_by_region.png`

---

### 4.3 Mortality Index by Region  
- Mortality is highest in the **South** and **Midwest**.  
- Plot: `mortality_by_region.png`

---

### 4.4 Patient Experience by Region  
- The **Northeast** shows the strongest patient experience scores.  
- Plot: `patient_experience_by_region.png`

---

### 4.5 TEC Score by Region  
- TEC varies widely across all regions.  
- Plot: `tec_by_region.png`

---

### 4.6 Regional Summary Table  
Averages by region were computed for:

- readmission_index  
- mortality_index  
- patient_experience_score  
- timely_effective_care_score  

This table supports Tableau dashboards and the case study narrative.

---

## Summary of EDA Findings

- The dataset is **clean, structured, and modeling‑ready**.  
- Missingness patterns are **domain‑expected** and consistent with CMS reporting.  
- Quality domains show **meaningful variation** across hospitals.  
- Relationships with readmission are **strong and interpretable**.  
- Regional differences highlight **targeted improvement opportunities**.  

This completes Step 3 of the workflow and prepares the project for **Step 4: Modeling Dataset Construction**.

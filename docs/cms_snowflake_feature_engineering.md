# 05_cms_snowflake_feature_engineering.md
CMS Hospital Quality Project 
Author : Waldo Ketonou
Feature Engineering, Validation, and Unified Dataset Creation

---

## Overview
This document summarizes the Snowflake SQL workflow completed on **April 7, 2026**, covering:

- Feature engineering for all CMS quality domains  
- Validation of engineered features  
- Creation of the unified modeling-ready dataset  
- Final quality checks  
- Export instructions for R and Tableau  

This file corresponds to the SQL script:
sql/05_cms_snowflake_feature_engineering.sql

---

## B. Feature Engineering

Four engineered feature tables were created:

### **B1. Readmission Index**
Aggregated readmission performance across all reported measures.  
Output table: `FEAT_READMISSION`  
Field: `READMISSION_INDEX`

### **B2. Mortality Index**
Aggregated mortality performance across all reported measures.  
Output table: `FEAT_MORTALITY`  
Field: `MORTALITY_INDEX`

### **B3. Patient Experience (HCAHPS)**
Aggregated HCAHPS patient experience scores.  
Output table: `FEAT_HCAHPS`  
Field: `PATIENT_EXPERIENCE_SCORE`

### **B4. Timely & Effective Care (TEC)**
Aggregated TEC performance across all reported measures.  
Output table: `FEAT_TEC`  
Field: `TIMELY_EFFECTIVE_CARE_SCORE`

All feature tables use `FACILITY_ID` as the primary key.

---

## C. Validation

Validation ensured the engineered features were clean, complete, and merge‑ready.

### **C1. Row Count Validation**
Confirmed each feature table contained the expected number of hospitals.

### **C2. Duplicate Facility Check**
Verified no feature table contained duplicate `FACILITY_ID` rows.

### **C3. NULL Feature Validation**
Checked for missing engineered values after joining features to the base hospital table.

Results:
- Readmission: 3100 NULLs  
- Mortality: 1444 NULLs  
- HCAHPS: 1465 NULLs  
- TEC: 979 NULLs  

NULLs are expected due to CMS non‑reporting patterns.

### **C4. Numeric Range Validation**
Verified engineered metrics fell within realistic CMS ranges.

Results:
- Readmission Index: 0.5524 → 1.3097  
- Mortality Index: 1.8 → 7  

All values were valid.

---

## D. Unified Modeling Dataset
A final dataset was created:
CMS_CLEAN_HOSPITAL_QUALITY_FINAL

This table merges:
- Clean hospital profile data  
- All engineered feature tables  
- A region assignment field (`STATE_REGION`)  

The dataset contains one row per hospital and is used for:
- R modeling  
- Tableau dashboarding  
- Case study analysis  

---

## Exporting the Final Dataset for R or Tableau

The simplest export method uses the Snowflake UI.

### **Step 1 — Query the final dataset**
Run:
SELECT * FROM CMS_PROJECT.CORE.CMS_CLEAN_HOSPITAL_QUALITY_FINAL;


### **Step 2 — Download the results**
In the Snowflake results pane:
- Click **Download**
- Choose **CSV**
- Save the file locally

### **Step 3 — Load into R**
df <- read.csv("cms_clean_hospital_quality_final.csv")

### **Step 4 — Load into Tableau**
- Open Tableau  
- Click **Connect → Text File**  
- Select `cms_clean_hospital_quality_final.csv`  

This CSV is the **single source of truth** for both R and Tableau.

---

## Final Validation

Two final checks were performed:

### **Row Count**
Confirmed the final dataset contains the expected number of hospitals.

### **Duplicate Facility Check**
Verified no duplicate `FACILITY_ID` values exist in the final dataset.

Both checks passed successfully.

---

## Summary

This workflow produced:
- Four engineered feature tables  
- A validated, unified dataset  
- A modeling‑ready and visualization‑ready asset  
- Clean, reproducible SQL suitable for analytics engineering portfolios  
- A simple export workflow for R and Tableau  

This file documents the complete Snowflake work performed on April 7, 2026.


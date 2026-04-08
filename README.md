# 🏥 CMS Hospital Readmission & Quality Analytics Case Study
**Snowflake SQL • R • Tableau • Healthcare Quality Metrics**

This project analyzes U.S. hospital quality and readmission performance using publicly available CMS datasets. It demonstrates a complete analytics engineering workflow: Snowflake for data preparation and feature engineering, R for predictive modeling, and Tableau for visualization and executive storytelling.

---

## 📌 Executive Summary
Hospital readmissions are a key indicator of care quality and financial performance. CMS publishes hospital‑level quality metrics, but the data is fragmented, inconsistent, and not modeling‑ready.  
This project solves that by building a **unified, engineered, validated dataset** that supports:

- Predictive modeling  
- Quality benchmarking  
- Executive dashboards  
- Scenario simulation and business impact analysis  

The final dataset is clean, standardized, and ready for downstream analytics.

---

## 🎯 Business Problem
Hospitals face financial penalties for excessive readmissions under the CMS Hospital Readmissions Reduction Program (HRRP).  
Understanding **which quality factors drive readmissions** enables:

- Targeted quality improvement  
- Better resource allocation  
- Reduced penalties  
- Improved patient outcomes  

This project identifies those drivers using a structured analytics workflow.

---

## 🗂️ Data Sources
**Centers for Medicare & Medicaid Services (CMS)**  
- Hospital Readmissions Reduction Program (HRRP)  
- Mortality Measures  
- Patient Experience (HCAHPS)  
- Timely & Effective Care (TEC)  
- Hospital General Information  
- Region Mapping  

All datasets are publicly available and widely used in healthcare quality reporting.

---

## 🏗️ Architecture Overview
### **Snowflake → R → Tableau**

#### **Snowflake**
- Ingest raw CMS files  
- Clean and standardize fields  
- Validate data integrity  
- Engineer quality metrics  
- Produce unified dataset:  
  `CMS_CLEAN_HOSPITAL_QUALITY_FINAL`

#### **R (Next Phase)**
- Exploratory data analysis  
- Predictive modeling  
- Feature importance  

#### **Tableau (Next Phase)**
- Executive dashboard  
- Regional comparisons  
- Quality performance insights  

---

## 📁 SQL Pipeline (With Descriptions)
01_cms_snowflake_pipeline.sql : Creates database, schema, stages, and file formats for CMS ingestion.
02_snowflake_data_preparation.sql : Loads raw CMS datasets, standardizes fields, cleans identifiers, and prepares base tables.
03_snowflake_data_validation.sql : Performs row count checks, duplicate checks, NULL analysis, and numeric range validation.
04_snowflake_data_modeling.sql : Creates modeling‑ready base tables and prepares unified structures for feature engineering.
05_cms_snowflake_feature_engineering.sql : Builds engineered quality metrics (readmission, mortality, patient experience, TEC).


This pipeline is **final**, **validated**, and **reproducible**.

---

## 🧪 Engineered Features
The project generates four major engineered feature domains:

- **Readmission Index**  
- **Mortality Index**  
- **Patient Experience Score**  
- **Timely & Effective Care (TEC) Score**  
- **Region Assignment**  

These features consolidate dozens of CMS measures into interpretable, modeling‑ready metrics.

---

## 📦 Final Unified Dataset
The final dataset produced in Snowflake is:
CMS_CLEAN_HOSPITAL_QUALITY_FINAL

It includes:

- Hospital profile information  
- All engineered quality metrics  
- Region mapping  
- Modeling‑ready numeric fields  
- One row per hospital  

This dataset is exported for R modeling and Tableau visualization.

---

## 🔁 Reproduction Instructions

### **1. Clone the repository**
git clone  
https://github.com/Oswaldketonou/CMS_Hospital_Readmission_Analytics_Case_Study

### **2. Run the Snowflake SQL pipeline**
Execute scripts in order:

1. `01_cms_snowflake_pipeline.sql`  
2. `02_snowflake_data_preparation.sql`  
3. `03_snowflake_data_validation.sql`  
4. `04_snowflake_data_modeling.sql`  
5. `05_cms_snowflake_feature_engineering.sql`  

### **3. Export the final dataset**
Download CSV from Snowflake query results.

### **4. Use in R or Tableau**
- R: `read.csv("cms_clean_hospital_quality_final.csv")`  
- Tableau: Connect → Text File  

---

## 📚 Repository Structure
for later

---

## 🚧 Next Steps (In Progress)
- R modeling (EDA, regression, random forest, feature importance)  
- Tableau dashboard (KPIs, regional insights, quality scoring)  
- Final case study narrative  
- Scenario simulation and business recommendations  
- Data dictionary completion  

---

## 👤 About the Analyst
**Waldo Ketonou**  
Business & Data Analyst | SQL • R • Tableau  
Focused on transforming healthcare operations and quality metrics into actionable insights.

---

## 📌 Status
**In Progress** — SQL engineering phase completed; modeling and dashboard phases upcoming.

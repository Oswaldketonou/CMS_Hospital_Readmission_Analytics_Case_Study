# 🧊 CMS Snowflake Pipeline  
**File:** `01_cms_snowflake_pipeline.sql`  
**Author:** Waldo Ketonou  
**Project:** CMS Hospital Readmission Analytics Case Study  
**Last Updated:** 2026‑04‑06  

---

## 📘 Purpose of This Pipeline
This pipeline builds the **raw data ingestion layer** of the CMS Hospital Analytics Warehouse in Snowflake. It automates:

- Creating the project database and schemas  
- Defining a unified CSV file format  
- Dynamically inferring schemas for all CMS datasets  
- Loading raw CSV files into Snowflake tables  
- Validating row counts across all datasets  

This is the **foundation** for the STAGING and CORE layers that follow.

---

## 🧩 Overview of the Workflow

The pipeline consists of seven major steps:

1. **Download CMS datasets**  
2. **Upload CSV files to Snowflake stage**  
3. **Verify stage contents**  
4. **Create database, schema, and file format**  
5. **Infer schema and load each dataset**  
6. **Apply consistent ingestion logic across all files**  
7. **Validate row counts**  

Each dataset is loaded using the same reproducible pattern:
CREATE TABLE USING TEMPLATE(INFER_SCHEMA) COPY INTO table FROM @stage MATCH_BY_COLUMN_NAME=CASE_INSENSITIVE

This ensures the pipeline adapts to CMS schema changes automatically.

---

## 📥 1. Download CMS Hospital Datasets

Source:  
https://data.cms.gov/provider-data/dataset/hospital

Files used in this project:

- `Hospital_General_Information.csv`  
- `FY_2026_Hospital_Readmissions_Reduction_Program_Hospital.csv`  
- `Complications_and_Deaths-Hospital.csv`  
- `HCAHPS-Hospital.csv`  
- `Timely_and_Effective_Care-Hospital.csv`

Save all files locally:
C:\CMS_Hospital_Readmission_Analytics_Case_Study\data\

---

## 📤 2. Upload Files to Snowflake Stage

In Snowflake:

1. Navigate to:  
   `CMS_PROJECT → ANALYTICS → CMS_STAGE`
2. Click **+ → Upload Files**
3. Select all five CSVs
4. Confirm upload:

```sql
LIST @CMS_PROJECT.ANALYTICS.CMS_STAGE;
Expected contents:
cms_stage/Hospital_General_Information.csv
cms_stage/FY_2026_Hospital_Readmissions_Reduction_Program_Hospital.csv
cms_stage/Complications_and_Deaths-Hospital.csv
cms_stage/HCAHPS-Hospital.csv
cms_stage/Timely_and_Effective_Care-Hospital.csv


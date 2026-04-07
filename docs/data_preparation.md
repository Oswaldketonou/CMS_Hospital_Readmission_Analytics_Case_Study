# 🧊 Data Preparation & Standardization  
**CMS Hospital Performance Project**  
**Author:** Waldo Ketonou  
**Last Updated:** 2026‑04‑06  

---

## 📘 Purpose of This Document
This document describes the full data preparation workflow used to clean, standardize, and structure all CMS hospital datasets before modeling and analysis.  
The goal of this step is to ensure:

- Consistent formatting across all datasets  
- Reliable joinability using `FACILITY_ID`  
- Clean, analysis‑ready tables  
- A reproducible Snowflake pipeline  
- A clear separation between raw and transformed data  

All transformations occur in the **STAGING** layer of the Snowflake warehouse.

---

## 🏗️ Workflow Overview

The data preparation process follows a structured, multi‑step pipeline:

1. **Create the STAGING schema**  
2. **Clean and standardize each dataset**  
3. **Apply consistent formatting rules**  
4. **Preserve numeric and date fields**  
5. **Prepare tables for downstream modeling**

Each staging table is created using a `CREATE OR REPLACE TABLE AS SELECT` (CTAS) pattern to ensure reproducibility.

---

## 🧹 Standardization Rules Applied

Across all datasets, the following cleaning rules were applied:

### **1. Facility ID Standardization**
- Converted to `VARCHAR`
- Renamed to `FACILITY_ID`
- Ensures consistent join key across all datasets

### **2. Text Field Cleaning**
- `TRIM(UPPER())` applied to all text fields  
- Removes whitespace  
- Ensures consistent casing  
- Improves grouping and filtering reliability  

### **3. Numeric & Date Fields**
- Preserved in original format  
- Not uppercased  
- Ensures accurate calculations and comparisons  

### **4. Column Renaming**
- Converted to clean, snake‑case style  
- Improves readability and consistency  

---

## 📂 Staging Tables Created

The following staging tables were created in the `CMS_PROJECT.STAGING` schema:

| Dataset | Staging Table | Description |
|--------|----------------|-------------|
| Hospital General Info | `STG_HOSPITAL_GENERAL_INFO` | Anchor table for all joins |
| HRRP | `STG_HRRP` | Readmissions metrics |
| CAD | `STG_CAD` | Complications & deaths |
| HCAHPS | `STG_HCAHPS` | Patient experience survey |
| TEC | `STG_TEC` | Timely & effective care |

Each table is fully standardized and ready for modeling.

---

## 🧾 Full SQL Script

The complete SQL script used to generate all staging tables is located at:
/sql/02_snowflake_data_preparation.sql

This script includes:

- Schema creation  
- Cleaning logic  
- Standardization rules  
- CTAS statements for all five datasets  

---

## 🧪 Validation Summary

After staging, the following checks were performed:

- All tables successfully created  
- All row counts matched raw datasets  
- No null `FACILITY_ID` values  
- All datasets successfully join to `STG_HOSPITAL_GENERAL_INFO`  
- All text fields standardized  
- All date fields preserved correctly  

These checks ensure the STAGING layer is reliable and ready for modeling.

---

## 🔗 Next Steps

With the STAGING layer complete, the next phase of the pipeline is:

### **➡️ Data Modeling (CORE Layer)**  
This includes:

- Creating dimension and fact tables  
- Building unified hospital performance models  
- Preparing analytic‑ready structures for Tableau  

---

## 📌 Notes

- This staging process is fully reproducible and can be rerun at any time.  
- No raw data is modified; all transformations occur in the STAGING layer.  
- This document is part of the project’s end‑to‑end data engineering workflow.

---

## ✅ Status: Data Preparation Complete

The CMS datasets are now fully cleaned, standardized, and ready for modeling.


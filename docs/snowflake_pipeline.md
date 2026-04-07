# 🧊 Snowflake Ingestion Pipeline  
**CMS Hospital Performance Project**  
**Author:** Waldo Ketonou  
**Last Updated:** 2026‑04‑06  

---

## 📘 Purpose of This Document
This document describes the full ingestion workflow used to load all CMS hospital datasets into Snowflake before any cleaning or standardization occurs.  
The goal of this step is to ensure:

- A reproducible, automated ingestion pipeline  
- Consistent handling of all CMS CSV files  
- Dynamic schema inference using `INFER_SCHEMA`  
- Accurate loading into the `ANALYTICS` layer  
- A clean separation between raw ingestion and downstream transformation  

All ingestion steps occur in the **ANALYTICS** layer of the Snowflake warehouse.

---

## 🏗️ Workflow Overview

The ingestion process follows a structured, multi‑step pipeline:

1. **Download CMS datasets**  
2. **Upload raw CSV files to Snowflake stage**  
3. **Create the project database and schemas**  
4. **Create a unified CSV file format**  
5. **Infer schemas dynamically using `INFER_SCHEMA`**  
6. **Create tables using Snowflake templates**  
7. **Load data using `COPY INTO`**  
8. **Validate row counts for all datasets**

Each table is created using Snowflake’s dynamic schema inference to ensure reproducibility and adaptability to CMS schema changes.

---

## 🧹 Ingestion Rules Applied

Across all datasets, the following ingestion rules were applied:

### **1. Unified File Format**
- A single CSV file format (`CMS_CSV_FORMAT`) was created  
- Ensures consistent parsing across all datasets  
- Handles headers, delimiters, and null values uniformly  

### **2. Dynamic Schema Inference**
- `INFER_SCHEMA` used to detect column names and data types  
- Eliminates manual schema creation  
- Automatically adapts to CMS file updates  

### **3. Template‑Based Table Creation**
- Tables created using `USING TEMPLATE`  
- Guarantees table structure matches the uploaded file  
- Ensures ingestion remains resilient to schema drift  

### **4. Case‑Insensitive Column Matching**
- `MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE`  
- Prevents load failures due to casing differences  
- Ensures reliable column alignment during ingestion  

---

## 📂 Tables Created in the ANALYTICS Layer

The following raw tables were created in the `CMS_PROJECT.ANALYTICS` schema:

| Dataset | Table Name | Description |
|--------|------------|-------------|
| Hospital General Info | `HOSPITAL_GENERAL_INFO` | Core facility attributes |
| HRRP | `HRRP` | Readmissions metrics |
| CAD | `CAD` | Complications & mortality |
| HCAHPS | `HCAHPS` | Patient experience survey |
| TEC | `TEC` | Timeliness & effectiveness of care |

Each table is a direct ingestion of the corresponding CMS CSV file.

---

## 🧾 Full SQL Script

The complete SQL script used to perform ingestion is located at:  
/sql/01_cms_snowflake_pipeline.sql

This script includes:

- Database and schema creation  
- Stage creation  
- CSV file format creation  
- Schema inference logic  
- Template‑based table creation  
- COPY INTO load commands  
- Row count validation queries  

---

## 🧪 Validation Summary

After ingestion, the following checks were performed:

- All five tables successfully created  
- All row counts matched the raw CSV files  
- No rejected rows or load errors  
- All columns correctly inferred  
- All datasets available in the `ANALYTICS` schema  

These checks confirm that the ingestion pipeline is reliable and ready for the STAGING layer.

---

## 🔗 Next Steps

With ingestion complete, the next phase of the pipeline is:

### **➡️ Data Preparation & Standardization (STAGING Layer)**  
This includes:

- Cleaning and standardizing all datasets  
- Applying consistent formatting rules  
- Ensuring joinability using `FACILITY_ID`  
- Preparing analysis‑ready tables for modeling  

---

## 📌 Notes

- This ingestion pipeline is fully reproducible and can be rerun at any time.  
- No raw data is modified; ingestion only loads data into Snowflake.  
- This document is part of the project’s end‑to‑end data engineering workflow.  

---

## ✅ Status: Ingestion Complete

All CMS datasets are now successfully ingested into Snowflake and ready for transformation in the STAGING layer.

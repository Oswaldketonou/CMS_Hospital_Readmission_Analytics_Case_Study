# 🧊 Data Modeling (CORE Layer)
**CMS Hospital Performance Project**  
**Author:** Waldo Ketonou  
**Last Updated:** 2026‑04‑06  

---

## 📘 Purpose of This Document
This document describes the **CORE data modeling layer** used to transform the cleaned STAGING tables into analytics‑ready dimension and fact tables.  
The CORE layer provides:

- A **single source of truth** for hospital attributes  
- Domain‑specific fact tables for each CMS dataset  
- A unified **FACT_HOSPITAL_PERFORMANCE** table for dashboarding  
- A consistent grain across all performance measures  
- A reproducible, Snowflake‑based modeling pipeline  

This layer powers the Tableau dashboards and downstream analytics.

---

## 🏗️ Modeling Workflow Overview

The CORE layer is built in the following order:

1. **Create CORE schema**  
2. **Build DIM_HOSPITAL** (anchor dimension)  
3. **Build domain‑specific fact tables**  
   - FACT_HRRP  
   - FACT_CAD  
   - FACT_HCAHPS  
   - FACT_TEC  
4. **Build unified FACT_HOSPITAL_PERFORMANCE**  
   - Combines all performance domains  
   - Standardizes measure naming  
   - Enables cross‑domain comparisons  

Each table is created using a CTAS pattern for reproducibility.

---

## 🧱 1. DIM_HOSPITAL (Dimension Table)

### **Grain:** One row per facility  
### **Source:** `STG_HOSPITAL_GENERAL_INFO`

This dimension anchors all fact tables and contains:

- Facility identifiers  
- Location attributes  
- Ownership and type  
- Emergency services  
- Birthing‑friendly designation  

It ensures consistent joins across all CMS datasets.

---

## 📊 2. FACT_HRRP — Readmissions

### **Grain:** Facility × Measure Name  
### **Source:** `STG_HRRP` + `STG_HOSPITAL_GENERAL_INFO`

This fact table includes:

- Excess readmission ratios  
- Predicted vs expected readmission rates  
- Number of discharges and readmissions  
- Time period (start/end date)  

Used for evaluating hospital readmission performance.

---

## ⚠️ 3. FACT_CAD — Complications & Deaths

### **Grain:** Facility × Measure ID  
### **Source:** `STG_CAD` + `DIM_HOSPITAL`

Includes:

- Complication and mortality measures  
- National comparison categories  
- Score and confidence intervals  
- Denominator and footnotes  

Supports safety and outcomes analysis.

---

## 🗣️ 4. FACT_HCAHPS — Patient Experience

### **Grain:** Facility × HCAHPS Measure ID × Answer Type  
### **Source:** `STG_HCAHPS` + `DIM_HOSPITAL`

Captures:

- Patient survey questions  
- Answer descriptions  
- Star ratings  
- Response rates  
- Completed survey counts  

Used for patient satisfaction and experience dashboards.

---

## ⏱️ 5. FACT_TEC — Timely & Effective Care

### **Grain:** Facility × Measure ID  
### **Source:** `STG_TEC` + `DIM_HOSPITAL`

Includes:

- Clinical process measures  
- Sample sizes  
- Scores and footnotes  
- Time period  

Supports operational and quality‑of‑care analysis.

---

## 🌐 6. FACT_HOSPITAL_PERFORMANCE — Unified Model

### **Grain:** Facility × Measure (across all domains)  
### **Source:** All CORE fact tables

This master fact table:

- Combines HRRP, CAD, HCAHPS, and TEC  
- Standardizes measure naming  
- Adds a `DOMAIN` field to distinguish datasets  
- Enables cross‑domain comparisons  
- Powers the Tableau performance dashboard  

This is the primary table used for visualization and KPI reporting.

---

## 🧾 Full SQL Script

The complete modeling script is located at:
/notebook/snowflake_data_modeling.sql

It includes:

- Schema creation  
- Dimension creation  
- All fact tables  
- Unified performance model  

---

## 🧪 Validation Summary

After building the CORE layer, the following checks were performed:

- All fact tables successfully joined to `DIM_HOSPITAL`  
- No orphaned `FACILITY_ID` values  
- Row counts matched expectations  
- All date fields preserved correctly  
- Unified fact table contains all domains  
- Tableau successfully connected to CORE tables  

These checks confirm the CORE layer is production‑ready.

---

## 🔗 Next Steps

With the CORE layer complete, the next phase is:

### **➡️ Analytics & Dashboarding**
- Build Tableau dashboards  
- Create KPIs and domain‑specific insights  
- Develop scenario simulations  
- Publish portfolio‑ready visualizations  

---

## ✅ Status: Data Modeling Complete

The CMS datasets are now fully modeled and ready for analytics.

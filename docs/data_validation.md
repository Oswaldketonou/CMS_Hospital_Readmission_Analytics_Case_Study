# 📊 Data Validation Summary  
**CMS Hospital Performance Project**  
**Last Updated:** 2026‑01‑26

---

## 🧭 Purpose of Data Validation
Before performing any cleaning, transformation, or modeling, all raw CMS datasets were validated to ensure:

- Successful ingestion into Snowflake  
- Correct table structures  
- Non‑zero row counts  
- Alignment with expected dataset sizes  
- Readiness for downstream analytics and Tableau visualization  

This step ensures data quality, reproducibility, and trustworthiness of all subsequent analysis.

---

## 🗂️ Tables Validated
The following tables were loaded into the `CMS_PROJECT.ANALYTICS` schema and validated using the SQL script located at:

**`/sql/validating_tables.sql`**

The validation query checks row counts for each dataset and confirms that all tables are accessible and populated.

---

## 📋 Row Count Results

| Table Name                | Row Count |
|---------------------------|-----------|
| HOSPITAL_GENERAL_INFO     | 5,426     |
| HRRP                      | 18,330    |
| CAD                       | 95,780    |
| HCAHPS                    | 325,652   |
| TEC                       | 138,129   |

All tables returned **non‑zero row counts**, indicating successful ingestion with no anomalies.

---

## 📦 Stage Validation
A `LIST` command was executed on the project stage:
LIST @CMS_PROJECT.ANALYTICS.CMS_STAGE;

This confirmed that all raw CMS files are present and accessible for reproducible loading.

---

## ✅ Validation Status
All datasets passed validation with no issues detected.

You may now proceed to:

- Data cleaning  
- Feature engineering  
- Building the unified hospital performance model  
- Creating Tableau‑ready extracts  

---

## 📁 Related Files
- **SQL Script:** `/sql/validating_tables.sql`  
- **Raw Data Folder:** `/data/raw/`  
- **Cleaned Data Folder (upcoming):** `/data/cleaned/`

---

## 📝 Notes
- No missing files or partial loads were detected.  
- Row counts align with expected CMS dataset sizes.  
- This validation step will be referenced in the project’s main case study documentation.

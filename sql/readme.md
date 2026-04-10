# 📁 SQL Pipeline Documentation  
This folder contains the complete Snowflake SQL pipeline used to ingest, clean, validate, model, and engineer features from CMS hospital quality datasets.  
Each script is numbered to ensure a clear, reproducible, end‑to‑end workflow.

---

## 🧱 Pipeline Overview  
The SQL workflow is organized into **five sequential stages**, each responsible for a specific part of the data engineering process:

1. **Environment Setup**  
2. **Data Preparation**  
3. **Data Validation**  
4. **Data Modeling**  
5. **Feature Engineering**

This structure ensures clarity, modularity, and professional analytics engineering standards.

---

## 📜 SQL Scripts (With Descriptions)

```
01_cms_snowflake_pipeline.sql  
    └─ Creates database, schema, stages, and file formats for CMS ingestion.

02_snowflake_data_preparation.sql  
    └─ Loads raw CMS datasets, standardizes fields, cleans identifiers, and prepares base tables.

03_snowflake_data_validation.sql  
    └─ Performs row count checks, duplicate checks, NULL analysis, and numeric range validation.

04_snowflake_data_modeling.sql  
    └─ Creates modeling‑ready base tables and prepares unified structures for feature engineering.

05_cms_snowflake_feature_engineering.sql  
    └─ Builds engineered quality metrics (readmission, mortality, patient experience, TEC).
```

---

## 🧪 Output  
The final output of this pipeline is a unified, modeling‑ready dataset:

```
CMS_CLEAN_HOSPITAL_QUALITY_FINAL
```

This table includes:

- Clean hospital profile fields  
- Engineered quality metrics  
- Region mapping  
- Standardized numeric fields  
- One row per hospital  

It serves as the foundation for R modeling and Tableau visualization.

---

## 🔁 How to Run the Pipeline  
Execute the scripts **in numerical order**:

1. `01_cms_snowflake_pipeline.sql`  
2. `02_snowflake_data_preparation.sql`  
3. `03_snowflake_data_validation.sql`  
4. `04_snowflake_data_modeling.sql`  
5. `05_cms_snowflake_feature_engineering.sql`

Each script is independent and modular, enabling easy debugging and reproducibility.

---

## 📝 Notes  
- All scripts are designed for Snowflake’s SQL dialect.  
- File formats and stages must be created before loading data.  
- Validation queries should be reviewed before modeling.  
- Feature engineering logic is fully documented in `/docs/cms_snowflake_feature_engineering.md`.

---

## 👤 Maintainer  
**Waldo Ketonou**  
Business & Data Analyst | SQL • R • Tableau  
Focused on building clean, scalable, analytics‑ready data pipelines.

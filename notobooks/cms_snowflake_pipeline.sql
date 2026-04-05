/* ============================================================
   📘 CMS Snowflake Pipeline
   Author: Waldo Ketonou
   Project: CMS_Hospital_Readmission_Analytics_Case_Study
   Environment: Windows 10 | Snowflake via Chrome | GitHub via Edge
   ============================================================ */

/* ============================================================
   🧩 PRE‑WORK: Downloading and Uploading CMS Files to Snowflake
   ============================================================

   ------------------------------------------------------------
   STEP 1: Download CMS Hospital Datasets
   ------------------------------------------------------------
   Source: https://data.cms.gov/provider-data/dataset/hospital
   Files downloaded:
     - Hospital_General_Information.csv
     - FY_2026_Hospital_Readmissions_Reduction_Program_Hospital.csv
     - Complications_and_Deaths-Hospital.csv
     - HCAHPS-Hospital.csv
     - Timely_and_Effective_Care-Hospital.csv

   Save all files in a local folder named:
     C:\CMS_Hospital_Readmission_Analytics_Case_Study\data\

   ------------------------------------------------------------
   STEP 2: Upload Files to Snowflake Stage
   ------------------------------------------------------------
   In Snowflake (via Chrome):
     1. Navigate to CMS_PROJECT → ANALYTICS → CMS_STAGE
     2. Click “+” → “Upload Files”
     3. Select all five CSVs from the local folder
     4. Confirm successful upload by running:
        LIST @CMS_PROJECT.ANALYTICS.CMS_STAGE;

   ------------------------------------------------------------
   STEP 3: Verify Stage Contents
   ------------------------------------------------------------
   Expected output:
     cms_stage/Hospital_General_Information.csv
     cms_stage/FY_2026_Hospital_Readmissions_Reduction_Program_Hospital.csv
     cms_stage/Complications_and_Deaths-Hospital.csv
     cms_stage/HCAHPS-Hospital.csv
     cms_stage/Timely_and_Effective_Care-Hospital.csv

   Once verified, proceed to the main pipeline below.
   ============================================================ */

/* ------------------------------------------------------------
   1️⃣ PROJECT INITIALIZATION
   ------------------------------------------------------------ */

-- Create database and schema
CREATE DATABASE CMS_PROJECT;
CREATE SCHEMA CMS_PROJECT.ANALYTICS;

-- Create stage for file uploads
CREATE OR REPLACE STAGE CMS_PROJECT.ANALYTICS.CMS_STAGE;

-- Define CSV file format
CREATE OR REPLACE FILE FORMAT CMS_PROJECT.ANALYTICS.CSV_FORMAT
TYPE = 'CSV'
FIELD_OPTIONALLY_ENCLOSED_BY = '"'
PARSE_HEADER = TRUE
NULL_IF = ('NULL', 'null', '');

/* ------------------------------------------------------------
   2️⃣ HOSPITAL GENERAL INFORMATION
   ------------------------------------------------------------ */
-- Note: for reproducibility line 71 should be run first. then run line 82 --
CREATE OR REPLACE TABLE CMS_PROJECT.ANALYTICS.HOSPITAL_GENERAL_INFO
USING TEMPLATE (
    SELECT ARRAY_AGG(OBJECT_CONSTRUCT(*))
    FROM TABLE(
        INFER_SCHEMA(
            LOCATION => '@CMS_PROJECT.ANALYTICS.CMS_STAGE/Hospital_General_Information.csv',
            FILE_FORMAT => 'CMS_PROJECT.ANALYTICS.CSV_FORMAT'
        )
    )
);

COPY INTO CMS_PROJECT.ANALYTICS.HOSPITAL_GENERAL_INFO
FROM @CMS_PROJECT.ANALYTICS.CMS_STAGE/Hospital_General_Information.csv
FILE_FORMAT = (FORMAT_NAME = 'CMS_PROJECT.ANALYTICS.CSV_FORMAT')
MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE;

/* ------------------------------------------------------------
   3️⃣ HRRP — Hospital Readmissions Reduction Program
   ------------------------------------------------------------ */
-- Note: for reproducibility line 91 should be run first. then run line 102 --
CREATE OR REPLACE TABLE CMS_PROJECT.ANALYTICS.HRRP
USING TEMPLATE (
    SELECT ARRAY_AGG(OBJECT_CONSTRUCT(*))
    FROM TABLE(
        INFER_SCHEMA(
            LOCATION => '@CMS_PROJECT.ANALYTICS.CMS_STAGE/FY_2026_Hospital_Readmissions_Reduction_Program_Hospital.csv',
            FILE_FORMAT => 'CMS_PROJECT.ANALYTICS.CSV_FORMAT'
        )
    )
);

COPY INTO CMS_PROJECT.ANALYTICS.HRRP
FROM @CMS_PROJECT.ANALYTICS.CMS_STAGE/FY_2026_Hospital_Readmissions_Reduction_Program_Hospital.csv
FILE_FORMAT = (FORMAT_NAME = 'CMS_PROJECT.ANALYTICS.CSV_FORMAT')
MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE;

/* ------------------------------------------------------------
   4️⃣ CAD — Complications & Deaths (Hospital)
   ------------------------------------------------------------ */
-- Note: for reproducibility line 111 should be run first. then run line 122 --
CREATE OR REPLACE TABLE CMS_PROJECT.ANALYTICS.CAD
USING TEMPLATE (
    SELECT ARRAY_AGG(OBJECT_CONSTRUCT(*))
    FROM TABLE(
        INFER_SCHEMA(
            LOCATION => '@CMS_PROJECT.ANALYTICS.CMS_STAGE/Complications_and_Deaths-Hospital.csv',
            FILE_FORMAT => 'CMS_PROJECT.ANALYTICS.CSV_FORMAT'
        )
    )
);

COPY INTO CMS_PROJECT.ANALYTICS.CAD
FROM @CMS_PROJECT.ANALYTICS.CMS_STAGE/Complications_and_Deaths-Hospital.csv
FILE_FORMAT = (FORMAT_NAME = 'CMS_PROJECT.ANALYTICS.CSV_FORMAT')
MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE;

/* ------------------------------------------------------------
   5️⃣ HCAHPS — Patient Experience (Hospital)
   ------------------------------------------------------------ */
-- Note: for reproducibility line 131 should be run first. then run line 142 --
CREATE OR REPLACE TABLE CMS_PROJECT.ANALYTICS.HCAHPS
USING TEMPLATE (
    SELECT ARRAY_AGG(OBJECT_CONSTRUCT(*))
    FROM TABLE(
        INFER_SCHEMA(
            LOCATION => '@CMS_PROJECT.ANALYTICS.CMS_STAGE/HCAHPS-Hospital.csv',
            FILE_FORMAT => 'CMS_PROJECT.ANALYTICS.CSV_FORMAT'
        )
    )
);

COPY INTO CMS_PROJECT.ANALYTICS.HCAHPS
FROM @CMS_PROJECT.ANALYTICS.CMS_STAGE/HCAHPS-Hospital.csv
FILE_FORMAT = (FORMAT_NAME = 'CMS_PROJECT.ANALYTICS.CSV_FORMAT')
MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE;

/* ------------------------------------------------------------
   6️⃣ TEC — Timely & Effective Care (Hospital)
   ------------------------------------------------------------ */
-- Note: for reproducibility line 151 should be run first. then run line 162 --
CREATE OR REPLACE TABLE CMS_PROJECT.ANALYTICS.TEC
USING TEMPLATE (
    SELECT ARRAY_AGG(OBJECT_CONSTRUCT(*))
    FROM TABLE(
        INFER_SCHEMA(
            LOCATION => '@CMS_PROJECT.ANALYTICS.CMS_STAGE/Timely_and_Effective_Care-Hospital.csv',
            FILE_FORMAT => 'CMS_PROJECT.ANALYTICS.CSV_FORMAT'
        )
    )
);

COPY INTO CMS_PROJECT.ANALYTICS.TEC
FROM @CMS_PROJECT.ANALYTICS.CMS_STAGE/Timely_and_Effective_Care-Hospital.csv
FILE_FORMAT = (FORMAT_NAME = 'CMS_PROJECT.ANALYTICS.CSV_FORMAT')
MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE;

/* ------------------------------------------------------------
   7️⃣ VALIDATION — Confirm Row Counts
   ------------------------------------------------------------ */

SELECT 
    'HOSPITAL_GENERAL_INFO' AS table_name, COUNT(*) AS row_count FROM CMS_PROJECT.ANALYTICS.HOSPITAL_GENERAL_INFO
UNION ALL
SELECT 'HRRP', COUNT(*) FROM CMS_PROJECT.ANALYTICS.HRRP
UNION ALL
SELECT 'CAD', COUNT(*) FROM CMS_PROJECT.ANALYTICS.CAD
UNION ALL
SELECT 'HCAHPS', COUNT(*) FROM CMS_PROJECT.ANALYTICS.HCAHPS
UNION ALL
SELECT 'TEC', COUNT(*) FROM CMS_PROJECT.ANALYTICS.TEC;

/* ============================================================
   ✅ END OF PIPELINE
   This notebook builds the CMS Hospital Analytics warehouse
   using dynamic schema inference and reproducible data loading.
   It forms the foundation for Tableau visualization and
   predictive modeling in R.
   ============================================================ */

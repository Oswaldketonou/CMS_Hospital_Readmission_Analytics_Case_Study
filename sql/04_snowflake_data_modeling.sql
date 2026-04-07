/* ============================================================
   DATA MODELING PIPELINE — CORE LAYER
   CMS Hospital Performance Project
   ------------------------------------------------------------
   This script creates the CORE schema, dimension, and fact
   tables used for analytics and dashboarding.
   ============================================================ */


/* ------------------------------------------------------------
   1. Create CORE Schema
   ------------------------------------------------------------ */
CREATE SCHEMA IF NOT EXISTS CMS_PROJECT.CORE;


/* ------------------------------------------------------------
   2. DIM_HOSPITAL
   ------------------------------------------------------------
   Grain: 1 row per facility
   Source: STG_HOSPITAL_GENERAL_INFO
   ------------------------------------------------------------ */
CREATE OR REPLACE TABLE CMS_PROJECT.CORE.DIM_HOSPITAL AS
SELECT
    FACILITY_ID,
    FACILITY_NAME,
    ADDRESS,
    CITY,
    STATE,
    ZIP_CODE,
    COUNTY_NAME,
    PHONE_NUMBER,
    HOSPITAL_TYPE,
    HOSPITAL_OWNERSHIP,
    EMERGENCY_SERVICES,
    BIRTHING_FRIENDLY
FROM CMS_PROJECT.STAGING.STG_HOSPITAL_GENERAL_INFO;


/* ------------------------------------------------------------
   3. FACT_HRRP — Readmissions
   ------------------------------------------------------------
   Grain: Facility × Measure Name
   Source: STG_HRRP + STG_HOSPITAL_GENERAL_INFO
   ------------------------------------------------------------ */
CREATE OR REPLACE TABLE CMS_PROJECT.CORE.FACT_HRRP AS
SELECT
    H.FACILITY_ID,
    H.FACILITY_NAME,
    H.STATE,
    HR.MEASURE_NAME,
    HR.NUMBER_OF_DISCHARGES,
    HR.EXCESS_READMISSION_RATIO,
    HR.PREDICTED_READMISSION_RATE,
    HR.EXPECTED_READMISSION_RATE,
    HR.NUMBER_OF_READMISSIONS,
    HR.START_DATE,
    HR.END_DATE
FROM CMS_PROJECT.STAGING.STG_HRRP HR
LEFT JOIN CMS_PROJECT.STAGING.STG_HOSPITAL_GENERAL_INFO H
    ON HR.FACILITY_ID = H.FACILITY_ID;


/* ------------------------------------------------------------
   4. FACT_CAD — Complications & Deaths
   ------------------------------------------------------------
   Grain: Facility × Measure ID
   Source: STG_CAD + DIM_HOSPITAL
   ------------------------------------------------------------ */
CREATE OR REPLACE TABLE CMS_PROJECT.CORE.FACT_CAD AS
SELECT
    C.FACILITY_ID,
    H.FACILITY_NAME,
    H.STATE,
    C.MEASURE_ID,
    C.MEASURE_NAME,
    C.COMPARED_TO_NATIONAL,
    C.DENOMINATOR,
    C.SCORE,
    C.LOWER_ESTIMATE,
    C.HIGHER_ESTIMATE,
    C.FOOTNOTE,
    C.START_DATE,
    C.END_DATE
FROM CMS_PROJECT.STAGING.STG_CAD C
LEFT JOIN CMS_PROJECT.CORE.DIM_HOSPITAL H
    ON C.FACILITY_ID = H.FACILITY_ID;


/* ------------------------------------------------------------
   5. FACT_HCAHPS — Patient Experience
   ------------------------------------------------------------
   Grain: Facility × HCAHPS Measure ID × Answer Type
   Source: STG_HCAHPS + DIM_HOSPITAL
   ------------------------------------------------------------ */
CREATE OR REPLACE TABLE CMS_PROJECT.CORE.FACT_HCAHPS AS
SELECT
    HCA.FACILITY_ID,
    H.FACILITY_NAME,
    H.STATE,
    HCA.HCAHPS_MEASURE_ID,
    HCA.HCAHPS_QUESTION,
    HCA.HCAHPS_ANSWER_DESCRIPTION,
    HCA.STAR_RATING,
    HCA.STAR_RATING_FOOTNOTE,
    HCA.ANSWER_PERCENT,
    HCA.ANSWER_PERCENT_FOOTNOTE,
    HCA.LINEAR_MEAN_VALUE,
    HCA.COMPLETED_SURVEYS,
    HCA.COMPLETED_SURVEYS_FOOTNOTE,
    HCA.RESPONSE_RATE_PERCENT,
    HCA.RESPONSE_RATE_PERCENT_FOOTNOTE,
    HCA.START_DATE,
    HCA.END_DATE
FROM CMS_PROJECT.STAGING.STG_HCAHPS HCA
LEFT JOIN CMS_PROJECT.CORE.DIM_HOSPITAL H
    ON HCA.FACILITY_ID = H.FACILITY_ID;


/* ------------------------------------------------------------
   6. FACT_TEC — Timely & Effective Care
   ------------------------------------------------------------
   Grain: Facility × Measure ID
   Source: STG_TEC + DIM_HOSPITAL
   ------------------------------------------------------------ */
CREATE OR REPLACE TABLE CMS_PROJECT.CORE.FACT_TEC AS
SELECT
    T.FACILITY_ID,
    H.FACILITY_NAME,
    H.STATE,
    T.CONDITION,
    T.MEASURE_ID,
    T.MEASURE_NAME,
    T.SCORE,
    T."SAMPLE",
    T.FOOTNOTE,
    T.START_DATE,
    T.END_DATE
FROM CMS_PROJECT.STAGING.STG_TEC T
LEFT JOIN CMS_PROJECT.CORE.DIM_HOSPITAL H
    ON T.FACILITY_ID = H.FACILITY_ID;


/* ------------------------------------------------------------
   7. FACT_HOSPITAL_PERFORMANCE — Unified Performance Model
   ------------------------------------------------------------
   Grain: Facility × Measure (across all domains)
   Source: FACT_HRRP, FACT_CAD, FACT_HCAHPS, FACT_TEC
   ------------------------------------------------------------ */
CREATE OR REPLACE TABLE CMS_PROJECT.CORE.FACT_HOSPITAL_PERFORMANCE AS
SELECT * FROM (

    /* HRRP */
    SELECT
        FACILITY_ID,
        FACILITY_NAME,
        STATE,
        MEASURE_NAME AS MEASURE,
        EXCESS_READMISSION_RATIO AS SCORE,
        'HRRP' AS DOMAIN,
        START_DATE,
        END_DATE
    FROM CMS_PROJECT.CORE.FACT_HRRP

    UNION ALL

    /* CAD */
    SELECT
        FACILITY_ID,
        FACILITY_NAME,
        STATE,
        MEASURE_NAME AS MEASURE,
        SCORE,
        'CAD' AS DOMAIN,
        START_DATE,
        END_DATE
    FROM CMS_PROJECT.CORE.FACT_CAD

    UNION ALL

    /* HCAHPS */
    SELECT
        FACILITY_ID,
        FACILITY_NAME,
        STATE,
        HCAHPS_QUESTION AS MEASURE,
        ANSWER_PERCENT AS SCORE,
        'HCAHPS' AS DOMAIN,
        START_DATE,
        END_DATE
    FROM CMS_PROJECT.CORE.FACT_HCAHPS

    UNION ALL

    /* TEC */
    SELECT
        FACILITY_ID,
        FACILITY_NAME,
        STATE,
        MEASURE_NAME AS MEASURE,
        SCORE,
        'TEC' AS DOMAIN,
        START_DATE,
        END_DATE
    FROM CMS_PROJECT.CORE.FACT_TEC

);

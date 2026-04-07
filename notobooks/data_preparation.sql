/* ============================================================
   DATA PREPARATION & STANDARDIZATION PIPELINE
   CMS Hospital Performance Project
   Author: Waldo Ketonou
   ------------------------------------------------------------
   This script creates the STAGING layer for all CMS datasets.
   Each table is cleaned, standardized, and prepared for modeling.
   ============================================================ */

/* ------------------------------------------------------------
   1. Create STAGING Schema
   ------------------------------------------------------------ */
CREATE SCHEMA IF NOT EXISTS CMS_PROJECT.STAGING;


/* ------------------------------------------------------------
   2. STG_HOSPITAL_GENERAL_INFO
   ------------------------------------------------------------ */
CREATE OR REPLACE TABLE CMS_PROJECT.STAGING.STG_HOSPITAL_GENERAL_INFO AS
SELECT
    TRIM(UPPER("Facility ID")) AS FACILITY_ID,
    TRIM(UPPER("Facility Name")) AS FACILITY_NAME,
    TRIM(UPPER("Address")) AS ADDRESS,
    TRIM(UPPER("City/Town")) AS CITY,
    TRIM(UPPER("State")) AS STATE,
    "ZIP Code" AS ZIP_CODE,
    TRIM(UPPER("County/Parish")) AS COUNTY_NAME,
    TRIM(UPPER("Telephone Number")) AS PHONE_NUMBER,
    TRIM(UPPER("Hospital Type")) AS HOSPITAL_TYPE,
    TRIM(UPPER("Hospital Ownership")) AS HOSPITAL_OWNERSHIP,
    "Emergency Services" AS EMERGENCY_SERVICES,
    "Meets criteria for birthing friendly designation" AS BIRTHING_FRIENDLY
FROM CMS_PROJECT.ANALYTICS.HOSPITAL_GENERAL_INFO;


/* ------------------------------------------------------------
   3. STG_HRRP — Hospital Readmissions Reduction Program
   ------------------------------------------------------------ */
CREATE OR REPLACE TABLE CMS_PROJECT.STAGING.STG_HRRP AS
SELECT
    "Facility ID"::VARCHAR AS FACILITY_ID,
    TRIM(UPPER("Facility Name")) AS FACILITY_NAME,
    TRIM(UPPER("State")) AS STATE,
    TRIM(UPPER("Measure Name")) AS MEASURE_NAME,
    TRIM(UPPER("Number of Discharges")) AS NUMBER_OF_DISCHARGES,
    "Footnote" AS FOOTNOTE,
    TRIM(UPPER("Excess Readmission Ratio")) AS EXCESS_READMISSION_RATIO,
    TRIM(UPPER("Predicted Readmission Rate")) AS PREDICTED_READMISSION_RATE,
    TRIM(UPPER("Expected Readmission Rate")) AS EXPECTED_READMISSION_RATE,
    TRIM(UPPER("Number of Readmissions")) AS NUMBER_OF_READMISSIONS,
    "Start Date" AS START_DATE,
    "End Date" AS END_DATE
FROM CMS_PROJECT.ANALYTICS.HRRP;


/* ------------------------------------------------------------
   4. STG_CAD — Complications & Deaths
   ------------------------------------------------------------ */
CREATE OR REPLACE TABLE CMS_PROJECT.STAGING.STG_CAD AS
SELECT
    TRIM(UPPER("Facility ID")) AS FACILITY_ID,
    TRIM(UPPER("Facility Name")) AS FACILITY_NAME,
    TRIM(UPPER("Address")) AS ADDRESS,
    TRIM(UPPER("City/Town")) AS CITY,
    TRIM(UPPER("State")) AS STATE,
    "ZIP Code" AS ZIP_CODE,
    TRIM(UPPER("County/Parish")) AS COUNTY_NAME,
    TRIM(UPPER("Telephone Number")) AS PHONE_NUMBER,
    TRIM(UPPER("Measure ID")) AS MEASURE_ID,
    TRIM(UPPER("Measure Name")) AS MEASURE_NAME,
    TRIM(UPPER("Compared to National")) AS COMPARED_TO_NATIONAL,
    TRIM(UPPER("Denominator")) AS DENOMINATOR,
    TRIM(UPPER("Score")) AS SCORE,
    TRIM(UPPER("Lower Estimate")) AS LOWER_ESTIMATE,
    TRIM(UPPER("Higher Estimate")) AS HIGHER_ESTIMATE,
    "Footnote" AS FOOTNOTE,
    "Start Date" AS START_DATE,
    "End Date" AS END_DATE
FROM CMS_PROJECT.ANALYTICS.CAD;


/* ------------------------------------------------------------
   5. STG_HCAHPS — Patient Experience Survey
   ------------------------------------------------------------ */
CREATE OR REPLACE TABLE CMS_PROJECT.STAGING.STG_HCAHPS AS
SELECT
    TRIM(UPPER("Facility ID")) AS FACILITY_ID,
    TRIM(UPPER("Facility Name")) AS FACILITY_NAME,
    TRIM(UPPER("Address")) AS ADDRESS,
    TRIM(UPPER("City/Town")) AS CITY,
    TRIM(UPPER("State")) AS STATE,
    "ZIP Code" AS ZIP_CODE,
    TRIM(UPPER("County/Parish")) AS COUNTY_NAME,
    TRIM(UPPER("Telephone Number")) AS PHONE_NUMBER,

    TRIM(UPPER("HCAHPS Measure ID")) AS HCAHPS_MEASURE_ID,
    TRIM(UPPER("HCAHPS Question")) AS HCAHPS_QUESTION,
    TRIM(UPPER("HCAHPS Answer Description")) AS HCAHPS_ANSWER_DESCRIPTION,

    TRIM(UPPER("Patient Survey Star Rating")) AS STAR_RATING,
    "Patient Survey Star Rating Footnote" AS STAR_RATING_FOOTNOTE,

    TRIM(UPPER("HCAHPS Answer Percent")) AS ANSWER_PERCENT,
    "HCAHPS Answer Percent Footnote" AS ANSWER_PERCENT_FOOTNOTE,

    TRIM(UPPER("HCAHPS Linear Mean Value")) AS LINEAR_MEAN_VALUE,

    TRIM(UPPER("Number of Completed Surveys")) AS COMPLETED_SURVEYS,
    "Number of Completed Surveys Footnote" AS COMPLETED_SURVEYS_FOOTNOTE,

    TRIM(UPPER("Survey Response Rate Percent")) AS RESPONSE_RATE_PERCENT,
    "Survey Response Rate Percent Footnote" AS RESPONSE_RATE_PERCENT_FOOTNOTE,

    "Start Date" AS START_DATE,
    "End Date" AS END_DATE
FROM CMS_PROJECT.ANALYTICS.HCAHPS;


/* ------------------------------------------------------------
   6. STG_TEC — Timely & Effective Care
   ------------------------------------------------------------ */
CREATE OR REPLACE TABLE CMS_PROJECT.STAGING.STG_TEC AS
SELECT
    TRIM(UPPER("Facility ID")) AS FACILITY_ID,
    TRIM(UPPER("Facility Name")) AS FACILITY_NAME,
    TRIM(UPPER("Address")) AS ADDRESS,
    TRIM(UPPER("City/Town")) AS CITY,
    TRIM(UPPER("State")) AS STATE,
    "ZIP Code" AS ZIP_CODE,
    TRIM(UPPER("County/Parish")) AS COUNTY_NAME,
    TRIM(UPPER("Telephone Number")) AS PHONE_NUMBER,

    TRIM(UPPER("Condition")) AS CONDITION,
    TRIM(UPPER("Measure ID")) AS MEASURE_ID,
    TRIM(UPPER("Measure Name")) AS MEASURE_NAME,

    TRIM(UPPER("Score")) AS SCORE,
    TRIM(UPPER("Sample")) AS SAMPLE,
    "Footnote" AS FOOTNOTE,

    "Start Date" AS START_DATE,
    "End Date" AS END_DATE
FROM CMS_PROJECT.ANALYTICS.TEC;

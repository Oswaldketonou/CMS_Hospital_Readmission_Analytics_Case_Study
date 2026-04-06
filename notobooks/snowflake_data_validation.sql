/* ============================================================
   CMS PROJECT — DATA VALIDATION SCRIPT
   Author:Waldo Ketonou
   Purpose: Validate structure, completeness, and joinability
   across all CMS datasets using "Facility ID" as the anchor key.
   ============================================================ */


/* ============================================================
   1. ROW COUNT VALIDATION
   Ensures all tables loaded successfully and contain expected rows.
   ============================================================ */

SELECT 'HOSPITAL_GENERAL_INFO' AS table_name, COUNT(*) AS row_count
FROM CMS_PROJECT.ANALYTICS.HOSPITAL_GENERAL_INFO
UNION ALL
SELECT 'HRRP', COUNT(*) FROM CMS_PROJECT.ANALYTICS.HRRP
UNION ALL
SELECT 'CAD', COUNT(*) FROM CMS_PROJECT.ANALYTICS.CAD
UNION ALL
SELECT 'HCAHPS', COUNT(*) FROM CMS_PROJECT.ANALYTICS.HCAHPS
UNION ALL
SELECT 'TEC', COUNT(*) FROM CMS_PROJECT.ANALYTICS.TEC;


/* ============================================================
   2. SCHEMA VALIDATION
   Confirms column names, data types, and structure.
   ============================================================ */

DESC TABLE CMS_PROJECT.ANALYTICS.HOSPITAL_GENERAL_INFO;
DESC TABLE CMS_PROJECT.ANALYTICS.HRRP;
DESC TABLE CMS_PROJECT.ANALYTICS.CAD;
DESC TABLE CMS_PROJECT.ANALYTICS.HCAHPS;
DESC TABLE CMS_PROJECT.ANALYTICS.TEC;


/* ============================================================
   3. PRIMARY KEY INTEGRITY — "Facility ID"
   Checks for duplicates and nulls in the anchor table.
   ============================================================ */

-- Duplicate check
SELECT "Facility ID", COUNT(*) AS dup_count
FROM CMS_PROJECT.ANALYTICS.HOSPITAL_GENERAL_INFO
GROUP BY "Facility ID"
HAVING COUNT(*) > 1;

-- Null check
SELECT COUNT(*) AS null_facility_ids
FROM CMS_PROJECT.ANALYTICS.HOSPITAL_GENERAL_INFO
WHERE "Facility ID" IS NULL;


/* ============================================================
   4. HRRP VALIDATION
   ============================================================ */

-- Duplicate check
SELECT "Facility ID", COUNT(*) AS dup_count
FROM CMS_PROJECT.ANALYTICS.HRRP
GROUP BY "Facility ID"
HAVING COUNT(*) > 1;

-- Null check
SELECT COUNT(*) AS null_facility_ids
FROM CMS_PROJECT.ANALYTICS.HRRP
WHERE "Facility ID" IS NULL;

-- Joinability check
SELECT COUNT(*) AS matched_records
FROM CMS_PROJECT.ANALYTICS.HOSPITAL_GENERAL_INFO h
JOIN CMS_PROJECT.ANALYTICS.HRRP r
  ON h."Facility ID" = r."Facility ID"::VARCHAR;


/* ============================================================
   5. CAD VALIDATION
   ============================================================ */

-- Duplicate check
SELECT "Facility ID", COUNT(*) AS dup_count
FROM CMS_PROJECT.ANALYTICS.CAD
GROUP BY "Facility ID"
HAVING COUNT(*) > 1;

-- Null check
SELECT COUNT(*) AS null_facility_ids
FROM CMS_PROJECT.ANALYTICS.CAD
WHERE "Facility ID" IS NULL;

-- Joinability check
SELECT COUNT(*) AS matched_records
FROM CMS_PROJECT.ANALYTICS.HOSPITAL_GENERAL_INFO h
JOIN CMS_PROJECT.ANALYTICS.CAD c
  ON h."Facility ID" = c."Facility ID"::VARCHAR;


/* ============================================================
   6. HCAHPS VALIDATION
   ============================================================ */

-- Duplicate check
SELECT "Facility ID", COUNT(*) AS dup_count
FROM CMS_PROJECT.ANALYTICS.HCAHPS
GROUP BY "Facility ID"
HAVING COUNT(*) > 1;

-- Null check
SELECT COUNT(*) AS null_facility_ids
FROM CMS_PROJECT.ANALYTICS.HCAHPS
WHERE "Facility ID" IS NULL;

-- Joinability check
SELECT COUNT(*) AS matched_records
FROM CMS_PROJECT.ANALYTICS.HOSPITAL_GENERAL_INFO h
JOIN CMS_PROJECT.ANALYTICS.HCAHPS s
  ON h."Facility ID" = s."Facility ID"::VARCHAR;


/* ============================================================
   7. TEC VALIDATION
   ============================================================ */

-- Duplicate check
SELECT "Facility ID", COUNT(*) AS dup_count
FROM CMS_PROJECT.ANALYTICS.TEC
GROUP BY "Facility ID"
HAVING COUNT(*) > 1;

-- Null check
SELECT COUNT(*) AS null_facility_ids
FROM CMS_PROJECT.ANALYTICS.TEC
WHERE "Facility ID" IS NULL;

-- Joinability check
SELECT COUNT(*) AS matched_records
FROM CMS_PROJECT.ANALYTICS.HOSPITAL_GENERAL_INFO h
JOIN CMS_PROJECT.ANALYTICS.TEC t
  ON h."Facility ID" = t."Facility ID"::VARCHAR;


/* ============================================================
   END OF VALIDATION SCRIPT
   ============================================================ */

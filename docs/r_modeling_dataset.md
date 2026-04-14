Modeling Dataset Construction  
CMS Hospital Readmission Modeling Project  
Author: Waldo Ketonou

## Overview
This document describes the creation of the modeling‑ready dataset used for predicting hospital readmission performance (ERR‑based readmission_index). The goal of this step is to transform the cleaned CMS hospital quality dataset into a structured, analysis‑ready modeling table with consistent variable types, complete target values, and only the fields required for modeling and scenario simulation.  
This step follows the data engineering and EDA phases and represents the bridge between raw CMS data and the modeling workflow.

## Objectives
- Select variables relevant for modeling hospital readmission performance  
- Remove fields not appropriate for modeling (e.g., incomplete or policy‑driven fields)  
- Ensure categorical variables are properly encoded as factors  
- Restrict the dataset to hospitals with valid ERR values  
- Produce a clean, reproducible modeling dataset for downstream modeling scripts

## Variable Selection
The following variables were retained for modeling:  
facility_id, facility_name  
city, state, county_name, state_region  
hospital_type, hospital_ownership, emergency_services  
readmission_index  
mortality_index, patient_experience_score, timely_effective_care_score

### Excluded Variable
- birthing_friendly — removed due to >3,000 missing values and CMS reporting inconsistencies.

## Data Filtering
CMS only reports ERR (readmission_index) for hospitals with sufficient qualifying cases.  
To ensure a valid modeling target:  
- Rows with missing readmission_index were removed  
- Final modeling dataset size: 2,326 hospitals  
This aligns with CMS reporting rules and ensures the model is trained only on hospitals with valid readmission performance metrics.

## Data Type Standardization
All categorical variables were converted to factors:  
- city  
- state  
- state_region  
- hospital_type  
- hospital_ownership  
- emergency_services (ordered as FALSE, TRUE)  
Numeric variables remained as continuous doubles.  
This ensures consistent behavior across modeling functions and prevents accidental coercion.

## Output Dataset
The final modeling dataset is saved as  
data/processed/cms_modeling_dataset.csv

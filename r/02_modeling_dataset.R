# ============================================================
# 02_modeling_dataset.R
# Author: Waldo Ketonou
# Purpose: Build modeling-ready dataset for CMS Readmission Model
# ============================================================

library(dplyr)

# ------------------------------------------------------------
# 1. Inspect base dataset
# ------------------------------------------------------------
glimpse(cms)

# ------------------------------------------------------------
# 2. Define modeling variables
# ------------------------------------------------------------
model_vars <- c(
  "facility_id",
  "facility_name",
  "city",
  "state",
  "county_name",
  "state_region",
  "hospital_type",
  "hospital_ownership",
  "emergency_services",
  "readmission_index",
  "mortality_index",
  "patient_experience_score",
  "timely_effective_care_score"
)

# ------------------------------------------------------------
# 3. Create initial modeling dataset
#    (birthing_friendly intentionally excluded)
# ------------------------------------------------------------
cms_model <- cms %>%
  select(all_of(model_vars))

# ------------------------------------------------------------
# 4. Keep only hospitals with ERR (non-missing readmission_index)
# ------------------------------------------------------------
cms_model <- cms_model %>%
  filter(!is.na(readmission_index))

# ------------------------------------------------------------
# 5. Convert categorical variables to factors
# ------------------------------------------------------------
cms_model <- cms_model %>%
  mutate(
    city               = factor(city),
    state              = factor(state),
    state_region       = factor(state_region),
    hospital_type      = factor(hospital_type),
    hospital_ownership = factor(hospital_ownership),
    emergency_services = factor(emergency_services, levels = c(FALSE, TRUE))
  )

# ------------------------------------------------------------
# 6. Final validation
# ------------------------------------------------------------
glimpse(cms_model)
summary(cms_model$readmission_index)
summary(cms_model$hospital_type)
summary(cms_model$state_region)

# ------------------------------------------------------------
# 7. Save modeling dataset
# ------------------------------------------------------------
write.csv(
  cms_model,
  file = "data/processed/cms_modeling_dataset.csv",
  row.names = FALSE
)

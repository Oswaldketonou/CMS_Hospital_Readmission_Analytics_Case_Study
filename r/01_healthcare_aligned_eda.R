# ============================================================
# 01 EDA — Healthcare-Aligned Exploratory Data Analysis
# Author : Waldo Ketonou
# CMS Hospital Quality Project
# ============================================================

# ------------------------------------------------------------
# Load Packages
# ------------------------------------------------------------
library(tidyverse)
library(janitor)
library(skimr)
library(caret)
library(randomForest)
library(vip)

# ------------------------------------------------------------
# Load Data (Cleaned & Engineered from Snowflake)
# ------------------------------------------------------------
cms <- read_csv("data/processed/cms_clean_hospital_quality_final.csv") |>
  clean_names()

glimpse(cms)
skim(cms)


# ============================================================
# A. Target Variable Exploration — readmission_index (ERR Proxy)
# ============================================================

# A1. Missingness for the target variable
sum(is.na(cms$readmission_index))
mean(is.na(cms$readmission_index))

# A2. Distribution of readmission_index
cms |>
  ggplot(aes(x = readmission_index)) +
  geom_histogram(bins = 30, fill = "steelblue", color = "white") +
  labs(
    title = "Distribution of Readmission Index (ERR Proxy)",
    x = "Readmission Index",
    y = "Count"
  ) +
  theme_minimal()

ggsave("visuals/r_plots/eda/readmission_index_hist.png", width = 7, height = 4)

# A3. Summary statistics for the target
cms |>
  summarize(
    n = n(),
    missing = sum(is.na(readmission_index)),
    mean = mean(readmission_index, na.rm = TRUE),
    sd = sd(readmission_index, na.rm = TRUE),
    min = min(readmission_index, na.rm = TRUE),
    max = max(readmission_index, na.rm = TRUE)
  )

# A4. Outlier check (boxplot)
cms |>
  ggplot(aes(y = readmission_index)) +
  geom_boxplot(fill = "lightblue") +
  labs(
    title = "Readmission Index — Outlier Check",
    y = "Readmission Index"
  ) +
  theme_minimal()

ggsave("visuals/r_plots/eda/readmission_index_boxplot.png", width = 5, height = 4)

# A5. Compare hospitals with vs without ERR
cms |>
  mutate(has_err = if_else(is.na(readmission_index), "Missing ERR", "Has ERR")) |>
  count(has_err)


# ============================================================
# B. Quality Domain Exploration
# (mortality_index, patient_experience_score, timely_effective_care_score)
# ============================================================

# B1. Missingness across quality domains
cms |>
  summarize(
    missing_mortality = sum(is.na(mortality_index)),
    missing_hcahps = sum(is.na(patient_experience_score)),
    missing_tec = sum(is.na(timely_effective_care_score))
  )

# B2. Distribution — Mortality Index
cms |>
  ggplot(aes(x = mortality_index)) +
  geom_histogram(bins = 30, fill = "firebrick", color = "white") +
  labs(
    title = "Distribution of Mortality Index",
    x = "Mortality Index",
    y = "Count"
  ) +
  theme_minimal()

ggsave("visuals/r_plots/eda/mortality_index_hist.png", width = 7, height = 4)

# B3. Summary — Mortality Index
cms |>
  summarize(
    mean = mean(mortality_index, na.rm = TRUE),
    sd   = sd(mortality_index, na.rm = TRUE),
    min  = min(mortality_index, na.rm = TRUE),
    max  = max(mortality_index, na.rm = TRUE)
  )

# B4. Distribution — Patient Experience (HCAHPS)
cms |>
  ggplot(aes(x = patient_experience_score)) +
  geom_histogram(bins = 30, fill = "darkorange", color = "white") +
  labs(
    title = "Distribution of Patient Experience Score (HCAHPS)",
    x = "Patient Experience Score",
    y = "Count"
  ) +
  theme_minimal()

ggsave("visuals/r_plots/eda/patient_experience_hist.png", width = 7, height = 4)

# B5. Summary — Patient Experience
cms |>
  summarize(
    mean = mean(patient_experience_score, na.rm = TRUE),
    sd   = sd(patient_experience_score, na.rm = TRUE),
    min  = min(patient_experience_score, na.rm = TRUE),
    max  = max(patient_experience_score, na.rm = TRUE)
  )

# B6. Distribution — Timely & Effective Care (TEC)
cms |>
  ggplot(aes(x = timely_effective_care_score)) +
  geom_histogram(bins = 30, fill = "steelblue", color = "white") +
  labs(
    title = "Distribution of Timely & Effective Care (TEC) Score",
    x = "TEC Score",
    y = "Count"
  ) +
  theme_minimal()

ggsave("visuals/r_plots/eda/tec_score_hist.png", width = 7, height = 4)

# B7. Summary — TEC Score
cms |>
  summarize(
    mean = mean(timely_effective_care_score, na.rm = TRUE),
    sd   = sd(timely_effective_care_score, na.rm = TRUE),
    min  = min(timely_effective_care_score, na.rm = TRUE),
    max  = max(timely_effective_care_score, na.rm = TRUE)
  )


# ============================================================
# C. Relationship Analysis — Quality Domains → Readmission
# ============================================================

# C1. Mortality Index → Readmission Index
cms |>
  ggplot(aes(x = mortality_index, y = readmission_index)) +
  geom_point(alpha = 0.4, color = "firebrick") +
  geom_smooth(method = "lm", se = FALSE, color = "black") +
  labs(
    title = "Relationship: Mortality Index vs Readmission Index",
    x = "Mortality Index",
    y = "Readmission Index (ERR Proxy)"
  ) +
  theme_minimal()

ggsave("visuals/r_plots/eda/mortality_vs_readmission.png", width = 7, height = 4)

# C2. Patient Experience → Readmission Index
cms |>
  ggplot(aes(x = patient_experience_score, y = readmission_index)) +
  geom_point(alpha = 0.4, color = "darkorange") +
  geom_smooth(method = "lm", se = FALSE, color = "black") +
  labs(
    title = "Relationship: Patient Experience Score vs Readmission Index",
    x = "Patient Experience Score (HCAHPS)",
    y = "Readmission Index (ERR Proxy)"
  ) +
  theme_minimal()

ggsave("visuals/r_plots/eda/patient_experience_vs_readmission.png", width = 7, height = 4)

# C3. TEC Score → Readmission Index
cms |>
  ggplot(aes(x = timely_effective_care_score, y = readmission_index)) +
  geom_point(alpha = 0.4, color = "steelblue") +
  geom_smooth(method = "lm", se = FALSE, color = "black") +
  labs(
    title = "Relationship: TEC Score vs Readmission Index",
    x = "Timely & Effective Care (TEC) Score",
    y = "Readmission Index (ERR Proxy)"
  ) +
  theme_minimal()

ggsave("visuals/r_plots/eda/tec_vs_readmission.png", width = 7, height = 4)

# C4. Correlation Table
cms |>
  select(
    readmission_index,
    mortality_index,
    patient_experience_score,
    timely_effective_care_score
  ) |>
  drop_na() |>
  cor()


# ============================================================
# D. Regional Variation Analysis
# ============================================================

# D0. Create region variable (U.S. Census Regions)
cms <- cms |>
  mutate(
    region = case_when(
      state %in% c("ME","NH","VT","MA","RI","CT","NY","NJ","PA") ~ "Northeast",
      state %in% c("OH","IN","IL","MI","WI","MN","IA","MO","ND","SD","NE","KS") ~ "Midwest",
      state %in% c("DE","MD","DC","VA","WV","NC","SC","GA","FL",
                   "KY","TN","AL","MS","AR","LA","OK","TX") ~ "South",
      state %in% c("MT","ID","WY","CO","NM","AZ","UT","NV","WA","OR","CA","AK","HI") ~ "West",
      TRUE ~ NA_character_
    )
  )

# D1. Regional counts
cms |>
  count(region)

# D2. Readmission Index by Region
cms |>
  ggplot(aes(x = region, y = readmission_index, fill = region)) +
  geom_boxplot(alpha = 0.7) +
  labs(
    title = "Readmission Index by Region",
    x = "Region",
    y = "Readmission Index (ERR Proxy)"
  ) +
  theme_minimal() +
  theme(legend.position = "none")

ggsave("visuals/r_plots/eda/readmission_by_region.png", width = 7, height = 4)

# D3. Mortality Index by Region
cms |>
  ggplot(aes(x = region, y = mortality_index, fill = region)) +
  geom_boxplot(alpha = 0.7) +
  labs(
    title = "Mortality Index by Region",
    x = "Region",
    y = "Mortality Index"
  ) +
  theme_minimal() +
  theme(legend.position = "none")

ggsave("visuals/r_plots/eda/mortality_by_region.png", width = 7, height = 4)

# D4. Patient Experience by Region
cms |>
  ggplot(aes(x = region, y = patient_experience_score, fill = region)) +
  geom_boxplot(alpha = 0.7) +
  labs(
    title = "Patient Experience Score by Region",
    x = "Region",
    y = "Patient Experience Score (HCAHPS)"
  ) +
  theme_minimal() +
  theme(legend.position = "none")

ggsave("visuals/r_plots/eda/patient_experience_by_region.png", width = 7, height = 4)

# D5. TEC Score by Region
cms |>
  ggplot(aes(x = region, y = timely_effective_care_score, fill = region)) +
  geom_boxplot(alpha = 0.7) +
  labs(
    title = "Timely & Effective Care (TEC) Score by Region",
    x = "Region",
    y = "TEC Score"
  ) +
  theme_minimal() +
  theme(legend.position = "none")

ggsave("visuals/r_plots/eda/tec_by_region.png", width = 7, height = 4)

# D6. Regional summary table
cms |>
  group_by(region) |>
  summarize(
    n = n(),
    mean_readmission = mean(readmission_index, na.rm = TRUE),
    mean_mortality = mean(mortality_index, na.rm = TRUE),
    mean_hcahps = mean(patient_experience_score, na.rm = TRUE),
    mean_tec = mean(timely_effective_care_score, na.rm = TRUE)
  )
# End of EDA scripts

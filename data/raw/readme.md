# **Raw Data**

This folder contains the original CMS Hospital Quality datasets used in this project.  
These files are **not stored directly in the repository** due to their large size and because CMS maintains authoritative, regularly updated versions.

Instead, all raw data sources are documented with **official CMS dataset links** and **direct CSV download URLs** in the `data_sources.md` file located in this same directory.

This design ensures:

- **Reproducibility** — anyone can re‑download the exact datasets used  
- **Transparency** — all data provenance is fully documented  
- **Version accuracy** — CMS updates datasets frequently, and linking avoids outdated files  
- **Lightweight repository** — avoids committing large CSV files to GitHub  

To reproduce the raw data locally:

1. Open `data_sources.md`  
2. Download each dataset using the provided CMS links  
3. Place the CSV files in this `data/raw/` directory before running any cleaning or modeling scripts  

This folder is intentionally kept minimal and serves as the starting point for all data preparation and feature engineering workflows.

# High-Performance Computing (HPC) Population Genomics Pipeline 🧬💻

**Author:** Octavio Morga Angel  
**Environment:** Linux / SLURM HPC Cluster  
**Languages:** Bash, R  

## 📌 Project Overview
This repository serves as a **demonstration** of my bioinformatics workflow for population genomics. Due to strict confidentiality agreements regarding my current research on marine metagenomics and functional genomics, I cannot share raw biological datasets or embargoed scripts. 

Instead, this repository illustrates the complete computational architecture I design and execute in HPC environments. The pipeline covers:
1. **Data Sanitization:** Removing PCR duplicates using `Picard`.
2. **Variant Calling & Covariance:** Computing genotype likelihoods and covariance matrices using `ANGSD` without relying on hard-called SNPs.
3. **Data Visualization:** Multivariate statistical analysis (PCA) in R to correlate genetic variation with environmental metadata, producing publication-ready figures.

## 🛠️ Pipeline Architecture

### 1. SLURM Bash Script (`scripts/01_picard_angsd_pipeline.sh`)
This script demonstrates how I submit jobs to a computing cluster, manage memory (`#SBATCH --mem=250G`), load modules, and automate the `Picard` to `ANGSD` transition for multiple BAM files.

### 2. R Visualization Script (`scripts/02_pca_visualization.R`)
This script processes the `.covMat` output. 
*Note: To allow recruiters to test my coding logic without needing the raw data, this R script includes a function that automatically generates a mock covariance matrix and metadata file if the real outputs are not detected.*

## 🚀 How to Run the R Script out-of-the-box
You can test the R visualization script directly on your machine.
```R
source("scripts/02_pca_visualization.R")

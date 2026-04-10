# High-Performance Computing (HPC) Population Genomics Pipeline 🧬💻

**Author:** Octavio Morga Angel  
**Environment:** Linux / SLURM HPC Cluster  
**Languages:** Bash, R

## 📌 Project Overview

This repository is a demonstration of my bioinformatics workflow for population genomics in HPC environments. It presents a simplified but representative version of the computational architecture I design and execute for genomic data processing and downstream analysis.

## ⚙️ Workflow Components

- **Data sanitization:** removal of PCR duplicates using Picard.
- **Variant calling and covariance estimation:** computation of genotype likelihoods and covariance matrices using ANGSD without relying on hard-called SNPs.
- **Data visualization:** PCA-based analysis in R to relate genetic variation to environmental metadata and generate publication-ready figures.

## 📂 Repository Structure

```text
HPC-Population-Genomics-Pipeline/
├── README.md
├── scripts/
│   ├── 01_picard_angsd_pipeline.sh
│   └── 02_pca_visualization.R
```

## 🛠️ Script Description

### 1. `scripts/01_picard_angsd_pipeline.sh`
This Bash script demonstrates how I submit jobs to a computing cluster, manage memory allocation (`#SBATCH --mem=250G`), load required modules, and automate the transition from Picard preprocessing to ANGSD-based population genomics analysis across multiple BAM files.

### 2. `scripts/02_pca_visualization.R`
This R script processes the `.covMat` output and performs PCA-based visualization. To allow recruiters and reviewers to test the coding logic without requiring access to confidential raw data, the script can automatically generate a mock covariance matrix and example metadata when real outputs are not detected.

## 🚀 How to Run the R Script

You can test the R visualization script directly on your machine:

```r
source("scripts/02_pca_visualization.R")
```

## 🔒 Note on Data Availability

Due to strict confidentiality agreements regarding my current research on marine metagenomics and functional genomics, I cannot share raw biological datasets or embargoed scripts. This repository is therefore intended as a technical demonstration of workflow design, scripting logic, and analytical structure.

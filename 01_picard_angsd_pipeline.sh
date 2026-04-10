```bash
#!/bin/bash
#SBATCH --job-name=pop_genomics_pipeline
#SBATCH --partition=cpu,uri-cpu
#SBATCH -q long
#SBATCH --mem=250G
#SBATCH --time=90:00:00
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=tu_correo@ejemplo.com

# ==============================================================================
# PIPELINE: Mark Duplicates (Picard) and Covariance Matrix (ANGSD)
# AUTHOR: Octavio Morga Angel
# DESCRIPTION: SLURM script demonstrating HPC workflow for population genomics.
# ==============================================================================

# 1. Load Required Modules
module load uri/main picard/2.25.1-Java-11
module load angsd

# 2. Define Directories
INPUT_DIR="/path/to/input/bam"  
PICARD_DIR="/path/to/output/picard"  
ANGSD_OUT="/path/to/output/angsd_results"

mkdir -p "$PICARD_DIR"
mkdir -p "$ANGSD_OUT"

# ==============================================================================
# STEP A: Mark Duplicates using Picard
# ==============================================================================
echo "Starting Picard MarkDuplicates..."

for bam_file in "$INPUT_DIR"/*.bam; do
    base_name=$(basename "$bam_file" .bam)
    output_bam="$PICARD_DIR/${base_name}_rmdup.bam"
    metrics_file="$PICARD_DIR/${base_name}_metrics.txt"
    
    java -jar $PICARD/picard.jar MarkDuplicates \
        I="$bam_file" \
        O="$output_bam" \
        M="$metrics_file" \
        REMOVE_DUPLICATES=true \
        VALIDATION_STRINGENCY=SILENT
done

# ==============================================================================
# STEP B: Covariance Matrix Generation using ANGSD
# ==============================================================================
echo "Starting ANGSD..."

# Create a list of the new processed BAM files
ls "$PICARD_DIR"/*_rmdup.bam > "$PICARD_DIR/bam_list.txt"

angsd -bam "$PICARD_DIR/bam_list.txt" \
    -out "$ANGSD_OUT/population_cov" \
    -doCounts 1 -GL 1 -doMajorMinor 1 -doMaf 1 \
    -minMaf 0.05 -doGeno 32 -doPost 1

echo "Pipeline completed successfully."


#!/bin/bash
#SBATCH --job-name=dog_cancer_genes
#SBATCH --output=dog_genes_%A_%a.out
#SBATCH --error=dog_genes_%A_%a.err
#SBATCH --array=0-9
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=jparedes@svsu.edu

# Stop if a command fails or a variable is missing
set -euo pipefail

# Load required software
module load bowtie2
module load samtools
module load bcftools

# Define directories
FASTQ_DIR="fastq_files"
BAM_DIR="bam_outputs"
VCF_DIR="vcf_outputs"
CONSENSUS_DIR="consensus_fastas"
RESULTS_DIR="results"

mkdir -p "$BAM_DIR" "$VCF_DIR" \
         "$CONSENSUS_DIR" "$RESULTS_DIR"

# Define reference genome and Bowtie2 index
REF="genes.fasta"
REF_PREFIX="dogs_ref"

# Check that reference indexes exist
if [ ! -f "${REF}.fai" ]; then
    echo "ERROR: FASTA index missing."
    exit 1
fi

if [ ! -f "${REF_PREFIX}.1.bt2" ] && \
   [ ! -f "${REF_PREFIX}.1.bt2l" ]; then
    echo "ERROR: Bowtie2 index missing."
    exit 1
fi

# Identify all paired-end samples
mapfile -t SAMPLES < <(
    find "$FASTQ_DIR" -maxdepth 1 \
        -name '*_1.fastq' -printf '%f\n' |
    sed 's/_1.fastq$//' | sort
)

# Confirm 10 samples are present
if [ "${#SAMPLES[@]}" -ne 10 ]; then
    echo "ERROR: Expected 10 samples."
    echo "Found ${#SAMPLES[@]} samples."
    exit 1
fi

# Select sample using SLURM array task ID
SAMPLE="${SAMPLES[$SLURM_ARRAY_TASK_ID]}"

FQ1="${FASTQ_DIR}/${SAMPLE}_1.fastq"
FQ2="${FASTQ_DIR}/${SAMPLE}_2.fastq"

if [ ! -s "$FQ1" ] || [ ! -s "$FQ2" ]; then
    echo "ERROR: Missing FASTQ files for $SAMPLE"
    exit 1
fi

echo "Processing sample: $SAMPLE"

# ==========================================
# STEP 1: ALIGN SEQUENCING READS
# ==========================================

echo "Step 1: Bowtie2 alignment"

bowtie2 \
    -x "$REF_PREFIX" \
    -1 "$FQ1" \
    -2 "$FQ2" \
    -p "$SLURM_CPUS_PER_TASK" | \
samtools view \
    -@ "$SLURM_CPUS_PER_TASK" \
    -b - | \
samtools sort \
    -@ "$SLURM_CPUS_PER_TASK" \
    -m 4G \
    -o "${BAM_DIR}/${SAMPLE}.sorted.bam" -

# Index sorted BAM
samtools index \
    "${BAM_DIR}/${SAMPLE}.sorted.bam"

# ==========================================
# STEP 2: CALL GENETIC VARIANTS
# ==========================================

echo "Step 2: Variant calling"

bcftools mpileup \
    -Ou \
    -f "$REF" \
    "${BAM_DIR}/${SAMPLE}.sorted.bam" |
bcftools call \
    -mv \
    -Oz \
    -o "${VCF_DIR}/${SAMPLE}.vcf.gz"

# Index the VCF
bcftools index -f \
    "${VCF_DIR}/${SAMPLE}.vcf.gz"

# Normalize variants and split multiallelic sites
bcftools norm \
    -f "$REF" \
    -m -any \
    -Oz \
    -o "${VCF_DIR}/${SAMPLE}.normalized.vcf.gz" \
    "${VCF_DIR}/${SAMPLE}.vcf.gz"

bcftools index -f \
    "${VCF_DIR}/${SAMPLE}.normalized.vcf.gz"

# ==========================================
# STEP 3: GENERATE CONSENSUS FASTA
# ==========================================

echo "Step 3: Generating consensus FASTA"

bcftools consensus \
    -f "$REF" \
    "${VCF_DIR}/${SAMPLE}.vcf.gz" \
    > "${CONSENSUS_DIR}/${SAMPLE}.fasta"

# ==========================================
# STEP 4: ANALYZE SNPS AND INDELS
# ==========================================

echo "Step 4: Counting variants by gene"

OUTPUT="${RESULTS_DIR}/${SAMPLE}_variants.tsv"

# Create table header
printf 'Sample\tGene\tGene_Length_bp\tSNPs\tInsertions\tDeletions\tOther_Variants\tTotal_Variants\tVariants_per_kb\n' \
    > "$OUTPUT"

# Extract variants and compare against gene lengths
bcftools query \
    -f '%CHROM\t%REF\t%ALT\n' \
    "${VCF_DIR}/${SAMPLE}.normalized.vcf.gz" |
awk -v sample="$SAMPLE" '
BEGIN {
    FS=OFS="\t"
}

# Read gene names and lengths from FASTA index
FNR==NR {
    gene_length[$1]=$2
    genes[++n]=$1
    next
}

# Count variants for each gene
{
    gene=$1
    ref=$2
    alt=$3

    if (length(ref)==1 && length(alt)==1 &&
        ref ~ /^[ACGT]$/ && alt ~ /^[ACGT]$/) {
        snps[gene]++
    }
    else if (length(alt)>length(ref) &&
             index(alt,ref)==1) {
        insertions[gene]++
    }
    else if (length(ref)>length(alt) &&
             index(ref,alt)==1) {
        deletions[gene]++
    }
    else {
        other[gene]++
    }
}

END {
    for (i=1; i<=n; i++) {
        g=genes[i]

        total=snps[g]+insertions[g]+
              deletions[g]+other[g]

        density=total*1000/gene_length[g]

        printf "%s\t%s\t%d\t%d\t%d\t%d\t%d\t%d\t%.4f\n",
            sample,g,gene_length[g],
            snps[g],insertions[g],
            deletions[g],other[g],
            total,density
    }
}
' "${REF}.fai" - >> "$OUTPUT"

echo "Completed analysis for $SAMPLE"
echo "Results saved to $OUTPUT"


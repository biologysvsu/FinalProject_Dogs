#!/bin/bash
#SBATCH --job-name=bowtie_gc
#SBATCH --output=bowtie_gc_%A_%a.out
#SBATCH --error=bowtie_gc_%A_%a.err
#SBATCH --array=0-10
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=64G #increase as needed
#SBATCH --time=1-00:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=jparedes@svsu.edu

module load bowtie2
module load samtools
module load bcftools
module load bedtools

# Directories
mkdir -p bam_outputs consensus_fastas

# Reference genome (FASTA)
REF="genes.fasta"
REF_PREFIX="dogs_ref"

# FASTQ folder
FASTQ_DIR="fastq_files"

# Build Bowtie2 index once (in array task 0)
if [ "$SLURM_ARRAY_TASK_ID" -eq 0 ]; then
  if [ ! -e "${REF_PREFIX}.1.bt2" ]; then
    echo "Building Bowtie2 index..."
    bowtie2-build "$REF" "$REF_PREFIX"
  else
    echo "Index already exists, skipping."
  fi
  # Let other tasks wait
  sleep 60
fi

# Sample selection
SAMPLES=($(ls ${FASTQ_DIR}/*_1.fastq | sed 's|.*/||' | sed 's/_1.fastq//' | sort))
SAMPLE=${SAMPLES[$SLURM_ARRAY_TASK_ID]}
FQ1="${FASTQ_DIR}/${SAMPLE}_1.fastq"
FQ2="${FASTQ_DIR}/${SAMPLE}_2.fastq"

echo "Processing $SAMPLE"

# Step 1: Align with Bowtie2
bowtie2 -x "$REF_PREFIX" -1 "$FQ1" -2 "$FQ2" -p $SLURM_CPUS_PER_TASK | \
  samtools view -@ $SLURM_CPUS_PER_TASK -bS - | \
  samtools sort -@ $SLURM_CPUS_PER_TASK -o "bam_outputs/${SAMPLE}.sorted.bam"

samtools index "bam_outputs/${SAMPLE}.sorted.bam"

# Step 2: Variant calling
bcftools mpileup -Ou -f "$REF" "bam_outputs/${SAMPLE}.sorted.bam" | \
  bcftools call -mv -Oz -o "gc_windows/${SAMPLE}.vcf.gz"
bcftools index "gc_windows/${SAMPLE}.vcf.gz"

# Step 3: Generate consensus FASTA
bcftools consensus -f "$REF" "gc_windows/${SAMPLE}.vcf.gz" > "consensus_fastas/${SAMPLE}.fasta"

# Step 4: GC content in 500 bp windows #Here is where you should and your selection metrics
samtools faidx "consensus_fastas/${SAMPLE}.fasta"
bedtools makewindows -g "consensus_fastas/${SAMPLE}.fasta.fai" -w 500 > "gc_windows/${SAMPLE}_windows.bed"
bedtools nuc -fi "consensus_fastas/${SAMPLE}.fasta" -bed "gc_windows/${SAMPLE}_windows.bed" > "gc_windows/${SAMPLE}_gc.tsv"

echo "✅ Finished $SAMPLE"

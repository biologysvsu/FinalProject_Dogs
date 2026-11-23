# OPEN THE TERMINAL, GIT BASH OR POWERSHELL

## LOG INTO THE HPC
- SSH into the HPC:
  ```bash
  ssh your-psc-username@bridges2.psc.edu
  ```
- When prompted, type your password. You will not see any characters appear on the screen as you type (not even * symbols), but your input is still being recorded. Press Enter when done.

## GO TO PERSONAL STORAGE DIRECTORY
- Navigate to your personal storage directory:
  ```bash
  cd /ocean/projects/bio260081p/your-psc-username
  ```
- Create a new directory: Dogs
- cD into Dogs

vi accessions.txt
copy and paste the 10 dog accessions in here
exit and save

```
module load anaconda3
conda create -n sra-tools -c bioconda -c conda-forge sra-tools
```
```
vi download_sra.sh
```
- Type I
```
#!/bin/bash
module load anaconda3
conda activate sra-tools
 while read -r SRR; do
   echo "Downloading $SRR..."
   prefetch --max-size 100G $SRR 
   fasterq-dump --gzip $SRR --split-files -O fastq_files/
done < accessions.txt
conda deactivate
```
vi genes.fasta
copy and paste 5 gene sequences
exit with :wq

vi assembly.slurm
copy and paste script 
exit and save

execute assembly.slurm: sbatch assembly.slurm


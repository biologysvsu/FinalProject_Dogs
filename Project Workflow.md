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
Create a new directory: Dogs
cD into Dogs
Create new directory: fastq_files
cd fastq_files
submit sra job to download files
  ```
  sbatch sra_genes.fastq.slurm
  ```

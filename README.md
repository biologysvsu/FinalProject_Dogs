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
## Creating a file for the dogs breed SRR numbers
- Create a new directory: Dogs.
```
mkdir Dogs
```
- Navigate to your new directory.
```
cd /Dogs
```
- Create a text file containing 10 sample SRR numbers for the dog breeds.
```
vi accessions.txt
```
- Copy and paste "accessions.txt"
- Exit (esc) and save by typing ":wq" and hitting enter.

```
module load anaconda3
conda create -n sra-tools -c bioconda -c conda-forge sra-tools
```
```
vi download_sra.sh
```
- Type "i" to edit, then copy and paste the following
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

```
vi genes.fasta
```
Copy and paste "genes.fasta" from GitHub
Exit and save
```
vi assembly.slurm
```
Copy and paste script, making sure you change the email to reflect your own.
Exit and save

Execute assembly.slurm: 
```
sbatch assembly.slurm
```



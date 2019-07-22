#!/bin/bash

#SBATCH --job-name=question4

# send output to question4.out
#SBATCH --output=question5.out

# this job requests 1 core. Cores can be selected from various nodes.
#SBATCH --ntasks=1000

# Run the process 
srun bs.exe



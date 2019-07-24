#!/bin/bash 

#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=00:01:00

#SBATCH --job-name=monte_pi
#SBATCH --output=monte_pi.out
#SBATCH --error=monte_pi.err

export OMP_NUM_THREADS=4
./monte_pi.exec


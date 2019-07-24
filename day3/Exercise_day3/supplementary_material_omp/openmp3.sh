#!/bin/bash 

#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=00:01:00

#SBATCH --job-name=montecarlo
#SBATCH --output=montecarlo.out
#SBATCH --error=montecarlo.err

export OMP_NUM_THREADS=4

### openmp executable
./montecarlo.exec

export OMP_NUM_THREADS=8

### openmp executable
./montecarlo.exec

export OMP_NUM_THREADS=12

### openmp executable
./montecarlo.exec


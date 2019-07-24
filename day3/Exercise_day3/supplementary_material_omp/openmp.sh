#!/bin/bash -l

#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1

#SBATCH --time=00:01:00

#SBATCH --job-name=normalize_vec
#SBATCH --output=normalize_vec.out
#SBATCH --error=normalize_vec.err

export OMP_NUM_THREADS=1
./normalize_vec.exec

export OMP_NUM_THREADS=2
./normalize_vec.exec

export OMP_NUM_THREADS=3
./normalize_vec.exec


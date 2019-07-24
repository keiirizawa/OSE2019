#!/bin/bash 


#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8

#SBATCH --time=00:01:00


#SBATCH --job-name=normalize_vec
#SBATCH --output=normalize_vec.out
#SBATCH --error=normalize_vec.err

export OMP_NUM_THREADS=4

### openmp executable
./normvec.cpp.exec 

export OMP_NUM_THREADS=8

### openmp executable
./normvec.cpp.exec

export OMP_NUM_THREADS=12

### openmp executable
./normvec.cpp.exec



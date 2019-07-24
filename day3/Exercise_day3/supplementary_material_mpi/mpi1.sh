#!/bin/bash

#SBATCH --job-name=broadcast-mpi
#SBATCH --output=broadcast-mpi.out
#SBATCH --ntasks=4
#SBATCH --partition=broadwl

# load the openmpi module
	module load openmpi

# Run the process with mpirun
	mpirun broadcast.exe


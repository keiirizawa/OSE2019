#!/bin/bash -l

#SBATCH --ntasks=16

#SBATCH --time=00:02:00

#SBATCH --output=allreduce.out
#SBATCH --error=allreduce.err

# load the openmpi module
module load openmpi

### MPI executable
	mpirun ./allreduce.exec

#!/bin/bash -l

#SBATCH --ntasks=16

#SBATCH --time=00:02:00

#SBATCH --output=broadcast.out
#SBATCH --error=broadcast.err

# load the openmpi module
module load openmpi

### MPI executable
	mpirun ./broadcast.exec

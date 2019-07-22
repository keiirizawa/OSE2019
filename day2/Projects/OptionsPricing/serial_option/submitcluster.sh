#!/bin/bash

<<<<<<< HEAD
#SBATCH --job-name=question4

# send output to question4.out
#SBATCH --output=question5.out

# this job requests 1 core. Cores can be selected from various nodes.
#SBATCH --ntasks=1000

# Run the process 
srun bs.exe


=======
# set the job name to question4
#SBATCH --job-name=question4

# send output to question4.out
#SBATCH --output=question4.out

# this job requests 1 core. Cores can be selected from various nodes.
#SBATCH --ntasks=1

# Run the process 
./Question4.cpp.exec
>>>>>>> a51a7847f1efceb19a49a80f397b8efc85096d44

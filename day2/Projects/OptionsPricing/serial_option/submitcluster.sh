#!/bin/bash

# set the job name to question4
#SBATCH --job-name=question4

# send output to question4.out
#SBATCH --output=question4.out

# this job requests 1 core. Cores can be selected from various nodes.
#SBATCH --ntasks=1

# Run the process 
./Question4.cpp.exec

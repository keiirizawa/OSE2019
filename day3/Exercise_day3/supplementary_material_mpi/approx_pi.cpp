#include <iostream>
#include <cmath>
#include <stdio.h>
#include <random>
#include <mpi.h>

int main(int argc, char *argv[])
{
    using namespace std;
    int i, rank, size, N, num, R;
    int remainder, start, stop;
    double count, total_count, x, y, pi;
    R = 1;
    random_device rd;  //used to obtain seed
    mt19937 gen(rd());  //engine seeded w/ rd()
    uniform_real_distribution<double> dis(-R, R);

    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    N = 1000000;
    num = N / size;
    remainder = N % size;    

    if (rank < remainder){
        start = rank * (num + 1);
        stop = start + num;
    }

    //// Remaining 'size - remainder' ranks get 'count' tasks each
    else{
        start = rank * num + remainder;
        stop = start + (num - 1);
    }

    for (i = start; i <= stop; ++i){
        x = dis(gen);
        y = dis(gen);
        
        if (pow(x,2) + pow(y,2) <= pow(R, 2)){
            count += 1.0;
        }
    }

    /* Reduce the value of count of each processor to receivedata of rank 0 */
    MPI_Reduce(&count, &total_count, 1, MPI_DOUBLE, MPI_SUM, 0, MPI_COMM_WORLD);

    if (rank == 0){
        pi = 4 * total_count / N;
        printf("The value of pi is approximated as: %f", pi);
    }

    MPI_Finalize();
    return 0;
}

#include <iostream>
#include <cmath>
#include <omp.h>
#include <mpi.h>

#define _USE_MATH_DEFINES

const int num_steps = 500000000;

// Following split of MPI work follows closely from:
// https://stackoverflow.com/questions/15658145/how-to-share-work-roughly-evenly-
// between-processes-in-mpi-despite-the-array-size

int main(int argc, char *argv[]) {
    int i, rank, size, count, remainder, proc_id;
    int start, stop;
    double ri, root_pi;
    double sum = 0.0;
    double pi  = 0.0;

    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    //std::cout << "using " << omp_get_max_threads() << " OpenMP threads" << std::endl;

    double time = -omp_get_wtime();

    const double w = 1.0/double(num_steps);
    count = num_steps / size;
    remainder = num_steps % size;

    // First 'remainder' ranks get count + 1 each 
    if (rank < remainder){
        start = rank * (count + 1);
        stop = start + count;
    }

    // Remaining 'size - remainder' ranks get 'count' tasks each
    else{
        start = rank * count + remainder;
        stop = start + (count - 1);
    }

    #pragma omp parallel for reduction(+:sum)
    for (i = start; i <= stop; ++i){
        double x = (i + 0.5) * w;
        sum += 4.0 / (1.0 + x * x);
    }
    pi = sum * w;

    /* Reduce the value of count of each processor to rank 0 */
    MPI_Reduce(&pi, &root_pi, 1, MPI_DOUBLE, MPI_SUM, 0, MPI_COMM_WORLD);

    // #pragma omp parallel for reduction(+:sum)
    // for(int i=0; i<num; ++i) {
    //     double x = ri + (i + 0.5) * w;
    //     sum += 4.0 / (1.0 + x * x);
    // }

    // MPI_Send(&sum, 1, MPI_DOUBLE, 0, 0, MPI_COMM_WORLD);

    // if(rank == 0){
    //     for(proc_id = 0; proc_id < size; proc_id++) {
    //         MPI_Recv(&sum, 1, MPI_DOUBLE, proc_id, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
    //         pi += sum;
    //     }

    //     pi *= pi * w ;

        time += omp_get_wtime();

    if(rank == 0){
        std::cout << num_steps
            << " steps approximates pi as : "
            << root_pi
            << ", with relative error "
            << std::fabs(M_PI-root_pi)/M_PI
            << std::endl;
        std::cout << "the solution took " << time << " seconds" <<std::endl;
    }
    MPI_Finalize();

    return 0;
}

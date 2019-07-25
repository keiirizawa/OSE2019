#include <iostream>
#include <cmath>
#include <omp.h>
#include <mpi.h>

#define _USE_MATH_DEFINES

const int num_steps = 500000000;

int main(int argc, char *argv[]) {
    int i, rank, size, num;
    double sum = 0.0;
    double total_sum = 0.0;
    double ri;
    double pi  = 0.0;

    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    std::cout << "using " << omp_get_max_threads() << " OpenMP threads" << std::endl;

    const double w = 1.0/double(num_steps);
    num = num_steps / size;
    ri = rank / size;  // b/c interval [0,1]

    double time = -omp_get_wtime();

    #pragma omp parallel for reduction(+:sum)
    for(int i=0; i<num; ++i) {
        double x = ri + (i+0.5)*w;
        sum += 4.0/(1.0+x*x);
    }

    /* gather the value of count of each processor to receivedata of rank 0 */
    MPI_Gather(&sum, 1, MPI_INT, &total_sum, 1, MPI_INT, 0, MPI_COMM_WORLD);

    if (rank == 0){
        pi = total_sum*w;
    }

    time += omp_get_wtime();

    std::cout << num_steps
              << " steps approximates pi as : "
              << pi
              << ", with relative error "
              << std::fabs(M_PI-pi)/M_PI
              << std::endl;
    std::cout << "the solution took " << time << " seconds" <<std::endl;

    MPI_Finalize();
    return 0;
}

#include <iostream>
#include <cmath>
#include <stdio.h>
#include <random>
#include <omp.h>

double monte_carlo(int R, int N){
    using namespace std;
    double x, y, count_circle;

    std::random_device rd;  //used to obtain seed
    std::mt19937 gen(rd());  //engine seeded w/ rd()
    std::uniform_real_distribution<double> dis(-R, R);
    
    count_circle = 0;
    for (int i=0; i<N; i++){
        
        x = dis(gen);
        y = dis(gen);
        
        if (pow(x,2) + pow(y,2) <= pow(R, 2)){
            count_circle += 1;
        }
        
    }
    return 4 * count_circle / N;
}

double monte_carlo_omp(int R, int N){
    using namespace std;
    double x, y, count_circle;

    std::random_device rd;  //used to obtain seed
    std::mt19937 gen(rd());  //engine seeded w/ rd()
    std::uniform_real_distribution<double> dis(-R, R);

    count_circle = 0;
    #pragma omp parallel for reduction(+:count_circle)
    for (int i=0; i<N; i++){

        x = dis(gen);
        y = dis(gen);

        if (pow(x,2) + pow(y,2) <= pow(R, 2)){
            count_circle += 1;
        }

    }
    return 4 * count_circle / N;
}


int main(){
    using namespace std;
    cout << "Please prove R and N:" << endl;
    int R, N;
    double pi_omp, pi_serial;
    R = 1;
    N = 100000;
    int max_threads = omp_get_max_threads();
    double time_parallel = -omp_get_wtime();
    pi_omp = monte_carlo_omp(R, N);
    time_parallel += omp_get_wtime();

    double time_serial = -omp_get_wtime();
    pi_serial = monte_carlo(R, N);
    time_serial += omp_get_wtime();


    cout << max_threads     << " threads" << endl;
    cout << "serial     : " << time_serial << " seconds\t" << endl;
    cout <<  "parallel   : " << time_parallel <<  " seconds" << endl;
    cout << "speedup    : " << time_serial/time_parallel << endl;
    cout << "efficiency : " << (time_serial/time_parallel)/double(max_threads) << endl;
    cout << "pi serial : " << pi_serial << endl;
    cout << "pi omp    : " << pi_omp << endl;
    
    return 0;
}




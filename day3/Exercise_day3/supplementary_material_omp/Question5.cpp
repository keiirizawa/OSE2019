//
//  Question5.cpp
//  
//
//  Created by Kei Irizawa on 7/19/19.
//

#include <iostream>
#include <cmath>
#include <stdio.h>
#include <random>
#include <omp.h>

double monte_carlo(int R, int N){
    using namespace std;
    double x, y, count_circle;
    
    unsigned seed = std::chrono::system_clock::now().time_since_epoch().count();
    std::default_random_engine generator (seed);
    uniform_real_distribution<double> distribution (-R, R);
    
    count_circle = 0;
    for (int i=0; i<N; i++){
        
        x = distribution(generator);
        y = distribution(generator);
        //uniform_real_distribution<double> x = uniform_real_distribution(-R, R);
        //uniform_real_distribution<double> y = uniform_real_distribution(-R, R);

        if (pow(x,2) + pow(y,2) <= pow(R, 2)){
            count_circle += 1;
        }
        
    }
    return 4 * count_circle / N;
}

double monte_carlo_omp(int R, int N){
    using namespace std;
    double x, y, count_circle;

    unsigned seed = std::chrono::system_clock::now().time_since_epoch().count();
    std::default_random_engine generator (seed);
    uniform_real_distribution<double> distribution (-R, R);

    count_circle = 0;
    #pragma omp parallel for reduction(+:count_circle)
    for (int i=0; i<N; i++){

        x = distribution(generator);
        y = distribution(generator);

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
    double pi_omp pi_serial;
    cin >> R >> N;
    int max_threads = omp_get_max_threads();
    double time_parallel = -omp_get_wtime();
    pi_omp = monte_carlo_omp(R, N);
    time_parallel += omp_get_wtime();

    double time_serial = -omp_get_wtime();
    pi_serial = monte_carlo(R, N);
    time_serial += omp_get_wtime();

    // Check the answer
    std::cout << "parallel error : " << fabs(norm(v,N) - 1.) << std::endl;
    
    std::cout << max_threads     << " threads" << std::endl;
    std::cout << "serial     : " << time_serial << " seconds\t"
    << "parallel   : " << time_parallel <<  " seconds" << std::endl;
    std::cout << "speedup    : " << time_serial/time_parallel << std::endl;
    std::cout << "efficiency : " << (time_serial/time_parallel)/double(max_threads) << std::endl;
    cout << "pi serial : " << pi_serial << endl;
    cout << "pi omp    : " << pi_omp << endl;
    
    return 0;
}




//
//  Question5.cpp
//  
//
//  Created by Kei Irizawa on 7/19/19.
//

#include "Question5.hpp"
#include <iostream>
#include <cmath>
#include <stdio.h>
#include <random>

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

int main(){
    using namespace std;
    cout << "Please prove R and N:" << endl;
    int R, N;
    double pi;
    cin >> R >> N;
    pi = monte_carlo(R, N);
    cout << pi;
    return 0;
}




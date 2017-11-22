
#include <thrust/version.h>

#include <thrust/device_vector.h> 
#include <thrust/host_vector.h> 
#include <thrust/transform.h> 
#include <thrust/sequence.h> 
#include <thrust/copy.h> 
#include <thrust/fill.h> 
#include <thrust/replace.h> 
#include <thrust/functional.h> 
#include <iostream>

#include <stdio.h>
#include <assert.h>
#include <cuda.h>
#include <cuda_runtime.h>

#include "Microbe.h"

struct printf_functor
{
  __host__ __device__
  void operator()(double x)
  {
    printf("%f\n", x);
  }
};

__global__
void hellWorld(int test)
{
    printf("Hello from block %d, thread %d\n", blockIdx.x, threadIdx.x);
}

int main(int argc, char *argv[])
{
    int major = THRUST_MAJOR_VERSION;
    int minor = THRUST_MINOR_VERSION;

    std::cout << "Thrust v" << major << "." << minor << std::endl;
    
    double dt = 0.1;
    int num_microbes = 8;

    // Microbe m(0, 0.1);

    thrust::host_vector<Microbe> h_microbes;
    for(int i = 0; i < num_microbes; i++)
    {
        Microbe newMicrobe(i, dt);
        h_microbes.push_back(newMicrobe);
    }

    thrust::device_vector<Microbe> d_microbes = h_microbes;

    thrust::for_each(d_microbes.begin(), d_microbes.end(), Simulate_functor());

    // kernal_Simulate <<<1, 32>>>(d_microbes.begin(), d_microbes.end());
    // kernal_Simulate <<<5, 32>>>(num_microbes);
    // cudaDeviceSynchronize();
    
    return 0;
}
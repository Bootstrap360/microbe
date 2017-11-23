
#include <thrust/version.h>

#include <vector>
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

    std::vector<Microbe> microbes;
    for(int i = 0; i < num_microbes; i++)
    {
        Microbe newMicrobe(i, dt);
        microbes.push_back(newMicrobe);
    }

    thrust::host_vector<MicrobeData> h_microbesData;
    for(int i = 0; i < num_microbes; i++)
    {
        h_microbesData.push_back(microbes[i].GetGPUData());
    }
    thrust::device_vector<MicrobeData> d_microbesData;
    d_microbesData = h_microbesData;


    // thrust::device_vector<Microbe> d_microbes = microbes;

    thrust::for_each(d_microbesData.begin(), d_microbesData.end(), functor_Simulate());

    // kernal_Simulate <<<1, 32>>>(d_microbes.begin(), d_microbes.end());
    // kernal_Simulate <<<5, 32>>>(num_microbes);
    // cudaDeviceSynchronize();
    
    return 0;
}
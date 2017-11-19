
#include <thrust/fill.h>
#include <thrust/host_vector.h>

#include <thrust/for_each.h>
#include <thrust/execution_policy.h>
#include <cstdio>

#include "Microbe.h"


Microbe::Microbe()
{
    thrust::host_vector<double> h_states (6);
    d_states = h_states;
    thrust::fill(d_states.begin(), d_states.end(), 0.0);
}

void Microbe::Simulate()
{
    thrust::fill(d_states.begin(), d_states.end(), 1.0);
}

struct printf_functor
{
  __host__ __device__
  void operator()(double x)
  {
    printf("%f\n", x);
  }
};

void Microbe::Print()
{
    thrust::for_each(thrust::device, d_states.begin(), d_states.end(), printf_functor());
}



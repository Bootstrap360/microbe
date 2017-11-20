
#include <thrust/fill.h>
#include <thrust/host_vector.h>

#include <thrust/for_each.h>
#include <thrust/execution_policy.h>
#include <cstdio>
#include <math.h> 

#include "World.h"


 __device__
void step(double * states, int state_pointer, int num_sub_states, double v, double omega, double dt)
{
    // compute velocity
    states[state_pointer + 3 + num_sub_states] = states[state_pointer + 3] + cos( states[state_pointer + 2] );
    states[state_pointer + 4 + num_sub_states] = states[state_pointer + 4] + sin( states[state_pointer + 2] );
    states[state_pointer + 5 + num_sub_states] = states[state_pointer + 5] + omega;

    // compute position
    states[state_pointer + num_sub_states] = states[state_pointer] + states[state_pointer + 3 + num_sub_states] * dt;
    states[state_pointer + 1 + num_sub_states] = states[state_pointer] + states[state_pointer + 4 + num_sub_states] * dt;
    states[state_pointer + 2 + num_sub_states] = states[state_pointer] + states[state_pointer + 5 + num_sub_states] * dt;
}

__device__
void execute_instruction(double * states, int state_pointer, int num_sub_states, int instruction)
{
    double v = 1;
    double omega = 0;
    double dt = 0.1;
    if(instruction == 0)
    {
        omega = 0;
    }
    if(instruction == 1)
    {
        omega = 0.1;
    }
    if(instruction == 2)
    {
        omega = -0.1;
    }
    
    step(states, state_pointer, num_sub_states, v, omega, dt);
}

__device__
void simulate(double * states
                , int state_pointer_start
                , int num_states
                , int num_sub_states
                , int * instructions
                , int intruction_pointer_start
                , int num_instructions)
{
    int instruction_pointer = intruction_pointer_start;
    for(int state_pointer = state_pointer_start; state_pointer < num_states && instruction_pointer < num_instructions ; state_pointer = state_pointer + num_sub_states)
    {
        execute_instruction(states, state_pointer, num_sub_states, instructions[instruction_pointer]);
        instruction_pointer ++;
    }
}

__global__
void simulate_kernel(double* states, int num_states, int num_sub_states, int * instructions, int num_instructions, int num_microbes)
{
    int state_pointer_start = threadIdx.x;
    int stride = num_states * num_sub_states;
    int end_states = stride * num_microbes;
    int intruction_pointer_start;
    for (state_pointer_start = threadIdx.x; state_pointer_start < end_states;  state_pointer_start += stride)
    {
        intruction_pointer_start = threadIdx.x * num_instructions;
        simulate(states, state_pointer_start, num_states, num_sub_states, instructions, intruction_pointer_start, num_instructions);
    }
}

World::World()
{
    thrust::host_vector<double> h_states (6);
    thrust::host_vector<int> h_instructions (6);
    d_states = h_states;
    d_instructions = h_instructions;
    thrust::fill(d_states.begin(), d_states.end(), 0.0);
    thrust::fill(d_instructions.begin(), d_instructions.end(), 0);
}

void Microbe::Simulate()
{
    simulate_kernel<<1, 32
}

struct printf_functor
{
  __host__ __device__
  void operator()(double x)
  {
    printf("%f\n", x);
  }
};

void world::Print()
{
    thrust::for_each(thrust::device, d_states.begin(), d_states.end(), printf_functor());
}



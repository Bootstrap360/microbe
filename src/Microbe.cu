
#include <stdio.h>
#include <thrust/sequence.h>

#include "Microbe.h"

__host__ Microbe::Microbe(int ID, double dt, int num_poses, int num_instructions)
    : m_ID(ID)
{
    // h_poses = thrust::host_vector<State> (num_poses);
    // h_velocities = thrust::host_vector<Velocity> (num_poses);
    thrust::host_vector<int> h_instructions (num_instructions);
    for(int i = 0; i < num_instructions; i ++)
    {
        h_instructions[i] = i;
        printf("generating %i ", m_ID);
        printf("instruction = %d\n", h_instructions[i]);
    }
    thrust::device_vector<int> d_instructions = h_instructions;
    thrust::device_ptr<int> dev_ptr = d_instructions.data();
    d_instructions_ptr = thrust::raw_pointer_cast(dev_ptr);
    d_instructions_length = num_instructions;

}

// TODO: d_instructions is going to go out of scope. Need to hold onto memory

// __host void Microbe::Upload()
// {
//     d_poses = h_poses;
//     d_velocities = h_velocities;
//     d_instructions = h_instructions;
// }

//  __device__ void Microbe::Step(const State& pose, 
//                                     const State& velocity, 
//                                     const Command& command, 
//                                     State& nextPose, 
//                                     State& nextVelocity)
// {

// }

__device__ void Microbe::Simulate()
{
    for(int i = 0; i < d_instructions_length; i ++)
    {
         printf("Simulating %i ",m_ID);
         printf("instruction = %i \n", d_instructions_ptr[i]);
    }
}

// __device__ Microbe&  Microbe::AsexualReproduce()
// {
//     printf("AsexualReproduce %d", m_ID);
//     return Microbe(m_ID, m_dt);
// }

// __device__ Microbe&  Microbe::SexualReproduce( const Microbe & other)
// {
//     printf("SexualReproduce %d  and %d ", m_ID, other.m_ID);
//     return Microbe(m_ID + other.m_ID);
// }


// __device bool Microbe::operator< (const Microbe & rhs) const
// {
//     return false;
// }

// __global__ 
// void kernal_Simulate(int num_microbes)
// {
//     int microbe_number = blockIdx.x * blockDim.x + threadIdx.x;
//     if(microbe_number < num_microbes)
//     {
//             printf("Hello from block %d, blockdim %d, thread %d\n", blockIdx.x,  blockDim.x, threadIdx.x);
//             printf("Calling simulate on microbe_number %d\n", microbe_number);
//         //     d_microbes[microbe_number].Simulate();
//     }
// }


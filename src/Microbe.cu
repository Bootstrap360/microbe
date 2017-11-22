
#include <stdio.h>

#include "Microbe.h"

__host__ Microbe::Microbe(long ID, double dt, int num_poses, int num_instructions)
    : m_ID(ID)
{
    // h_poses = thrust::host_vector<State> (num_poses);
    // h_velocities = thrust::host_vector<Velocity> (num_poses);
    // d_instructions = thrust::host_vector<Velocity> (num_poses);
}

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
    printf("Simulating %d\n", m_ID);
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


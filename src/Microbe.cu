
#include <stdio.h>
#include <thrust/sequence.h>
// #include <uniform_real_distribution.h>
#include <thrust/random.h>

#include "Microbe.h"

struct GenRand
{
    __device__
    float operator () (int idx)
    {
        thrust::default_random_engine randEng;
        thrust::uniform_real_distribution<float> uniDist;
        randEng.discard(idx);
        return uniDist(randEng);
    }
};

__host__ Microbe::Microbe(int ID, double dt, int num_poses, int num_instructions)
    : m_ID(ID)
{
    // h_poses = thrust::host_vector<State> (num_poses);
    // h_velocities = thrust::host_vector<Velocity> (num_poses);

    
    h_instructions = thrust::host_vector<double> (num_instructions);

    d_instructions = h_instructions;
    thrust::transform(
        thrust::make_counting_iterator(0),
        thrust::make_counting_iterator(num_instructions),
        d_instructions.begin(),
        GenRand());
}

// TODO: d_instructions is going to go out of scope. Need to hold onto memory

__host__ void Microbe::Upload()
{
    // d_poses = h_poses;
    // d_velocities = h_velocities;
    d_instructions = h_instructions;
}

__host__ void Microbe::Download()
{
    // h_poses = d_poses;
    // h_velocities = d_velocities;
    h_instructions = d_instructions;
}

__host__ MicrobeData Microbe::GetGPUData()
{
    MicrobeData data;
    data.instructions = convertToKernel(d_instructions);
    data.ID = m_ID;
    return data;
}

//  __device__ void Microbe::Step(const State& pose, 
//                                     const State& velocity, 
//                                     const Command& command, 
//                                     State& nextPose, 
//                                     State& nextVelocity)
// {

// }

// __global__ void Microbe::kernel_Simulate()
// {
//     printf("Hello from block %d, blockdim %d, thread %d\n", blockIdx.x,  blockDim.x, threadIdx.x);
// }
__host__ void Microbe::Simulate()
{

    kernel_Simulate<<< 1,1 >>>(m_ID, convertToKernel(d_instructions));
}

// __device__ void Microbe::Simulate()
// {
//     for(int i = 0; i < d_instructions_length; i ++)
//     {
//          printf("Simulating %i ",m_ID);
//          printf("instruction = %i \n", d_instructions_ptr[i]);
//     }
// }

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

__global__
void kernel_Simulate(int ID, KernelArray<double> instructions)
{
    printf("Hello from block %d, blockdim %d, thread %d\n", blockIdx.x,  blockDim.x, threadIdx.x);
    printf("num instructions %d\n", instructions.size);
    for(int instruction_ptr = 0; instruction_ptr < instructions.size; instruction_ptr ++)
    {
        printf("%d, %d, %f\n", ID, instruction_ptr, instructions.array[instruction_ptr]);
    }
    
}

 


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


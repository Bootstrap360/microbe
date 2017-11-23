#pragma once

#include <thrust/device_vector.h> 
#include <thrust/device_reference.h> 

#include "gpuErrchk.h"

// Template structure to pass to kernel
template <typename T>
struct KernelArray
{
    T*  array;
    int size;
};
 
// Function to convert device_vector to structure
template <typename T>
KernelArray<T> convertToKernel(thrust::device_vector<T>& dVec)
{
    KernelArray<T> kArray;
    kArray.array = thrust::raw_pointer_cast(&dVec[0]);
    kArray.size  = (int) dVec.size();
 
    return kArray;
}

struct State
{
    double x, y, theta;
    bool isAlive;
};

struct Velocity
{
    double x, y, omega;
};

struct Command
{
    double velocity, omega, dt;
};

struct MicrobeData
{
    int ID;
    KernelArray<double> instructions;
};

class Microbe
{
    public:
        __host__ Microbe(int ID, double dt = 0.01, int num_poses = 256, int num_instructions = 8);


        // __device__ static void Step(const State& pose, 
        //                             const Velocity& velocity, 
        //                             const Command& command, 
        //                             State& nextPose, 
        //                             State& nextVelocity);

        // __global__ void kernel_Simulate();
        __host__ void Simulate();

        // __device__ Microbe&  AsexualReproduce();
        // __device__ Microbe&  SexualReproduce( const Microbe & other);
    
        int m_ID;

        __host__ void Upload();
        __host__ MicrobeData GetGPUData();
        __host__ void Download();

        thrust::host_vector<State> h_poses;
        thrust::host_vector<Velocity> h_velocities;
        thrust::host_vector<double> h_instructions;

    private:

        
        thrust::device_vector<State> d_poses;
        thrust::device_vector<State> d_velocities;
        thrust::device_vector<double> d_instructions;


        // double m_dt;
    
    // __device__ bool operator< (const Microbe & rhs) const;
    
    

};

__global__ 
void kernel_Simulate(int ID, KernelArray<double> instructions);

struct functor_Simulate
{
    __device__
    void operator()(MicrobeData& data)
    {
        int microbe_number = blockIdx.x * blockDim.x + threadIdx.x;
        printf("Hello from block %d, blockdim %d, thread %d\n", blockIdx.x,  blockDim.x, threadIdx.x);
        printf("Microbe ID %d\n", data.ID);
        for(int instruction_ptr = 0; instruction_ptr < data.instructions.size; instruction_ptr ++)
        {
            printf("%d, %d, %f\n", data.ID, instruction_ptr, data.instructions.array[instruction_ptr]);
        }

        // if(microbe_number < data.size)
        // {
        //     //     printf("Calling functor_Simulate on microbe_number %d\n", microbe_number);
        //     //     d_microbes[microbe_number].Simulate();
        // }
    }
};

struct Simulate_functor
{
    __device__
    void operator()(Microbe& microbe)
    {
        int microbe_number = blockIdx.x * blockDim.x + threadIdx.x;
        printf("Hello from block %d, blockdim %d, thread %d\n", blockIdx.x,  blockDim.x, threadIdx.x);
        printf("Calling simulate on microbe_number %d\n", microbe_number);
        microbe.Simulate();
    }
};
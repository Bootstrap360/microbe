#pragma once

#include <thrust/device_vector.h> 
#include <thrust/device_reference.h> 

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

class Microbe
{
    public:
        __host__ Microbe(long ID, double dt = 0.01, int num_poses = 256, int num_instructions = 5);


        // __device__ static void Step(const State& pose, 
        //                             const Velocity& velocity, 
        //                             const Command& command, 
        //                             State& nextPose, 
        //                             State& nextVelocity);

        __device__ void Simulate();

        // __device__ Microbe&  AsexualReproduce();
        // __device__ Microbe&  SexualReproduce( const Microbe & other);
    
        long m_ID;

        // __host__ void Upload();

        // thrust::host_vector<State> h_poses;
        // thrust::host_vector<Velocity> h_velocities;
        // thrust::host_vector<double> h_instructions;

    private:

        // TODO: Need pointers to below for computing

        
        // thrust::device_vector<State> d_poses;
        // thrust::device_vector<State> d_velocities;
        // thrust::device_vector<double> d_instructions;


        // double m_dt;
    
    // __device__ bool operator< (const Microbe & rhs) const;
    
    

};

__global__ 
void kernal_Simulate(int num_microbes);

struct Simulate_functor
{
    __device__
    void operator()(Microbe& microbe)
    {
        int microbe_number = blockIdx.x * blockDim.x + threadIdx.x;
        printf("Hello from block %d, blockdim %d, thread %d\n", blockIdx.x,  blockDim.x, threadIdx.x);
        printf("Calling simulate on microbe_number %d\n", microbe_number);
        microbe.Simulate();
        // if(microbe_number < num_microbes)
        // {
        //     //     d_microbes[microbe_number].Simulate();
        // }
    }
};
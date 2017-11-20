#pragma once

#include <thrust/device_vector.h> 
#include <thrust/device_reference.h> 

struct State
{
    double x, y, theta;
};

struct Command
{
    double velocity, omega, dt;
};

class Microbe
{
    public:
        __device__ __host__ Microbe(long ID, double dt = 0.01);


        __device__ static void Step(const State& pose, 
                                    const State& velocity, 
                                    const Command& command, 
                                    State& nextPose, 
                                    State& nextVelocity);

        __device__ void Simulate();

        __device__ Microbe&  AsexualReproduce();
        __device__ Microbe&  SexualReproduce( const Microbe & other);
    
        long m_ID;

    private:

        // TODO: Need pointers to below for computing
        
        thrust::device_vector<State> d_poses;
        thrust::device_vector<State> d_velocities;
        thrust::device_vector<double> d_instructions;


        double m_dt;
    
    __device__ bool operator< (const Microbe & rhs) const;
    
    __global__ 
    static void kernal_Simulate(int num_microbes)
    {
        int microbe_number = ThreadId.x;
        if(microbe_number < num_microbes)
        {
                printf("Calling simulate on microbe_number %d", microbe_number);
            //     d_microbes[microbe_number].Simulate();
        }
    };

};
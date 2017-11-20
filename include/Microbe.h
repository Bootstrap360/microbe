#pragma once

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
        __device __ __host__ Microbe();


        __device__ static void Step(const State& pose, 
                                    const State& velocity, 
                                    const Command& command, 
                                    State& nextPose, 
                                    State& nextVelocity);

        __device__ void Simulate();

        __device__ Microbe &  AsexualReproduce();
        __device__ Microbe &  SexualReproduce( const Microbe & other);
    

    private:

        thrust::device_vector<State> d_poses;
        thrust::device_vector<State> d_velocities;
        thrust::device_vector<double> d_instructions;

        double dt;
    
    bool operator<( const Microbe & rhs ) const;
    __global__ static void kernal_Simulate(thrust::device_vector<Microbe> d_microbes);
    __global__ static void kernal_Simulate(Microbe * d_microbes, int num_microbes);

};

// Kernels



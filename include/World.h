#pragma once

#include <thrust/device_vector.h>

typedef thrust::device_vector<double> States;

class World
{
    public:
        World();

        void Simulate();
        void Print();
        thrust::device_vector<double> d_states;
        thrust::device_vector<int> d_instructions;

};
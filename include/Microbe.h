#pragma once

#include <thrust/device_vector.h>

typedef thrust::device_vector<double> States;

class Microbe
{
    public:
        Microbe();

        void Simulate();
        void Print();
        States d_states;

};
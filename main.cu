
#include <thrust/version.h>

#include <thrust/device_vector.h> 
#include <thrust/transform.h> 
#include <thrust/sequence.h> 
#include <thrust/copy.h> 
#include <thrust/fill.h> 
#include <thrust/replace.h> 
#include <thrust/functional.h> 
#include <iostream>

#include "Microbe.h"

int main(int argc, char *argv[])
{
    int major = THRUST_MAJOR_VERSION;
    int minor = THRUST_MINOR_VERSION;

    std::cout << "Thrust v" << major << "." << minor << std::endl;
    

    Microbe m;
    m.Print();
    m.Simulate();
    m.Print();
    return 0;
}
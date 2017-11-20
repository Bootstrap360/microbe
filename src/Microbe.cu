

#include "Microbe.h"

__device__ __host__ Microbe::Microbe(long ID, double dt = 0.01)
    : m_ID(ID)
    , m_dt(dt)
{
    
}

 __device__ void Microbe::Step(const State& pose, 
                                    const State& velocity, 
                                    const Command& command, 
                                    State& nextPose, 
                                    State& nextVelocity)
{

}

__device__ void Microbe::Simulate()
{
    printf("Simulating %d", m_ID);
}

__device__ Microbe&  Microbe::AsexualReproduce()
{
    printf("AsexualReproduce %d", m_ID);
    return Microbe(m_ID, m_dt);
}

__device__ Microbe&  Microbe::SexualReproduce( const Microbe & other)
{
    printf("SexualReproduce %d  and %d ", m_ID, other.m_ID);
    return Microbe(m_ID + other.m_ID);
}


__device bool Microbe::operator< (const Microbe & rhs) const
{
    return false;
}


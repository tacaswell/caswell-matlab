#include <vector>
#include <iostream>
#include "particle.h"
#include "particle_track.h"
#include "params.h"

#ifndef MASTER_BOX
#define MASTER_BOX
namespace tracking{
/**
  Class to hold the master list of all particles to be processed by
  the code.  
 
*/

  class master_box{
  protected:
    /**
       Vector that contains pointers to all of the particles that are
       going to be considered in the code.  This class is responcible
       for making all of the objects to represent the particles.  This
       is all done with pointers, not with objects to take anvatage of
       polymorphism.  This class is responcible to creating and destroying
       all of the particle objects.
    */
    vector<particle_base*> contents;
  
    /**
       Pointer to wrapper to take care of particle location
       input data.  This class is responcible for creating
       and destroying this wrapper.  This pointer will be handed
       to every particle that is part of this master_box.  The
       exact type of wrapper that is made will be determined by the
       parameter object.
    */
    wrapper_i_base * in_wrapper;
    /**
       Pointer to wrapper to take care of particle location
       data output.  This class is responcible for creating
       and destroying this wrapper.  This pointer will be handed
       to every particle that is part of this master_box.  The
       exact type of wrapper that is made will be determined by the
       parameter object.
    */
    wrapper_o_base * out_wrapper;
    set<wrapper::p_vals> data_types;
  
  public:
    ///Returns the size of the box, ie number of particles
    unsigned int get_size(){return contents.size(); }
   
  
    ///prints out a representation of this in some useful way
    void print();
    
    ///add next particle
    void push(particle_base* next){
      contents.push_back(next);
    };

    ///return a pointer to particle in the location
    particle_base * get_particle(int n){
      return contents.at(n);
    }
  

    ~master_box();
  
    ///Constructor for a master_box based on
    ///data read in from a txt file
    master_box(params_file* prams_in, params_file* prams_out);

    ///Constructor that uses n to determine which type of particle
    ///objects to make
    master_box(params_file* params_in,params_file* params_out, int n);
    
    ///Returns the total number of particles contained in the
    ///master_box.
    int size(){ return contents.size();}

    ///Finalized the out_wrapper (ie, write to disk)
    void finalize_out(){
      out_wrapper->finalize_wrapper();
    }
  };


}
#endif

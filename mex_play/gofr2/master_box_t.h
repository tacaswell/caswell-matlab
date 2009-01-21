#include <vector>
#include <iostream>
#include <set>
#include "particle.h"
#include "params.h"

#include "wrapper.h"

#ifndef MASTER_BOX_T
#define MASTER_BOX_T
namespace tracking{
/**
   Templated class to hold the master list of all particles to be processed by
   the code.  
 
*/

template <class particle>
class master_box_t{
protected:
  /**
     Vector that contains pointers to all of the particles that are
     going to be considered in the code.  This class is responcible
     for making all of the objects to represent the particles.  This
     is all done with pointers, not with objects to take anvatage of
     polymorphism.  This class is responcible to creating and destroying
     all of the particle objects.
  */
  vector<particle*> particle_vec;
  
  /**
     Pointer to wrapper to take care of particle location
     input data.  This class is responcible for creating
     and destroying this wrapper.  This pointer will be handed
     to every particle that is part of this master_box_t.  The
     exact type of wrapper that is made will be determined by the
     parameter object.
  */
  wrapper_i_base * in_wrapper;
  /**
     Pointer to wrapper to take care of particle location
     data output.  This class is responcible for creating
     and destroying this wrapper.  This pointer will be handed
     to every particle that is part of this master_box_t.  The
     exact type of wrapper that is made will be determined by the
     parameter object.
  */
  wrapper_o_base * out_wrapper;
  
  //imlement this
  unsigned int  imagesz1;
  unsigned int  imagesz2;

  set<wrapper::p_vals> data_types;
  
public:
  
  
  ///prints out a representation of this in some useful way
  void print();
    
  ///add next particle
  void push(particle* next){
    particle_vec.push_back(next);
  };

  ///return a pointer to particle in the location
  particle * get_particle(int n){
    return particle_vec.at(n);
  }
  
  void append_to_data_types(wrapper::p_vals type){
    data_types.insert(type);
  }

  
  ///Constructor for a master_box_t based on
  ///data read in from a txt file
  master_box_t(params* prams_in, params* prams_out);

  ///Constructor that uses n to determine which type of particle
  ///objects to make
  master_box_t(params_file* params_in,params_file* params_out, int n);
    
  ///Returns the total number of particles contained in the
  ///master_box_t.
  unsigned int size(){ return particle_vec.size();}

  ///Finalized the out_wrapper (ie, write to disk)
  void finalize_out(){
    out_wrapper->finalize_wrapper();
  }

  ///initialize the out_wrapper
  void initialize_out(){
    out_wrapper->initialize_wrapper();
  }
  

  ///Cleans up hanging lists from the tracking procedure
  void clean_pos_link();

  ~master_box_t();
};


template <class particle>
master_box_t<particle>::master_box_t(params* params_in,params* params_out ){
  
  in_wrapper = params_in->make_wrapper_in();
  out_wrapper = params_out->make_wrapper_out();
  
  data_types = in_wrapper->get_data_types();
  data_types.insert(wrapper::d_unqid);

  particle_vec.reserve(in_wrapper->num_entries());
  for(int j = 0; j<in_wrapper->num_entries(); j++){
    particle_vec.push_back( new particle(in_wrapper, out_wrapper,j,&data_types));
  }
  
}
template <class particle>
void master_box_t<particle>::print(){
  for(unsigned int j = 0; j<particle_vec.size();j++)
    particle_vec.at(j)->print();
}

template <class particle>
master_box_t<particle>::~master_box_t(){
  //deletes the particles it made
  for(unsigned int j = 0; j<particle_vec.size();j++)
    {
      delete particle_vec.at(j);
    }
  //deletes the wrapper objects
  delete in_wrapper;
  delete out_wrapper;
}


template <class particle>
void master_box_t<particle>::clean_pos_link(){
  for(unsigned int j = 0; j<particle_vec.size();j++){
    delete particle_vec.at(j)->pos_link;
    particle_vec.at(j)->pos_link = NULL;
  }
}
}


#endif

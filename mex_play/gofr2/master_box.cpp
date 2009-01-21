#include "master_box.h"
#include "params_file.h"
using namespace tracking;

master_box::master_box(params_file* params_in,params_file* params_out ){
  
  in_wrapper = params_in->make_wrapper_in();
  out_wrapper = params_out->make_wrapper_out();
  
  data_types = in_wrapper->get_data_types();
  data_types.insert(wrapper::d_unqid);

  
  contents.reserve(in_wrapper->num_entries());
  for(int j = 0; j<in_wrapper->num_entries(); j++){
    contents.push_back( new particle_base(in_wrapper, out_wrapper,j,&data_types));
  }

}

master_box::master_box(params_file* params_in,params_file* params_out, int n ){
  
  in_wrapper = params_in->make_wrapper_in();
  out_wrapper = params_out->make_wrapper_out();
  
  data_types = in_wrapper->get_data_types();
  data_types.insert(wrapper::d_unqid);



  contents.reserve(in_wrapper->num_entries());
  for(int j = 0; j<in_wrapper->num_entries(); j++){
    contents.push_back( new particle_track(in_wrapper, out_wrapper,j,&data_types));
  }

}

void master_box::print(){
  for(unsigned int j = 0; j<contents.size();j++)
    contents.at(j)->print();
}

master_box::~master_box(){
    //deletes the particles it made
  for(unsigned int j = 0; j<contents.size();j++)
    {
      delete contents.at(j);
    }
  //deletes the wrapper objects
  delete in_wrapper;
  delete out_wrapper;
}


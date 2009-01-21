#include "particle.h"
#include "track_box.h"
#include <typeinfo>
#include <iostream>

using namespace tracking;
/*
particle_track::particle_track(wrapper_i_base * i_data, 
			       wrapper_o_base* o_out, int i_ind, 
			       track_box* i_track)
  :particle_base(i_data,  o_out,i_ind),next(NULL),prev(NULL),track(i_track)
  ,n_pos_link(NULL),p_pos_link(NULL){



}
*/
particle_track::particle_track(wrapper_i_base * i_data, 
			       wrapper_o_base* o_data, 
			       int i_ind,  
			       set<wrapper::p_vals>* contents_in)
  :particle_base(i_data,o_data,i_ind,contents_in),
   next(NULL),
   prev(NULL),
   track(NULL) ,
   n_pos_link(NULL),
   p_pos_link(NULL){

}



void particle_track::print_t(int more){
  particle_base::print();
  if(more-->0&&next!=NULL)
    next->print_t(more);
  
}

void particle_track::print(){
  particle_base::print();

}


void particle_track::set_next(particle_track* n_next){
  if(next!=NULL)
    throw "nuking the list";
  next = n_next;
}


void particle_track::set_prev(particle_track* n_prev){
  if(prev!=NULL)
    throw "nuking the list";
  prev = n_prev;
}


particle_track* particle_track::get_from_front(int n){
  if(n==0)
    return this;

  if (next == NULL)
    throw "out of range";
    
  //check for obo bugs
  return next->get_from_front(--n);
}

particle_track* particle_track::get_from_back(int n){
  if(n==0)
    return this;
  //check for obo bugs
  if (prev == NULL)
    throw "out of range";
  return prev->get_from_front(--n);
}

void particle_track::set_track(track_box* i_track){
  if(track!=NULL)
    throw "moving between lists!";
  track = i_track;

}

 track_box* particle_track::get_track(){
  return track;
}

int particle_track::get_track_id(){
  return track->get_id();
}

particle_track::~particle_track(){
  //just to be safe
  delete n_pos_link;
  delete p_pos_link;
  p_pos_link = NULL;
  n_pos_link = NULL;
}


double particle_track::get_value(wrapper::p_vals type){
  if(type == wrapper::d_next){
    if(next==NULL)
      return -1;
    //    return next->get_value(wrapper::d_unqid);
    return next->get_value(wrapper::d_index);
  }
  if(type == wrapper::d_prev){
    if(prev==NULL)
      return -1;
    return prev->get_value(wrapper::d_unqid);
  }
  if(type ==wrapper::d_trackid)
    {
      if(track==NULL)
	return -1;
      return track->get_id() ;
    }
  return particle_base::get_value(type);
}

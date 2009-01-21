#include "hash_box.h"
using namespace tracking;
void hash_box::append(hash_box* next){
  
  vector<particle_base *>::iterator it;
  for (it = next->contents.begin(); it<next->contents.end(); it++)
    contents.push_back(*it);

}

void hash_box::print(){
  
  vector<particle_base *>::iterator it;
  for (it = contents.begin(); it<contents.end(); it++)
    (*it)->print();

}

void hash_box::get_val_vec(vector<double> & vec, wrapper::p_vals type){
  
  vec.reserve(contents.size());
  vector<particle_base *>::iterator it;
  
  for (it = contents.begin(); it<contents.end(); it++){
    vec.push_back((double)(*it)->get_value(type));
  }
  
}

list<particle_track*>* hash_box::box_to_list(){

  list<particle_track*>* tmp = new list<particle_track*>;
  
  for(vector<particle_base*>::iterator it = contents.begin();
      it<contents.end(); it++)
    {
      tmp->push_back(static_cast<particle_track*>(*it));
    }


  return tmp;

}

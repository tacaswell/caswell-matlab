#include "track_box.h"

using namespace tracking;

int track_box::running_count = 0;

track_box::track_box(particle_track * first){
  t_first = first;
  t_last = first;

  id = running_count++;
  if(first != NULL){
    first->set_track(this);
    length = 1;
  }
}

void track_box::print(){
  t_first->print_t(length);
}

particle_track* track_box::at(int n){
  if (n>length)
    return NULL;
  if(n<length/2)
    return t_first->get_from_front(n);
  else
    return t_last->get_from_back(n);

}


void track_box::push_back(particle_track * next){
  if( next==NULL)
    return;
  ++length;
  //use the level of indrection so that we don't
  //have to reimplement the canity checking
  //at this point
  t_last->set_next(next);
  next->set_prev(t_last);
  next->set_track(this);
  t_last = next;
}

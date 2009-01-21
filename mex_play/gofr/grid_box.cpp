#include "grid_box.h"


grid_box::grid_box(){
  count = 0;
  first = NULL;
}


grid_box::~grid_box(){
  //  if (first!=NULL)
    delete first;
}


void grid_box::append(int* new_part){
  this->first = new particle(new_part, this->first);
  count++;
  //return count;
}

void grid_box::box_print(){
  cout<<"count: "<<this->count<<"\n";
  (*(this->first)).part_printm(0);
}

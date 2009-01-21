#include "particle.h"
#include <iostream>


void particle::part_print(int c){
  cout<<"el "<<c<<": "<<*(this->part)<<"\n";
  particle * tmp;
  tmp = this->next;
   if(this->next!=NULL)
     (*(this->next)).part_print(++c);
  return;

}

void particle::part_printm(int c){
  cout<<"el "<<c<<": "<<*(this->part)<<" ("<<*(1+(this->part))<<
    ","<<*(2+(this->part))<<")\n";

  if(this->next!=NULL)
    (*(this->next)).part_printm(++c);
  return;
}


particle::particle(int* new_part, particle* new_next){
  next = new_next;
  part = new_part;
}


particle::~particle(){
  //  if (part!=NULL)
  //   delete part;
  
  // if (next!=NULL)
    //    return;
    delete next;
}


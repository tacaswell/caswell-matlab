using namespace std;
#include <iostream>
#include "general.h"



class particle{
private:
  int* part;
  particle* next;
public:
  particle(int* new_part, particle* new_part);
  ~particle();
  particle* get_next(){return next;}
  int* get_data(){return part;}
  void part_print(int c);
  void part_printm(int c);
};

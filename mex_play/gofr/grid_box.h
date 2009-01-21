using namespace std;
#include <iostream>
#include "particle.h"



class grid_box{
private:
  int count;
  particle* first;
public:
  grid_box();
  ~grid_box();
  void append(int* next);
  int get_count(){return count;}
  particle* get_parts(){return first;}
  void box_print();
};


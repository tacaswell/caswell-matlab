#ifndef t_grid_box2_h
#define t_grid_box2_h

#include <iostream>
#include <vector>
#include "mex.h"

//T is a vector, or something that implements stl operations
//D is a pointer to the type of data being used
template <typename D>
class grid_box2{
private:
  vector<D> box;
public:
  grid_box2();
  ~grid_box2();
  void append(D* next);
  int get_count(){return box.size();}
  typename vector<D>::iterator get_parts(){return box.begin();}
  void box_print();
};

template<typename D>
grid_box2<D>::grid_box2(){
  box = new vector<D>();
  box.reserve(15);
}

template<typename D>
grid_box2<D>::~grid_box2(){
  delete box;
}


template<typename D>
void grid_box2<D>::append(D* next){
  box.push_back(next);
  return;
}
     
template<typename D>
void grid_box2<D>::box_print(){
 typename  vector<D>::iterator itr;
  itr = box.begin();
    while(itr != box.end()){
#ifndef mex_h
      mexPrintf("%d", (double)(*(itr)));
#else
      cout<<*(itr);
#endif
      itr++;
    }
}





#endif

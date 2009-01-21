#include "hash_shelf.h"

#ifndef HASH_SHELF_3D
#define HASH_SHELF_3D
namespace tracking{
  /**
     Derived class from hash_shelf to deal with three dimensions
   */
class hash_shelf3d :public hash_shelf{
public:
  unsigned int hash_function(particle_base* p){
    return 
      (((int)p->get_value(wrapper::d_zpos))/ppb)*hash_dims[0]*hash_dims[1]+
      (((int)p->get_value(wrapper::d_ypos))/ppb)*hash_dims[1]+
      (((int)p->get_value(wrapper::d_xpos))/ppb);
  }

  hash_shelf3d(vector<int> imgsz, unsigned int ippb, int i_frame):
    hash_shelf(imgsz, ippb, i_frame){};
  void print();
  void get_region( particle_base* p,
		   hash_box* box, int range=1);
  void get_region( int n,  int m, int s,
		  hash_box* box, int range=1);

  ~hash_shelf3d(){}
protected:


private:
};
}
  


#endif

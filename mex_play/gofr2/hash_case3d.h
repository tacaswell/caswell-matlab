#include "hash_case.h"
#include "hash_shelf3d.h"

#ifndef HASH_CASE3D
#define HASH_CASE3D
namespace tracking{
  
/**
   derived class from hash_case to implement a third dimension
 */
class hash_case3d:public hash_case{
public:
  template<class particle>
  hash_case3d(master_box_t<particle> & mb,vector<int> img_dims, 
	      unsigned int ppb, int frames);
  
};


template<class particle>
hash_case3d::hash_case3d(master_box_t<particle> & mb,vector<int> img_dims, 
		     unsigned int ppb, int frames){
  h_case.resize(frames);
  for(unsigned int j = 0; j<h_case.size(); j++){
    h_case.at(j) = new hash_shelf3d(img_dims, ppb,j);
  }
  // cout<<
  particle_base *p;
  for(unsigned int j = 0; j<mb.size(); j++){
    p = mb.get_particle(j);
    (h_case.at((int)(p->get_value(wrapper::d_frame))))->push(p);
  }
}

}
#endif

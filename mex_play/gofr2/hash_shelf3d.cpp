#include "hash_shelf3d.h"
using namespace tracking;

void hash_shelf3d::print(){
  for(int k = 0;k<hash_dims[2];k++){
    cout<<"Plane "<<k<<endl; 
    for(int j=0; j<hash_dims[0];j++){
      for(int i=0; i<hash_dims[1];i++){
	cout<<(hash.at( k*hash_dims[1]*hash_dims[1]+
			j*hash_dims[0] + i)).get_size()
	    <<"\t";
      }
      cout<<endl;
    }
  }
}


void hash_shelf3d::get_region( particle_base* p,
		   hash_box* box, int range){
  get_region((int)(p->get_value(wrapper::d_xpos)/ppb),
	     (int)(p->get_value(wrapper::d_ypos)/ppb),
	     (int)(p->get_value(wrapper::d_zpos)/ppb),
	     box,range);

}

void hash_shelf3d::get_region( int n,  int m, int s,
			       hash_box* box, int range){
  

  if(n<0||m<0||range<0||box==NULL)
    return;
  
  int i_bot = (((n-range)>=0)?(n-range):0);
  int i_top = ((n+range)<(int)hash_dims[0]?(n+range+1):hash_dims[0]);
  int j_bot = ((m-range)>0?(m-range):0);
  int j_top = ((m+range)<(int)hash_dims[1]?(m+range+1):hash_dims[1]);
  int k_bot = ((s-range)>0?(s-range):0);
  int k_top = ((s+range)<(int)hash_dims[2]?(s+range+1):hash_dims[2]);
  

  
  for( int i = i_bot; i<i_top;i++){ //x
    for( int j = j_bot; j<j_top;j++){//y
      for( int k = k_bot; k<k_top;k++){//z
	box->append(&(hash.at(i + hash_dims[0]*j + hash_dims[1]*hash_dims[2]*k)));
      }
    }
  }
}

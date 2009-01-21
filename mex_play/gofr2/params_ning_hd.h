#include "params_ning.h"
#include "wrapper_i_ning_hd.h"

#ifndef PARAMS_NING_HD
#define PARAMS_NING_HD
namespace tracking{
  /**
     Paramter class for the hacked down version of the file ning sent me
*/
class params_ning_hd :public params_file{
public:
  params_ning_hd(int a, int b,std::map<wrapper::p_vals,int> contents)
    :params_file(a,b,contents)
  {
    fname = string("new_ning.txt");
  }
  
  wrapper_i_base* make_wrapper_in(){
    return new wrapper_i_ning_hd(this);
  }
  

};
}

#endif

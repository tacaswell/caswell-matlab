#include "params_file.h"
#include "wrapper_i_ning.h"

#ifndef PARAMS_NING
#define PARAMS_NING
namespace tracking{
//forward declerations

  /**
     Parameter class for the file from Ning
*/

class params_ning :public params_file{
public:
  params_ning(int a, int b,std::map<wrapper::p_vals,int> contents)
    :params_file(a,b,contents)
  {
    fname = string("ning.txt");
  }
  
  virtual wrapper_i_base* make_wrapper_in(){
    return new wrapper_i_ning(this);
  }
  

};
}

#endif

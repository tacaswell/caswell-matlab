#include "params.h"
#include "wrapper_o_file.h"
#include "wrapper_i_file.h"

#ifndef PARAMS_FILE
#define PARAMS_FILE
namespace tracking{
/**
   Class for dealing with the parameters of file based wrapper
   objects.
 */  
class params_file:public params{
public:
  ///number of rows
  int rows;
  ///number of cols
  int cols;
  ///name of file to read data from
  string fname;

  ///constructor
  params_file(int a, int b, string  s, std::map<wrapper::p_vals,int> contents )
    :params(contents)
  {
    rows = a;
    cols = b;
    fname = s;
  }

  ///constructor with default file name
  params_file(int a, int b, std::map<wrapper::p_vals,int> contents )
    :params(contents){
    rows = a;
    cols = b;
    fname = string("dummy.txt");
  }

  wrapper_i_base* make_wrapper_in(){
    return new wrapper_i_file(this);
  }


  wrapper_o_base* make_wrapper_out(){
    return new wrapper_o_file(this);
  }

  

};
}
#endif

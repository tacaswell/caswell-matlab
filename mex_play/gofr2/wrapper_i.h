#include <iostream>
#include <map>

#include "wrapper.h"




#ifndef WRAPPER_BASE
#define WRAPPER_BASE

namespace tracking{
//forward declarations
class params_file;
using std::map;
using std::string;
/**
   Abstract base class for input wrappers.  Defines the basic
   functionality that a input wrapper needs to have.  This moatly
   exists to make the polymorphism in/out wrappers type safe.
 */
class wrapper_i_base: public wrapper{

private:

protected:
  

public:
  virtual double get_value(int ind, wrapper::p_vals type)=0;
  virtual void print(int ind);
  //  virtual int num_entries()=0;
  wrapper_i_base(std::map<p_vals,int>map_in):wrapper(map_in){};
  
  virtual ~wrapper_i_base(){};
  

  
};

}

#endif


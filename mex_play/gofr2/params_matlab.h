#include <vector>

#include "params.h"

#include "wrapper_i_matlab.h"
#include "wrapper_o_matlab.h"


#include "mex.h"

#ifndef PARAMS_MATLAB
#define PARAMS_MATLAB


namespace tracking{

  /**
     Parameter class for matlab input/output
   */
class params_matlab:public params{
 
public:
  ///Pointer to the pointer to the data array.  
  //using the extra level of dereference to make it work better with
  //output wrapper and matches the input/output format for the mex
  //function
  const mxArray** data_in;
  mxArray** data_out;
    
  ///Number of rows in the data
  int rows;

  ///number of columns in the data
  int cols;
  
  ///

  
  
  ///constructor
  params_matlab(const mxArray ** data_ptr,
		std::map<wrapper::p_vals,int> contents )
    :params(contents),data_in(data_ptr){

  }
  
  params_matlab( mxArray ** data_ptr,
		std::map<wrapper::p_vals,int> contents, int rows_in, int cols_in )
    :params(contents),data_out(data_ptr),rows(rows_in),cols(cols_in){

  }

    
  wrapper_i_base* make_wrapper_in(){
    return new wrapper_i_matlab(this);
  }
    
  
  wrapper_o_base* make_wrapper_out(){
    return new wrapper_o_matlab(this);
    }
    
    
};  
}
#endif

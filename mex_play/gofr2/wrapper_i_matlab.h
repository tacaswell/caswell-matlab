#include "wrapper_i.h"
#include "mex.h"


#ifndef WRAPPER_I_MATLAB
#define WRAPPER_I_MATLAB
namespace tracking{

class params_matlab;
/**
   Wrapper class for dealing with data from matlab
*/

class wrapper_i_matlab:public wrapper_i_base{
private:
  ///Pointer to matlab array that holds the data
  const mxArray * data_array;
  ///The number of rows in the array.  This isn't strictly needed,
  ///hoever it should make returning values faster by amoritizing the
  ///dereference cost, maybe
  int rows;
  ///The number of columns (and hence number of values in the array.
  ///This isn't strictly needed, hoever it should make returning
  ///values faster by amoritizing the dereference cost, maybe
  int cols;
  ///anchor to data with in array
  double * first;
protected:

  void init();
public:
  int num_entries();

  //  void print(int ind);
  void print();
  double get_value(int ind, wrapper::p_vals type);
  
  virtual ~wrapper_i_matlab();
  wrapper_i_matlab(params_matlab* param);
  wrapper_i_matlab();
  
};

}

#endif

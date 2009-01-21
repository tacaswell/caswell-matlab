#include "wrapper_o.h"
#include "mex.h"


#ifndef WRAPPER_O_MATLAB
#define WRAPPER_O_MATLAB


namespace tracking{
class params_matlab;
/**
   Wrapper class for dealing with output to matlab
*/
class wrapper_o_matlab:public wrapper_o_base{
public:  
  //old
  int  num_entries()					  {return 0;};
  void set_value(int, tracking::wrapper::p_vals, double)  {};
  void print(int)					  {};
  int  add_particle()                                     {return 0;}; 


  //new
  void set_new_value(wrapper::p_vals type, double val);
  void end_new_particle();
  void finalize_wrapper();
  void initialize_wrapper();
  void reset_wrapper(params * param);
  void start_new_particle();
  
  wrapper_o_matlab(params_matlab* parms);
  ~wrapper_o_matlab();

  void print(){};


 protected:

  
 private:
  ///Pointer to matlab array that holds the data
  mxArray ** data_array;
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
  ///index of current open particle
  int part_index;
};

}
#endif

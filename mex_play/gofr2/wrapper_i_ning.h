#include "wrapper_i.h"

#ifndef WRAPPER_NING
#define WRAPPER_NING
namespace tracking{
/**
   Wrapper class for dealing with data from a text file.  This
   is mainly for testing purposes.  The assumption is that the 
   data is stored in space deliniated file with one particle per
   row 
*/

class wrapper_i_ning:public wrapper_i_base{
public:
  int num_entries();

  //  void print(int ind);
  void print();
  double get_value(int ind, wrapper::p_vals type);
  
  virtual ~wrapper_i_ning();
  wrapper_i_ning(params_file* param);
  wrapper_i_ning(std::map<wrapper::p_vals,int>map_in);
  
protected:
  ///Pointer to the first data point of the 
  double * first;
  
  ///number of rows(particles) that the 
  int rows;

  int cols;
  //std::map<wrapper::p_vals, int> contents;
  virtual void fill_data(std::string file_name, int row, int col);
  void init();

};
}

#endif

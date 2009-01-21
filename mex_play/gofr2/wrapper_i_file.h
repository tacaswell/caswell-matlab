#include <iostream>
#include <map>

#include "wrapper_i.h"

#ifndef WRAPPER_FILE
#define WRAPPER_FILE
namespace tracking{

using std::map;
/**
   Wrapper class for dealing with data from a text file.  This
   is mainly for testing purposes.  The assumption is that the 
   data is stored in space deliniated file with one particle per
   row with the orderin [indx, x, y, I, r2,E]
*/
class wrapper_i_file:public wrapper_i_base{
private:
  ///Pointer to the first data point of the 
  double * first;
protected:
  ///number of rows(particles) that the 
  int rows;

  int cols;
  map<wrapper::p_vals, int> contents;
  void fill_data(string file_name, int row, int col);
public:
  int num_entries();

  //  void print(int ind);
  void print();
  double get_value(int ind, wrapper::p_vals type);
  
  ~wrapper_i_file();
  wrapper_i_file(params_file* param);
  

};
}

#endif

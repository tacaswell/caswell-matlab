#include "wrapper_o.h"


#ifndef WRAPPER_O_FILE
#define WRAPPER_O_FILE
namespace tracking{
//set up to use stl
using std::string;
using std::vector;
using std::map;
using std::cout;
using std::pair;
using std::endl;
using std::ofstream;
//forward declerations
class params_file;
/**
   wrapper_o class for dealing with  writing data to a file.  The
   data is stored in a vector of vectors.  The wrapper must be
   explicitly told to write the data to disk
 */

class wrapper_o_file :public wrapper_o_base{
private:

protected:
  ///File name to write data to
  string fname;

  ///Data structure to hold all of the data
  vector<vector<double> > data;

  ///number of fields per particle
  int cols;

  ///initializes the wrapper_i class
  void initialize(params_file* param);
  
  ///takes care of ensuring everything is in range for writing stuff
  ///into the data structure.
  void store_data(int index, int pos, double val);
  
  ///Map that stores what values go where in what columns
  map<wrapper::p_vals, int> contents;

public:
  ///adds another particle to the data table and fills it with
  ///zero values.  Returns the index of the new particle
  int add_particle();

  ///print out a representation of the data
  void print();
  
  void print(int ind);
  
  ///default constructor
  //nuke this eventully
  wrapper_o_file(params_file* params);
  

  int num_entries(){return data.size();}

  virtual void set_value(int ind, wrapper::p_vals type,double val);



  void set_new_value(wrapper::p_vals type, double val){};
  void end_new_particle(){};
  void finalize_wrapper(){};
  void initialize_wrapper(){};
  void reset_wrapper(params * param){};
  void start_new_particle(){};
  
  
  ///writes data structure out to disk
  void finalize();
};
}

#endif

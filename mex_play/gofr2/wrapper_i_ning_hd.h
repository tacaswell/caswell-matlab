#include "wrapper_i_ning.h"

#ifndef WRAPPER_NING_HD
#define WRAPPER_NING_HD
namespace tracking{
/**
   Wrapper class for dealing with data from a text file.  This
   is mainly for testing purposes.  The assumption is that the 
   data is stored in space deliniated file with one particle per
   row with the orderin [indx, x, y, I, r2,E]
*/

class wrapper_i_ning_hd:public wrapper_i_ning{
protected:
  void fill_data(std::string file_name, int row, int col);
public:
  wrapper_i_ning_hd(params_file* param);
};
}




#endif

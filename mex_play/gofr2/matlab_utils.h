#include "mex.h"
#include <vector>

#ifndef UTILS
#define UTILS
namespace utils{
/**
   Converts a std::vector an mxArray for output from the mexfunction.
   This assumes, but does not check that the contents of the vector
   are a number of some sort that can sensibly be cast to a double.
   This function justs copies the order, so if the 1-D array is
   secretly a 2D array, it may get transposed
*/
template<class T>
void vector_to_mat(mxArray** out, std::vector<T> &in){
  *out = mxCreateDoubleMatrix(1,in.size(), mxREAL);
   double*data = mxGetPr(*out);
   int j = 0;
   typename std::vector< T >::iterator it;
   for(it = in.begin(); it<in.end(); it++,j++)
     data[j] = (double)(*it);
};
/**
   Converts an 2 dimension array using c-style indexing to
   an mexArray.
*/
void array_to_mat(mxArray** out, double * in, int rows, int cols);

}


#endif

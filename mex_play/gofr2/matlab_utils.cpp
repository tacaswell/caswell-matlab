#include "matlab_utils.h"

using namespace utils;

void array_to_mat(mxArray** out, double * in, int rows, int cols){
  *out = mxCreateDoubleMatrix(rows,cols, mxREAL);
  double*data = mxGetPr(*out);
  for(int j = 0; j<rows;j++)
    for(int k = 0; k<cols;k++)
      //takes transpose
      *(data+rows*k + j  ) = *(in+cols*j + k );
  return;
}

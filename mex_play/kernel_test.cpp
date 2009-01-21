#include "mex.h"
#include "ipp.h"
#include "ipps.h"
#include "kernel1.h"

#include <time.h>
#include <string>
using namespace std;
#include <fstream>
#include <iostream>

/*//defined constants*/
#define epsilon 0.0001


using namespace std;

extern void _main();
void mexFunction( int nlhs, mxArray *plhs[], 
		  int nrhs, const mxArray* prhs[] )
     
{ 

  int size = 11;
  int len = size*size;
  Convolution_Kernel c = Convolution_Kernel((size-1)/2, 500,500);
  
  Ipp32f *xvec = c.get_ramp_x_kernel();
  Ipp32f *yvec = c.get_ramp_y_kernel();
  Ipp32f *svec = c.get_sin_kernel();
  Ipp32f *cvec = c.get_cos_kernel();
  Ipp32f *r2vec = c.get_r2_kernel();
  Ipp32f *circ = c.get_circle_kernel();

  plhs[0] = mxCreateDoubleMatrix(size,size,mxREAL);
  plhs[1] = mxCreateDoubleMatrix(size,size,mxREAL);
  plhs[2] = mxCreateDoubleMatrix(size,size,mxREAL);
  plhs[3] = mxCreateDoubleMatrix(size,size,mxREAL);
  plhs[4] = mxCreateDoubleMatrix(size,size,mxREAL);
  plhs[5] = mxCreateDoubleMatrix(size,size,mxREAL);
  double *data_out0 = mxGetPr(plhs[0]);
  double *data_out1 = mxGetPr(plhs[1]);
  double *data_out2 = mxGetPr(plhs[2]);
  double *data_out3 = mxGetPr(plhs[3]);
  double *data_out4 = mxGetPr(plhs[4]);
  double *data_out5 = mxGetPr(plhs[5]);
  for(int j = 0;j<len;j++)
    {
      data_out0[j] = xvec[j];
      data_out1[j] = yvec[j];
      data_out2[j] = svec[j];
      data_out3[j] = cvec[j];
      data_out4[j] = r2vec[j];
      data_out5[j] = circ[j];
    }
//  ippsFree(xvec);
//  ippsFree(yvec);
//  ippsFree(svec);
//  ippsFree(cvec);
//  ippsFree(r2vec);
//  ippsFree(circ);
//
  

}

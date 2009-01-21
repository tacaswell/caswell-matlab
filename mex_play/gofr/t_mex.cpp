
#include "t_mex.h"
#include "mex.h"


//
//void mat_to_arr(int* &out, const mxArray * in, int &sz1, int &sz2){
//  sz1 = mxGetM(in);
//  sz2 = mxGetN(in);
//  double *mat_tmp;
//  mat_tmp = mxGetPr(in);
//
//
//  out = new int[sz1*sz2];
//  for(int j=0;j<sz1;j++)
//    for(int k = 0; k<sz2;k++)
//    {
//      out[k + j*sz2] = (int)mat_tmp[j+k*sz1];
//    } 
//
//
//}

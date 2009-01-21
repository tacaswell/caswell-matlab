#include "mex.h"
#include "ipp.h"
#include "ipps.h"


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
  IppStatus status;
  Ipp64f *in_data = ippsMalloc_64f( size*size*(sizeof(Ipp64f)));
  Ipp64f *xvec = ippsMalloc_64f( size*size*(sizeof(Ipp64f)));
  Ipp64f *yvec = ippsMalloc_64f( size*size*(sizeof(Ipp64f)));

  Ipp64f *t = ippsMalloc_64f( size*size*(sizeof(Ipp64f)));

  Ipp64f *cvec = ippsMalloc_64f( size*size*(sizeof(Ipp64f)));
  Ipp64f *svec = ippsMalloc_64f( size*size*(sizeof(Ipp64f)));


  Ipp64f *tmp1 = ippsMalloc_64f( size*size*(sizeof(Ipp64f)));
  Ipp64f *tmp2 = ippsMalloc_64f( size*size*(sizeof(Ipp64f)));


  Ipp64f center = ((double) (size-1))/2;

  for(int j = 0;j<size;j++)
    {
      for(int k = 0;k<size;k++)
	{
	  xvec[j*size+k]=k;
	  yvec[j*size+k]=j;
	}
    }

  status = ippsSubC_64f_I(center, xvec,size*size);
  status = ippsSubC_64f_I(center, yvec,size*size);

  status = ippsAtan2_64f_A50(xvec,yvec,t,len);
  
  status = ippsMulC_64f_I(2,t,len);

  status = ippsSinCos_64f_A50(t,svec,cvec,len);


  
  plhs[0] = mxCreateDoubleMatrix(size,size,mxREAL);
  plhs[1] = mxCreateDoubleMatrix(size,size,mxREAL);
  plhs[2] = mxCreateDoubleMatrix(size,size,mxREAL);
  plhs[3] = mxCreateDoubleMatrix(size,size,mxREAL);
  plhs[4] = mxCreateDoubleMatrix(size,size,mxREAL);
  double *data_out = mxGetPr(plhs[0]);
  double *data_out2 = mxGetPr(plhs[1]);
  double *data_out3 = mxGetPr(plhs[2]);
  double *data_out4 = mxGetPr(plhs[3]);
  double *data_out5 = mxGetPr(plhs[4]);
  for(int j = 0;j<len;j++)
    {
      data_out[j] = svec[j];
      data_out2[j] = cvec[j];
      data_out3[j] = xvec[j];
      data_out4[j] = yvec[j];
      data_out5[j] = t[j];
    }
  ippsFree(xvec);
  ippsFree(yvec);
  ippsFree(svec);
  ippsFree(cvec);
  ippsFree(t);
  ippsFree(in_data);
  ippsFree(tmp1);
  ippsFree(tmp2);
}

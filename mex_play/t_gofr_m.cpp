#include "mex.h"
#include "ipp.h"
#include "ipps.h"
#include <time.h>
#include <string>

using namespace std;
#include <fstream>
#include <iostream>

/*//defined constants*/





extern void _main();
void mexFunction( int nlhs, mxArray *plhs[], 
		  int nrhs, const mxArray* prhs[] )
     
{ 
  //assumes 3 inputs xpos and ypos, prams
  //prams = [num_bins, max_disp xdim ydim]
  //2 outputs, vals, part_count
  //mexPrintf("Hello, world!\n"); 
  IppStatus status;
  double *m_x_pos, *m_y_pos,*m_prams;
  
  int size_x = mxGetM(prhs[0]);
  int size_y = mxGetM(prhs[1]);
  int part_count = 0;

  if (size_x!=size_y)
    {
      mexErrMsgTxt("Not same size, died");
    }

  m_x_pos = mxGetPr(prhs[0]);
  m_y_pos = mxGetPr(prhs[1]);
  m_prams = mxGetPr(prhs[2]);

  Ipp64f max_disp = m_prams[1];
  int num_bins = m_prams[0];
  Ipp64f x_dim = m_prams[2];
  Ipp64f y_dim = m_prams[3];

  Ipp64f *x_pos = ippsMalloc_64f(size_x);
  Ipp64f *y_pos = ippsMalloc_64f(size_y);
  Ipp64f *x_pos_tmp = ippsMalloc_64f(size_x);
  Ipp64f *y_pos_tmp = ippsMalloc_64f(size_y);
  Ipp64f *dist = ippsMalloc_64f(size_y);
  //  Ipp64f *distf = ippsMalloc_64f(size_y);
  
  int *hist = (int*)calloc(num_bins,sizeof(int));

  for (int j = 0; j<size_x;j++)
    {
      x_pos[j] = m_x_pos[j];
      y_pos[j] = m_y_pos[j];
    }
  
  
   
 
  for(int k = 0; k <size_x;k++)
    {

      if(x_pos[k]>max_disp && y_pos[k]>max_disp  && y_pos[k]<(y_dim-max_disp)&& x_pos[k]<(x_dim-max_disp))
	{
	  part_count++;
	  status = ippsSubC_64f(x_pos,x_pos[k],x_pos_tmp,size_x);
	  status = ippsSubC_64f(y_pos,y_pos[k],y_pos_tmp,size_x);
	  
	  status = ippsHypot_64f_A50(x_pos_tmp,y_pos_tmp,dist,size_x);
	  
	  
	  status = ippsThreshold_GTVal_64f_I(dist,size_x,max_disp,0);
      
	  status = ippsDivC_64f_I(max_disp,dist,size_x);
      
	  status = ippsMulC_64f_I(num_bins,dist,size_x);
      
	  status = ippsFloor_64f(dist,x_pos_tmp,size_x);
	  //      status = ippsFloor_64f(dist,distf,size_x);
      
	  for(int j = 1; j<size_x;j++)
	    {
	      if(dist[j]!=0)
		hist[(int)x_pos_tmp[j]]++;
	    }
	}
    
    }
  
  plhs[1] = mxCreateDoubleMatrix(1,1,mxREAL);
  double *data_out = mxGetPr(plhs[1]);
  plhs[0] = mxCreateDoubleMatrix(1,num_bins,mxREAL);
  double *data_out1 = mxGetPr(plhs[0]);

  data_out[0] = (double) part_count;

  
  for(int j = 0; j<num_bins;j++)
        data_out1[j] = hist[j];

  
  

  


  ippsFree(x_pos);
  ippsFree(y_pos);
  ippsFree(x_pos_tmp);
  ippsFree(y_pos_tmp);
  ippsFree(dist);
  //  ippsFree(distf);
  free(hist);
 
}

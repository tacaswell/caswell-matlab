#ifndef t_mex_h
#define t_mex_h
#include <vector>
#include "mex.h"
/*! \brief general functtions for dealing with matlab structures
  
 */

///copies a matlab array over to a c++ array
///
///Copies a matlab array to a c++ style array doing the 
///transposistion.
template<class T> void mat_to_arr(T* &out, const mxArray * in, int &sz1, int &sz2){
  sz1 = mxGetM(in);
  sz2 = mxGetN(in);
  double *mat_tmp;
  mat_tmp = mxGetPr(in);
  out = new T[sz1*sz2];
  for(int j=0;j<sz1;j++)
    for(int k = 0; k<sz2;k++)
    {
      out[k +  j*sz2] = (int)mat_tmp[j+k*sz1];
    } 


}

///copies a matlab array over to a c++ array
///
///Copies a matlab array to a c++ style array doing the 
///transposistion.
template<class T> void arr_to_mat(T* in, mxArray* &out, int sz1, int sz2){
  out = mxCreateDoubleMatrix(sz1,sz2,mxREAL);
  double *data_out = mxGetPr(out);
  
  for(int j=0;j<sz1;j++)
    for(int k = 0; k<sz2;k++)
    {
      data_out[j + k*sz1] = (double)in[k+j*sz2];
    } 

};


///copies a c++ array over to a matlab array
///
///Copies c++ a array to a matlab style array doing the 
///transposistion.
template<class vector> void vec_to_mat(vector* in, mxArray* &out, int sz1, int sz2){
  out = mxCreateDoubleMatrix(sz1,sz2,mxREAL);
  double *data_out = mxGetPr(out);

  typename vector::iterator itr;
  itr = in->begin();

  for(int j=0;j<sz1;j++)
    for(int k = 0; k<sz2;k++)
    {
      
      data_out[j + k*sz1] = (double)(*(itr+(k + j*sz2)));
    } 

};

#endif

//void mat_to_arr(int* &out, const mxArray * in, int &sz1, int &sz2);

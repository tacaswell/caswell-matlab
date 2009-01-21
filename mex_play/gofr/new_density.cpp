/*//standard C++ header files*/
#include <time.h>
#include <string>

using namespace std;
#include <fstream>
#include <iostream>
#include <mcheck.h>

#include "mex.h"
//local includes

#include "grid.h"

/*//defined constants*/
#define NUMCOLUMNS 9


void read_data(int parts[][NUMCOLUMNS],int max_rows){
  ifstream indatafile;
  indatafile.open("dummy.txt",ios::in);
  int i=0,j=0;
  float tmp;

  while(indatafile.eof()==false && i<max_rows) {
    for(j=0; j<NUMCOLUMNS; j++) {
      indatafile >> tmp;
      parts[i][j] = (int)tmp ;

    }
    i++;
  }
  indatafile.close();
}



//int main()
void mexFunction( int nlhs, mxArray *plhs[], 
		  int nrhs, const mxArray* prhs[] )

{
  //  mtrace();
  const mxArray *data;
  int gridsz1, gridsz2;
  
  data = prhs[0];
  

  int j;
  double *mat_tmp;
  mat_tmp = mxGetPr(data);
  
  int width = mxGetM(data);
  int height = mxGetN(data);

  int* data_in = new int[height*width];
  //cout<<height<<"  "<<width;
  int gheight, gwidth;
  for(j=0;j<height*width;j++)
    {
      data_in[j] = (int)mat_tmp[j];
    } 


  //  read_data(data,height*width);
  

  grid* test2 = new grid(data_in, height,width, 55,55,5);
  //  (*test2).print_grid();
  //cout<<(*test2).get_total_num()<<endl;
  
  test2->get_gridsz(gheight,gwidth);
  
  // test2->print_grid();
   
  plhs[0] = mxCreateDoubleMatrix(gheight,gwidth,mxREAL);
  double *data_out = mxGetPr(plhs[0]);
  
  for(j = 0;j<gheight*gwidth;j++)
    {

      data_out[j] = (double)(*test2).get_box_count(j);
	  

    }

  
   
   
  


    delete test2;
    delete data_in;

      


    //  muntrace();
 }


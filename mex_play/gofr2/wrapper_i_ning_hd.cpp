#include<iostream>
#include<fstream>
#include <stdlib.h>
#include <string>
#include <assert.h>


#include "wrapper_i_ning_hd.h"
#include "wrapper_i_ning.h"
#include "params_ning_hd.h"


using namespace tracking;
using std::cout;
using std::ifstream;
using std::endl;
using std::ios;

wrapper_i_ning_hd::wrapper_i_ning_hd(params_file* param) :wrapper_i_ning(param){
  fill_data(param->fname,param->rows,5);
};

void wrapper_i_ning_hd::fill_data(std::string file_name, int row, int col){
  //magic number, fix this
  rows = row;
  cols = 5;
  first = (double*)malloc(rows*cols*sizeof(double));
  
  double tmp=0;
  
  
  ifstream indatafile;
  //add something to deal with the case where the file
  //doesn't exist, but everything seems happy
  indatafile.open(file_name.c_str(),ios::in);
  cout<<file_name<<endl;
  //this is all magic code, needs to be generalized
  

  for(int j = 0 ; j<rows; j++){
    indatafile >> tmp;
    *(first + j*cols) = tmp;
    for(int n = 0; n<3; n++){
      indatafile >> tmp;
      //move the origin to the corner, not the center (to deal with
      //the fact that all the code is written with the assumption
      //that all of the posistions are postive and scale up to make
      //the box look bigger (purely for my brain to be happier)
      *(first  + j*cols+n+1) = (tmp+.7)*50;
      assert((tmp+.7)>0);
    }
    indatafile >> tmp;
    *(first  + j*cols+4) = tmp;
  }

 
  cout<<rows<<endl;
  indatafile.close();
};

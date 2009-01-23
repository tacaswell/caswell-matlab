//Copyright 2008,2009 Thomas A Caswell
//tcaswell@uchicago.edu
//http://jfi.uchicago.edu/~tcaswell
//
//This program is free software; you can redistribute it and/or modify
//it under the terms of the GNU General Public License as published by
//the Free Software Foundation; either version 3 of the License, or (at
//your option) any later version.
//
//This program is distributed in the hope that it will be useful, but
//WITHOUT ANY WARRANTY; without even the implied warranty of
//MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
//General Public License for more details.
//
//You should have received a copy of the GNU General Public License
//along with this program; if not, see <http://www.gnu.org/licenses>.
//
//Additional permission under GNU GPL version 3 section 7
//
//If you modify this Program, or any covered work, by linking or
//combining it with MATLAB (or a modified version of that library),
//containing parts covered by the terms of MATLAB User License, the
//licensors of this Program grant you additional permission to convey
//the resulting work.

#include<iostream>
#include<fstream>
#include <stdlib.h>
#include <string>


#include "wrapper_i_file.h"
#include "params_file.h"


using namespace tracking;
using std::cout;
using std::ifstream;
using std::endl;
using std::ios;

/**
   Implementation for wrapper_i of files.
 */


int wrapper_i_file::num_entries(){
  return rows;
}

void wrapper_i_file::fill_data(string file_name, int row, int col){
  rows = row;
  cols = col;
  first = (double*)malloc(rows*cols*sizeof(double));
  

  
  
  ifstream indatafile;
  //add something to deal with the case where the file
  //doesn't exist, but everything seems happy
  indatafile.open(file_name.c_str(),ios::in);
  int i=0,j=0;
  int tmp;

  while(indatafile.eof()==false && i<rows) {
    for(j=0; j<cols; j++) {
      indatafile >> tmp;
      *(first + i*cols + j) = (double)tmp ;
    }
    i++;
  }
 
  if(i!=rows){
    rows = i-1;
  }
  cout<<rows<<endl;
  indatafile.close();
}


double wrapper_i_file::get_value(int ind,  wrapper::p_vals type){

  
  int data_posistion = data_layout[type];
  if(data_posistion >=0)
    return *(first + ind * cols + data_posistion);


  
  //deal with error
  cout<<"wraper does not store this type of data, size of set it: "
      <<data_types.size()
      <<   endl;
  //    return;
  return -123456789;




}

/*
void wrapper_i_file::print(int ind){
  //  cout<< "file "<<"\t";
  cout<<get_value(ind, d_index)<<"\t";
  cout<<get_value(ind,d_xpos ) <<"\t";
  cout<<get_value(ind,d_ypos ) <<"\t";
  cout<<get_value(ind, d_I) <<"\t";
  cout<<get_value(ind, d_r2) <<"\t";
  cout<<get_value(ind, d_frame) <<"\t";
  cout<<endl;
}
*/
void wrapper_i_file::print(){
  cout<<"rows: "<<rows<<" cols: "<<cols<<endl;
}


wrapper_i_file::~wrapper_i_file(){
  free(first);
}


wrapper_i_file::wrapper_i_file(params_file* param):wrapper_i_base(param->contains){
  p_vals tmp[] = {d_index, d_xpos, d_ypos, d_I, d_r2, d_frame};
  int tmp2[] = {0, 1, 2 ,3,4,5};

  vector<wrapper::p_vals > tmp3(tmp, tmp+6);
  vector<p_vals>::iterator it1 = tmp3.begin();

  vector<int> tmp4(tmp2, tmp2+6);
  vector<int>::iterator it2 = tmp4.begin();

  map<p_vals, int>::iterator it3 = contents.begin();

  for( ;it2<tmp4.end() && it1<tmp3.end() ; it1++, it2++, it3++)
    contents.insert(it3,pair<p_vals, int>(*it1, *it2));
  
  /*  cout<<contents[d_index]<<"\t"
      <<contents[d_xpos	]<<"\t"
      <<contents[d_ypos	]<<"\t"
      <<contents[d_I	]<<"\t"
      <<contents[d_r2	]<<"\t"
      <<contents[d_e    ]<<"\t"
      <<endl;*/

  fill_data(param->fname,param->rows,param->cols);
  
}

/*set<wrapper::p_vals> get_data_types(){
  set<wrapper::p_vals> tmp;
  for(;;)
      return set<wrapper::p_vals>();

      }*/

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
#include "wrapper_o_matlab.h"
#include "params_matlab.h"
using namespace tracking;
using std::cout;

void wrapper_o_matlab::set_new_value(wrapper::p_vals type, double val){



  int data_posistion = data_layout[type];
  if(data_posistion >=0){
    if(part_open){
      *(first + part_index  + rows * data_posistion) = val;
      return;
    }
    //deal with fail condition
    cout<<"no particle is open"<<endl;
  }
  cout<<"wrapper doesn't have this data_type"<<endl;

}
void wrapper_o_matlab::end_new_particle(){
  part_open = false;
  part_index = -1;
  //nothing else special needs to be done in this function because we
  //are writing straight into the matlab memory.  
  return;
}
void wrapper_o_matlab::finalize_wrapper(){
  wrapper_open = false;
  //we don't need to do anything special for matlab arrays because we
  //are writing straight in to the memory
}
void wrapper_o_matlab::initialize_wrapper(){
  if(wrapper_open){
    cout<<"err, wrapper is open";
    return;
  }
  //allocates the mex array
  *data_array = mxCreateDoubleMatrix(rows,cols, mxREAL);
  first = mxGetPr(*data_array);
  wrapper_open = true;
}

void wrapper_o_matlab::reset_wrapper(params * param_in){
  params_matlab* param;
  param = dynamic_cast<params_matlab*>(param_in);
  seq_count = 0;
  part_count = 0;
  wrapper_open = false;
  part_open = false;
  data_array = param->data_out;
};

void wrapper_o_matlab::start_new_particle(){
  part_index = seq_count++;
  if(seq_count>rows){
    //deal with error
    cout<<"over max number of columns"<<endl;
    //close the wrapper so no more particle can be opened
    wrapper_open = false;
    return;
  }
  part_open = true;
}


wrapper_o_matlab::wrapper_o_matlab(params_matlab* parms)
  :wrapper_o_base(parms->contains),data_array(parms->data_out),
   rows(parms->rows),cols(parms->cols){
  //this needs more sanity checking!
}
  

wrapper_o_matlab::~wrapper_o_matlab(){
  //
  if(wrapper_open)
    finalize_wrapper();
  //do nothing because the memory is in the control of matlab, not the
  //mex code
}

 

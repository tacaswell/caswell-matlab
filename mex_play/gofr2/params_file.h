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
#include "params.h"
#include "wrapper_o_file.h"
#include "wrapper_i_file.h"

#ifndef PARAMS_FILE
#define PARAMS_FILE
namespace tracking{
/**
   Class for dealing with the parameters of file based wrapper
   objects.
 */  
class params_file:public params{
public:
  ///number of rows
  int rows;
  ///number of cols
  int cols;
  ///name of file to read data from
  string fname;

  ///constructor
  params_file(int a,  string  s, std::map<wrapper::p_vals,int> contents )
    :params(contents)
  {
    rows = a;
    cols = contents.size();
    fname = s;
  }

  ///constructor with default file name
  params_file(int a,  std::map<wrapper::p_vals,int> contents )
    :params(contents){
    rows = a;
    cols = contents.size();
    fname = string("dummy.txt");
  }

  wrapper_i_base* make_wrapper_in(){
    return new wrapper_i_file(this);
  }


  wrapper_o_base* make_wrapper_out(){
    return new wrapper_o_file(this);
  }

  

};
}
#endif

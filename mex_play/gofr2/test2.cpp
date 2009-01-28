//Copyright 2009 Thomas A Caswell
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
#include "histogram.h"
#include <iostream>
#include <cmath>

using namespace tracking;
using std::cout;
using std::cerr;
using std::endl;
using std::vector;



void vec_print2(vector<double> in){
  for(unsigned int j = 0 ; j<in.size(); j++)
    cout<<in.at(j)<<"\t";
  cout<<endl;
}


int main(){
  const double pi = 3.1415;
  Histogram h(25,0, pi);
  for(double j = -1; j<1;j = j+.001 )
    h.add_data_point(acos(j));

  h.print();
  
  cout<<"--------------------"<<endl;
  
  vector<double> tmp_v = h.get_bin_edges();
  
  vec_print2(tmp_v);
}

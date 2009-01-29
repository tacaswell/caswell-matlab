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

using namespace utilities;

using std::cout;
using std::cerr;
using std::endl;
using std::vector;

typedef vector<int> vectori;
typedef vector<double> vectord;

void Histogram::print(){
  for(vectori::iterator it = hist_array_.begin();
      it<hist_array_.end(); it++)
    cout<<*it<<"\t";
  cout<<endl;
}


Histogram::Histogram(int num_bins, double bottom, double top):
  hist_array_(num_bins,0), under_count_(0), over_count_(0), number_bins_(num_bins),
  top_edge_(top), bottom_edge_(bottom), bin_width_((top-bottom)/num_bins),
  wrapper_out_(NULL){
  
  if(bin_width_<0){
    cerr<<"negative bin width, assuming input flipped and reversing top and bottom"<<endl;
    bottom_edge_ = top;
    top_edge_ = bottom;
    bin_width_ = -bin_width_;
  }

  

}

vectori Histogram::get_bin_values(){
  
  return vectori(hist_array_);
}


vectord Histogram::get_bin_edges(){
  vectord tmp;
  tmp.reserve(number_bins_ + 1);
  
  for(int j = 0; j<number_bins_+1; j++)
    tmp.push_back(bottom_edge_  + j* bin_width_);

  if(top_edge_!= tmp.back())
    cerr<<"round error in generateing bin edges: "<<top_edge_ - tmp.back()<<endl;
  
  return vectord(tmp);
}

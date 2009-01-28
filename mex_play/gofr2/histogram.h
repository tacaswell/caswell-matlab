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
#ifndef HIST
#define HIST

#include <vector>
//forward declared until I acctuly implement it
//#include "generic_wrapper.h"
class Generic_wrapper;
namespace tracking{
/**
   Base class for historgram objects.
   Implements a linearly spaced histogram.

*/
class Histogram{
public:
  /**
     Add a data point to the histogram.  This may be better to do with just
     a number of overlaoded functions.  
   */
  template<class T>
  void add_data_point(T in);
  
  /**
     Returns a vector of length number_bins of the values in the bins
   */
  std::vector<int> get_bin_values();

  /**
     Returns a vector of the edges in the bins, has length number_bins + 1
   */
  std::vector<double> get_bin_edges();

  /**
     Spits something reasonable out to std
   */
  void print();

  int get_over_count(){
    return over_count_;
  }


  int get_ounder_count(){
    return under_count_;
  }
  /**
     Default constructor
   */
  Histogram(int num_bins, double bottom , double top);
  
  ~Histogram(){};

protected:
  /**
     Vector of the number of counts per bin
   */
  std::vector<int> hist_array_;




  /**
     Number of points that are below the bottom of the histogram
   */
  int under_count_;

  /**
     Number of points that are over the top of the histogram
   */
  int over_count_;

  /**
     Total number of bins
   */
  int number_bins_;

  /**
     The maximum value to be included in the histogram
  */
  double top_edge_;
  
  /**
     The minimum value to be included in the histogram
  */
  double bottom_edge_;

  /**
     Width of each bin
   */
  double bin_width_;
  /**
     Generic wrapper pointer for output to extrenal interfaces
   */
  Generic_wrapper * wrapper_out_;
private:


};
  
template<class T>
void Histogram::add_data_point(T in){
  double tmp_in = (double) in;
  if(tmp_in < bottom_edge_){
    ++under_count_;
    return;
  }
  if(tmp_in> top_edge_){
    ++over_count_;
    return;
  }
  
  //  ++(*(hist_array_ptr_ + ((int)((tmp_in - bottom_edge_)/bin_width_))));
  ++hist_array_[((int)((tmp_in - bottom_edge_)/bin_width_))];
  
}




}

#endif

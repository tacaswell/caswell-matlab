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
//standard includes
#include<iostream>
#include<fstream>
#include <mcheck.h>

//my includes
#include "wrapper.h"
#include "wrapper_i.h"
#include "wrapper_o.h"

#include "particle.h"
#include "params.h"


#include "hash_box.h"
#include "hash_shelf.h"
#include "track_box.h"
#include "master_box_t.h"
#include "hash_case.h"

#include "wrapper_i_ning.h"
#include "params_ning.h"
#include "hash_case3d.h"

using namespace tracking;
using std::cout;
using std::ifstream;
using std::endl;
using std::ios;

/*//defined constants*/
#define NUMCOLUMNS 6


void vec_print2(vector<double> in){
  for(unsigned int j = 0 ; j<in.size(); j++)
    cout<<in.at(j)<<"\t";
  cout<<endl;
}






int main(){
  //  mtrace();
  //  params_file p = params_file(50*50,6);
  //  params_ning_hd p = params_ning_hd(20464,6);
  map<wrapper::p_vals, int> contents;
  wrapper::p_vals tmp[] = {wrapper::d_index,wrapper::d_xpos,
			   wrapper::d_ypos, wrapper::d_zpos, 
			   wrapper::d_frame};
  int tmp2[] = {0, 1, 2 ,3,4};
  
  vector<wrapper::p_vals > tmp3(tmp, tmp+5);
  vector<wrapper::p_vals>::iterator it1 = tmp3.begin();
  
  vector<int> tmp4(tmp2, tmp2+5);
  vector<int>::iterator it2 = tmp4.begin();
  
  map<wrapper::p_vals, int>::iterator it3 = contents.begin();
  
  for( ;it2<tmp4.end() && it1<tmp3.end() ; it1++, it2++, it3++)
    contents.insert(it3,pair<wrapper::p_vals, int>(*it1, *it2));

  
  params_ning p_in = params_ning(100*1000,contents);
  params_file p_out = params_file(100*1000,contents);
    //  master_box b = master_box(&p,&p,6);

  master_box_t<particle_track>bt(&p_in,&p_out);
  //  for (int j = 0;j<25;j++)
  // (bt.get_particle(j))->print();

  
  vector<int> dims;
  for(int t = 0; t<3;t++)
    dims.push_back(70);

  //  hash_case3d s(bt,dims,5,100);
  
  //  cout<<"hashed"<<endl;

  bt.initialize_out();
  cout<<"intialized"<<endl;
 for (unsigned int j = 0;j<bt.size();j++){
   //    (bt.get_particle(j))->print();
   (bt.get_particle(j))->set_particle();
}

  bt.finalize_out();

  //s.print();

  //  hash_shelf* f = s.return_shelf(0);


  //  f->get_region(5,5,&tmp,1);
  //  tmp.print();
  
  //  track_shelf tracks;

  //  s.link(4,tracks);
  //  tracks.print();

// vector<double> bin_c, bin_r; 
//   s.gofr(9, 20, bin_c, bin_r);
//vec_print2(bin_c);



//   for(int j = 0; j<15; j++){
//     (b.get_particle(j))->set_particle();
//   }

//   b.finalize_out();
  
//   track_box tb = track_box(dynamic_cast<particle_track*>(b.get_particle(0)));
//   tb.print();
  
//   for(int j = 1; j<15; j++){
//     tb.push_back(dynamic_cast<particle_track*>(b.get_particle(j)));
//   }
  
//  tb.print();

  //  muntrace();
  return 0;
}

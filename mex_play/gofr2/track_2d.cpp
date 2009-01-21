/*
  This function is meant to be a stand alone (almost) drop in replacement for track.m for 2-D samples
  The array can 

  incantation:
  data_out[x,y,t,track_id] = track_2D(data_in[x y t], max_disp, max_x, max_y, frames);
*/

//standard includes
#include<iostream>
#include<fstream>
#include<vector>
#include<map>

//my includes

#include "master_box_t.h"
#include "track_shelf.h"


#include "params_matlab.h"
#include "hash_case3d.h"


#include "mex.h"

#include "matlab_utils.h"

using namespace tracking;
using utils::array_to_mat;
using utils::vector_to_mat;


extern void _main();
void mexFunction( int nlhs, mxArray *plhs[], 
		  int nrhs, const mxArray* prhs[] ){

  if(nlhs!=1 || nrhs!=5){
    cout<<"Error, wrong number of arguments"<<endl;
    cout<<"Provide one output array, one input 3xN array and "<<endl;
    //    return;
  }

  
  vector<int> dims;	
  dims.push_back((int)mxGetScalar(prhs[2]));    
  dims.push_back((int)mxGetScalar(prhs[3]));    
  
  track_shelf tracks;


  //nonsense to get the map set up
  map<wrapper::p_vals, int> contents;
  wrapper::p_vals tmp[] = {wrapper::d_xpos,
			   wrapper::d_ypos,
			   wrapper::d_frame};
  int tmp2[] = {0, 1, 2};

  vector<wrapper::p_vals > tmp3(tmp, tmp+3);
  vector<wrapper::p_vals>::iterator it1 = tmp3.begin();

  vector<int> tmp4(tmp2, tmp2+3);
  vector<int>::iterator it2 = tmp4.begin();

  map<wrapper::p_vals, int>::iterator it3 = contents.begin();

  for( ;it2<tmp4.end() && it1<tmp3.end() ; it1++, it2++, it3++)
    contents.insert(it3,pair<wrapper::p_vals, int>(*it1, *it2));
  //end nonsense
  //there has to be a better way to do this

  double max_disp = mxGetScalar(prhs[1]);
  if(max_disp<0)
    max_disp = 1;

  

  //set up input and output wrapers
  params_matlab p_in = params_matlab(prhs,contents);

   contents.insert(pair<wrapper::p_vals, int>(wrapper::d_trackid,3));
  
  params_matlab p_out = params_matlab(plhs,contents,mxGetM(*prhs),contents.size());
  
  //load data from matlab
  master_box_t<particle_track>bt(&p_in,&p_out);
  //make hash case
  hash_case s(bt,dims,25,(int)mxGetScalar(prhs[4]));
  //link tracks
  //  cout<<max_disp<<endl;
  s.link(max_disp,tracks);
  // s.print();

  //output to matlab
  bt.initialize_out();
  for (int j = 0;j<bt.size();j++){
    (bt.get_particle(j))->set_particle();
  }
  bt.finalize_out();
  
  return;
}

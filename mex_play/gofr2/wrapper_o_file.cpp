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
#include "wrapper_o_file.h"
#include "params_file.h"
#include <iostream>
#include <stdexcept> // out_of_range exception
#include <fstream>



using namespace tracking;





//using std::cout;
///Set the index of a particle
void wrapper_o_file::store_data(int index,int pos, double val){
 
 try{
    (data.at(index)).at(pos) = val;
    
  }
  catch(...){
    cout<<"SOMETHING BORKE"<<endl;
    data.resize(index+1);
    (data.at(index)).resize(cols);
    store_data(index,pos, val);
  }
}


///print out a representation of the data
void wrapper_o_file::print(){
  for(unsigned int j = 0; j<data.size();j++){
    for(unsigned int k = 0; k<(data.at(j)).size();k++)
      cout<<(data.at(j)).at(k)<<" ";
    cout<<endl;
  }
}
 
void wrapper_o_file::initialize(params_file* param){
  //This clearly needs to be fixed to do something with the 
  //parameter file
  p_vals tmp[] = {d_index, d_xpos, d_ypos, d_I, d_r2, d_e};
  int tmp2[] = {0, 1, 2 ,3,4,5};
  
  vector<wrapper::p_vals > tmp3(tmp, tmp+6);
  vector<p_vals>::iterator it1 = tmp3.begin();

  vector<int> tmp4(tmp2, tmp2+6);
  vector<int>::iterator it2 = tmp4.begin();

  map<p_vals, int>::iterator it3 = contents.begin();

  for( ;it2<tmp4.end() && it1<tmp3.end() ; it1++, it2++, it3++)
    contents.insert(it3,pair<p_vals, int>(*it1, *it2));
  
  cols = 6;
  fname = string("out.txt");

}

int wrapper_o_file::add_particle(){
  data.push_back(vector<double> (cols,0));
  return seq_count++;
}

void wrapper_o_file::set_value(int ind, wrapper::p_vals type,double val){
  (data.at(ind)).at(contents[type]) = val;
}

wrapper_o_file::wrapper_o_file(params_file* param){
   initialize(param);
}

void wrapper_o_file::finalize(){
  ofstream f_out(fname.data());
  cout<<"writting out the file"<<endl;
  cout<<fname<<endl;
  for(unsigned int j = 0; j<data.size(); j++){
    for(unsigned int k = 0; k<(data.at(j)).size(); k++){
      f_out<<(data.at(j)).at(k)<<"\t";
      cout<<(data.at(j)).at(k)<<"\t";
    }
    f_out<<endl;
    cout<<endl;
  }

  f_out.close();
}

void wrapper_o_file::print(int ind){
  for(unsigned int k = 0; k<(data.at(ind)).size(); k++)
    cout<<(data.at(ind)).at(k)<<"\t";
  cout<<endl;
}



#include "wrapper.h"

using namespace tracking;
using std::set;
using std::map;

std::set<wrapper::p_vals> wrapper::get_data_types(){
  set<wrapper::p_vals> tmp;
  for(map<wrapper::p_vals,int>::iterator it = data_types.begin();
      it!= data_types.end(); it++)
    tmp.insert((*it).first);
  return set<wrapper::p_vals>(tmp);
}

wrapper::wrapper(std::map<p_vals,int>map_in):data_types(map_in) {
  for(std::map<p_vals,int>::iterator it = data_types.begin();
      it!= data_types.end(); it++)
    data_layout[(*it).first] = (*it).second;

};

#include "wrapper_i.h"

using namespace tracking;
using std::map;
using std::cout;
using std::endl;
void wrapper_i_base::print(int ind){
  //  cout<< "file "<<"\t";

  for(map<wrapper::p_vals,int>::iterator it = data_types.begin();
      it!=data_types.end(); it++)
    cout<<get_value(ind, (*it).first)<<"\t";
  
  cout<<endl;
}

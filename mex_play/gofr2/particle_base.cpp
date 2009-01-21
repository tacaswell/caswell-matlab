#include "particle.h"

using namespace tracking;

int particle_base::running_total = 0;

/*particle_base::particle_base(wrapper_i_base * i_data, 
			     wrapper_o_base* o_out, int i_ind){
    wrapper_in = i_data;
    wrapper_out = o_out;
    ind = i_ind;


    //change this to extract the types of data supported by the wrapper_i
    wrapper::p_vals tmp[] = {wrapper::d_index, wrapper::d_xpos, 
			     wrapper::d_ypos, wrapper::d_I, 
			     wrapper::d_r2, wrapper::d_e};
    data_types_old =  set<wrapper::p_vals>(tmp, tmp+6);
    unq_id = running_total++;
  };
*/

particle_base::particle_base(wrapper_i_base * i_data, 
			     wrapper_o_base* o_out,
			     int i_ind,  set<wrapper::p_vals>* contents_in){
    wrapper_in = i_data;
    wrapper_out = o_out;
    ind = i_ind;
    data_types = contents_in;
    
    unq_id = running_total++;
  };



double particle_base::distancesq(particle_base* part_in){
  double X =get_value(wrapper::d_xpos) - part_in->get_value(wrapper::d_xpos);
  double Y =get_value(wrapper::d_ypos) - part_in->get_value(wrapper::d_ypos);
  //  double Z =get_value(wrapper::d_zpos) - part_in->get_value(wrapper::d_zpos);
  return X*X + Y*Y ;//+ Z*Z;
}


void particle_base::set_particle_old(){
  int tmp_ind = wrapper_out->add_particle();
  for(set<wrapper::p_vals>::iterator it = data_types_old.begin();
      it!=data_types_old.end(); it++)
    wrapper_out->set_value(tmp_ind, *it, get_value(*it));
}


void particle_base::set_particle(){
  wrapper::p_vals tmp_type;
  map<wrapper::p_vals,int> * map_tmp = wrapper_out->get_map_ptr();
  wrapper_out->start_new_particle();
    
  for(map<wrapper::p_vals,int>::iterator it = map_tmp->begin();
      it!=map_tmp->end(); it++){
    tmp_type = (*it).first;
    wrapper_out->set_new_value(tmp_type, get_value(tmp_type));
  }
  
  wrapper_out->end_new_particle();
  
}


  double particle_base::get_value(wrapper::p_vals type){
    //add check to make sure that the particle know about this
    //type
    if(type == wrapper::d_unqid)
      return (double)unq_id;

    return wrapper_in->get_value(ind, type);
  }

  void particle_base::print(){
    //    cout<<ind<<endl;
    cout<<unq_id<<"\t";
    wrapper_in->print(ind);
  }

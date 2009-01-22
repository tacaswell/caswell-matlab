#include "hash_case.h"
using namespace tracking;

void hash_case::print(){
  for(unsigned int j = 0; j<h_case.size();j++){
    h_case.at(j)->print();
    cout<<endl;
  }
}




hash_case::~hash_case(){
  for(unsigned int j = 0; j<h_case.size(); j++){
    delete h_case.at(j);
  }
}

void hash_case::rehash(unsigned int ppb){
  for(vector<hash_shelf*>::iterator it = h_case.begin();
      it<h_case.end(); it++)
    (*it)->rehash(ppb);
}

void hash_case::link(double max_range, track_shelf& tracks){

  this->rehash((int)(1.2*max_range));

  vector<hash_shelf*>::iterator it = h_case.begin();

  //generate first list
  list<particle_track*>* t_list = (*it)->shelf_to_list();

  //fill first track pos_link_next
  fill_pos_link_next(t_list,++it,max_range);

  for(list<particle_track*>::iterator it2 = t_list ->begin();
      it2!=t_list->end(); it2++)
    tracks.add_new_track(*it2);
  

  //  tracks.print();
  
  //make local track_list object
  track_list tracking(t_list, max_range,&tracks);
  
  int stupid_counter = 0;
  //cout<<"here"<<endl;
  //loop over shelves
  while( it<(h_case.end()-1))
  {
    ++stupid_counter;
    if(stupid_counter%50==0)
      cout<<stupid_counter<<endl;;
    //generate next list
    t_list = (*it)->shelf_to_list();
    //    cout<<": "<<t_list->size()<<endl;
    
    //fill next list's pos_link_next
    fill_pos_link_next(t_list,++it,max_range);
    


    //shove in to track_list
    tracking.link_next(t_list);
  
  }
  //make last list
  t_list = (*it)->shelf_to_list();
  tracking.link_next(t_list);
  cout<<"here"<<endl;
}

bool lt_pair_tac(const pair<particle_track*, double> &  lh, const pair<particle_track*, double> & rh){
    return lh.second<rh.second;
  }

void hash_case::fill_pos_link_next(list<particle_track*>* tlist, 
			vector<hash_shelf*>::iterator in_it, double max_disp)
{
  hash_box tmp_box;
  double distsq;
  list<particle_track*>* tmp_list = NULL;
  particle_track* tmp_particle1 = NULL;
  particle_track* tmp_particle2 = NULL;
  
  //square the maximum dispalcement to save having to take square roots later
  max_disp = max_disp*max_disp;


  //loop over partciles in handed in list
  for(list<particle_track*>::iterator it = tlist->begin();
            it != tlist->end(); it++)
    {
      tmp_particle1 = (*it);
      tmp_box.clear();

      (*in_it)->get_region(*it,&tmp_box, 1);

      //      cout<<"box size: "<<tmp_box.get_size()<<endl;
      
      //allocates a list
      tmp_list = tmp_box.box_to_list();
     
      //loop over the list to be added to the current particle to add
      //the the current particle as a previous to each of them and
      //remove the ones that are too far away
      for(list<particle_track*>::iterator it2 = tmp_list->begin();
	  it2!=tmp_list->end();it2++){

	tmp_particle2 = (*it2);
	distsq = (tmp_particle1->distancesq(tmp_particle2));
	//if the particles are with in the maximum dispalacement of eachother
	if(distsq<max_disp){
	  
	  //make sure the lists exist
	  if(tmp_particle2->p_pos_link==NULL){
	    tmp_particle2->p_pos_link = new list<pair<particle_track*,double> >;
	  }
	  if(tmp_particle1->n_pos_link==NULL){
	    tmp_particle1->n_pos_link = new list<pair<particle_track*,double> >;
	  }
	 
	  //add pairing to list
	  (tmp_particle2->p_pos_link)->
	    push_back(pair<particle_track*, double>(tmp_particle1,distsq));
	  (tmp_particle1->n_pos_link)->
	    push_back(pair<particle_track*, double>(tmp_particle2,distsq));
	  
	}
      }
      if(tmp_particle1->n_pos_link!=NULL)
	(tmp_particle1->n_pos_link)->sort(lt_pair_tac);
      //deletes the list
      delete tmp_list;
      tmp_list = NULL;

    }
}






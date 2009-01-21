#include "track_shelf.h"
using namespace tracking;

track_shelf::~track_shelf(){
  for(map<int,track_box*>::iterator it = track_map.begin();
      it!=track_map.end(); it++)
    delete it->second;
}


void track_shelf::add_new_track(particle_track* first_part){
  if(first_part ==NULL)
    throw "null particle";
  track_box * tmp_box = new track_box(first_part);
  track_map.insert(pair<int,track_box*>(tmp_box->get_id(), tmp_box));

}

void track_shelf::add_to_track(int track, particle_track* next_particle){
  map<int,track_box*>::iterator it = track_map.find(track);
  if(it == track_map.end())
    throw "not in map";
  if(next_particle ==NULL)
    throw "null particle";
  (it->second)->push_back(next_particle);
}

void track_shelf::remove_track(int track){
  map<int,track_box*>::iterator it = track_map.find(track);
  if(it == track_map.end())
    throw "not in map";
  delete it->second;
  it->second = NULL;
  track_map.erase(it);
}

track_box* track_shelf::get_track(int track){
  map<int,track_box*>::iterator it = track_map.find(track);
  if(it == track_map.end())
    throw "not in map";
  return it->second;
}

void track_shelf::print(){
 for(map<int,track_box*>::iterator it = track_map.begin();
     it!=track_map.end(); it++)
   {
     cout<<"track id: "<<it->first<<endl;
     (it->second)->print();
   }
}

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
#include <map>
#include "track_box.h"
#include "particle.h"

#ifndef TRACK_SHELF
#define TRACK_SHELF
namespace tracking{
/**
   Top level class for holding the track boxes. (which are the head of
   the linked lists made of particle_track objects) eventually I think
   all the track_* classes but this one will be made completely
   private with friend functions.
*/

class track_shelf{

public:
  /**
     Add a track to the shelf.  Evnetually this function will be the only
     way to add a new track
     @param first_part
     The first particle in the track
   */
  void add_new_track(particle_track* first_part);
  /**
     Adds a particle to the end of the track specified.
     @param track
     the unique id of the track to add the particle to
     @param next_particle
     pointer to the next particle to be added 
   */
  void add_to_track(int track, particle_track* next_particle);

  /**Removes the track specified.  Removes and destroys the track.  Be
     aware of this and make sure there arn't any dangling refernces
     left.  
     @param 
     track unique ID of track to be removed
   */
  void remove_track(int track);
  
  /**
     Returns a pointer to the track_box for the specified track
     @param track
     unique ID of track to be removed 
   */
  track_box* get_track(int track);

  void print();

  /**
     Sets all of the particles in shelf to their respective wrappers
  */
  void set_shelf();

  ///Constructor
  track_shelf(){};
  ///Destructor.  Destroys all of the tracks contained in the shelf
  ~track_shelf();
protected:
  /** 
      Map to store locations of tracks.  Map used instead of a vector
      because each track has a unique number set on construction, but
      I want to be able to nuke tracks entirely, with out having to
      store empty boxes or deal with renumbering all tracks.  There is
      a hit on the access time (logrithmic vs constant) comapred to
      using a vector, but I think the time saved (both at run time and
      coding time) by not having the extra baggage to keep track of
      everything is worth it.  
  */
  map<int,track_box*> track_map;  
};
}


#endif

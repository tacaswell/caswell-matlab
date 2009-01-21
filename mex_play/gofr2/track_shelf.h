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

  ///Constructor
  track_shelf(){};
  ///Destructor.  Destroys all of the tracks contained in the shelf
  ~track_shelf();
  
};
}


#endif

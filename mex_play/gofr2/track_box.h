#include <vector>
#include "particle_track.h"

#ifndef TRACK_BOX
#define TRACK_BOX
namespace tracking{
/**
   Box class for dealing with tracks.  Essentially roling my own
   linked list class
*/


class track_box{
protected:
  ///Pointer to first particle in track
  particle_track * t_first;
  //pointer to last particle in track
  particle_track * t_last;
  ///length of path
  int length;
  ///the number of tracks identified used for unique id's
  static int running_count;
  ///unique ID of the track
  int id;
public:
  ///retruns the nth particle of the track.
  ///returns null if n > length
  particle_track * at(int n);

  ///adds the particle next the end of the track
  void push(particle_track* next);
  ///Extracts velocity vector from track, details of implementation
  ///pending
  void extract_velocity();
  
  ///Constructor
  track_box(particle_track * first);
    
  ///Prints outs some representation of the track
  virtual void print();

  void push_back(particle_track* next);

  int get_id(){return id;}

  virtual ~track_box(){};

};
}

#endif

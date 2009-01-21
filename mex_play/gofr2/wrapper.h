#include <set>
#include <map>

#ifndef WRAPPER_
#define WRAPPER_
namespace tracking{
/**
   Abstract base class from which all of the particle wrappers are derived.
   The family derived from wrapper_generic should be used for non-particle
   output (ie, vectors, representation of sets/maps, etc)
   This exists mostly to be a common place to define the enumeration of
   data types
 */

class wrapper{
public:
  ///enumeration for data types
  enum p_vals {d_index=0, 
	       d_xpos, 
	       d_ypos, 
	       d_frame, 
	       d_I, 
	       d_r2, 
	       d_e,
	       d_next,
	       d_prev, 
	       d_dx, 
	       d_dy, 
	       d_orgx, 
	       d_orgy, 
	       d_zpos,
	       d_unqid,
	       d_trackid};

  ///Prints out the currents contents of the wrapper in some
  ///sort of sensible way.
  virtual void print() = 0;
  
  ///returns the current number of particle entires that the wrapper
  ///has under it's control.  
  virtual int num_entries()=0;

  /**
     Returns a set of the types of data that the wrapper knows how
     to deal with.  
   */
  virtual std::set<p_vals> get_data_types();

  /**
     Returns a pointer to the map
  */
  std::map<p_vals, int>* get_map_ptr(){
    return &data_types;
  }

  wrapper(std::map<p_vals,int>map_in);
  wrapper(){};
  virtual ~wrapper(){};

  
protected:
  ///Boolean value to determine if this is a cloned wrapper or not.
  ///If the data structure of this is pointing at the same chunk of memory
  ///as another wrapper, then it only needs to be deleted once.
  ///Currently none of this is implemented
  bool clone;
  /**
     A map between the data types and a posistion in the data structure.
     This orginally had been burried down in the derived classes, but 
     I couldn't think of a data structure for storing particle data where
     this sort of thing wasn't uesful.  Thus, it has been dragged up to
     the top level.
   */
  std::map<p_vals, int> data_types;
  int data_layout[16];
};
}
#endif

 

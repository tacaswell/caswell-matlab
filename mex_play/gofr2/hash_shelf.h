#include <vector>
#include <list>
#include <vector>

#include "hash_box.h"

#include "master_box_t.h"

#ifndef HASH_SHELF
#define HASH_SHELF
namespace tracking{
/**
   Class to implemnt the hash table
 */

class hash_shelf{
public:
  void push(particle_base * p){
    (hash.at(hash_function(p))).push(p);
  }

  ///Constructor for un-tempalted master box class, to be removed
 //  hash_shelf(master_box & mb,unsigned int imsz1, 
// 	     unsigned int imsz2, unsigned int ppb);

  ///Templated constructor for dealing with templated master_box_t objects
  template <class particle>
  hash_shelf(master_box_t<particle> & mb, int imsz1, 
	      int imsz2, unsigned int ppb);

  ///Constructor that makes an empty hash_shelf
  hash_shelf(unsigned int imsz1, unsigned int imsz2, 
	     unsigned int ppb,int i_frame);
  ///Constructor that makes an empty hash_shelf
  hash_shelf(vector<int>imgsz, unsigned int ppb, int i_frame);

  ///Changed the pixels per box and re-hashes the shelf
  void rehash(unsigned int PPB);
  
  ///Generates the hash value based on a pointer to a particle object
  virtual unsigned int hash_function(particle_base* p);

  ///Destructor
  virtual ~hash_shelf(){};

  ///Print function
  virtual void print();

  ///@name Getter Functions
  ///@{

  ///returns the box at (n,m)
  hash_box* get_box(int n, int m){
    return &(hash.at(hash_dims[1]*n + m));
  }
  
  ///Retruns the hash for the particle p


  void get_region( int n,  int m, 
		  hash_box* box, int range=1);

  void get_region( int n,
		   hash_box* box, int range=1);
  virtual void get_region( particle_base* n,
		   hash_box* box, int range=1);
  ///@}

  ///@name g(r)
  ///@{

  ///returns the fully normalized g(r)
  void gofr_norm(double max_d, int nbins,
	    vector<double>& bin_count,vector<double>& bin_r);
  /**
     returns the total number of particles.  The bin_c is
     normalized by area and density, but not averaged
   */
  int gofr(double max_d, int nbins,
	    vector<double>& bin_count,vector<double>& bin_r);
  ///@}

  /**
     Generates and returns a pointer to all the particles in
     this shelf in a list form.  This makes new objects on the
     heap, be aware of this for memory leaks.
   */
  list<particle_track*> * shelf_to_list();

private:
  ///Initialization function
  //  void init(unsigned int X, unsigned int Y, unsigned int PPB);
  void init2(vector<hash_box> & tmp);

protected:
  //change all of this to be pointers to hash_boxes, to keep
  //consistent with everythign else


  ///Main data structure.  This is an vector of
  ///hash boxes.  For simplicity the strcuture is stored as
  ///a 1-D array and the class takes care of the 1D<->2D conversion
  vector<hash_box> hash;
  
  ///@name grid properties.
  /// These should not be allowed to change once
  /// the hash table is instantiated 
  //@{ 
  ///Number of pixel rows in initial image
  //  unsigned int imagesz1;
  ///Number of pixel columns in initial image
  //  unsigned int imagesz2;
  ///number of rows in the grid
  //  unsigned int sz1;
  ///number of colmns in the grid
  //  unsigned int sz2;
  ///Vector to store the dimensions of the grid
  vector<int> hash_dims;
  ///Vector to store the dimensions of input data
  vector<int> img_dims;
  
  ///number of pixels per side of the gridboxes
  unsigned int ppb;
  //@}
  ///stores the plane number of the 
  int plane_number;


  
};

template <class particle>
hash_shelf::hash_shelf(master_box_t<particle> & mb, int imsz1, 
		       int imsz2, unsigned int PPB): ppb(PPB){
  img_dims.push_back(imsz1);
  img_dims.push_back(imsz2);
  cout<<img_dims[0]<<endl
      <<img_dims[1]<<endl;
  init2(hash);
  for(unsigned int j = 0; j<mb.size();j++)
    {
      particle* p = mb.get_particle(j);
      push(p);
    }
  
  

}

inline unsigned int hash_shelf::hash_function(particle_base* p){
    return (unsigned int)
      (((unsigned int)p->get_value(wrapper::d_ypos)/ppb)*hash_dims[0] +
       p->get_value(wrapper::d_xpos)/ppb);
}
}
#endif

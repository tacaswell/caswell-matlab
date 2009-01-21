using namespace std;
#include <iostream>
#include "grid_box.h"
#include "grid_box2.h"
#include <vector>
#include "t_mex.h"
/*!
 \brief hash table

 This is the hash table for speeding up calculations involving
 neighborhoods around particles.  Consits of an array of boxes
 that each contain a linked list of particles that go in that box
 */
class grid{
private:
  //!the array that is the hash table
  grid_box *grid_d;
  int gridsz1;///<size of hash table along first dimension
  int gridsz2;///<size of hash table along second dimension
  int ppb; ///<number of pixels from the orginal image per box

  //!private function to initilize the grid and memory allocation
  void init(int gridsz1, int gridsz2, int ppb);

public:
  //!constructor of empty grid
  grid(int gridsz1, int gridsz2, int ppb);
  //!fills hases data from an mxArray
  grid( const mxArray * in, const int imsz1, 
     const int imsz2,int ppb);
  //!fills grid hases from an int array [FOR TESTING ONLY]
  grid(int * parts, const int num_parts,const int num_rows, const int imsz1, 
       const int imsz2,int ppb);

  //!destructor
  ~grid();
  

 
  //! returns total number of particles in table
  int get_total_num();
  //! returns size of grid
  void get_gridsz(int &sz1, int& sz2){sz1 = gridsz1; sz2 = gridsz2;return; }
  //!returns the grid_box at a given location
  grid_box* get_box(int cord1,int cord2){return grid_d+cord1+gridsz1*cord2;}
  //! returns the number of particles in a given box
  int get_box_count(int index);
  //! prints grid via print functions for gird_boxes
  void print_grid();
  /*! returns a representation of the hash table.  Implemented by
    calling the count of each grid_box. Returns a gridsz1 X
    gridsz2 by 1 int array
  */
  int * return_density();
  /*! returns a representation of the hash table.  Implemented by
    calling the count of each grid_box.  Returns a gridsz1 X
    gridsz2 by 1 int vector.
  */
  vector<int> * return_densityv();
  //!

};

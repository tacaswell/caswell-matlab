#include <string>
#include "wrapper.h"
#include "wrapper_i.h"
#include "wrapper_o.h"




#ifndef PARAMS
#define PARAMS
namespace tracking{
/**
    Abstract base Class to handle passing parameters around between
    the levels of the functions.  This will have lots of children.
 */

class params{

public:
  std::map<wrapper::p_vals,int> contains;
  ///Default constructor
  params(std::map<wrapper::p_vals,int> contents ):contains(contents){};
  ///hack to make stuff compile, kill this!
  //  params(){};
  ///virtual default destructor
  virtual ~params(){};
  /**
     Returns a pointer to a output wrapper_o object based on the
     parameter object.  This function instataites an object, but the
     paramter class does not clean it up.  This should only be called
     in cases where how it will be cleaned up is clear.  This should
     probably be moved in to protected and have every child class be
     friends with master_box.
   */
  virtual wrapper_o_base* make_wrapper_out()=0;
  /**
     Returns a pointer to a wrapper_i object based on the parameter
     object.  This function instataites an object, but the paramter
     class does not clean it up.  This should only be called in cases
     where how it will be cleaned up is clear.  This should probably
     be moved in to protected and have every child class be friends
     with master_box.
   */
  virtual wrapper_i_base* make_wrapper_in()=0;
protected:
};
}
#endif

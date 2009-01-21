#include "mex.h"

#include <mcheck.h>

/*//defined constants*/

using namespace std;

extern void _main();
void mexFunction( int nlhs, mxArray *plhs[], 
		  int nrhs, const mxArray* prhs[] )
     
{ 

  mtrace();
  char *str = (char *)malloc(52);
  int a =5;
  int c;
  c = a*5;

  muntrace();


}

#include "general.h"

void cord_to_indx(int cord1, int cord2, const int sz1, int* indx)
{
  *indx =  cord1 + sz1*cord2;
}



void indx_to_cord(int* cord1, int* cord2, const int sz1, int indx)
{
  *cord1 = indx%sz1;
  *cord2 = indx/sz1;
}

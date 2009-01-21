#include "grid.h"
#include "mex.h"

grid::grid(int gsz1, int gsz2, int ippb)
{
  (*this).init(gsz1, gsz2, ippb);
  
}

void grid::init(int gsz1, int gsz2, int ippb){
  this->gridsz1 = gsz1;
  this->gridsz2 = gsz2;
  this->ppb = ippb;
  this->grid_d = new grid_box[gridsz1*gridsz2];
}

grid::grid(int * parts, const int num_parts,const int num_cols, const int imsz1, 
	   const int imsz2,int ppb){


  gridsz1 = (imsz1%ppb==0?imsz1/ppb:(1+imsz1/ppb));
  gridsz2 = (imsz2%ppb==0?imsz2/ppb:(1+imsz2/ppb));
  int tmp1, tmp2, tmpindx;
  (*this).init(gridsz1, gridsz2, ppb);

//   for(int i = 0; i<gridsz1;i++ ){
//     for(int k = 0 ;k<gridsz2; k++){
//       mexPrintf("%d\t",this->get_box_count(gheight + i*g));
//     }
//     mexPrintf("\n");
//   }


  for(int k = 0; k<num_parts; k++ ){
    tmp1 = (int)((float)(*(parts+k*num_cols +1))/imsz1*gridsz1);
    tmp2 = (int)((*(parts+k*num_cols +2))/(float)imsz2*gridsz2);
    tmpindx = tmp1*gridsz2 + tmp2;

    //    mexPrintf("%d, %d, %d\n",tmp1,tmp2,tmpindx);
    grid_d[tmpindx].append(parts + k*num_cols);
  }
}

grid::grid( const mxArray * in, const int imsz1, 
	const int imsz2,int ppb){
    //makes the assumption that the format of the data is [number x y other junk]
    //rember when dealing with this, and getting the pointers back from the 
    

  }



grid::~grid()
{
  delete [] grid_d;
}

int grid::get_total_num(){
  int  tot=0;
  for(int j = 0; j<gridsz1;j++){
    for(int k = 0; k<gridsz2;k++){
      tot +=(grid_d[j+k*gridsz1].get_count());
    }
  }
  return tot;

}

void grid::print_grid(){
  for(int j = 0; j<gridsz1;j++){
    for(int k = 0; k<gridsz2;k++){
      cout<<(grid_d[j+k*gridsz1].get_count())<<"\t";
    }
    cout<<endl;
  }
}

int grid::get_box_count(int indx){
  
  if (indx>gridsz1*gridsz2)
    return -1;
  return grid_d[indx].get_count();

}

int* grid::return_density(){
  
  
  int * density = new int[gridsz1 * gridsz2];

  for(int j = 0;j<gridsz1*gridsz2;j++)
    density[j] = grid_d[j].get_count();
  
  return density;
      

}

vector<int>* grid::return_densityv(){
  
  
  vector<int>* density = new vector<int>();
   density->reserve(gridsz1*gridsz2);
   //   density->push_back(5);
//
  mexPrintf("%d, %d \n", density->capacity(), gridsz1*gridsz2);
 for(int j = 0;j<gridsz1*gridsz2;j++)
    density->push_back(grid_d[j].get_count());
//  

  mexPrintf("%d, %d \n", density->size(), gridsz1*gridsz2);
  return density;
      

}

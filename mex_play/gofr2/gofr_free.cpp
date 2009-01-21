#include "hash_box.h"
#include "hash_shelf.h"
#include <algorithm>
#include "math.h"


using namespace tracking;


void vec_print(vector<double> in){
  for(unsigned int j = 0 ; j<in.size(); j++)
    cout<<in.at(j)<<"\t";
  cout<<endl;
}

namespace{
///Local struct of structs for use with the transform operators
struct mymath{
  ///Local struct for use with the transform operators
  struct mysub{
    double sub;
    double operator()(double in){
      return in-sub;
    }
    double operator()(double a, double b){
      
      return sqrt(pow(a,2)+pow(b,2));
    }
    mysub(){sub = 0;}
  }myobject;
  

  ///Local struct for use with the transform operators
  struct myarea{
    //figure out how to make this a static
    double pi;
    double operator()(double a, double b){
      
      return (pow(b,2)-pow(a,2))*pi;
    }
    myarea(){
      pi= 4*atan(1.0);
    }
  }myaob;

  

///Local struct for use with the transform operators
  struct mydiv{
    double div;
    double operator()(double a){return a/div;}
    double operator()(double a, double b){
      return a/b;
    }
    mydiv(){div = 1;};
  }mydob;
  

///Local struct for use with the transform operators
  struct myadd{
    double add;
    double operator()(double a){return a+add;}
    double operator()(double a, double b){
      return a+b;
    }
    myadd(){add = 0;};
  }myaddob;
  mymath(){
    
  };
}mymathobs;
}
//}
int hash_box::gofr(double max_d, int nbins, hash_box* points,
		   vector<double>& bin_count,vector<double>& bin_r){
  bin_count.clear();
  bin_count.resize(nbins);
  bin_r.clear();
  bin_r.resize(nbins);
  for(int j = 0; j<(int)bin_r.size();j++)
    bin_r.at(j) = j*max_d/nbins;
  return gofr( max_d,  nbins,  points, bin_count);

}

int hash_box::gofr(double max_d, int nbins, hash_box* points,
		   vector<double>& bin_count){

  double tmp_dist = 0;

  vector<particle_base*>::iterator box_it, points_it;

  for(box_it = contents.begin(); box_it!=contents.end(); box_it++)
    {
      
      for(points_it = (points->contents).begin(); 
	points_it !=(points->contents).end();points_it++ )
	{
	  tmp_dist = (*box_it)->distancesq(*points_it);
	  if(tmp_dist < max_d && tmp_dist !=0)
	    bin_count.at((int)(((tmp_dist)/max_d)*nbins))++;
	  
	}
    }
  return contents.size(); 
}

int hash_box::gofr2D(double max_d, int nbins, hash_box* points,
		   vector<double>& bin_count){

  //  vec_print(bin_r);
  vector<double>::iterator it,it2,it3;

  vector<double> X,Y, Xp, Yp, Xdif, Ydif,r;
  

  get_val_vec(X,wrapper::d_xpos);
  get_val_vec(Y,wrapper::d_ypos);
  
  points->get_val_vec(Xp,wrapper::d_xpos);
  points->get_val_vec(Yp,wrapper::d_ypos);
  Xdif.resize(Xp.size());
  Ydif.resize(Yp.size());
  r.resize(Xp.size());
 
  
  //  vec_print(Yp);
  

  for (int j =0;j< (int)X.size();j++)
    {
   
  
    mymathobs.myobject.sub = X.at(j);
    transform(Xp.begin(),Xp.end(),Xdif.begin(),mymathobs.myobject);

    mymathobs.myobject.sub = Y.at(j);
    transform(Yp.begin(),Yp.end(),Ydif.begin(),mymathobs.myobject);

    transform(Xdif.begin(),Xdif.end(),Ydif.begin(), r.begin(),mymathobs.myobject);
    //    it2 = Xdif.begin();
    //    it3 = Ydif.begin();
    for(it = r.begin(); it<r.end(); it++)
      {
	
	if(*it<max_d && *it!=0)
	  {
	    //    cout<<*it2<<" "<<*it3<<" "<<*it<<endl;
	    //	    cout<<*it<<" ";
	    bin_count.at((int)(((*it)/max_d)*nbins))++;
	  }

	//	it2++;
	//	it3++;
      }

    }
  
  
  
  return X.size();
}

int hash_box::gofr_norm_a(double max_d, unsigned int nbins, hash_box* points,
			  vector<double>& bin_count,vector<double>& bin_r){
  
  int count = gofr(max_d, nbins, points, bin_count, bin_r);
  vector<double>area;
  area.resize(bin_r.size());

  //vec_print(bin_r);
  bin_r.push_back(max_d);
  //vec_print(bin_r);
  transform(bin_r.begin(),bin_r.end()-1,bin_r.begin()+1,area.begin(),mymathobs.myaob);
  //vec_print(bin_r);
  
  
  transform(bin_count.begin(), bin_count.end(), area.begin(),
	    bin_count.begin(),mymathobs.mydob);
  //vec_print(bin_r);
  bin_r.pop_back();
  //vec_print(bin_r);
  return count;
  
}

int hash_shelf::gofr(double max_d, int nbins, vector<double>& bin_count,
		      vector<double>& bin_r){
  //this needs some extra code to cope with edge cases
  unsigned int buffer = (unsigned int)((int)max_d%(int)ppb==0?max_d/ppb:(1+max_d/ppb));
  
  int count = 0;
  hash_box*  working_box;
  hash_box working_region = hash_box();
  vector<double>area;

  bin_count.clear();
  bin_count.resize(nbins);

  bin_r.clear();
  bin_r.resize(nbins);

  area.resize(bin_r.size());

  for(int j = 0; j<(int)bin_r.size();j++)
    bin_r.at(j) = j*max_d/nbins;


  for(unsigned int j = buffer; j<(hash_dims[0]-buffer);j++){
    for(unsigned int k = buffer; k<(hash_dims[1]-buffer);k++){
      working_box = get_box(j,k);
      get_region(j,k,&working_region,buffer);

      count += working_box->gofr(max_d,nbins,&working_region,bin_count);
      working_region.clear();
    }
  }




  //compute the area of each ring, this requires a point at
  //max_d which is added and removed
  bin_r.push_back(max_d);

  transform(bin_r.begin(),bin_r.end()-1,
	    bin_r.begin()+1,
	    area.begin(),
	    mymathobs.myaob);

  bin_r.pop_back();

  // devide by the
  //average density.  The average density used is the density with in
  // the non-exlcuded area.  If you have nice uniform samples then
  //this should be fine.
  //div = 1 * count/((number of boxes)(area of a box))
  //div = 1 * (count /((hash_dims[0]-buffer)(hash_dims[1]-buffer)(area of box)))

  
  //  mydob.div = count;
  mymathobs.mydob.div = count * 1 / //took out a factor of count to remove averageing
    (double)(ppb*ppb*(hash_dims[0]-2*buffer)*(hash_dims[1]-2*buffer));
  //  cout<<"div factor: "<<mymathobs.mydob.div<<endl;
				      
  //normalization for density
  transform(bin_count.begin(), bin_count.end(), bin_count.begin(),mymathobs.mydob);

  //normalization for area
  transform(bin_count.begin(), bin_count.end(), area.begin(),
 	    bin_count.begin(),mymathobs.mydob);

  //
  return count;
 
}
void hash_shelf::gofr_norm(double max_d, int nbins, vector<double>& bin_count,
		      vector<double>& bin_r){
  int count =   gofr(max_d, nbins,bin_count,bin_r);

  mymathobs.mydob.div = count ;
				      
  //average over number of particles
  transform(bin_count.begin(), bin_count.end(), bin_count.begin(),mymathobs.mydob);

}

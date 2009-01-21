#include "mex.h"
#include "ipp.h"
#include "image1.h"
#include "params1.h"
#include "data_proc1.h"


#include "kernel1.h"
#include "fileops1.h"

/*//header files for Intel and TIFF code*/

/*//standard C++ header files*/
#include <time.h>
#include <string>
using namespace std;
#include <fstream>
#include <iostream>

#include <mcheck.h>

/*//defined constants*/
#define epsilon 0.0001


using namespace std;



extern void _main();
void mexFunction( int nlhs, mxArray *plhs[], 
		  int nrhs, const mxArray* prhs[] )
     
{ 


 //mexPrintf("Hello, world!\n"); 
 IppStatus status;
 int k,n,m,i,j;
 int step;
 double *data1;
 double *data2;
 



 
 Params parm = Params(mxGetN(prhs[1]) ,prhs[1]);


 
 //mexPrintf("size, %d %d\n",mxGetM(prhs[1]),mxGetN(prhs[1]));
 //debugging statement
 //mexPrintf("parm 1: %d 2: %f 3: %d 4: %d 5: %f 6: %d\n",parm.get_feature_radius(),parm.get_hwhm_length(),parm.get_dilation_radius(),parm.get_mask_radius(),parm.get_pctle_threshold(),parm.get_testmode());

 mtrace();
 Image2D image_in = mat_to_IPP(prhs[0]); 


 
 
 /* Create an mxArray for the output data */
 

    
    
   /* Retrieve the input data */
  
   //  data1 = mxGetPr(prhs[i]);
    //data2 = mxGetPr(plhs[i]);


    
 Image2D image_bpass(image_in.get_length(), image_in.get_width());	
//     /*//result of bandpassing original image data*/

 Image2D image_bpass_thresh(image_in.get_length(), image_in.get_width());	
 //     /*//result of setting lower threshold on bandpassed image*//
 Image2D image_localmax(image_in.get_length(), image_in.get_width());
//     /*//holds 1 in pixel locations with local max, 0 otherwise*/
    
//     RecenterImage(image_in);
    
//     /*//Convolve kernels with image (gauss and top-hat); then subtract the two (i.e. bandpass filter them)*/
 muntrace();   
 status = BandPass_2D(image_in, image_bpass, parm.get_feature_radius(), (int)parm.get_hwhm_length());
	
 status = FindLocalMax_2D(image_bpass, image_bpass_thresh, image_localmax, (int)parm.get_pctle_threshold(),
			  parm.get_dilation_radius());
	
 RecenterImage(image_bpass_thresh);

//     /*//find 1-D indices of local maxima*/
// 	int counter = 0;
// 	/*//	Ipp32f (*particledata)[8] = ParticleStatistics(image_localmax, image_in, Parameters.get_mask_radius(),*/

 int counter =0;
 Ipp32f (*particledata)[9] = ParticleStatistics(image_localmax, image_bpass_thresh, 
	   parm.get_mask_radius(),parm.get_feature_radius(), counter);
 //mexPrintf("count %d\n",counter);



 if(nlhs>1)
   {
     plhs[1] = mxCreateDoubleMatrix(image_in.get_width(), image_in.get_length(), mxREAL);
     IPP_to_mat(plhs[1],image_bpass_thresh);
     if(nlhs>2)
       {
	 plhs[2] = mxCreateDoubleMatrix(image_in.get_width(), image_in.get_length(), mxREAL);
	 IPP_to_mat(plhs[2],image_localmax);
	 if(nlhs>3)
	   {
	     plhs[3] = mxCreateDoubleMatrix(image_in.get_width(), image_in.get_length(), mxREAL);
	     IPP_to_mat(plhs[3],image_bpass);
	   }
       }
   }


   
 plhs[0] = mxCreateDoubleMatrix(9,counter,mxREAL);
 double *data_out = mxGetPr(plhs[0]);
 Ipp32f *tmp;
  for(j = 0;j<counter;j++)
   {
     tmp = particledata[j];
     for(i=0;i<9;i++)
       {
	 data_out[j*9+i] = (double)tmp[i];

       }
   }


  n
//  delete &image_in;
//  delete &image_bpass;
//  delete &image_bpass_thresh;
//  delete &image_localmax;
//
//  image_in =NULL;
//  image_bpass=NULL;
//  image_bpass_thresh=NULL;
//  image_localmax=NULL;
//



// 	/*//print out results if in testmode */
// 	string filename = Parameters.get_outfilestem() + make_file_number(framenumber,stacknumber);
// /*//	cout << filename + ": " << counter << " total particles located." << endl;*/

// 	if(Parameters.get_testmode() == 1) {	
// 		/*//print out all images*/
// 		PrintOutputImages(image_in, image_bpass_thresh, image_localmax, Parameters, framenumber, stacknumber);
// 	}

// 	if(Parameters.get_testmode() == 2 && (stacknumber) % 100 == 1) {
// 		/*//print out images for stack 1, 101, 201, etc.*/
// 		PrintOutputImages(image_in, image_bpass_thresh, image_localmax, Parameters, framenumber, stacknumber);
// 	}
// 	PrintParticleData(files.outdatafile, particledata, 0, counter, framenumber, stacknumber);	

// 	if(Parameters.get_testmode() == 3) {
// 		/*//print the number of particles found in a 2D slice*/
// 		cout << framenumber << "\t" << counter << endl;
// 	}

// 	delete [] particledata;
// 	particledata = NULL;


   
//     //copy image back to matlab form
    

/*Ipp32f x[5*5]={0};*/
//    Ipp32f *x;
//    x = ippiMalloc_32f_C1(m,n,&step);
//    IppiSize roi = {2,3};
//    
//    for(j=0;j<m*n;j++)
//      {
//	x[j%m+(j/m)*step/4] = data1[j];
//      }
//    ippiSet_32f_C1R(-1,x+3*step/4 + 2,step,roi);
//    roi.width = n-2;
//    ippiAddRandUniform_Direct_32f_C1IR(x,step,roi,1,3,(uint*)&j);
//    /* Create a pointer to the output data */
//  
//    
//    
//    /* Put data in the output array */
//    for (j = 0; j < m*n; j++)
//      {
//	data2[j] = (double)x[j%m +(j/m)*step/4 ];
//      }
//    ippiFree(x);
//    //mexPrintf("the step is %d \n",step);
  
 
 
}

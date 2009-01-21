function [row, col] = t_1d_2d_cords(in,h)
%function that converts from 1D indexing to 2D indexing h is the dimension
%in the row direction
%
%this is meant to be pasted in to other functions as a subfunction
%and is just a stand alone file here to make it easier for me to find it
    

   row = mod(in-1,h)+1;
   col = floor((in-1)/h)+1;
   
end
   
   

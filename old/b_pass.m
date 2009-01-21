function out = b_pass(in, f_sz)
%%wrapper function for band pass
%%f_sz is diameter of objects
    f_sz = ceil(f_sz/2);
    out =bpass(in,1,f_sz);
    
 end
    
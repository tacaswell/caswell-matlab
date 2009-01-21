function [a_frac v_frac] =  v_fraction(results)
%o function [a_frac v_frac] =  v_fraction(results)
%o summary: calculates the volume fraction of a sample from a 2D slice
%through the sample.  This seems sligthly sketchy.  This is more of an
%area fraction until I come up with a better way to deal with the third
%dimension 
%o inputs:
%-results: struct with fields ...
%o output: 
%-v_frac: the volume fraction
%-a_frac: the area fraction
   
    g_max = find(results.bin_val==max(results.bin_val));
    p_rad = results.t_bins(g_max)/2;
    part_indx = t_trim_track_indx(results.all_pks_trim(:,end),15);
    mean_part = mean(diff(part_indx,[],2),1);
    
    part_area = pi()*p_rad^2*mean_part;
    
    total_area = 696* 520;
    
    a_frac = part_area/total_area;
    
    part_vol = 4/3 * pi() * p_rad^3 * mean_part;
    total_vol = 696* 520*2*p_rad;
    
    v_frac = part_vol/total_vol;
    
end
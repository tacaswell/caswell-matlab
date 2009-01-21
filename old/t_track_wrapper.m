function [ all_pks tm_vec]= t_track_wrapper(filename, p_rad, hwhm,d_rad, ...
                                            mask_rad,threshold)

    r = loci.formats.ChannelFiller();
    r = loci.formats.ChannelSeparator(r);
    r.setId(filename);
   
    [all_pks tm_vec] =t_track_m(r, p_rad, hwhm,d_rad,mask_rad,threshold);
    
    r.close()
    clear r;
end
    
    
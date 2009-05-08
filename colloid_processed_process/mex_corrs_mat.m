function out = mex_corrs_mat(in)
   

    frames = max(in(:,3)) +1;

    
    tic; [out.mean_dip,   ...
          out.md,         ...
          out.md_count,   ...
          out.msd,        ...
          out.msd_count,  ...
          out.msd_sq,     ...
          out.msd_sq_c    ...
          out.Duu,        ...
          out.Duu_c,      ...
          out.DuuL,       ...
          out.DuuL_c,     ...
          out.DuuT,       ...
          out.DuuT_c,     ...
          out.Ddrdr,      ...
          out.Ddrdr_c     ...
          out.Ddudu,      ...
          out.Ddudu_c,    ...
          out.msd_hist]    ...
            = basic_dynamic(in,2000,3000,frames,5);toc;

    clear basic_dynamic;
    
% $$$     s_name = ['corrs_' fname((find(fname =='/',1,'last')+11):(find(fname ...
% $$$                                                       =='.',1,'last')-1)) ...
% $$$               '.mat']
% $$$     eval(sprintf('save %s out',s_name))
    
    end
    

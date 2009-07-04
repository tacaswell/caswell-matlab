function out = mex_msd_tracks(fname)
   
    output = open(fname);
    
    tmp = output.all_pks_trim(:,[2 3 end]);
    tmp(:,3) = tmp(:,3) -1;
    out.stack_name = output.fname;
    out.fname = fname
    clear output

    frames = 1200;
    offset = 0;
    max_r = 5;
    out.prams.offset = offset;
    out.prams.frames = frames;
    out.prams.max_r = max_r;
    size(tmp)
    tmp = tmp(tmp(:,3)<(frames+offset) & tmp(:,3)>=offset,:);
    tmp(:,3) = tmp(:,3) - offset;
    
    size(tmp)
    tic;
        [out.mean_dip,   ...
          out.md,         ...
          out.md_count,   ...
          out.msd,        ...
          out.msd_count,  ...
          out.msd_sq,     ...
          out.msd_sq_count...
          out.pos    ...
          out.tracks_disp]     ...
            = basic_dynamic(tmp,520,1390,frames,max_r);
    toc;
    clear basic_dynamic;
    
% $$$     s_name = ['corrs_' fname((find(fname =='/',1,'last')+11):(find(fname ...
% $$$                                                       =='.',1,'last')-1)) ...
% $$$               '.mat']
% $$$     eval(sprintf('save %s out',s_name))
    
    end
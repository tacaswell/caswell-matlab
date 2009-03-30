function out = msd_fft_process(fname)
    
    out.fname = fname;
    
    input = open(fname);
    tmp = input.all_pks_trim;
    clear input;
    
    tmp = tmp(:,[2 3 end]);
    tmp(:,end) = tmp(:,end) -1;
    clear test;    
    tic; 
        [out.msd out.msd_count junk d] = test(tmp);
    toc;
    clear test;

    
    out.pm = squeeze(mean(reshape(cell2mat(tracks_in_cell_fft(d,50)),25, ...
                                  [],2),2));
end
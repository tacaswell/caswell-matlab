function out = extract_results(fname,fld_indx)
%o function out = extract_results(fname,fld_index)
%o summary:Extracts the high level data from
% the files saved by the processing scripts, works on second iteration
% of output format
%o input:
%-fname:fully qualified name of file to open
%-fld_indx: which tracks to extract from the file. A vector containing
%the indicies of the desired fields from the cell array fields = {'all_pks', ' tms',
%' all_pks_trim', ' bin_val', ' t_bins',' tracks', ' tracks_fill', '
%msd', ' msd_e', ' v_fft_x', ' v_fft_y'};
%o output:
%-out: struct containing a trimmed name of the file and the
%fields that are extracted 

    post_fix = fname(max(find(fname=='/')):(max(find(fname=='.'))-1));
    post_fix = post_fix(min(find(post_fix=='_')):end);
    out = struct;
    out.name = post_fix(2:end);
    
    fields = {'all_pks', ' tms', ' all_pks_trim', ' bin_val', ' t_bins', ...
              ' tracks', ' tracks_fill', ' msd', ' msd_e', ' v_fft_x', ' v_fft_y'};
    
    in = open(fname);
    
    for j = fld_indx
        
        eval(sprintf('out.%s = in.%s;',fields{j},fields{j}));
        
    end
    
    
    
end
    
   
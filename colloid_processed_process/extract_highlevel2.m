function out = extract_highlevel2(fname)
%o function out = extract_highlevel2(fname)
%o summary:Extracts the high level data from
% the files saved by the processing scripts
%o input:
%-fname:fully qualified name of file to open
%o output:
%-out: struct containing a trimmed name of the file and the
%fields that are extracted (as set by loop variable)

    post_fix = fname(max(find(fname=='/')):(max(find(fname=='.'))-1));
    post_fix = post_fix(min(find(post_fix=='_')):end);
    out = struct;
    out.name = post_fix(2:end);
    
    fields = {'all_pks', ' tms', ' all_pks_trim', ' bin_val', ' t_bins', ...
              ' tracks', ' tracks_fill', ' msd', ' msd_e', ' v_fft_x', ' v_fft_y'};
    
    in = open(fname);
    
    for j = [1 3]
        
        eval(sprintf('out.%s = in.%s;',fields{j},fields{j}));
        
    end
    
    
    
end
    
   
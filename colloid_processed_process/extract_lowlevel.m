function out = extract_lowlevel(fname)
%o function out = extract_lowlevel(fname)
%o summary:Extracts the low level data from
% the files saved by the processing scripts works on the first iteration
% of format from the prcessing scripts, for newer file see extract_results.m
%o input:
%-fname:fully qualified name of file to open
%o output:
%-out: struct containing a trimmed name of the file and the
%fields that are extracted (ffts, tms, bin_val,t_bins,msd,msd_e)

    post_fix = fname(max(find(fname=='/')):(max(find(fname=='.'))-1));
    post_fix = post_fix(min(find(post_fix=='_')):end);
    out = struct;
    out.name = post_fix(2:end);
    
    fields = {'all_pks', ' tms', ' all_pks_trim', ' bin_val', ...
              ' t_bins', ' tracks', ' tracks_fill', ' msd', ...
              ' msd_e', ' v_fft', ' p_fft'};
    
    in = open(fname);
    
    for j = [2 4 5  7 8 9 10]

        eval(sprintf('out.%s = in.%s%s;',fields{j},fields{j},post_fix));

        
    end
    
    
    
end
    
   
function out = trim_proc(fname)
% TRIM_PROC - takes in all the identifed peaks and trims them according to args
%   
    out = open(fname);
    out = out.out;
    out.proc_fname = fname;
    out.tms = tdatetime(out.tms);
    out.all_pks = t_trim_md(out.all_pks,out.args.scut,out.args.rgcut, out.args.ecut);
end

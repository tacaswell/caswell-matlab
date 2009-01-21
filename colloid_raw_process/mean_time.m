function [mtime_s mtime] = mean_time(tms)
%o function mtime = mean_time(tms)
%o summary: gets the mean time for a stack of images.  Assumes the
%format of the metamoprh time stamps.
%o inputs:
%-tms:stack of time stamps
%o output:
%-mtime: average time of stack as a 1x7 vector
%-mtime_s: averate time of stack in seconds
    mtime = mean(tms,1);
    %assume all taken on the same day
    mtime_s = mtime(4:end);
    mtime_s = sum(mtime_s.*[60*60 60 1 1/1000]);
end
    
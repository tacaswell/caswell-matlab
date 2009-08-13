function tms = tdatetime(tms)
% TDATETIME - takes in a m-7 array from the metadata and returns the time from frame zero in seconds
%   
  
    tms = datenum(tms(:,1:6)) + tms(:,7)/(24*60*60*1000);
    tms = (tms - tms(1))*(24*60*60);
    % conversion to deal with the fact that matlab doesn't use unix time
    
end

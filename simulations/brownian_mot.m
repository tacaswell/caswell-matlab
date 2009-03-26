% Copyright 2009 Thomas A Caswell
% all rights reserved

function out = brownian_mot (in)
    
    track_count = in.count;
    track_length = in.length;
    sampling = 1;
    
    track_disp = randn(track_length*sampling, track_count);
    out= [zeros(1,track_count);cumsum(track_disp)];
    
    

    
end
% Copyright 2009 Thomas A Caswell
% all rights reserved

function out = constrianed_bm (in)
    
    track_count = in.count;
    track_length = in.length;
    max_disp = in.max_d;
    sampling = 1;
    
    out = zeros(track_length,track_count);
    
    for j = 1:track_count
        k = 1;
        cur_pos = 0;
        while(k<track_length)
            step = randn(1);
            if(abs(cur_pos + step)< max_disp)
                cur_pos = cur_pos + step;
                out(k,j) = cur_pos;
                k = k+1;
            else
                % add soft edges
            end
        end
    end

    
end
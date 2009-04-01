% Copyright 2009 Thomas A Caswell
% all rights reserved

function [out out2]= constrianed_bm_r (in)
    
    track_count = in.count;
    track_length = in.length;
    max_disp = in.max_d;
    sampling = 1;

    out = zeros(track_length,track_count);
    out2 = zeros(track_length,track_count);
    
    for j = 1:track_count
        k = 1;
        cur_pos = 0;
        while(k<=track_length)
            step = randn(1);
            next_pos = cur_pos + step;
            if(abs(next_pos)< max_disp)
                cur_pos = next_pos;
                out(k,j) = step;
                k = k+1;
                
            else
                while(abs(next_pos) > max_disp)
                    next_pos =...
                        sign(next_pos)*(2*max_disp - abs(next_pos));
                end
                
                out(k,j) = next_pos - cur_pos;
                cur_pos = next_pos;
                k = k+1;
            end

        end
    end
    

    
end


function out = liklyhood(pos,max)
    if(abs(pos)<max)
        out = 1;
    else
        out = 0;
        %out = exp(-(abs(pos)-max));
        %out = exp(-(abs(pos)-max)^2);
        %out = 1;
    end
end
% Copyright 2009 Thomas A Caswell
% all rights reserved

function [out ]= constrained_bm_3D (in)
    
    track_count = in.count;
    track_length = in.length;
    max_disp = in.max_d;
    sampling = 1;
    LH = 1;
    out = zeros(track_length,track_count,3);
    out2 = zeros(track_length,track_count,3);
    
    for j = 1:track_count
        k = 1;
        cur_pos = zeros(3,1);
        while(k<=track_length)
            step = randn(3,1);
            %             if(abs(cur_pos + step)< max_disp)
            %                 cur_pos = cur_pos + step;
            %                 out(k,j) = cur_pos;
            %                 k = k+1;
            %                 LH = 1;
            %             else
            LH_new = liklyhood(cur_pos + step,max_disp);
            if(LH_new >= LH)
                cur_pos = cur_pos + step;
                out(k,j,:) = step;%cur_pos;
                
                
                k = k+1;
                LH = LH_new;
            elseif(LH_new/LH > rand(1))
                cur_pos = cur_pos + step;
                out(k,j,:) = step;%cur_pos;

                k = k+1;
                LH = LH_new;
            end
            % add soft edges
            %            end
        end
    end
    

    
end


function out = liklyhood(pos,max)
    if(sum(pos.^2)<max^2)
        out = 1;
    else
        %out = 0;
        %out = exp(-(abs(pos)-max));
        out = exp(-(sqrt(sum(pos.^2))-max)^2);
        %out = 0;
    end
end
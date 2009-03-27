% Copyright 2009 Thomas A Caswell
% all rights reserved
function out = constrained_p_step(in,step)
    if(nargin<2)
        step = 1;
    end
    out = in;
    out.max_d = out.max_d + step;
    
end
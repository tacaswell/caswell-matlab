% Copyright 2009 Thomas A Caswell
% all rights reserved

function out = simulation_loop(in_param, pram_step, generating_func)
    
    iters = 15;
    steps = diff(logspace(0,2,iters+1))
    out = cell(iters,1);
    for j = 1:iters
        j
        data = generating_func(in_param);
        data = power_from_disp(diff(data));
        out{j} = mean(data,2);
        in_param = pram_step(in_param,steps(j));
    end
    
    
end
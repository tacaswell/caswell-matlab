% Copyright 2009 Thomas A Caswell
% all rights reserved

function out = simulation_loop(in_param, pram_step, generating_func)
    
    iters = 15;
    steps = diff(logspace(0,3,iters+1));
    out = cell(iters,1);
    for j = 1:iters
        j

        data = generating_func(in_param);
        %        size(data)
        % mean(data)
        
        %data = power_from_disp([data]);
        out{j} = mean(power_from_disp([data(:,:,1)]),2);
        in_param = pram_step(in_param,steps(j));
    end
    
    
end
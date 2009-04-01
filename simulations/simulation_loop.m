% Copyright 2009 Thomas A Caswell
% all rights reserved

function out = simulation_loop(in_param, pram_step, generating_func)
    
    iters = 15;
    steps = diff(logspace(0,3,iters+1));
    
    if ~isfield(in_param,'filter')
        in_param.filter = @hann;
    end
    %     out.pm = cell(iters,1);
    %     out.msd = cell(iters,1);
    out.pm = zeros(floor(in_param.length/2),iters);
    out.msd = zeros(in_param.length,iters)
    for j = 1:iters
        j

        data = generating_func(in_param);
        %        size(data)
        % mean(data)
        
        %data = power_from_disp([data]);
        out.pm(:,j) = mean(power_from_disp(data,in_param.filter),2);
        out.msd(:,j) = sim_msd(data);
        in_param = pram_step(in_param,steps(j));
    end
    
    
end
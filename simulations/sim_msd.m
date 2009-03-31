function out = sim_msd(in)
%o function out = sim_msd(in)
%o summary: Computes the mean squared dispalcement as a function of
%time for the simulation data
%o output:
%-out:a vector with mean squared dispalcement at 1,2,.. time intervals
%o inputs:
%-in: an array of simulation tracks
    
    pos_data = [zeros(1,size(in,2));cumsum(in)];
    
    out = zeros(size(in,1),1);
    
    for j = 1:size(in,1)
        out(j) = mean(mean(diff(pos_data(1:j:end)).^2));
    end
    
end
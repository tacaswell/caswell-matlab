function  out = t_density_wrapper(in,m)
%o function  out = t_density_wrapper(in)
%o summary: wrapper for t_density.m to automate looping through grid
%sizes, properly scale the results to a per pixel value and generate the
%estiamted err, mean, and stardard deviation of the results.  The error
%is estimated based on counting statistics and what the density
%fluctuations should be if the particles were put down entirely randomly    
%o inputs:
%-in: Nx2 array of posistions of particles in a frame
%o outputs:
%-out: mx3 array containt [mean_density density_std counting_error]
    prams.m = 8;
    
    if nargin>1
        prams.m = m;
    end
    
    prams.grid_step = 10;
    out = zeros(prams.m,3);
    
    for j = 1:prams.m
         
        den= t_density(in,j*prams.grid_step);
        out(j,1) = mean(reshape(den(2:end-1,2:end-1),1,[]))/(j^2*prams.grid_step^2);
        out(j,2) = std(reshape(den(2:end-1,2:end-1)/(j^2*prams.grid_step^2),1,[]));
        out(j,3) = sqrt(out(j,1))/sqrt(j^2*prams.grid_step^2);
    end;
    
end

    
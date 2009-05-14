function out = gofr_correction(gofr)
% $$$     (rp,dr,nsteps,rad)
    
    rad = 4;
    nsteps = 200;
    dr = mean(diff(gofr.edges));
    deltar = (0:(nsteps))*dr;
    
    
    
    tmp = zeros(1,length(gofr.gofr) + nsteps);
    
    for j = 1:length(gofr.edges)
        Pr = Pdr(gofr.edges(j),dr,deltar,rad);
        size(Pr)
        size(tmp(j:(j+nsteps)))
        tmp(j:(j+nsteps)) = tmp(j:(j+nsteps)) + Pr*gofr.gofr(j);
    end
    
    out.edges = gofr.edges;
    out.gofr = tmp(1:(end-nsteps));
end

function out = Pdr(rp,dr,deltar,rad)
% check to make sure this vectorizes properly
    z2 = sqrt(2*rp'*(dr + deltar) + (deltar + dr).^2);
    z1 = sqrt(2*rp'*(deltar) + (deltar).^2);
    if any(rp<0) ||any(dr<0)||any(deltar<0)
        die
    end
    z1(z1>1.5*rad) = 1.5*rad;
    z2(z2>1.5*rad) = 1.5*rad;
   


    out = 2*(1.5*rad*(z2-z1) - (z2.^2 - z1.^2)/2)/((1.5*rad)^2);
    
end
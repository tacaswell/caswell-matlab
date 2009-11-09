function fixed_plane()
% FIXED_ANGLE_FIXED_PLANE - simulates pairs of partciles at fixed
% angles that can vibrate in and out along their lines
%   
    count = 1e7;
    
    scale = .1;
    ascale = .17;

    edges = linspace(0,3,1000);
    aedges= linspace(0,2*pi,1000);
    redges = edges;
    
    
    r1 = randn(2*count,1)*scale + 1;
    r2 = randn(2*count,1)*scale + 1;

    hr = histc([r1; r2],redges);
    
    a1 = randn(2*count,1)*ascale + pi/6;
    a2 = randn(2*count,1)*ascale + pi/6;

    ah_120 = histc(pi-a1 -a2,aedges);
    
    data_120 = sqrt(...
        (sin(a1).*r1 - sin(a2).*r2).^2 + ...
        (cos(a1).*r1 + cos(a2).*r2).^2);
    h_120 = histc(data_120,edges);
    
    r1 = randn(count,1)*scale + 1;
    r2 = randn(count,1)*scale + 1;
    
    hr = hr + histc([r1; r2],redges);
    
    a1 = randn(count,1)*ascale;
    a2 = randn(count,1)*ascale;
    ta = pi-a1 -a2;
    ta(ta>pi) = (2*pi - ta(ta>pi));
    ah_180 = histc(ta,aedges);
    
    data_180 =  sqrt(...
        (sin(a1).*r1 - sin(a2).*r2).^2 + ...
        (cos(a1).*r1 + cos(a2).*r2).^2);
    h_180 = histc(data_180,edges);
    
    f = figure;
    title('simulations')
    subplot(2,1,1)
    hold on;
    stairs(edges,h_180/sum(h_180 + h_120),'r')
    stairs(edges,h_120/sum(h_120 + h_180),'b')
    stairs(edges,(h_180 + h_120)/sum(h_180+h_120),'k')
    set(gca,'xlim',[1 2.5]);
    title(['simulated g(r) \sigma_a = ' num2str(ascale) ' \sigma_r = ' ...
           num2str(scale)])
    
    ylabel('g(r) [arb units]')
    xlabel('r [natural units]')
    
    
    subplot(2,1,2)
    hold on;
    stairs(aedges,ah_180/sum(ah_180 + ah_120),'r')
    stairs(aedges,ah_120/sum(ah_120 + ah_180),'b')
    stairs(aedges,(ah_180 + ah_120)/sum(ah_180 + ah_120),'k')
    set(gca,'xlim',[0 pi]);
    title(['simulated g(\theta) \sigma_a = ' num2str(ascale) ' \sigma_r = ' ...
           num2str(scale)])
    ylabel('g(\theta) [arb units]')
    xlabel('\theta [rad]')
    
    if (false)
        save_figure(['gof_sim_' num2str(ascale) '_' num2str(scale)], [8 8], ...
                    f,mfilename,'')
    end
% $$$     
% $$$     figure;
% $$$     stairs(redges,hr/sum(hr))
end


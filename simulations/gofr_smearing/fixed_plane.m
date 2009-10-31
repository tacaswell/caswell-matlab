function fixed_plane()
% FIXED_ANGLE_FIXED_PLANE - simulates pairs of partciles at fixed
% angles that can vibrate in and out along their lines
%   
    count = 10000000;
    
    scale = .1;
    ascale = .17;
    edges = linspace(1,3,100);
    aedges= linspace(0,2*pi,100);
    redges = linspace(0,2,100);
    
    r1 = randn(count,1)*scale + 1;
    r2 = randn(count,1)*scale + 1;

    hr = histc([r1; r2],redges);
    
    a1 = randn(count,1)*ascale + pi/6;
    a2 = randn(count,1)*ascale + pi/6;

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
    ah_180 = histc(pi-a1 -a2,aedges);
    
    data_180 =  sqrt(...
        (sin(a1).*r1 - sin(a2).*r2).^2 + ...
        (cos(a1).*r1 + cos(a2).*r2).^2);
    h_180 = histc(data_180,edges);
    
    figure;
    hold on;
    stairs(edges,h_180/sum(h_180),'r')
    stairs(edges,h_120/sum(h_120),'b')
    stairs(edges,(h_180 + h_120)/sum(h_180+h_120),'k')

    figure;
    hold on;
    stairs(aedges,ah_180/count,'r')
    stairs(aedges,ah_120/count,'b')
    stairs(aedges,(ah_180 + ah_120)/(2*count),'k')
    
    figure;
    stairs(redges,hr/sum(hr))
end


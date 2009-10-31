function fixed_angle_fixed_plane()
% FIXED_ANGLE_FIXED_PLANE - simulates pairs of partciles at fixed
% angles that can vibrate in and out along their lines
%   
    count = 100000;
    
    scale = .07;
    
    edges = linspace(1,3,50);
    r1 = randn(count,1)*scale + 1;
    r2 = randn(count,1)*scale + 1;
    

    data_120 = sqrt((sin(pi/6) * (r1-r2)).^2 + (cos(pi/6) * (r1 + ...
                                                      r2)).^2);
    h_120 = histc(data_120,edges);
    
    r1 = randn(count,1)*scale + 1;
    r2 = randn(count,1)*scale + 1;
    
    data_180 = r1 + r2;
    
    h_180 = histc(data_180,edges);
    
    figure;
    hold on;
    stairs(edges,h_180/sum(h_180),'r')
    stairs(edges,h_120/sum(h_120),'b')
    stairs(edges,(h_180 + h_120)/sum(h_180+h_120),'k')
    
end


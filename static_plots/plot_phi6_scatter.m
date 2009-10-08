function plot_phi6_scatter(in)
% PLOT_PHI6_SCATTER - takes in the posistion and phi6 for a single plane at a temi
%   
    in(:,3) = sum(in(:,[3 4]).^2,2);
    figure;
    scatter(in(:,2),in(:,1),in(:,3)*20+10,in(:,5),'filled');
    axis image;
end

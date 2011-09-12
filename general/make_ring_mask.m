function mask = make_ring_mask(r,dr,x_cen,y_cen,r_pt_cnt,t_pt_cnt,x_dim,y_dim)
% makes the masks neede to take an average around a ring
% r - radius of ring
% dr - width of ring, centered on r
% x_cen - the center of the ring, in matlab's reconing (start at 1,
% label at center
% y_cen - the center of the ring, in matlab's reconing (start at 1,
% label at center
% r_pt_cnt - the number of points to make radially
% t_pt_cnt - the number of points around the circle
% x_dim - the dimension of the image to be masked
% y_dim the y-dim of the image to be masked
   

    
    
    % set up the arrays for spacing   
    theta_pts = linspace(0,2*pi,t_pt_cnt);
    r_pts = linspace(r-dr/2,r+dr/2,r_pt_cnt)';

    
    % set up the sampling point arrays
    % the -1 is to transfrom from matlabs 1 based labeling to 0
    % based counting.  +1/2 is to change the labeling from the
    % centers to the cornor 
    x_pts = reshape(r_pts *sin(theta_pts),1,[]) + x_cen -1/2; 
    y_pts = reshape(r_pts *cos(theta_pts),1,[]) + y_cen -1/2;
    pts = [x_pts;y_pts]';
    
    
    % make and normalize mask
    mask = histc2(pts,[0,y_dim-1,x_dim],[0,y_dim-1,y_dim]);
    
    mask = mask/sum(sum(mask));

    
    
end


function out = histc2(data,x_range,y_range)
% HISTC2 - returns a 2-D histogram of the 2-D data, complains if data is not a Nx2 array
%   the ranges are of the form [min max steps]
    
    data = data(data(:,1)>x_range(1)&data(:,1)<x_range(2)&...
                data(:,2)>y_range(1)&data(:,2)<y_range(2),:);
    
    x_bin=floor(((data(:,1)-x_range(1))/(x_range(2)-x_range(1)))*x_range(3))+1;
    y_bin=floor(((data(:,2)-y_range(1))/(y_range(2)-y_range(1)))*y_range(3))+1;
    out = zeros(x_range(3),y_range(3));
    
    for i = 1:size(data,1)
       
        out(x_bin(i),y_bin(i)) = out(x_bin(i),y_bin(i)) +1;
    end
    
end

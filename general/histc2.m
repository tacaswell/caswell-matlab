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

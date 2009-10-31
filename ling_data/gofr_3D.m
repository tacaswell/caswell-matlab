function [bins edges] =gofr_3D(max_range,bin_num)



plane_dim = [1 2 3];


d = importdata('~/colloids/other_data/ling_mri_data.txt');


poses = d.data(:,[2 4 6]);



pos_sz = size(poses,1);


maxes = max(poses(:,plane_dim));
mins = min(poses(:,plane_dim));

particle_count = 0;
bins = zeros(bin_num,1);
edges = (0:bin_num-1)*max_range/bin_num;
for k = 1:(pos_sz)
% $$$     if      poses(k,plane_dim(1)) < maxes(1)-max_range &&...
% $$$             poses(k,plane_dim(2)) < maxes(2)-max_range &&...
% $$$             poses(k,plane_dim(1)) > maxes(1)+max_range &&...
% $$$             poses(k,plane_dim(2)) > maxes(2)+max_range
        %excludes particles too close to edge to have a full circle
        %around them
        
        tmp = repmat(poses(k,:),pos_sz-1,1);
        dist_tmp = sqrt(sum((poses([1:(k-1) (k+1):end],:)-tmp).^2,2));
        indx = 1+floor(bin_num * dist_tmp(dist_tmp < max_range)/max_range);
        bins(indx) = bins(indx) +1;
% $$$     end
    
end


bins = bins'./(diff([edges max_range].^2) * pi);
stairs(edges,bins);
return;


%scales for volume
as = as/(pos_sz(1)/...
         ((x_max-3*part_sz)*(y_max-3*part_sz)* ...
          frame_count));
% devide by average density
figure
plot(b,as,'.');
end    



function data = slice_data(range,dim,data)
% SLICE_DATA - takes a 2-D slice of 3-D data
%   

data = data(data(:,dim) < range(2) & data(:,1) > range(1),:);

end

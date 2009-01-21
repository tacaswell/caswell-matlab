function [dist as b] =gofr(poses,t_len, t_bin_num,tdims,part_sz)
%%takes in a stack of posistion data and returns G(r)
%%assume data is of form (x) (y) (anything else) (frame index)
pos_sz = size(poses);
poses = poses(:,[1 2 pos_sz(2)]);
frame_count = max(poses(:,3));
dist=cell(1,frame_count);
x_max = tdims(1);
y_max = tdims(2);
%frame_count = 1;
particle_count = 0;

for j = 1:frame_count
    pos_count=sum(poses(:,3)==j);
    frame_tmp = poses(poses(:,3)==j,[1,2]);
    dist_tmp = -ones(pos_count^2,1);
    index = 1;
    t_bin_vec = 0:t_len/
    
    for k = 1:(pos_count-1)
        if frame_tmp(k,1)>2*t_len &&frame_tmp(k,1)<(x_max-2*t_len)...
                &&frame_tmp(k,2)>2*t_len&&frame_tmp(k,2)<(y_max-2*t_len)
            %excludes particles too close to edge to have a full circle
            %around them
            tmp = repmat(frame_tmp(k,:),pos_count-1,1);
            dist_tmp(index:(index+pos_count-2))=...
                sqrt(sum((frame_tmp([1:(k-1) (k+1):end],:)-tmp).^2,2));
            index = index + pos_count-1;
            particle_count = particle_count+1;
        end

    end
    dist{j} = dist_tmp(dist_tmp>0);
end
dist = cell2mat(dist');

dist = dist(dist<t_len);

[a b]=hist(dist,t_bins);
bin_width = b(2)-b(1);
as = a/particle_count; %average over particles
as = as./(pi()*(([b+bin_width/2].^2)-([0 b(1:(end-1))+bin_width/2].^2)));
%scales for volume
as = as/(pos_sz(1)/...
         ((x_max-3*part_sz)*(y_max-3*part_sz)* ...
          frame_count));
% devide by average density
figure
plot(b,as,'.');
end    


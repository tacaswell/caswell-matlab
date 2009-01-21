function [bin_val t_bins] = t_gofr_wm(pks,bin_num, max_length,frame_dims)
%o function [bin_val t_bins] = t_gofr_wm(pks,bin_num,max_length,frame_dims)
%o summary: generates g(r) plots for a set of particle posistions.
%assumes that frame_dims is properly adjusted for dead area
%o inputs:
%-pks: particle posistion data
%-bin_num: number of bins to use for the histogram
%-max_length: range of g(r) calculation (larger max_length reduces the
%number of particles that are averaged in the result due to excluding
%particles that are with in max_length of the edge)
%-fram_dims: the dimension of the area in which peaks are identified,
%used in the normalization process
%o outputs:
%-bin_val: the average density at a given radius range
%-t_bins: the radius ranges for the bins
%
    if size(pks,2)<3
        die
    end
    pks = pks(:,[1 2 end]);
    %% strips out extra information we do not need for this computation

    bin_width = max_length/bin_num;    
    t_bins = (0:bin_width:max_length)';
    %set up bins to use
    bin_val = zeros(size(t_bins));
    %sets up bins
    tmp_index = [0; find(diff(pks(:,3))); size(pks(:,3),1)];
    pos_total = 0;
    part_count = 0;
    frame_count =max(pks(:,end));
    for j = 1:frame_count
    
        frame = pks((tmp_index(j)+1):tmp_index(j+1),[1 2]);
        pos_count = size(frame,1);
        %loop over all images
        pos_total = pos_total + pos_count;
        [b a] = t_gofr_m(frame(:,1),frame(:,2),[bin_num+1,max_length frame_dims]);
        part_count = part_count+a;
        bin_val = bin_val + b';
        
    end
    bin_val = bin_val(1:(end-1))/part_count; 
    %average over particles and remove extra bin at end
    bin_val = bin_val./(pi()*(diff(t_bins.^2)));
    %scales for volume
    bin_val = bin_val/(pos_total/(prod(frame_dims)*frame_count));
    % devide by average density
figure
plot(cumsum(diff(t_bins)),bin_val,'.');

    
end


    
    

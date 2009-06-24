function out = testing_nn_corrs(in_pos,in_nn)
    
    max_range = 30;
    r_min = 0;
    steps = 120;
    corr_data = zeros(1,steps);
    corr_count = zeros(1,steps);
    
    for j = 1:size(in_pos,1)
        tmp_indx = in_pos(:,1)<(in_pos(j,1)+max_range)&...
            in_pos(:,1)>(in_pos(j,1)-max_range)&...
            in_pos(:,2)<(in_pos(j,2)+max_range)&...
            in_pos(:,2)>(in_pos(j,1)-max_range);
        tmp_indx(j) = false;
        tmp_pos = in_pos(tmp_indx,:);
        tmp_nn = in_nn(tmp_indx,:);
        clear tmp_indx
        
        tmp_dist = sqrt((tmp_pos -repmat(tmp_pos(j,:),size(tmp_pos,1),1)).^2);
        tmp_indx2 = tmp_dist < max_range & tmp_dist> r_min;
        
        % tmp_pos = tmp_pos(tmp_indx2);
        
        tmp_nn = tmp_nn(tmp_indx2);
        tmp_dist = tmp_dist(tmp_indx2);
        
        tmp_bins = ceil(steps*(tmp_dist-r_min)/(max_range-r_min));
        
        for i = 1:length(tmp_bins)
            tmp_nn(i,:)
            in_nn(j,:)'
            
            corr_data(tmp_bins(i))=corr_data(tmp_bins(i)) + tmp_nn(i,:)*in_nn(j,:)';
            corr_count(tmp_bins(i)) = corr_count(tmp_bins(i)) + 1;
        end
    end
    
    out = corr_data./corr_count;
    
end
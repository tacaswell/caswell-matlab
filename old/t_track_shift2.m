function track_out = t_track_shift(track_in);

    [junk sort_index] = sort(track_in(:,end-1));
    %get perumatation vector to putting in frame order
    
    track_in = track_in(sort_index,:);
    plane_index = t_trim_track_indx(track_in(:,end-1),5);
    for j = 1:size(plane_index,1)

        tmp_mean= mean(track_in(plane_index(j,1):plane_index(j,2),[3 ...
                            4]),1);
        
        tmp_mean = [tmp_mean tmp_mean 0 0];
        
        track_out(plane_index(j,1):plane_index(j,2),:) =  ...
            track_in(plane_index(j,1):plane_index(j,2),:)...
            - tmp_mean(ones(1,1+plane_index(j,2)-plane_index(j,1)),:);
    end

    [junk sort_index] = sort(track_out(:,end));
    track_out = track_out(sort_index,:);
end
    
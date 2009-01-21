function t_quiver(tracks)

    [junk sort_index] = sort(tracks(:,end-1));
    tracks = tracks(sort_index,[1:(end-2) end end-1]);
    frame_index = t_trim_track_indx(tracks,15);
    figure
    for j = 1:size(frame_index,1)
       tmp_frame = tracks(frame_index(j,1):frame_index(j,2),[1:4]);
       
       quiver(tmp_frame(:,1),tmp_frame(:,2),tmp_frame(:,3),tmp_frame(:, ...
                                                         4))
       pause;
    end
    
    
    
end 
    

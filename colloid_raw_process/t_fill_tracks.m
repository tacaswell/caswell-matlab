function track_out = t_fill_tracks(track_in,min_len)
%o function track_out = t_fill_tracks(track_in,min_len)
%o summary: if memory is ised in particle tracking there can be
%gaps in the paths.  This function will fill in gaps that are
%one time step wide by averaging the posisitions on either side
%o input:
%-track_in: output from the track finding algorithm
%-min_len: the minimum track length to consider
%o output:
%-track_out: tracks filled with interpolated posistions such that they
%have posistion data for all time steps
    
    track_index = t_trim_track_indx(track_in,min_len);
    %get posistions of track_in longer than min_len
    
    
    track_out = zeros(sum(track_in(track_index(:,2),3) - track_in(track_index(:,1),3)),6);
    %set up matrix to hold 
    
    
    tmp_index2 = 1;
    
    %couinter for postition in new matrix
    size(track_index)
    for j = 1:size(track_index,1)
        track_out(tmp_index2:(tmp_index2 + track_in(track_index(j,2),3) - ...
                              track_in(track_index(j,1),3)),:)= ...
            t_interperolate_track(track_in(track_index(j,1): ...
                                           track_index(j,2),:));
        %shove interperolated data in to matrix
        
        
        
        tmp_index2 = tmp_index2 + track_in(track_index(j,2),3) - ...
            track_in(track_index(j,1),3)+1;
        %incriment 
       
    end
    
    track_out = track_out(track_out(:,3)~=0,:);

    
end
    
function track_out = t_interperolate_track(track_in)
%o function track_out = t_interperolate_track(track_in)
%o summary: fill sin holes in computed tracks via linear interpolation,
%ie the posistion of the missing point is set to be the average of the
%two on either side of it.   The largest gap can be 1 time step, multi
%timestep gaps are not supported and will insult you if you try
%o output:
%-track_out:a single particle track with all hole filled in
%o input:
%-track_in: an ordered list of positions with time stamps for a single
%track. 
    
%fills in holes in tracks and computes the velocity
%out puts in form [x y vx vy frame track]
    track_out = zeros(track_in(end,3)-track_in(1,3)+1,6);
    


    
    %find the gaps
    missing_index1 = find((diff(track_in(:,3))-1)==1);
    missing_index2 = (diff(track_in(:,3))-1)==2;
    
    %die if we jump more than 1 at a time
    if sum(missing_index2) + 0*sum(missing_index1)
        fprintf(2,'you idiot, keep trakc of what your code can deal with\n');
        return
    else

    %copy over the input
    track_out([track_in(:,3)-track_in(1,3)+1],[1 2 end-1 end]) = track_in;
    %make up the missing points
    interp_points = (track_in(missing_index1,:) + ...
                     track_in(missing_index1+1,:))/2;
    
    %shove the missing points in to the output
    track_out(interp_points(:,3)+1-track_in(1,3),[1 2 end-1 end]) = interp_points;
    
    
    
    %compute the velocity
    track_out(1:(end-1),[3 4]) = diff(track_out(:,[1 2]));
    
   end 
end
    
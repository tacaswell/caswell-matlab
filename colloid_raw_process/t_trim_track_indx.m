function track_indx = t_trim_track_indx(tracks,cutoff)
%o function track_indx = t_track_indx(tracks,cutoff)
%summary: takes in a set of tracks 
%and retruns a nx2 matrix where each row is
% [track_start track_end] for all tracks which are longer than
%cutoff
%o inputs:
%-tracks: a matrix of the form [pos pos ... time part#] representing a
%set of tracks
%-cutoff: minimum track length
%o outputs:
%-track_indx:  a nx2 matrix where each row is
% [track_start track_end]
    
    p_indx = [0; find(diff(tracks(:,end))); size(tracks,1)];
    p_indx_len = diff(p_indx);
    t_indx = find(p_indx_len>cutoff);
    track_indx = [p_indx(t_indx)+1 p_indx(t_indx+1)];
    
end 
    

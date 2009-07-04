function plot_tracks(in, min_len, max_len)
% PLOT_TRACKS - plots tracks from the output of basic_dynamic in is a struc,
%   min_len is the minimum track length to plot and 
%   max_len is the maximum track length to plot
    
    t_len = cellfun(@(x) length(x),in.tracks_disp);
    tmp_indx2 = find(t_len<= max_len &t_len>= min_len  );
    figure;
    hold all
    for j = 1:length(tmp_indx2); 
        plot(in.pos(tmp_indx2(j),2)+ ...
             [0; cumsum(in.tracks_disp{tmp_indx2(j)}(:,2))], ...
             in.pos(tmp_indx2(j),1)+ ...
             [0 ;cumsum(in.tracks_disp{tmp_indx2(j)}(:,1))],'.');
    end;
    for j = 1:length(tmp_indx2);
        plot(in.pos(tmp_indx2(j),2)+ ...
             [0 ;cumsum(in.tracks_disp{tmp_indx2(j)}(:,2))], ...
             in.pos(tmp_indx2(j),1)+ ...
             [0; cumsum(in.tracks_disp{tmp_indx2(j)}(:,1))],'-');
    end;
    for j = 1:length(tmp_indx2); 
        circle(in.pos(tmp_indx2(j),[2 1]),4,25,'-k');
    end;
    axis image
    plot(in.pos(tmp_indx2,[2]),in.pos(tmp_indx2,[1]),'xk');
    
    
end

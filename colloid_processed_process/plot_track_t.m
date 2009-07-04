function plot_track_t(in,t)
% PLOT_TRACKS - plots tracks from the output of basic_dynamic in is a struc,
%   min_len is the minimum track length to plot and 
%   max_len is the maximum track length to plot
    
    
    t_len = cellfun(@(x) length(x),in.tracks_disp);
       
    
    tmp_indx2 = find(in.pos(:,3) <t & (in.pos(:,3) + t_len) >t);
    figure;
    hold all
    for j = 1:length(tmp_indx2); 
        plot(in.pos(tmp_indx2(j),2)+ ...
             [0; cumsum(in.tracks_disp{tmp_indx2(j)}(:,2))], ...
             in.pos(tmp_indx2(j),1)+ ...
             [0 ;cumsum(in.tracks_disp{tmp_indx2(j)}(:,1))],'-');%,'markeredgecolor','k');
    end;
    
    set(gca,'ydir','reverse');
    
    set(gca,'position',[0.05 0 .90 1])
    
% $$$ 
% $$$     for j = 1:length(tmp_indx2); 
% $$$         circle(in.pos(tmp_indx2(j),[2 1]),4,25,'-k');
% $$$     end;
    axis image                          
    plot(in.pos(tmp_indx2,[2]),in.pos(tmp_indx2,[1]),'xk');
    
    figure
    quiver(in.pos(tmp_indx2,[2]),in.pos(tmp_indx2,[1]),...
           cellfun(@(x) sum(x(:,2)),in.tracks_disp(tmp_indx2)),...
           cellfun(@(x) sum(x(:,1)),in.tracks_disp(tmp_indx2)),0);
    axis image;

    % 
    
end

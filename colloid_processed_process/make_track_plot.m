function make_track_plot(in,max_t,save_)
    if nargin<3
        save_ = false;
    end
    
    start_indx =find( ...
        in.pos(:,3)<max_t & ...
        in.pos(:,1)<400 & in.pos(:,1)>100 & ...
        in.pos(:,2)<800 & in.pos(:,2)>500);
% $$$     start_indx = 1:size(in.pos,1);
    f = figure; 
    hold on
   
    cols = jet(1200);
% $$$     cols = jet(max_t);
    
    for k = 1:length(start_indx);

        plot(in.pos(start_indx(k),2) + in.tracks_disp{start_indx(k)}(:,2)...
             ,in.pos(start_indx(k),1) + in.tracks_disp{start_indx(k)}(:, 1)...
             ,'color',cols(length(in.tracks_disp{start_indx(k)}(:, 1)),:));
% $$$              ,'color',cols(in.pos(start_indx(k),3)+1,:));
    end;
    tmp = cell2mat(regexpi(in.stack_name,['[0-' ...
                        '9]{2}-[0-9]'],'match'))
    title([tmp(1:2) '.' tmp(4)])
    caxis([0 1200]);
    colorbar;
    axis off
    axis image;
    t_date = cell2mat(regexpi(in(1).stack_name,'[0-9]{8}', ...
                              'match'));
    if save_
        save_figure(strcat('tracks_',t_date,'_', tmp),[5 5],f);
    end
end

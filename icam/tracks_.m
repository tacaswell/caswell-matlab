function tracks_
    
    c = load('~/collids/processed_data/20090514/msd_track_20090502.mat');
    c = c.out_0502;
% $$$     arrayfun(@(x) make_track_plot_(x,20,true),c)
    make_msd_plots_(c,true)
end

function make_track_plot_(in,max_t,save_)
    if nargin<3
        save_ = false;
    end
    
    start_indx =find( ...
        in.pos(:,3)<max_t & ...
        in.pos(:,1)<400 & in.pos(:,1)>200 & ...
        in.pos(:,2)<800 & in.pos(:,2)>600);
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


function make_msd_plots_(in,save_)
    if nargin<2
        save_ = false;
    end

    
    leg = arrayfun(@(x) cell2mat(regexpi(x.stack_name,['[0-9]{2}-' ...
                        '[0-9]'],'match')),in,'uniformoutput', ...
                   false);

    leg = cellfun(@(x) [x(1:2) '.' x(4)],leg,'uniformoutput', ...
                   false);
    f1 =figure;
    hold all;
    for j = 1:length(in); 
        plot(1/20*(1:length(in(j).msd)),(6.45/60)^2*in(j).msd./ ...
             in(j).msd_count,'-x');
    end;
    axis([0 2.5  0 1])
    
    legend(leg);
% $$$     title('\langleD^2\rangle')
    xlabel('\tau [s]')
    ylabel('\langleD^2\rangle [\mum^2]')
    grid on;
    
    
    f2=figure;
    hold all;
    for j = 1:length(in); 
        plot(1/20*(1:length(in(j).msd)),(6.45/60)^2*in(j).msd./ ...
             in(j).msd_count,'-x');
    end;
    tmp_x = .05:.1:.8
    plot(tmp_x,tmp_x/2,'k')
    grid on;
    set(gca,'yscale','log'),
    set(gca,'xscale','log'),
    axis([0 2.5 0 1])
    legend(leg,'Location','northwest');
    

    xlabel('\tau [s]')
    ylabel('\langleD^2\rangle [\mum^2]')
    t_date = cell2mat(regexpi(in(1).stack_name,'[0-9]{8}', ...
                              'match'));

        
    if(save_)
        save_figure(strcat('msd_',t_date),[5 5],f1);
        save_figure(strcat('msd_ll_',t_date),[5 5],f2);
    end

end

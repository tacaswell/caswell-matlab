function make_mean_frame_disp_plots(in)
    save_ = false;
    
    leg = arrayfun(@(x) cell2mat(regexpi(x.stack_name,['[0-9]{2}-' ...
                        '[0-9]'],'match')),in,'uniformoutput', ...
                   false)

    
    col = lines(length(in));
    col = col(reshape([1:length(in);1:length(in)],1,[]),:);
    leg2 = leg(reshape([1:length(in);1:length(in)],1,[]));
    
    
    f=figure;
    set(gca,'colororder',col);
    hold all;
    for j = 1:length(in);
        plot(cumsum(in(j).mean_dip));
    end;
    axis([0 1200 -15 15])
    legend(leg2);
    title('msd count');
    t_date = cell2mat(regexpi(in(1).stack_name,'[0-9]{8}', ...
                              'match'));

        
    if(save_)
        save_figure(strcat('mean_frame_disp_',t_date),[5 5],f);

    end

end
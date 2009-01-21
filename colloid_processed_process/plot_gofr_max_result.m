function plot_gofr_max_result(results)
%o function plot_gofr_results(results)
%o summary: the max g(r) at different time points
%o inputs:
%-results: array of structs that contain the fields, t_bins, bin_val,
%tms, name

   
    tps = 7;
    to_save = 0;
    format = {'rx--','mx--','bx--','kx-','ro-','mo-','bo-','ko-','rs-'};
    
    f=figure;
    hold on
    g_max = zeros(size(results));
    max_loc = zeros(size(results));
    name = results{7}.name(1:(find(results{7}.name=='_',1)-1));
    leg = cell(1,length(results)/tps);
    time = size(results);
    for j = 1: length(results)
        g_max(j) = max(results{j}.bin_val);
        max_loc(j) = results{j}.t_bins(find(results{j}.bin_val==g_max(j),1));
        
        %  plot(results{j}.t_bins(1:(end-1)),results{j}.bin_val,format{j});

        time(j) = mean_time(results{j}.tms);
        
        
        
    end
    heat_on_t = mean_time([2008 8 8 15 35 0 0]);
    heat_off_t = mean_time([2008 8 8 15 57 30 0])-heat_on_t;

    %        heat_on_t = mean_time([2008 07 28 15 39 0 0]);
    % heat_off_t = mean_time([2008 07 28 16 22 30 0])-heat_on_t;

    ax1 = gca;
    set(ax1,'color','none')
    hold on
    ax2 = axes('Position',get(ax1,'Position'),...
           'XAxisLocation','bottom',...
           'YAxisLocation','right',...
           'Color','none',...
           'XColor','k','YColor','k');

    
    hold on
    for j = 1:length(results)/tps
        tmp1 = time(((j-1)*tps+1):j*tps)-heat_on_t;
        tmp2 = max_loc(((j-1)*tps+1):j*tps);
        tmp3 = g_max(((j-1)*tps+1):j*tps);
        axes(ax1)
       plot(tmp1([end 1:(end-1)]),tmp2([end 1:(end-1)]),format{j})
       axes(ax2)
       plot(tmp1([end ...
                           1:(end-1)]),tmp3([end 1:(end-1)]),format{j+4});

        
    end
    
    axes(ax1)
    grid on
    ylabel('position of max g(r)')
        
    plot([0 0],[7 9],'r--')

    plot([heat_off_t heat_off_t],[7 9],'b--')
    
    legend({'d1 loc', 'd2 loc', 'ld loc'})
    
    axes(ax2)
    ylabel('max g(r)')
    legend({'d1 max', 'd2 max', 'ld max'})
    
    xlimits = get(ax1,'XLim');
    ylimits = get(ax1,'YLim');
    xinc = (xlimits(2)-xlimits(1))/10;
    yinc = (ylimits(2)-ylimits(1))/10;

    set(ax1,'XTick',[xlimits(1):xinc:xlimits(2)],...
            'YTick',[ylimits(1):yinc:ylimits(2)])

    xlimits = get(ax2,'XLim');
    ylimits = get(ax2,'YLim');
    xinc = (xlimits(2)-xlimits(1))/10;
    yinc = (ylimits(2)-ylimits(1))/10;

    set(ax2,'XTick',[xlimits(1):xinc:xlimits(2)],...
            'YTick',[ylimits(1):yinc:ylimits(2)])
    
    xlabel('time from heat on [s]')


    
    %axis([0 50 0 3])
    %title(name)
    %xlabel('r')
    %ylabel('g(r)')
    %    legend(leg)
    
    if to_save==1
        save_figure([name '_gofr_full'],[5 5],f)
        figure(f)
        axis([0 20 0 3])
        save_figure([name '_gofr_detail'],[5 5],f)
    end
end    
    
    
function make_msd_plots(in,save_)
    if nargin<3
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
        plot(1/20*(1:length(in(j).msd)),(6.45/60)^2*in(j).msd./in(j).msd_count,'-x');
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
        stairs(1/20*(1:length(in(j).msd)),in(j).msd_count);
    end;
    grid on;
    set(gca,'yscale','log'),
    axis([0 2.5 1e3 1e6])
    legend(leg,'Location','southwest');
    

    xlabel('\tau [s]')
    ylabel('count');
    t_date = cell2mat(regexpi(in(1).stack_name,'[0-9]{8}', ...
                              'match'));

        
    if(save_)
        save_figure(strcat('msd_',t_date),[5 5],f1);
        save_figure(strcat('msd_count_',t_date),[5 5],f2);
    end

end

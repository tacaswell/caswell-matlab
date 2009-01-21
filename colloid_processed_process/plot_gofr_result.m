function plot_gofr_result(results)
%o function plot_gofr_results(results)
%o summary: plots g(r) at different time points
%o inputs:
%-results: array of structs that contain the fields, t_bins, bin_val,
%tms, name

   
    to_save = 0;
    format = {'bx-','mx-','gx-','rx-','mo-','bo-','rs-'};
    
    f=figure;
    hold on
    name = 'g(r) at varried temperatures';
    %name = results{7}.name(1:(find(results{7}.name=='_',1)-1));
    leg = cell(1,length(results));
    for j = 1: length(results)
        plot(results{j}.t_bins(1:(end-1)),results{j}.bin_val,format{j});
        mtime = mean(results{j}.tms);
        
%        leg{j} = sprintf('%s - %d:%02.0f:%02.0f', ...
%                         results{j}.name((find(results{j}.name=='_',1)+1): ...
%                                         (find(results{j}.name=='_',1,'last')-1) ...
%                                         ),mtime(4:6));
leg{j} = sprintf('%s C - %d:%02.0f:%02.0f', ...
                 results{j}.name((end-1):end),mtime(4:6));

    end
    axis([0 50 0 3])
    title(name)
    xlabel('r')
    ylabel('g(r)')
    legend(leg)
    
    if to_save==1
        save_figure([name '_gofr_full'],[5 5],f)
        figure(f)
        axis([0 20 0 3])
        save_figure([name '_gofr_detail'],[5 5],f)
    end
end    
    
    
function plot_mds_results(results)
%o function plot_mds_results(results)
%o summary: plots msd at different time points, recomputs msd
%o inputs:
%-results: array of structs that contain the fields, tracks_filled
%tms, name

   
    to_save = 0;
    format = {'rx-','mx-','ko-','ro-','mo-','bo-','rs-'};
    format2 = {'rx--','mx--','bx--','ro--','mo--','bo--','rs--'};
    
    f1=figure;
    hold on
    f2=figure;
    hold on
    
    name = results{7}.name(1:(find(results{7}.name=='_',1)-1));
    leg = cell(1,length(results));
    for j = 1: length(resu/home/tcaswell/collids/data/zexin/20080929lts)
        figure(f1)
        dt = mean( sum(diff(results{j}.tms).*repmat([0 0 24*60*60 60*60 ...
                            60 1 1/1000],length(results{j}.tms)-1,1),2));
 
        %  dt = 1;
        [results{j}.msd num_pts] = t_msd_sum(results{j}.tracks_fill(:,[1 2 end-1 end]), 900,5);
        tmp1 = dt*(1:length(results{j}.msd));
        figure(f1)
        plot(tmp1,results{j}.msd,format{j});
        figure(f2)
        plot(tmp1,num_pts,format{j})
        %        plot(tmp1,(tmp1'.^2).*results{j}.p_fft,format2{j});
                
        mtime = mean(results{j}.tms);
        
        leg{j} = sprintf('%s - %d:%02.0f:%02.0f', ...
                         results{j}.name((find(results{j}.name=='_',1)+1): ...
                                         (find(results{j}.name=='_',1,'last')-1) ...
                                         ),mtime(4:6));
                
        
    end
    %    axis([0 fs/2 0 .1])
    figure(f1)
    title(name)

    legend(leg)
    ylabel('MSD [pixel^2]')
    xlabel('T[s]')
    
    figure(f2)    
    legend(leg)
    ylabel('#')
    xlabel('T[s]')
    axis([0 45 0 1000])
    
    if to_save
        save_figure([name '_gofr_full'],[5 5],f)
        figure(f)
        axis([0 20 0 3])
        save_figure([name '_gofr_detail'],[5 5],f)
    end
end    
    
    
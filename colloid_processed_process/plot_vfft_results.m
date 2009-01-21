function plot_vfft_results(results)
%o function plot_vfft_results(results)
%o summary: plots power spectrum on a linear and log-log scale with fits
% and plots the fits as a function of time
%o inputs:
%-results: array of structs that contain the fields: tracks_fill, tms, name
%o output:
%-NONE: generates plots
   
    to_save = 0;
    
    format = {'rx-','mx-','ro-','mo-','bo-','ko','rs-'};
    format2 = {'rx--','mx--','ro--','mo--','bo--','ko--','rs--'};
    format3 = {'r--','m--','r--','m--','b--','k--','r--'};
    
    f1 = figure;
    hold on
    
    f2 = figure;
    hold on
    
    f3 = figure;
    hold on
    
    
    heat_on_t = mean_time([2008 8 8 15 35 0 0]);
    heat_off_t = mean_time([2008 8 8 15 57 30 0])-heat_on_t;

    
    
    name = results{1}.name(1:(find(results{1}.name=='_',1)-1));
    leg = cell(1,length(results));
    slope_fit = zeros(length(results),2);
    times = zeros(size(results));
    
    
    for j = 1: length(results)
        figure(f1)

        fs = 1/mean( sum(diff(results{j}.tms).*repmat([0 0 24*60*60 60*60 ...
                            60 1 1/1000],length(results{j}.tms)-1,1),2));
 

        
        [fft_x fft_y] = t_fft_mean_cord(results{j}.tracks_fill);
        
        freq = fs/2 *linspace(0,1,length(fft_x));
        
        plot(freq(1:length(fft_x)),fft_x,format{j});
        plot(freq(1:length(fft_x)),fft_y,format2{j});


        %plot(tmp1,(tmp1'.^2).*results{j}.v_fft_y,format2{j});
                
        
        slope_fit(j,:) = t_fit_powerspec((fft_x + fft_y)/2,freq);
        
        figure(f3) 

        X = .1:.01:10;
        plot(X,exp(slope_fit(j,2) + log(X)*(slope_fit(j,1))),format3{j}) 
        plot(freq,(fft_x+fft_y)/2,format{j})
        

        mtime = mean(results{j}.tms);
%        figure(f2)
%        plot(tmp1,results{j}.p_fft,format{j});
        leg{2*j-1} = sprintf('%s - %d:%02.0f:%02.0f x', ...
                         results{j}.name((find(results{j}.name=='_',1)+1): ...
                                         (find(results{j}.name=='_',1,'last')-1) ...
                                         ),mtime(4:6));
        
        leg{2*j}=  sprintf('%s - %d:%02.0f:%02.0f y', ...
                         results{j}.name((find(results{j}.name=='_',1)+1): ...
                                         (find(results{j}.name=='_',1,'last')-1) ...
                                         ),mtime(4:6));
        times(j) = mean_time(mtime);
        
    end
    %    axis([0 fs/2 0 .1])

    figure(f2)
    plot(times([end 1:end-1])-heat_on_t,slope_fit([end 1:end-1],1),'x--');
    plot([0 0],get(gca,'ylim'),'r--')

    plot([heat_off_t heat_off_t],get(gca,'ylim'),'b--')

    
    figure(f1)
    title(name)

    legend(leg)
    ylabel('S_v(f)')
    xlabel('f')
    %    figure(f2)
%    title(name)
%    ylabel('S_x(f)')
%    xlabel('f')
%    legend(leg)
%    
    if to_save
        save_figure([name '_gofr_full'],[5 5],f)
        figure(f)
        axis([0 20 0 3])
        save_figure([name '_gofr_detail'],[5 5],f)
    end
end    
    
    
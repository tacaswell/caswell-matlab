function out = t_pspec_fit_wrap(results)
%o function out = t_pspec_fit_wrap(results)
%o summary: fits a power law to the first 1Hz of data of the power
% spectrum of the velocities of particles
%o input:
%-results: 1xN cell array of structs that must contan the fields name, tms and
%tracks_fill
%o output:
%-out: 1xN cell array that contains name and a power law fit to the first
%hertz of data.
    
    
    out = cell(size(results));

    for j = 1:length(results)
        out{j} = struct;
        out{j}.name = results{j}.name;
        
        fs = 1/mean( sum(diff(results{j}.tms).*repmat([0 0 24*60*60 60*60 ...
                            60 1 1/1000],length(results{j}.tms)-1,1),2));

        
        [a b] = t_fft_mean_cord(results{j}.tracks_fill);
        out{j}.fitx = t_fit_powerspec(a,linspace(0,fs/2,length(a)));
        out{j}.fity = t_fit_powerspec(b,linspace(0,fs/2,length(b)));
    end
    figure;
    tmpx = zeros(size(out));
    tmpy = zeros(size(out));
    time = zeros(size(out));
    heat_on_t = mean_time([2008 07 28 15 39 0 0]);
    heat_off_t = mean_time([2008 07 28 16 22 30 0])-heat_on_t;

    for j = 1:length(out)
        tmpx(j) = out{j}.fitx(1);
        tmpy(j) = out{j}.fity(1);
        time(j) = mean_time(results{j}.tms)- heat_on_t;
    end
    
    hold on;
    plot(time([end 1:(end-1)]),tmpx([end 1:(end-1)]));
    plot(time([end 1:(end-1)]),tmpy([end 1:(end-1)]));
            
    plot([0 0],get(gca,'ylim'),'r--')

    plot([heat_off_t heat_off_t],get(gca,'ylim'),'b--')
    

end
function disp_diagnos(pos,disp)
% DISP_DIAGNOS - displays plots of the cumulative displacement to try and find a good way to identify small displacements
%   
    avg_wind = 1;
    cum_disp = cellfun(@(x) filter(ones(avg_wind,1),avg_wind,[0 0; ...
                        cumsum(x)]),disp,'uniformoutput',false);

    f1 = figure;

    f2 = figure;
    hold all;
    f3 = figure;
    hold all;
    plot(pos(:,2),pos(:,1),'x');
    h = [];
    f4 = figure;
    hist_range = linspace(-25,25,100);
    hold on;
    for k =  1:length(cum_disp)
        figure(f1);
        cla;
        plot( cum_disp{k}(:,2),cum_disp{k}(:,1));
        axis image
        figure(f2)
        cla;
        plot(cum_disp{k}(:,2),'b');
        plot(cum_disp{k}(:,1),'r');
        figure(f3)
        delete(h)
        h= plot(pos(k,2),pos(k,1),'o');
        figure(f4)
        cla
        xh=histc(cumsum(disp{k}(:,1)),hist_range);
        yh=histc(cumsum(disp{k}(:,2)),hist_range);
        stairs(hist_range,xh,'r');
        stairs(hist_range,yh,'b');
        pause;
        
    end
              
end

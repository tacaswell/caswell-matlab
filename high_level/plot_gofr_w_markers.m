function plot_gofr_w_markers(in)
   
    figure;
    hold on;
    
    stairs(in.edges,in.gofr);
    arrayfun(@(x) plot([x x],[.5 1.5],'r'), ...
             in.extrema.peaks)
    arrayfun(@(x) plot([x x],[.5 1.5],'m'), ...
             in.extrema.troughs)
   
    h = title(in.stack_name((find(in.stack_name=='/',2,'last')+1):end));
    set(h,'interpreter','none')
   axis([0 100 0 3]) 
end
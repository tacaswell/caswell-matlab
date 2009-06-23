function out = plot_fft_new(in,fft_in,fft_len,f)

    

    figure(f);
    hold all;
    set(gca,'colororder',lines(length(fft_in)));
    % don't use arrayfun, order isn't guarantee
    for j = 1:length(fft_in); 
        plot(linspace(0,20,fft_len),fft_in(j).mean_x,'-x');
    end
    for j = 1:length(fft_in); 
        plot(linspace(0,20,fft_len),fft_in(j).mean_y,'--o');
    end
    
    leg = arrayfun(@(x) cell2mat(regexpi(x.stack_name,['[0-9]{2}-' ...
                        '[0-9]'],'match')),in,'uniformoutput', ...
                   false);

    leg = cellfun(@(x) [x(1:2) '.' x(4)],leg,'uniformoutput', ...
                   false);
    
    legend(leg,'Location','northwest');
    
    set(gca,'xscale','log')
    set(gca,'yscale','log')
    axis([0 10 0 10])


end
function out = make_fft_new(in,fft_len)

    
    out = arrayfun(@helper_fun,in);
    
    figure;
    hold all;
    
    % don't use arrayfun, order isn't guarantee
    for j = 1:length(out); 
        plot(linspace(0,20,fft_len),out(j).mean_x,'-x');
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

    function out = helper_fun(in)
        
        filt_fun = @hann;
        
        tmp = in.tracks_disp;
        tmp = tmp(cellfun(@(x) length(x),tmp)>fft_len);
        out.fft = cellfun(@(x) (abs(fft(x(1:fft_len,:).*[window(filt_fun,fft_len) ...
                            window(filt_fun,fft_len)],fft_len)).^2)/ ...
                          fft_len,tmp,'uniformoutput', false);
        
        tmp = cell2mat(out.fft);
        out.mean_x = mean(reshape(tmp(:,1),fft_len,[]),2);
        out.mean_y = mean(reshape(tmp(:,2),fft_len,[]),2);
        
    end

end
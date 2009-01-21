function fit = t_fit_powerspec(fft_res, freq)
%o function fit = t_fit_powerspec(fft_res, time)
%o summary: fits a one term power law to the data below
% one Hz with a bottom cut off o fthe for f(x) = cx^b
%o inputs:
%-fft_res: power spectrum vector
%-freq: frequencies to go with power spectrum
%o output:
%-fit: 1x2 vector with the coefficent and exponential [b c]
    
    cut_off_indx = find(freq>2,1);
    bottom_cut = 4;
    pspec = fft_res(bottom_cut:cut_off_indx);
    freq = freq(bottom_cut:cut_off_indx);
%    figure
%    plot(log(freq),log(pspec),'x')
%    hold on
%
   
    
    fit = tlinfit(log(pspec)', [log(freq);ones(1,length(freq))]',1);
    %    X = linspace(log(min(freq)),log(max(freq)),50);
    % plot(X,fit(2) + fit(1)*X);
    
    

    
    
    
end
    
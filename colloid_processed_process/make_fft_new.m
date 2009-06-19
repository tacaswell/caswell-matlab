function out = make_fft_new(in,fft_len)

    
    out = arrayfun(@helper_fun,in);
    
    
    


function out = helper_fun(in)
    tmp = in.tracks_disp;
    tmp = tmp(cellfun(@(x) length(x),tmp)>fft_len);
    out.fft = cellfun(@(x) (abs(fft(x(1:fft_len,:).*[hann(fft_len) hann(fft_len)],fft_len)).^2)/fft_len,tmp,'uniformoutput', ...
                      false);
    
    tmp = cell2mat(out.fft);
    out.mean_x = mean(reshape(tmp(:,1),fft_len,[]),2);
    out.mean_y = mean(reshape(tmp(:,2),fft_len,[]),2);
    
end

end
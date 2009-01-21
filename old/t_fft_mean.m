function [fft_mean_v fft_mean_p] = t_fft_mean(track)


    
    tmp_index = t_trim_track_indx(track,512);
    
    count = 0;
    fft_mean_v = zeros(512,1);
    fft_mean_p = zeros(512,1);
 
    for j = 1:size(tmp_index,1)
        if (tmp_index(j,2) - tmp_index(j,1))<1000
            fft_mean_v = fft_mean_v + t_fft(track(tmp_index(j,1):tmp_index(j,2),3));                
            fft_mean_v = fft_mean_v + t_fft(track(tmp_index(j,1): ...
                                                tmp_index(j,2),4));
            
            fft_mean_p =...
                fft_mean_p + t_fft(track(tmp_index(j,1):tmp_index(j,2),1)...
                                -mean(track(tmp_index(j,1):tmp_index(j,2),1)) ...
                                 );                
            fft_mean_p =...
                fft_mean_p + t_fft(track(tmp_index(j,1):tmp_index(j,2),2)...
                                 -mean(track(tmp_index(j,1):tmp_index(j,2),2)));                

            
            count = count +2;
        end
        
    end
    
    fft_mean_v = fft_mean_v/count;
    fft_mean_p = fft_mean_p/count;
    
    count
    
end
    
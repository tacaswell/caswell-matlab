function [fft_mean_vy fft_mean_vx] = t_fft_mean_cord(track)
%o function [fft_mean_vy fft_mean_vx] = t_fft_mean_cord(track)
%o summary: computes the mean power spectrum in the X and Y directions of
%the motion of a large number of particles
%o inputs:
%-track: posistion data
%o outputs:
%-fft_mean_vx: mean power spectrum along the x-axis
%-fft_mean_vy: mean power spectrum along the y-axis


    NFFT = 128*2;
    
    tmp_index = t_trim_track_indx(track,NFFT);
    
    count = 0;
    fft_mean_vx = zeros(NFFT/2,1);
    fft_mean_vy = zeros(NFFT/2,1);
 
    for j = 1:size(tmp_index,1)
        %        if (tmp_index(j,2) - tmp_index(j,1))<1000
            fft_mean_vx = fft_mean_vx+ t_fft_2(track(tmp_index(j,1): ...
                                                      tmp_index(j,2),3),NFFT);
                

            fft_mean_vy = fft_mean_vy + t_fft_2(track(tmp_index(j,1): ...
                                                tmp_index(j,2),4),NFFT);
            
            
            count = count +1;
            %end
        
    end
    
    fft_mean_vx = fft_mean_vx/count;
    fft_mean_vy = fft_mean_vy/count;
    
%    figure
%    plot(fft_mean_vx,'rx-')
%    hold on
%    plot(fft_mean_vy,'rx--')
%    
    count
    
end
    
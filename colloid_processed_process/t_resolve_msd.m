function [msd msd_c] = t_resolve_msd(in,t_start,t_bin_sz,t_bin_c,msd_steps)
% T_RESOLVE_MSD - msd as a function of starting time
%   
    
    msd = zeros(t_bin_c,msd_steps);
    msd_c = zeros(t_bin_c,msd_steps);
    for j = 1:length(in.tracks_disp)
        tmp_disp = [0 0;cumsum(in.tracks_disp{j})];
        for k = 1:msd_steps
            for m = 0:(floor(size(in.tracks_disp{j},1)/k)-1)
                               
                t_bin_i = floor(((in.pos(j,3) + m*k)-t_start)/t_bin_sz)+1;
                msd(t_bin_i,k) = msd(t_bin_i,k) + sum((tmp_disp(m*k+1,:) - tmp_disp(k*(m+1),:)).^2);
                msd_c(t_bin_i,k)=msd_c(t_bin_i,k)+1;
            end
            
            
            
        end
        
        
    end
    
    
end

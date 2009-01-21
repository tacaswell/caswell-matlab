function [msd_vec msd_err ] = t_msd2_2(tracks,max_offset, minlength)
       
    Dd = .2;
    %error in pixels
    
    track_index = t_trim_track_indx(tracks,minlength);
    
    
    
    num_tracks = size(track_index,1);
    
    
    
    
    part_count = zeros(1,max(tracks(:,3)));
    
    disp_sum = zeros(1,max_offset);
    for j = 1:num_tracks

        tmp = tracks((track_index(j,1)):track_index(j,2),[1 2]);
        %%extract just the track we want

        pt_count = size(tmp,1);
        %make sure it si long enough
        
        %this version of the code computes the msd for each particle
        %and then averages these with equal weight
        part_count(pt_count) = part_count(pt_count)+1;


        for k = 1:(min([max_offset pt_count]-1))
            
            disp_sum(k) = disp_sum(k) + ...
                mean(sum(diff(tmp(1:k:end,:)).^2,2));
        end
    end


    
    part_count = fliplr(cumsum(fliplr(part_count)));
    msd_vec = disp_sum./part_count(1:length(disp_sum));
    
    msd_err = 2 * Dd *sqrt(msd_vec./part_count(1:length(msd_vec)));
end

 

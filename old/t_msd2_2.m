function [msd_vec track_count part_count msd_err ] = t_msd2_2(tracks,max_offset, minlength)
       
    Dd = .2;
    %error in pixels
    
    track_index = t_trim_track_indx(tracks,minlength);
    
    
    
    num_tracks = size(track_index,1);
    
    track_count = zeros(1,max_offset);
    
    
    part_count = zeros(1,max(tracks(:,3)));
    
    disp_sum = zeros(1,max_offset);
    for j = 1:num_tracks

        tmp = tracks((track_index(j,1)):track_index(j,2),[1 2]);
        %%extract just the track we want

        pt_count = size(tmp,1);



        part_count(pt_count) = part_count(pt_count)+1;


        for k = 1:(min([max_offset pt_count]-1))

            track_count(k) = track_count(k) + floor((pt_count-1)/k);
            disp_sum(k) = disp_sum(k) + ...
                sum(sum(diff(tmp(1:k:end,:)).^2,2));
        end
    end


    
    part_count = fliplr(cumsum(fliplr(part_count)));
    msd_vec = disp_sum./track_count(1:length(disp_sum));
    
    msd_err = 2 * Dd *sqrt(msd_vec./part_count(1:length(msd_vec)));
 end
    
 

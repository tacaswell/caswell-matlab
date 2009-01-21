function [msd_vec track_count part_count msd_err ] = t_msd(tracks,max_offset, minlength, maxlength)
    if nargin<4
        maxlength = 1e8;
    end
       
    Dd = .2;
    %error in pixels

    num_tracks = max(tracks(:,end));
    track_count = zeros(1,max_offset);
    part_count = zeros(1,max(tracks(:,3)));
    disp_sum = zeros(1,max_offset);
    track_list = tracks(:,4);
    %%loop over tracks
    tmp_index = [0; find(diff(track_list)); size(track_list,1)];
    for j = 1:num_tracks

        tmp = tracks((tmp_index(j)+1):tmp_index(j+1),[1 2]);
        %%extract just the track we want

        pt_count = size(tmp,1);
        %make sure it si long enough
        if(pt_count>=minlength&&pt_count<=maxlength)
            %this version of the code computes the msd for each particle
            %and then averages these with equal weight
            part_count(pt_count) = part_count(pt_count)+1;
            track_count(1) = track_count(1)+pt_count-1;
            disp_sum(1) = disp_sum(1) + mean(sum(diff(tmp).^2,2));
            for k = 2:(min([max_offset pt_count]-1))
                track_count(k) = track_count(k) + pt_count-k;
                disp_sum(k) = disp_sum(k) + mean(sum((tmp((k+1):end,:)...
                                                     -tmp(1:(end-k),: ...
                                                          )).^2,2));
            end
        end
    end

    
    part_count = fliplr(cumsum(fliplr(part_count)));
    msd_vec = disp_sum./part_count(1:length(disp_sum));
    
    msd_err = 2 * Dd *sqrt(msd_vec./part_count(1:length(msd_vec)));
 end
    
 

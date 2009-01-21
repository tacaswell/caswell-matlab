function [msd_vec track_count msd_err] = t_msd_sum(tracks,max_offset, minlength)
%o function [msd_vec msd_err] = t_msd_sum(tracks,max_offset, minlength)
%o summary: Computes the mean squared dispalcement as a function of
%time.  the input must not have any holes.  This is computed by averaging
%all of the track intervals which have a given dispalcement across all
%tracks.  There is something strange that happens around 700 time units
%for reasons unknown, this code needs to be gone over carefully
%o output:
%-msd_vec:a vector with mean squared dispalcement at 1,2,.. time intervals
%-msd_err: error in the computed msd based on extimated error in finding
%particle location and the number of intervals that contributed to the
%average, this needs to be gone over carefully as well
%-track_count: number of data points at each time step
%o inputs:
%-tracks: matrix of tracks, each row is of the form [pos pos track #
%?time?]
%-max_offset:maximum time interval to computer msd at
%-minlength: minimum track length to use in computation
    Dd = .2;
    %error in pixels
    
    track_index = t_trim_track_indx(tracks,minlength);
    
    
    
    num_tracks = size(track_index,1);
    
    track_count = zeros(1,max_offset);
    
    
    part_count = zeros(1,max(tracks(:,end-1)));
    
    disp_sum = zeros(1,max_offset);
    for j = 1:num_tracks

        tmp = tracks((track_index(j,1)):track_index(j,2),[1 2]);
        %%extract just the track we want

        pt_count = size(tmp,1);



        part_count(pt_count) = part_count(pt_count)+1;


        for k = 1:(min([max_offset pt_count]-1))


            track_count(k) = track_count(k) + 1;
            disp_sum(k) = disp_sum(k)+ sum((tmp(1,:)-tmp(k,:)).^2);
            %track_count(k) = track_count(k) + floor((pt_count-1)/k);
            %disp_sum(k) = disp_sum(k) + ...
            %    sum(sum(diff(tmp(1:k:end,:)).^2,2));
        end
    end


    
    part_count = fliplr(cumsum(fliplr(part_count)));

    msd_vec = disp_sum./track_count(1:length(disp_sum));
    
    msd_err = 2 * Dd *sqrt(msd_vec./track_count(1:length(msd_vec)));
 end
    
 

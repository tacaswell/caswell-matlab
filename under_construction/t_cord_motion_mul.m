function [d_vals,d_bins]= t_cord_motion_mul(tracks2, range,frame_dims,format)

    
    if size(tracks2,2)<4
        die
    end
    if nargin<4
        format = 'bx';
    end
    tracks2 = tracks2(tracks2(:,3)~=0,:);
    
    [junk pnt_sort] = sort(tracks2(:,end-1));
    points = tracks2(pnt_sort,:);

    size(points)
    
    track_index =  t_trim_track_indx(tracks2,5);
    %set up the track posistions for the trimed list
    plane_index = t_trim_track_indx(points(:,[end-1]),5);
    %set up index for time step images
    
    
    dot_sum = 0;

    %set up bins to use

    %sets up bins


    d_bins = 0:1/500:pi();
    d_vals = zeros(length(range),length(d_bins));
    
    pos_total = 0;
    part_count = zeros(1,length(range));
    frame_count = size(plane_index,1)
    for j = 1:frame_count
        frame = points((plane_index(j,1)):plane_index(j,2),[1 2 3 4]);
        pos_count = size(frame,1);
        %loop over all images
        pos_total = pos_total + pos_count;
        tmp_mean= mean(frame(:,[3 4]),1);
        frame(:,[3 4]) = frame(:,[3 4]) - tmp_mean(ones(1,size(frame,1)),:);

            for k = 1:pos_count
                %loop over all posistions
                
                if frame(k,1)>1.5*range(1) &&...
                        frame(k,1)<(frame_dims(1)-1.5*range(1))...
                        &&frame(k,2)>1.5*range(1)...
                        &&frame(k,2)<(frame_dims(2)-1.5*range(1))
                    %excludes particles too close to edge to have a full
                    %circle around them
                    
                    
                    dist = sqrt(sum( ([frame(k,1)*ones(pos_count,1) ...
                                       frame(k,2)* ones(pos_count,1)]-frame(:,[1 ...
                                        2])).^2, 2)); 
                    %compute distance] between acceptable peaks and
                    %all other peaks
                    for rang = 1:length(range)
                        dist_indx = dist<range(rang);
                        dist_indx(k) = 0;
                        
                        
                        part_count = part_count + sum(dist_indx);
                       
                        if sum(dist_indx)>1
                    
                            d_vals(rang,:) = d_vals(rang,:) + histc(real(acos(sum( ...
                                [ones(sum(dist_indx),1)* frame(k,3) ...
                                 ones(sum(dist_indx),1)* frame(k,4)].* ...
                                frame(dist_indx,[3 4]),2)./ (sqrt(sum(frame(k,[3 ...
                                                4]).^2)) * ...
                               sqrt(sum(frame(dist_indx,[3 4]).^2,2))))),d_bins)';

                
                        end
                    end

                end
                
            end
    

    end
   
    
    figure
    hold on
    
    for j = 1:length(range)
        plot(d_bins(1:(end-1)),length(d_bins(1:(end-1)))*d_vals(j,1:(end-1))/sum(d_vals(j,1:(end-1)))-1,format{j})
    end
end

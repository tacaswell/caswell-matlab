function [d_vals,d_bins]= t_cord_motion(tracks, range,frame_dims,format,recomputre)

    
    if size(tracks,2)<4
        die
    end
    if nargin<4
        format = 'bx';
    end
    if nargin>4
        
        track_index = t_trim_track_indx(tracks,5);
        %get posistions of tracks longer than 5
        
        %set up matrix to hold 
        tracks2 = zeros(sum(tracks(track_index(:,2),3) - tracks(track_index(:,1),3)),6);
        
        %    size(tracks)
%    size(track_index)
%    keep_trk = diff(track_index,[],2)+...
%        tracks(track_index(:,1),3)-tracks(track_index(:,2),3)==-3;
%    sum(keep_trk)
%    
%    
%    tmp_bins = 1:5;
%    tmp_vals = zeros(size(tmp_bins));
%    tmp_sum = zeros(1,60);
%    for j = 1:size(track_index,1)
%        tmp_vals = tmp_vals + histc(diff(tracks(track_index(j,1): ...
%                                                track_index(j,2),3)),tmp_bins)';
%        t_sum = sum(diff(tracks(track_index(j,1): ...
%                                                track_index(j,2),3))-1);
%        tmp_sum(t_sum+1) = tmp_sum(t_sum+1) +1;
%    end
%    
%  
%    
%    figure
%    plot(tmp_bins,tmp_vals,'x')
%    tmp_vals
%    figure
%    plot(0:59,tmp_sum,'x')
%    
%    
%%    die
    tmp_index2 = 1;
    for j = 1:size(track_index,1)
       %if j==82
       %    size(tracks2(tmp_index2:(tmp_index2 + tracks(track_index(j,2),3) - ...
       %                        tracks(track_index(j,1),3)),:))
       %        size(t_interperolate_track(tracks(track_index(j,1):track_index(j,2),:)))
       %    
       %        tracks(track_index(j,1):track_index(j,2),:)
       %        t_interperolate_track(tracks(track_index(j,1):track_index(j,2),:))
       %            
       %end
       %
        
        tracks2(tmp_index2:(tmp_index2 + tracks(track_index(j,2),3) - ...
                            tracks(track_index(j,1),3)),:)=...
       t_interperolate_track(tracks(track_index(j,1):track_index(j,2),:));

        
        
        
        tmp_index2 = tmp_index2+ tracks(track_index(j,2),3) - ...
                            tracks(track_index(j,1),3)+1;
       
    end
  
    
else
     
     tracks2 = tracks;
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


    d_bins = 0:1/1000:pi();
    d_vals = zeros(size(d_bins));
    
    pos_total = 0;
    part_count = 0;
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
           
            if frame(k,1)>1.5*range &&...
                    frame(k,1)<(frame_dims(1)-1.5*range)...
                    &&frame(k,2)>1.5*range...
                    &&frame(k,2)<(frame_dims(2)-1.5*range)
                %excludes particles too close to edge to have a full
                %circle around them

               
                dist = sqrt(sum( ([frame(k,1)*ones(pos_count,1) frame(k,2)* ...
                                   ones(pos_count,1)]-frame(:,[1 2])).^2, 2)); ...
                                 
                %compute distance] between acceptable peaks and
                %all other peaks

                dist_indx = dist<range;
                dist_indx(k) = 0;


                part_count = part_count + sum(dist_indx);
               dot_sum = dot_sum + sum(...
                    acos(sum(...
                        [ones(sum(dist_indx),1)* ...
                                    frame(k,3) ones(sum(dist_indx),1)* ...
                                    frame(k,4)].*frame(dist_indx,[3 4]),2)./...
                    (sqrt(sum(frame(k,[3 4]).^2)) *sqrt(sum(frame(dist_indx,[3 ...
                                    4]).^2,2)) ))); 
                
                if sum(dist_indx)>1
                    %                    k
                    % find(dist_indx)
                    % pause
                    %                    acos(max(sum( [ones(sum(dist_indx),1)* frame(k,3) ones(sum(dist_indx),1)* ...
                    %   frame(k,4)].*frame(dist_indx,[3 4]),2)./ ...
                    % (sqrt(sum(frame(k,[3 4]).^2)) *sqrt(sum(frame(dist_indx,[3 ...
                    %                 4]).^2,2)))))
                    
                d_vals = d_vals + histc(real(acos(sum( [ones(sum(dist_indx),1)* frame(k,3) ones(sum(dist_indx),1)* ...
                      frame(k,4)].*frame(dist_indx,[3 4]),2)./ ...
                    (sqrt(sum(frame(k,[3 4]).^2)) *sqrt(sum(frame(dist_indx,[3 ...
                                    4]).^2,2))))),d_bins)';

                
                end
 %               if min(dist) ==0
 %                   min(dist)
 %                   j
 %                   k
 %                 
 %               end
                   
                %                              size(dist)
                %                dummy = find(dist<5)
%                if ~isempty(dummy)
%                    dummy
%                    j
%                end
                %filter out peaks that are too far away

            end
            
        end
        
    end

    dot_sum/part_count

    plot(d_bins,d_vals/sum(d_vals),format)
    
end
    
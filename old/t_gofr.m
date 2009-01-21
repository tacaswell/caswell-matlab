function [bin_val t_bins] = t_gofr(pks,bin_num, max_length,frame_dims)
%%assumes that frame_dims is properly adjusted for dead area
%%assumes all adjustments to convert pixels to distance has been done
    if size(pks,2)<3
        die
    end
    pks = pks(:,[1 2 end]);
    %% strips out extra information we do not need for this computation

    bin_width = max_length/bin_num;    
    t_bins = (0:bin_width:max_length)';
    %set up bins to use
    bin_val = zeros(size(t_bins));
    %sets up bins
    tmp_index = [0; find(diff(pks(:,3))); size(pks(:,3),1)];
    pos_total = 0;
    part_count = 0;
    frame_count =max(pks(:,end));
    for j = 1:frame_count
    
        frame = pks((tmp_index(j)+1):tmp_index(j+1),[1 2]);
        pos_count = size(frame,1);
        %loop over all images
        pos_total = pos_total + pos_count;
        for k = 1:pos_count
            %loop over all posistions
           
            if frame(k,1)>1.5*max_length &&...
                    frame(k,1)<(frame_dims(1)-1.5*max_length)...
                    &&frame(k,2)>1.5*max_length...
                    &&frame(k,2)<(frame_dims(2)-1.5*max_length)
                %excludes particles too close to edge to have a full
                %circle around them

               
                dist = sqrt(sum(...
                ([frame(k,1)*ones(pos_count-1,1) frame(k,2)* ...
                  ones(pos_count-1,1)]-frame([1:(k-1) (k+1):end],:)).^2, ...
                    2));
                %compute distance between acceptable peaks and
                %all other peaks

                dist = dist(dist<max_length);
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
                 part_count = part_count +1;
                if prod(size(dist))>1
                   
                    bin_val = bin_val + histc(dist,t_bins);
                end
            end
            
        end
        
    end
    bin_val = bin_val(1:(end-1))/part_count; 
    %average over particles and remove extra bin at end
    bin_val = bin_val./(pi()*(diff(t_bins.^2)));
    %scales for volume
    bin_val = bin_val/(pos_total/(prod(frame_dims)*frame_count));
    % devide by average density
figure
plot(cumsum(diff(t_bins)),bin_val,'.');

    
end


    
    

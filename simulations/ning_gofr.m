function [out] = ning_gofr(pks,bin_num, max_length,frame_dims)
%%assumes that frame_dims is properly adjusted for dead area
%%assumes all adjustments to convert pixels to distance has been done
    if size(pks,2)<3
        die
    end
    
    if max(diff(pks(:,end)))>1
        die
    end



    t_bins = linspace(0,max_length,bin_num)';
    %set up bins to use
    bin_val = zeros(size(t_bins));
    %sets up bins
    tmp_index = [0; find(diff(pks(:,end))); size(pks(:,end),1)];
    pos_total = 0;
    part_count = 0;
    frame_count =max(pks(:,end))+1;

    for j = 1:frame_count
        %loop over all images
        frame = pks((tmp_index(j)+1):tmp_index(j+1),1:(end -1));
        pos_count = size(frame,1);
        pos_total = pos_total + pos_count;
        for k = 1:pos_count
            %loop over all posistions
           
            if prod(double(frame(k,:)>max_length & ...
                    frame(k,:)<(frame_dims-max_length)))
            

                %excludes particles too close to edge to have a full
                %circle around them

                dist = sqrt(sum((frame(k*ones(pos_count-1,1),:) -...
                       frame([1:(k-1) (k+1):end],:)).^2,2));
               
                %compute distance between acceptable peaks and
                %all other peaks

                dist = dist(dist<max_length);
                %filter out peaks that are too far away
                part_count = part_count +1;
                if prod(size(dist))>1
                    bin_val = bin_val + histc(dist,t_bins);
                end
            else
% $$$                 frame(k,:)
            end
            
        end
        
    end
    part_count
    pos_total
    bin_val = bin_val(1:(end-1))/part_count; 
    %average over particles and remove extra bin at end
    if(length(frame_dims) ==2)
        bin_val = bin_val./(pi()*(diff(t_bins.^2)));

    elseif(length(frame_dims) ==3)
        bin_val = bin_val./(4*pi()*(diff(t_bins.^3))/3);
    end
    %scales for volume
    
    bin_val = bin_val/(pos_total/(prod(frame_dims)*frame_count));
    
    out.gofr = bin_val;
    out.edges = t_bins(1:(end-1));
    
    % devide by average density
% $$$ 
% $$$     figure
% $$$     stairs(t_bins(1:end-1),bin_val)

    
end


    
    

function [sqr_vec quad_vec part_count] = t_particp(tracks,max_offset, minlength)
%o function [sqr_vec quad_vec part_count] = t_particp(tracks,max_offset,minlength)
%o summary: computes the participation ratio for the velocity, need to
%go over carefully and figure out what is going on/finish writing this


       
    Dd = .2;
    %error in pixels
    
    track_index = t_trim_track_indx(tracks,minlength);
    
    
    
    num_tracks = size(track_index,1)
    
    track_count = zeros(1,max_offset);
    
    
    part_count = zeros(1,max(tracks(:,(end-1))));
    
    disp_sqr_sum = zeros(1,max_offset);
    disp_quad_sum = zeros(1,max_offset);
    for j = 1:num_tracks

        tmp = tracks((track_index(j,1)):track_index(j,2),[1 2]);
        %%extract just the track we want


        pt_count = size(tmp,1);

      

        part_count(pt_count) = part_count(pt_count)+1;


        for k = 1:(min([max_offset pt_count]-1))

            track_count(k) = track_count(k) + floor((pt_count-1)/k);
           
            
%            floor((pt_count-1)/k)+1
%            size(tmp(1:k:end,:))
%            pause
%           
            v = sqrt(sum(diff(tmp(1:k:end,:)).^2,2));
            
            disp_quad_sum(k) = disp_quad_sum(k) + sum(v.^4);
            
            %        disp_quad_sum(k) = disp_quad_sum(k) + ...
            %     sum(( sum(diff(tmp(1:k:end,:)).^2,2)).^2);

            
            disp_sqr_sum(k) = disp_sqr_sum(k) + sum(v.^2);
        end
    end
    


    
    part_count = fliplr(cumsum(fliplr(part_count)));
    sqr_vec = disp_sqr_sum;
    quad_vec = disp_quad_sum;
    
    sqr_vec(1:10).^2
    quad_vec(1:10)

    
    %figure
     %    plot((sqr_vec.^2)./quad_vec,'-x')
     % hold on
     %plot(track_count(1:max_offset),'r')
    figure
    plot(1-3*(sqr_vec.^2)./(quad_vec)./track_count(1:max_offset),'mo')
 end
    
 

function draw_plane(results,indx)
%o function draw_plane(results,indx)
%o summary: draws a single plane with dots for the centers and circles
%drawn at teh radius of the first peak of g(r)
%o inputs:
%-results: struct with all_pks_trim
%-indx: index of plane to draw
    
    
    g_max = find(results.bin_val==max(results.bin_val));
    p_rad = results.t_bins(g_max)
    part_indx = t_trim_track_indx(results.all_pks_trim(:,end),15);
    figure
    hold on
    tmp = results.all_pks_trim(part_indx(indx,1):part_indx(indx,2),[2 3]);
    scatter(tmp(:,1),tmp(:,2))
    
   
    
    for j = 1:size(tmp,1)
        circle(tmp(j,:),p_rad/2,128,'b-');
    end
    
end
    
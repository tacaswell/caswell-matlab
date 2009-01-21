function t_vals = make_track_hist(tracks,sz,format,normalize)

    track_index = t_trim_track_indx(tracks,5);
    t_bins = -sz:sz/100:sz;
    t_vals = zeros(size(t_bins))';
    
for j = 1:size(track_index,1);


    t_vals = t_vals + histc(diff(tracks(track_index(j,1): ...
                                            track_index(j,2),1)),t_bins);
    %    t_vals = t_vals + histc(diff(tracks(track_index(j,1): ...
    %                                         track_index(j,2),2)),t_bins);

    
end

    if nargin>2
       if nargin<4
           normalize = sum(t_vals);
       else
           normalize = t_vals(101);
       end

        plot(t_bins,t_vals/normalize,format);
    end
end
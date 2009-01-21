function draw_all_tracks(results)
%o function draw_all_tracks(results)
%o summary: plot all tracks
%o input:
%-results: 1x1 struct contianing fields tracks_fill
    

t_cmap = jet(512);
length(results)
for k = 1:length(results)

    track_ind = t_trim_track_indx(results{k}.tracks_fill,5);

    f = figure;
    hold on;
    
    caxis([0 1000])
    colorbar
    
    

    for j = 1:size(track_ind,1);
        plot(results{k}.tracks_fill(track_ind(j,1):track_ind(j,2), ...
                                    1), ...
             results{k}.tracks_fill(track_ind(j,1):track_ind(j,2), ...
                                    2),'color',t_cmap(1+floor(512* ...
                                                          (track_ind(j,2)- ...
                                                          track_ind(j,1))/ ...
                                                          1000),:));

    end
    title(results{k}.name);
    axis([0 520 0 696])   ;
    axis square
    save = 0;
    if save==1
        save_figure(sprintf('%s_all_tracks',results{k}.name),[5 5],f);
    end
end

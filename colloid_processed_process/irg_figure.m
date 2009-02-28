function irg_figure(tracks)
    cutoff = 0;
    t_index = t_trim_track_indx(tracks,cutoff);
    seed_plane = 1200;
    
    
    x_max = 300;
    x_min = 250;
    y_max = 800;
    y_min = 750;
    
    
    tracks_in_plane = tracks(tracks(:,3) == seed_plane...
                             &tracks(:,1) > x_min...
                             &tracks(:,1) < x_max ...
                             &tracks(:,2) > y_min ...
                             &tracks(:,2) < y_max...
                             ,:);
    
    
    figure;
    hold on;

    
    scatter3(tracks_in_plane(:,2),tracks_in_plane(:,1),...
             seed_plane*ones(size(tracks_in_plane,1),1) ,'kx')
    axis image
    

   
                             
    tracks_in_plane = tracks_in_plane(:,4)+1;
    col_map =  lines(size(tracks_in_plane,1));
    for j=1:size(tracks_in_plane,1),
        plot3(...
            tracks(t_index(tracks_in_plane(j)):...
                   (t_index(tracks_in_plane(j)+1)-1),2),...
            tracks(t_index(tracks_in_plane(j)):...
                   (t_index(tracks_in_plane(j)+1)-1),1),...
            tracks(t_index(tracks_in_plane(j)):...
                   (t_index(tracks_in_plane(j)+1)-1),3),...
            'color',col_map(j,:));
        
    end
    axis image;
    xlabel('X')
    ylabel('Y')
    zlabel('time')
    grid on
    
    figure
    hold on;
    pos_in_plane = tracks(tracks(:,3)==1200,[1 2]);
    
    %javaaddpath('/home/tcaswell/matlab/bio-formats.jar')
    r = loci.formats.ChannelFiller();
    r = loci.formats.ChannelSeparator(r);
    fname ='/home/tcaswell/collids/data/polyNIPAM_batch_11/20081010/temp_series/26.tif'
    r.setId(fname);
    img = extract_image(r,1200);
    imagesc(img)
    axis image
    colormap(gray)
    axis off
    
    scatter(pos_in_plane(:,2)+1,pos_in_plane(:,1)+1,'rx')
    
    plot([y_min y_max y_max y_min y_min],[x_min x_min  x_max x_max ...
                        x_min])
    
    scale = 1.5;
    
    axis([ y_min - scale*(y_max - y_min) y_max + scale*(y_max - y_min)...
           x_min - scale*(x_max - x_min) x_max + scale*(x_max - x_min) ])
end
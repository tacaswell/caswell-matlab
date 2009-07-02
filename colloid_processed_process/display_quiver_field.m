function display_quiver_field(in)
   
    
    figure;
    quiver(in.pos(:,2),in.pos(:,1),cellfun(@(x) sum(x(:,2)),in.tracks_disp(:)),cellfun(@(x) sum(x(:,1)),in.tracks_disp(:)),0);
    axis image;

end
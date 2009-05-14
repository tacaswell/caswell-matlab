function ning_proj_series(data,min_plane,max_plane,step)
    
    f =figure;
    hold all

    
    plane_vec = min_plane:step:max_plane;
    set(gca,'colororder',jet(length(plane_vec)));
    
    gofr = arrayfun(@(x) ning_gofr(ning_project(data,x),250,.3, ...
                                   max(data(:,1:(end-2)))), ...
                    plane_vec);
    
    for j = (1:length(gofr))
        stairs(gofr(j).edges,gofr(j).gofr);
    end
    
    leg = arrayfun(@(x) num2str(max(data(:,3))/x),plane_vec,'uniformoutput', ...
                   false);
    legend(leg)
end
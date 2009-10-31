function link_track_vis(hinfo,id,f1,f2,f3)
% LINK_TRACK_VIS - displays plots of the tracks that come from the attemps
% to link the parctiles to get posistions in 3D 
    
    tmp_data = load_tracks_hdf(hinfo,id);
    id
    x = tmp_data.data(:,1);
    y = tmp_data.data(:,2);
    z = tmp_data.data(:,3);
    I = tmp_data.data(:,4);
    
    x = x;%-mean(x);
    y = y;%-mean(y);

    xm = sum(x.*I)/sum(I);%-mean(x);
    ym = sum(y.*I)/sum(I);%-mean(x);
    [sx,sy,sz] = sphere(20);
    sx = sx*.5;
    sy = sy*.5;
    sz = sz*.5;
    [centers ranges] = split_tracks(tmp_data.data)
    figure(f1);
    clf;        hold all;
    plot(x,y,'x-');
    plot(xm,ym,'gs')
    figure(f2);
    clf;        hold all;
    plot(z,I,'x-');
    figure(f3);
    clf;        hold all;
    plot3(x*0.107576,y*0.107576,z,'-x');
    for j = 1:size(centers,1)
        tmp_range = ranges(j,1):ranges(j,2);
        figure(f1);


        plot(x(tmp_range),y(tmp_range),'x-');
        circle([centers(j,1) centers(j,2) ],1.5,25,'-r');
        plot(centers(j,1), centers(j,2) ,'rx')
        axis image
        figure(f2);


        plot(z(tmp_range),I(tmp_range),'x-');
        mean(z(tmp_range))
        plot(ones(1,2)*centers(j,3) ,[min(I) max(I)],'k--')
        figure(f3);


        plot3(x(tmp_range)*0.107576,y(tmp_range)*0.107576,z(tmp_range),'-x');

        surf(sx+centers(j,1)*0.107576,sy+centers(j,2)*0.107576,sz+ ...
             centers(j,3),'FaceColor','red','EdgeColor','none')
        camlight left; lighting phong;
        view(-50,10)
        alpha(.5)
        axis image
    end
    
end


function [centers ranges] = split_tracks(data)
% SPLIT_TRACKS - splits a 'track' that may contain more than one particle it to particles
%   
    
    x = data(:,1);
    y = data(:,2);
    z = data(:,3);
    I = data(:,4);
    
    lm = local_max(I)
    if lm(1) ==1
        %        lm = lm(2:end);
        lm(1) =lm(1) +1;
    end
    if (~isempty(lm) & lm(end) == length(I))
% $$$         lm = lm(1:(end-1));
        lm(end) = lm(end)-1;
    end
    lm
    ranges =find_ranges(lm,I);
    centers = zeros(size(ranges,1),3);
    for j = 1:size(ranges,1)
        tmp_range = ranges(j,1):ranges(j,2);
        norm_I = sum(I(tmp_range))
        centers(j,1) = sum(x(tmp_range).*I(tmp_range))/norm_I;
        centers(j,2) = sum(y(tmp_range).*I(tmp_range))/norm_I;
        centers(j,3) = sum(z(tmp_range).*I(tmp_range))/norm_I;
    end
    
end


function ranges = find_ranges(lm,vec)
% FIND_RANGES - finds the best ranges for identifying particles
%   
    
    if isempty(lm)
        ranges = []
        return
    end
    to_close_range = 3;
    buffer_range = 2;
    
    to_close = find(diff(lm)<=to_close_range);
    while(sum(to_close))
        to_close
        j = to_close(1)
        if vec(lm(j)) > vec(lm(j+1))
            lm = lm([1:j (j+2):end])
        else
            lm = lm([1:(j-1) (j+1):end])
        end
        to_close = find(diff(lm)<=to_close_range)
    end
    
    ranges = zeros(length(lm),2);
    ranges(:,1) = lm - buffer_range;
    ranges(:,2) = lm + buffer_range;
    ranges
    ranges(ranges<1) = 1;
    ranges(ranges>length(vec)) = length(vec);
    for j = 1:length(lm)-1
        if(ranges(j+1,1) == ranges(j,2))
            ranges(j+1,1) =ranges(j+1,1) +1;
            ranges(j,2) =ranges(j,2) -1;
        end
    end
    ranges
    ranges = ranges(diff(ranges,[],2)>1,:)
end

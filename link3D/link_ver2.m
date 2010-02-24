function link_ver2(r,data,plane,data2D,plot_scale)
% link_VER2 - attempt 2 at verifying the 3D linking
%   
    
    axis_bounds = [1030 1250 250 380];
    
    data2D(:,3) = 519 - data2D(:,3) +1;
    data2D(:,4) = data2D(:,4)+1;
    
    %    buffer_pk = cell(1,numImages);    

    img = extract_image(r,plane);
    
    plane_step = .2;
    plane_z = plane * plane_step;
    
    slice_thickness = .5;
    rad = .45;
    indxa = data(:,3)>(plane_z-slice_thickness - rad)& data(:,3)<(plane_z) ;
    indxb = data(:,3)<(plane_z+slice_thickness + rad) & data(:,3)>(plane_z) ; ;
    
    fh = figure
    set(fh,'WindowButtonDownFcn',@button_down)
    im1 = imagesc(img);
    a1 = gca;
    colormap(gray)
    axis image;
    hold on;
    
    data2D_tmp = trim_to_region(data2D(data2D(:,end)==plane-2,[2 3]),axis_bounds);
    p4 = plot(data2D_tmp(:,1) , data2D_tmp(:,2) ,'bx');
    data2D_tmp = trim_to_region(data2D(data2D(:,end)==plane-1,[2 3]),axis_bounds);
    p2 = plot(data2D_tmp(:,1) , data2D_tmp(:,2) ,'mx');
    
    data2D_tmp = trim_to_region(data2D(data2D(:,end)==plane,[2 3]),axis_bounds);
    p1 = plot(data2D_tmp(:,1) ,  data2D_tmp(:,2) ,'gx');
    
    data2D_tmp = trim_to_region(data2D(data2D(:,end)==plane+1,[2 3]),axis_bounds);
    p3 = plot(data2D_tmp(:,1) ,  data2D_tmp(:,2) ,'rx');
    data2D_tmp = trim_to_region(data2D(data2D(:,end)==plane+2,[2 3]),axis_bounds);
    p5 = plot(data2D_tmp(:,1) ,  data2D_tmp(:,2) ,'kx');
    
    r_upper = data(indxb,3)-plane_z - slice_thickness;
    r_upper(r_upper>0) = sqrt(rad^2 - r_upper(r_upper>0).^2);
    r_upper(r_upper<=0) = rad;
       
    
    r_lower = data(indxa,3)-plane_z + slice_thickness;
    r_lower(r_lower>=0) = rad;
    r_lower(r_lower<0) = sqrt(rad^2 - r_lower(r_lower<0).^2);
    
    

    
    s1 = scatter(data(indxb,1)/.107576 +1, 519-data(indxb,2)/.107576 ...
            +1,r_upper.^2*pi*plot_scale,'r');
    
    s2 = scatter(data(indxa,1)/.107576 +1, 519-data(indxa,2)/.107576 +1,pi ...
            * r_lower.^2 *plot_scale,'b');

    axis(axis_bounds)
    
    bc = changer('plane',[30 30] ,fh,@adjust_plane);
    
    legend({'-2','-1','0','1','2','above','below'});
    
    adjust_plane(plane);
    
    fig2 = figure;
    
    function button_down(src,event)
        box_sz = 3.5;
        plane_range = 3;
        cur_point = get(a1,'currentpoint');
        cur_point = floor(cur_point(1,1:2)+.5);
        display(cur_point);
        indx_disp = data2D(:,2)<(cur_point(1)+box_sz) &...
            data2D(:,2)>(cur_point(1)-box_sz) &...
            data2D(:,3)<(cur_point(2)+box_sz) &...
            data2D(:,3)>(cur_point(2)-box_sz) &...
            data2D(:,end)>=plane-plane_range&...
            data2D(:,end)<=plane+plane_range;
        
        display(data2D(indx_disp,[2 3 end]))
        display(sum(diff(data2D(indx_disp,[2 3])).^2,2))
        display(sqrt(...
            (data2D(indx_disp,[2])-cur_point(1)).^2 + ...
            (data2D(indx_disp,[3])-cur_point(2)).^2))
        figure(fig2)
        plot(data2D(indx_disp,end)-plane,data2D(indx_disp,6),'-x')
        
    end
    
    function int = adjust_plane(int)
        plane = int;
        update_buffer;
    end
    
    function update_buffer()
        tic
        img = extract_image(r,plane);
        set(im1,'cdata',img);
        
        


        data2D_tmp = trim_to_region(data2D(data2D(:,end)==plane,[2 3]),axis_bounds);
        set(p1, 'xdata', data2D_tmp(:,1) );
        set(p1,'ydata', data2D_tmp(:,2) );
        data2D_tmp = trim_to_region(data2D(data2D(:,end)==plane-1,[2 3]),axis_bounds);
        set(p2, 'xdata', data2D_tmp(:,1) );
        set(p2,'ydata', data2D_tmp(:,2) );
        data2D_tmp = trim_to_region(data2D(data2D(:,end)==plane+1,[2 3]),axis_bounds);
        set(p3, 'xdata', data2D_tmp(:,1) );
        set(p3,'ydata', data2D_tmp(:,2) );
        data2D_tmp = trim_to_region(data2D(data2D(:,end)==plane-2,[2 3]),axis_bounds);
        set(p4, 'xdata', data2D_tmp(:,1) );
        set(p4,'ydata', data2D_tmp(:,2) );
        data2D_tmp = trim_to_region(data2D(data2D(:,end)==plane+2,[2 3]),axis_bounds);
        set(p5, 'xdata', data2D_tmp(:,1) );
        set(p5,'ydata', data2D_tmp(:,2) );
    
        
        
        
        plane_z = plane * plane_step;
    
        
        indxa = data(:,3)>(plane_z-slice_thickness - rad)& data(:,3)<(plane_z) ;
        indxb = data(:,3)<(plane_z+slice_thickness + rad) & data(:,3)>(plane_z) ; ;
    
        r_upper = data(indxb,3)-plane_z - slice_thickness;
        r_upper(r_upper>0) = sqrt(rad^2 - r_upper(r_upper>0).^2);
        r_upper(r_upper<=0) = rad;
       
    
        r_lower = data(indxa,3)-plane_z + slice_thickness;
        r_lower(r_lower>=0) = rad;
        r_lower(r_lower<0) = sqrt(rad^2 - r_lower(r_lower<0).^2);
    

    
        set(s1,'xdata',data(indxb,1)/.107576 +1)
        set(s1,'ydata',519-data(indxb,2)/.107576+1)
        set(s1,'sizedata',r_upper.^2*pi*plot_scale);
        
        set(s2,'xdata',data(indxa,1)/.107576 +1);
        set(s2,'ydata',519-data(indxa,2)/.107576 +1);
        set(s2,'sizedata',pi * r_lower.^2 *plot_scale);
    

        toc
        

        
    end
    
end

function out= trim_to_region(data,range)
    
    ind = data(:,1)>range(1) & ...
          data(:,1)<range(2) & ...
          data(:,2)>range(3) & ...
          data(:,2)<range(4);
    out = data(ind,:);
end
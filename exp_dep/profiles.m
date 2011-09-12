function profiles(img,bpassed,pt,pks)
    x = pt(1)
    y = pt(2)
    figure
    hold all
    wind = 20;
    img_row = img(y-wind:y+wind,x+1);
    img_row = img_row-min(img_row);
% $$$     img_row = img_row/max(img_row);
    title(['col ' num2str(x)])
    plotyy(1+(y-wind:y+wind),img_row,1+(y-wind:y+wind),bpassed(y-wind:y+wind,x+1),'stairs')
% $$$     stairs(1+(y-wind:y+wind),img_row);
% $$$     stairs(1+(y-wind:y+wind),bpassed(x+1,y-wind:y+wind));
   
    
    f = figure
    
    hold on
    img_tmp = img(1+(y-wind:y+wind),1+(x-wind:x+wind));
    img_tmp = img_tmp - min(min(img_tmp));
    img_tmp = img_tmp/max(max(img_tmp))*50;
    imagesc(1+(x-wind:x+wind),1+(y-wind:y+wind),bpassed(1+(y-wind:y+wind),1+(x-wind:x+wind)))
    
    contour(1+(x-wind:x+wind),1+(y-wind:y+wind),img_tmp)
    
    indx = ((pt(1)-wind) < pks(:,3) )& ((pt(1)+wind) > pks(:,3)) & ...
           ((pt(2)-wind)<pks(:,2)) &     ((pt(2)+wind)>pks(:,2)) ;
    close_pts = pks(indx,[3 2]);% - pks(indx,[5 4]);

    plot(close_pts(:,1)+1,close_pts(:,2)+1,'k*')
    axis equal
    a = get(f,'children')
    set(a,'ydir','reverse')
    
    
end
function guess_id(i,s,pks,img,bpass)

    a = get(i,'parent');
    size(s)
    size(pks)
    if(get(get(a,'parent'),'selectiontype') == 'extend')
        cp = get(a,'currentpoint');
        part = proc_point(cp(1,1:2),pks)
        profiles(img,bpass,round(part),pks)
        pind = find(pks(:,3) == part(1) & pks(:,2)==part(2));
        display(['Itensity: ' num2str( pks(pind,6))])
        display(['rg: ' num2str( pks(pind,7))])
        display(['E: ' num2str( pks(pind,6))])
    end
end

function part =  proc_point(pt,pks)
    wind = 10;
    indx = ((pt(1)-wind) < pks(:,3) )& ((pt(1)+wind) > pks(:,3)) & ...
           ((pt(2)-wind)<pks(:,2)) &     ((pt(2)+wind)>pks(:,2)) ;
    close_pts = pks(indx,[3 2]);% - pks(indx,[5 4]);
    size(close_pts)
    min = wind^2
    part = [];
    for j = 1:size(close_pts,1)
        t_min = sum((close_pts(j,:) - pt).^2);
        if(t_min<min)
            min = t_min;
            part = close_pts(j,:);
        end
    end
    
end




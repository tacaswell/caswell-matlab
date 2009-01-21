function [histval hist_bin] = t_procslide(fname,format, fhandle)

if nargin<3
    fhandle = figure;
end


interactive = 1;
cen_x = 4600;
cen_y = 3300;
cs_sz = 3300;

if interactive ==1
   f = figure; 
   hold on
end

data = imread(fname);
if interactive ==1
   h = imagesc(data);
   taxes = get(h,'parent');
   fprintf('put mouse over center of slide and hit any key\n')
   impixelinfo
   pause
   cen = get(taxes,'currentpoint');
   cen_x = cen(1,1)
   cen_y = cen(1,2)
   
   fprintf('put mouse at edge of analysis region slide and hit any key\n')
   pause
   edge = get(taxes,'currentpoint');
   edge_x = edge(1,1)
   edge_y = edge(1,2)



   cs_sz = sqrt(sum(([cen_x,cen_y]-[edge_x, edge_y]).^2))
   
   scatter(cen_x,cen_y,'rx')
    circle([cen_x,cen_y],cs_sz,512,'g --');
   axis equal        
   pause;
end

data = cast(data,'double');
data_t = trim_data(data,cen_x,cen_y,cs_sz);
if interactive ==1
    set(h,'cdata',data_t)
    pause
end
data_b = bpass(data_t,1,10);
if interactive ==1
    set(h,'cdata',data_b)
    pause
end

pks = pkfnd(data_b,1500,8);
pksc = cntrd(data_b,pks,9);
if interactive ==1
    scatter(pksc(:,1),pksc(:,2),'mx')
    pause
end

[a b c] = t_density(pksc(:,[1 2]), 150);
pksc_shiftcom = pksc(:,[1 2])-repmat(b,size(pksc,1),1);
[histval hist_bin] = t_gofr(pksc_shiftcom,150,3000);
n = histval/sum(histval);

figure(fhandle)

plot(hist_bin(1:(end-1)),n,format)

end
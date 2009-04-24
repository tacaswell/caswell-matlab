function out = dummy_fun(fname)
   
    
    output = open(fname);
    tmp = output.all_pks_trim(:,[2 3 end]);

    tmp(:,3) = tmp(:,3) -1;
    clear output
    
    tmp = tmp(tmp(:,3)<100,:);
    
% $$$     
% $$$     out.edge_hist = zeros(1,21)';
% $$$     out.area_hist = zeros(1,151)';
% $$$     for j = 0:(max(tmp(:,3)))
% $$$         [a b] = voronoin(unique(tmp(tmp(:,end)==j,[1 2]),'rows'));
% $$$         out.area_hist = out.area_hist +...
% $$$             histc(cellfun(@(x) polyarea(a(x,1),a(x,2)),b),0:1:150);
% $$$         
% $$$         out.edge_hist =out.edge_hist...
% $$$             + histc(cellfun(@(x) size(x,2),b),0:1:20);
% $$$     end
% $$$        
% $$$     out.edge_hist =out.edge_hist/size(tmp,1);
% $$$     out.area_hist =out.area_hist/size(tmp,1);
    
% $$$     [out.Drr_a  out.Drr_b...
% $$$      out.Drr2_a out.Drr2_b...
% $$$      out.Dxx_a  out.Dxx_b...
% $$$      out.Dtt_a  out.Dtt_b...
% $$$      out.Dyy_a  out.Dyy_b...
% $$$     ] = test(tmp);toc;
    [out.msd  out.msd_count...
    ] = test(tmp);toc;
    clear test;
    clear tmp;
    
end
function t_look_at_paths(in,l)
    figure
    hold on
    c = jet(256);
    
    for j = 1:max(in(:,4))
      tmp = in(in(:,4)==j,:);
      if size(tmp,1)<(l+5) & size(tmp,1)>(l-5)
         plot(tmp(:,1),tmp(:,2),'color',c(mod(j,256)+1,:))
      end
    end
      
    
end
    
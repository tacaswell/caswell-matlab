function out = ning_project(raw,planes)
    epsilon = .001;
    


    out = raw(:,(1:(end-1)));
    out(:,end) = raw(:,end)*planes +...
        floor(planes*raw(:,(end-1))/max(epsilon +raw(:,(end-1))));
    
    [junk indx] = sort(out(:,end));
    out = out(indx,:);
end
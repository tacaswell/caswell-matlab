function out = t_normalize_tracks(in)
  
    old = in(in(:,3)==1,:);
    old2(old(:,4),:) = old(:,[1 2 4]);
    disps = zeros(max(in(:,3))-1,3);
    for j = 2:(max(in(:,3)))
        %loop over frames
        tmp = in(in(:,3)==j,:);
        tmp2(tmp(:,4),:)= tmp(:,[1 2 4]);
        
        if(size(old2,1)>size(tmp2,1))
            tmp2(size(old2,1),:) = [0 0 0];
        else if(size(old2,1)<size(tmp2,1))
            old2(size(tmp2,1),:) = [0 0 0];
        end
        
        t_diff = old2-tmp2;
        
        t_diff = t_diff(old2(:,1)~=0 & tmp2(:,1)~=0,:);
        disps(j-1,:) = mean(t_diff);
        
        old2 = tmp2;
        
    end
    
    out = disps;
    
end
    
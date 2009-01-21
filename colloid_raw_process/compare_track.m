function out = compare_track(track1, track2)
%o function comapre_track(track1, track2)
%o summary: comapres the track identification in the case where
% the ids assigned to the tracks are different.  Not very clever at the moment
%o outputs:
%-NONE
%o inputs:
%-track1: the first set of tracks to look at
%-track2: the second set of tracks to look at
    
    t1_edge = [0, find(diff(track1(:,end)))', size(track1,1)];
    t2_edge = [0, find(diff(track2(:,end)))', size(track2,1)];
    t2_front = 1+t2_edge(1:(end-1));
    t2_back = t2_edge(2:(end));

    dif = 0;
    count = 1;
    outs = -ones(max(track1(:,end)),1q);
    for j = 1:max(track1(:,end))
        tmp = track1(1+t1_edge(j),1:3);
        if(mod(j,50)==0)
            j
        end
        for k = 1:length(t2_front)

            if (tmp ==track2(t2_front(k),1:3))
                out(j) = t1_edge(j+1) - t1_edge(j)- ...
                         ( t2_back(k) - t2_front(k)+1);
                %dif=dif +sum(sum(track1((1+t1_edge(j)):(t1_edge(j+1)),1:3)- ...
                %                   track2((1+t2_edge(k)):(t2_edge(k+1)),1:3)));
                count = count+1;
                t2_front = t2_front([1:(k-1) k+1:end]);
                t2_back = t2_back([1:(k-1) k+1:end]);
                
                break;
            end
        end
        
    end
    
    dif
    
end
    
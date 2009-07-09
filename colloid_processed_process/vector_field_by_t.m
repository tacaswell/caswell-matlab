function vector_field_by_t(in,t)
% VECTOR_FIELD_BY_T - displays the displacement vector fields as a function of time
%   
    
    figure;

    t_len = cellfun(@(x) length(x),in.tracks_disp);
       
    
    tmp_indx2 = find(in.pos(:,3) <t & (in.pos(:,3) + t_len) >t);
    x = zeros(size(tmp_indx2));
    y = zeros(size(tmp_indx2));
    u = zeros(size(tmp_indx2));
    v = zeros(size(tmp_indx2));
    
    for j = 1:length(tmp_indx2); 
        x(j) = in.pos(tmp_indx2(j),2) + sum(in.tracks_disp{tmp_indx2(j)}(1:(t-in.pos(tmp_indx2(j),3)),2)); 
        y(j) = in.pos(tmp_indx2(j),1) + sum(in.tracks_disp{tmp_indx2(j)}(1:(t-in.pos(tmp_indx2(j),3)),1));
        u(j) = in.tracks_disp{tmp_indx2(j)}((t-in.pos(tmp_indx2(j),3))+1,2);
        v(j) = in.tracks_disp{tmp_indx2(j)}((t-in.pos(tmp_indx2(j),3))+1,1);


    end;
    a = dbstack
    quiver(x,y,u,v);
    axis image
end

function out = get_sub_region(data,x_range,y_range,p_range,pos_indx)
% GET_SUB_REGION - trims a data set to a sub region in planes and posistion
%   

    out = data;
    out = out(out(:,end)<=p_range(2),:);
    out = out(out(:,end)>=p_range(1),:);
    out(:,end) = out(:,end) - min(out(:,end));
    out = out(out(:,pos_indx(1))<=x_range(2),:);
    out = out(out(:,pos_indx(1))>=x_range(1),:);
    out(:,pos_indx(1)) = out(:,pos_indx(1)) - min(out(:,pos_indx(1)));
    out = out(out(:,pos_indx(2))<=y_range(2),:);
    out = out(out(:,pos_indx(2))>=y_range(1),:);
    out(:,pos_indx(2)) = out(:,pos_indx(2)) - min(out(:,pos_indx(2)));
end

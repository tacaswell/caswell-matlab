function out = t_bin(in)
    out = in(2:2:end,1:2:end)+in(1:2:end,1:2:end)+in(1:2:end,2:2:end)+ ...
         in(2:2:end,2:2:end);
%        out = in(2:2:end,1:2:end,:)+in(1:2:end,1:2:end,:)+in(1:2:end,2:2:end,:)+ ...
%         in(2:2:end,2:2:end,:);
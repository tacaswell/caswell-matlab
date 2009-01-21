function out = t_bin(in,size)
%%bins in 2^size by 2^size squares
%%size must be an integer, in must have even dimensions
    size = round(size);
    for k = 1:size 
        in = in(2:2:end,1:2:end)+in(1:2:end,1:2:end)+in(1:2:end,2:2:end)+ ...
             in(2:2:end,2:2:end);
    end
    out = in;
    
end    
    
%        out = in(2:2:end,1:2:end,:)+in(1:2:end,1:2:end,:)+in(1:2:end,2:2:end,:)+ ...
%         in(2:2:end,2:2:end,:);
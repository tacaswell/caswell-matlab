% Copyright 2009 Thomas A Caswell
% all rights reserved

function out = power_from_disp(in,filter)
    
% out = abs(fft(in.*(ones(size(in,1),1)*ones(1,size(in,2))))).^2/ ...
%         size(in,1);
    
    if nargin <2
        filter = @hann;
    end
    out = abs(fft(in.*(window(filter,size(in,1))*ones(1,size(in,2))))).^2/size(in,1);
    out = out(1:floor(size(in,1)/2),:);
    
end
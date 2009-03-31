% Copyright 2009 Thomas A Caswell
% all rights reserved

function out = power_from_disp(in)
    
    out = abs(fft(in.*(hamming(size(in,1))*ones(1,size(in,2))))).^2/size(in,1);
    out = out(1:floor(size(in,1)/2),:);
    
end
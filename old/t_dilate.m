function out = t_dilate(in,sz)
%%dilates image using a sz by sz sqaure
%%sz should be odd.  If it is eaven it will be rounded
%%up to the next odd number
    
    sz_in = size(in);
    h = sz_in(1);
    k =1;
    out = zeros(prod(sz_in),(2*sz+1)^2);
    sz = ceil((sz-1)/2);
    %set up matrix to use vectorization
    for ci=-sz:sz
        for ri = -sz:sz
            i = h*ci+ri;
            if i==0
                out(:,k) = in(1:end)';
            end
            if i<0
                out((1-i):end,k) = in(1:(end+i))';
            end
            
            if i>0
                out(1:(end-i),k) = in((1+i):end)';
            end
            k = k+1;
        end
    end
   %    dilate plus shift zero entries to one
    out = reshape(max(out,[],2),sz_in)+(in==0);

    
    
end    
    
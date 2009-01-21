function pk = pk_fd_t(in,ds)
%in = single image frame
%ds = dilation size
    size(in)
    ds
    in_d = dilate2(in,ds);
    pk = find(exp(in-in_d)==1);
end
    
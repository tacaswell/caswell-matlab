function img = extract_image(handle,ind)
%o function img = extract_image(handle,ind)
%o Summary: extracts a plane from a ND image. Assums the series is
%already set
%o input:
%-handle: file handle to data
%-ind: the index of the plane 
%o output:
%-img: 2D array of pixel values


% $$$     img = handle.openImage(ind);
    
    w = cast(handle.getSizeX,'double');
    h = cast(handle.getSizeY,'double');
    
    img =typecast(handle.openBytes(ind,0, 0, w, h),'uint16');
    img = cast(img,'double');
    

    
    img = reshape(img,[w,h])';
    
end    
    
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
    
    
    handle.isRGB()
    bpp = handle.getBitsPerPixel()
    if bpp == 8
        img =typecast(handle.openBytes(ind,0, 0, w, h),'uint8');
    elseif bpp == 16
        img =typecast(handle.openBytes(ind,0, 0, w, h),'uint16');
    else
        die
    end
    size(img)
    img = cast(img,'double');
    
% $$$     size(img)
% $$$ 
% $$$     size(img,1)/3
% $$$     
    img = reshape(img,[w,h])';
    
end    
    

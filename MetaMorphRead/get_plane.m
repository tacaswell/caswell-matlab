function img = get_plane(handle,ind,ser)
%o function img = get_plane(handle,ind,ser)
%o Summary: extracts a plane from a ND image.  If a series
%is provided then then the plane is extracted from that
%series, if it is not provided the plane is extracted from the
%last set series.
%o input:
%-handle: file handle to data
%-ind: the index of the plane 
%-[opt]ser: series to extracts the image from.  If not prodvided
%last set plane is used.
%o output:
%-img: 2D array of pixel values
    
    if nargin>2
        handle.setSeries(ser);
    end

    img = handle.openImage(ind);
    w = handle.getSizeX;
    h = handle.getSizeY;
    
    img = img.getData.getPixels(0, 0, w, h, []);
    img = reshape(img,[w,h])';
    
end    
     
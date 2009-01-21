function img = extract_image_gen(handle,ind,h,w, x,y)
%o function img = extract_image(handle,ind)
%o Summary: extracts a region of a  plane from a ND image. Assums the series is
%already set.  needs some sanity checking code added
%o input:
%-handle: file handle to data
%-ind: the index of the plane 
%-[opt]h: height of region to extract
%-[opt]w: width of region to extract
%-[opt]x: top left cord x value of region to extract
%-[opt]y: top left cord y value of region to extract
%o output:
%-img: 2D array of pixel values

    if nargin<4
        w = handle.getSizeX;
        h = handle.getSizeY;
    end

    if nargin<6
       x=0;
       y=0;
        
    end
    img = handle.openImage(ind);
    
    %%build in some sanity checks
    
    img = img.getData.getPixels(x, y, w, h, []);
    img = reshape(img,[w,h])';
    
end    
    
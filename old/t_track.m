function [tracks all_pks]= t_track(handle, threshold, d_sz,p_sz,max_sz,b_sz)
%%takes in a file handle and generates the track data
%%mid level wrapper
    
    handle.setSeries(0);
    w = handle.getSizeX();
    h = handle.getSizeY(); 
    numImages = handle.getImageCount();
    all_pks = [];
    for j = 1:numImages
        img = extract_image(handle,j-1,h,w);
        img = t_bin(img,b_sz);
        img = b_pass(img,p_sz);
        img = img.*(img>threshold);
        pks = find_parts(img,d_sz,max_sz);
        all_pks = [all_pks; [pks,j*ones(size(pks,1),1)]];
        %        clear img
    end
    clear img
    tracks = track(all_pks(:,[1 2 6]),p_sz/2);
    
end
    
function link_ver(r,data,plane,data2D)
% LINK_VER - plots a slice of the linked data on to a confocal slice
%   
     
%%set up file handle
% $$$     r = loci.formats.ChannelFiller();
% $$$    
% $$$     %%uncomment to stich files
% $$$ % $$$     r = loci.formats.FileStitcher(r);
% $$$ 
% $$$     r.setId(filename);
% $$$ 
% $$$     r.setSeries(series_index);
% $$$     
% $$$     
        
    data2D = data2D(data2D(:,end)==plane,[2 3]);
    
    %    buffer_pk = cell(1,numImages);    

    img = extract_image(r,plane);
    
    plane_step = .2;
    plane_z = plane * plane_step;
    
    slice_thickness = 2;
    
    indxa = data(:,3)>(plane_z-slice_thickness/2)& data(:,3)<(plane_z) ;
    indxb = data(:,3)<(plane_z+slice_thickness/2) & data(:,3)>(plane_z) ; ;

    
    figure
    imagesc(img);
    colormap(gray)
    axis image;
    hold on;
    plot(data2D(:,1) + 1,519 - data2D(:,2) + 1,'go')
    plot(data(indxb,1)/.107576 +1, 519-data(indxb,2)/.107576 +1,'rx')
    plot(data(indxa,1)/.107576 +1, 519-data(indxa,2)/.107576 +1,'bx')

    
end

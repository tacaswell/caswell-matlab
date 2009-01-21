function times = get_times(fh)
%o function times = get_times(fh)
%o summary: returns the time stamps from a metamorph multiplane image
%and assumes that the time stamp is in the form of YYYY-MM-DDTHH:MM:SS.SSS
%o input:
%-fh: handle to file to extract time stamps from
%o output:
%-times: a Nx7 matrix, where N is the number of images
    numim = fh.getImageCount();
    times = zeros(numim,7);
    for j = 1:numim
        
        times(j,:) = sscanf(fh.getMetadataValue(sprintf('timestamp %d',j-1)),'%d-%d-%dT%d:%d:%d.%d')';


    end
end
    
    
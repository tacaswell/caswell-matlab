function handle = tfread(fname)
%o function handle = tfread(fname)
%o summary: sets up file handlers to read the file
%should work on *.tif and *.stk
%o input:
%-fname:path of file to open
%o output:
%-handle:file handle for opened file
    
    handle = loci.formats.ChannelFiller();
    handle = loci.formats.ChannelSeparator(handle);
    handle.setId(fname);
    
end    
    
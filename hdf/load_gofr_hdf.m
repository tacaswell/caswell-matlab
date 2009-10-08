function gofr = load_gofr_hdf(fname)
% LOAD_GOFR_HDF - reads in gofr data from an hdf file
%   
    
    hinfo = hdf5info(fname);
    
    gofr = arrayfun(@helper_1,hinfo.GroupHierarchy.Groups);
end


function out =helper_1(in)
   
    out.name = in.Name;
    out.bin_edges = hdf5read(in.Filename,[in.Name '/bin_edges']);
    out.bin_count = hdf5read(in.Filename,[in.Name '/bin_count']);
    
end
    
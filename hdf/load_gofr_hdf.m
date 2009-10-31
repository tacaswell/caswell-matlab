function gofr = load_gofr_hdf(fname)
% LOAD_GOFR_HDF - reads in gofr data from an hdf file
%   
    
    hinfo = hdf5info(fname);
    
    gofr = arrayfun(@helper_1,hinfo.GroupHierarchy.Groups);
end


function out =helper_1(in)
   
    out.name = in.Name;
    [junk out.tmp] = parse_temperature(out.name);
    out.edges = hdf5read(in.Filename,[in.Name '/bin_edges']);
    

   
    out.gofr = hdf5read(in.Filename,[in.Name '/bin_count']);
    %delete this after this round of data
    if out.gofr(end)<0
        out.gofr = out.gofr/out.gofr(end);
    end
end
    
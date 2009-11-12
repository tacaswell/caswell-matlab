function out = load_tracks_hdf(hinfo,track_num)
% LOAD_GOFR_HDF - reads in gofr data from an hdf file
%   
    
    tic;

    in = hinfo.GroupHierarchy.Groups(track_num)
    toc;
    out.name = in.Name;


    tic;
    out.data = zeros(in.Datasets(1).Dims,4);
    
    out.data(:,1)=hdf5read(in.Filename,[in.Name '/x']);
    out.data(:,2)=hdf5read(in.Filename,[in.Name '/y']);
    out.data(:,3)=hdf5read(in.Filename,[in.Name '/z']);
    out.data(:,4)=hdf5read(in.Filename,[in.Name '/intensity']);
    
% $$$     g = arrayfun(@helper_1,hinfo.GroupHierarchy.Groups);
toc;
 
end


function out =helper_1(in)
   
    out.name = in.Name;


    
    out.data = zeros(in.Datasets(1).Dims,4);
    
    out.data(:,1)=hdf5read(in.Filename,[in.Name '/x']);
    out.data(:,2)=hdf5read(in.Filename,[in.Name '/y']);
    out.data(:,3)=hdf5read(in.Filename,[in.Name '/z']);
    out.data(:,4)=hdf5read(in.Filename,[in.Name '/intensity']);
    
   

end

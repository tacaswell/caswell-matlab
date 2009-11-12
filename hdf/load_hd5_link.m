function data = load_hd5_link(fname)
% LOAD_HDF - loads an hdf file into the form expected by all of the current matlab code
%   
    hinfo = hdf5info(fname);
    data = zeros(1e6,10);
    count = 0;
    for j = 1:length(hinfo.GroupHierarchy.Groups)
        tmp_group = hinfo.GroupHierarchy.Groups(j);
        part_count =tmp_group.Datasets(1).Dims ;
        tmp = zeros(part_count,10);
        
        
        tmp(:,1)=hdf5read(tmp_group.Filename,[tmp_group.Name '/x'])*.107576;
        tmp(:,2)=hdf5read(tmp_group.Filename,[tmp_group.Name '/y'])*.107576;
        tmp(:,3)=hdf5read(tmp_group.Filename,[tmp_group.Name '/z']);
        tmp(:,4)=hdf5read(tmp_group.Filename,[tmp_group.Name '/intensity']);
        
        
        if(count + part_count > size(data,1))
            data = make_bigger(data);
        end
        data((count+1):(count+part_count),:) = tmp;
        count = count + part_count;

    end
    
    data = data(1:count,:);
end

function out = make_bigger(in)
% MAKE_BIGGER - increments the size of in
%   
    inc = 1e6;
  
    out = zeros(size(in) + [inc 0]);
    out(1:size(in,1),:) = in;
end

function num = parse_frame_name(in_str)
% PARSE_FRAME_NAME - strips the frame name and retruns the index
%   
    
    num = str2double(in_str(7:end));
end

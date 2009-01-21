function metaD = getall_meta(handle,show)
%o function metaD = getall_meta(handle,show)
%o summary: extracts all of the avaible metadata and returns as cell
%    array of key:value pairs
%o input:
%-handle: handle to data file
%-[opt]show: if 1, then print out metadata, default:0
%o output: 
%-metaD = nx2 cell array with each row of the form {{key} {value}}
    if nargin<2
        show = 0;
    end
    
    metadata = handle.getMetadata();
    metaD = cell(metadata.size(),2);
    metaD(:,2) = enum2cell(metadata.elements()); 
    metaD(:,1) = enum2cell(metadata.keys()); 
    
    if show==1
        print_meta(metaD);
    end
end
 
 
function elist = enum2cell(enum_t)
    i=1;
    while(enum_t.hasMoreElements());elist{i} = ...
      enum_t.nextElement();i=i+1;
    end;
end

function metad = get_meta(handle,key)
%o function metad = get_meta(handle,key)
%o Summary: returns a string which contains the specified value.  If the
%key does not exist returns empty array
%o input:
%-handle: handle to data file
%-key: key of metadata to be extracted as a string
%o output: 
%-metad = string of the value for the given key, returns an
%empty array if the key does not exist

metad = handle.getMetadataValue(key);
    
end
    
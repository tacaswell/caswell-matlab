% in is a cell array which is of structs gofr and edges that are the values
% of the bins in g(r) and the bottom edges of the bins

% out is a cell array with vectors of the values of the extreama

function out = gofr_find_peaks(in)
    
    max_r = cellfun(@(x) x.edges(find(x.gofr==max(x.gofr))),in, ...
                    'uniformoutput',false );
    
    

    tmp = cellfun(@(x) find(diff(sign(diff(x.gofr)))~=0),in,...
                  'uniformoutput',false);
    tmp{1}
    % filters out junk
    tmp = cellfun(@(x) x(find(diff(x)>1)),tmp,'uniformoutput',false );
    tmp{1}
    
    out = cellfun(@(x,y,z) x.edges(y +1)/z,in,...
                  tmp,max_r,'uniformoutput',false);
    
    out = cellfun(@(x) x(x>=1),out,'uniformoutput',false );
    
    

end
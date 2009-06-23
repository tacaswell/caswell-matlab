function leg = struct_fname_to_legend(in)

        
    leg = arrayfun(@(x) cell2mat(regexpi(x.fname,['[0-' ...
                        '9]{2}-[0-9]'],'match')),in, ...
                   'uniformoutput',false);
    
    leg = cellfun(@(x) [x(1:2) '.' x(4)],leg,'uniformoutput', ...
                   false);

    
end
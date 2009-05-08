function uniform_test(in)
    
    figure;
    hold all;
    set(gca,'colororder',jet(length(in.uniform_test)))
    
    for j = 1:length(in.uniform_test)
        stairs(in.uniform_test(j).edges,in.uniform_test(j).gofr)
    end
    stairs(in.edges,in.gofr,'k')
   
     grid on;
    h = title(parse_tmp(in.stack_name));
    set(h,'interpreter','none')
   
    
end


function out_str = parse_tmp(in_str)

    out_str = in_str((find(in_str=='/',1,'last')+1):...
                     (end-4));
    
end


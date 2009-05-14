function uniform_test(in)
    
    save_ = 0;
    f = figure;
    hold all;
    set(gca,'colororder',jet(length(in.uniform_test)))
    
    for j = 1:length(in.uniform_test)
        stairs(in.uniform_test(j).edges,in.uniform_test(j).gofr)
    end
    stairs(in.edges,in.gofr,'k')
   
    grid on;
    t_date = cell2mat(regexpi(in.stack_name,'[0-9]{8}','match'));
    t_tmp = cell2mat(regexpi(in.stack_name,'[0-9]{2}-[0-9]','match'));
    h = title(strcat('Date: ', t_date(5:6),'-',t_date(7:8) ,' tmp: ' ,t_tmp));
% $$$     set(h,'interpreter','none')
    
    if(save_)
        save_figure(strcat('uniform_test_',t_date,'_',t_tmp),[5 5],f);
    end
        
       
    
end


function out_str = parse_tmp(in_str)

    out_str = in_str((find(in_str=='/',1,'last')+1):...
                     (end-4));
    
end


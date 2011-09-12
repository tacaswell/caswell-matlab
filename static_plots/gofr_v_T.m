function gofr_v_T(in)
    save_ = false;
    f = figure; 
    hold all; 
    set(gca, 'colororder',jet(length(in)));
    
    for j = 1:length(in); 
        j
        stairs(in(j).edges*(6.45/60),in(j).gofr);
    end;
    
    leg = arrayfun(@(x) cell2mat(regexpi(x.stack_name,['[0-' ...
                        '9]{2}-[0-9]'],'match')),in, ...
                   'uniformoutput',false);
    
    leg = cellfun(@(x) [x(1:2) '.' x(4)],leg,'uniformoutput', ...
                   false);

% $$$     leg = cellfun(@(x) strcat(x(1:2),'.',x(4)),leg, 'uniformoutput',false);
    legend(leg)
    
    t_date = cell2mat(regexpi(in(1).stack_name,'[0-9]{8}', ...
                              'match'));
% $$$     h = title(strcat('\tilde{g}(r) Date: ', t_date(5:6),'-', ...
% $$$                      t_date(7:8)));
% $$$     h = title('g(r)');
    xlabel('r [\mum]');
    ylabel('g(r)');
    axis([0 9 0 3])
    grid on;
    
    
    if(save_)
        save_figure(strcat('gofr_',t_date),[5 5],f);
    end
    
    
end

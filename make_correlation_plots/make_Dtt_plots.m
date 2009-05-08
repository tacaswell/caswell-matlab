function make_Ddudu_plots(in,type)
    
    arrayfun(@helper, in)

    
end

function helper(in)
    figure; 
    hold all;
    set(gca,'colorOrder',jet(size(in.Ddudu,2)));
    leg = arrayfun(@(x) num2str(x),1:size(in.Ddudu,2),'uniformoutput', ...
                   false);
    
    
    for k = 1:size(in.Dtt,2); 
        stairs(linspace(5,100,2500),...
               in.Dtt(:,k)./in.Dtt_c(:,k));
    end;
    % note normalization
    

    grid on;
    h = title(['Dtt ' parse_tmp(in.stack_name)]);
    set(h,'interpreter','none')
     
        
end

function out_str = parse_tmp(in_str)

    out_str = in_str((find(in_str=='/',1,'last')+1):...
                     (end-4));
    
end
function make_Ddudu_plots(in,type)
    
    arrayfun(@helper, in)

    
end

function helper(in)
    
    figure; 
    hold all;
    set(gca,'colorOrder',jet(size(in.Ddudu,2)));
    
    for k = 1:size(in.Ddrdr,2); 
        stairs(linspace(5,100,2500),...
               in.Ddrdr(:,k)./in.Ddrdr_c(:,k)/...
               (in.md(k)/in.md_count(k))^2);
    end;
    
    for k = 1:size(in.Ddrdr,2); 
        stairs(linspace(5,100,2500),...
               in.Ddrdr(:,k)./in.Ddrdr_c(:,k),'--');
    end;
    

    grid on;

    h = title(['Ddrdr ' parse_tmp(in.stack_name)]);
    set(h,'interpreter','none')
    
end

function out_str = parse_tmp(in_str)

    out_str = in_str((find(in_str=='/',1,'last')+1):...
                     (end-4));
    
end
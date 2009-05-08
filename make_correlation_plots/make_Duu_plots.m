function make_Duu_plots(in,type)
    
    arrayfun(@helper, in)

    
end

function helper(in)
    figure; 
    hold all;
    set(gca,'colorOrder',jet(size(in.Ddudu,2)));
    leg = arrayfun(@(x) num2str(x),1:size(in.Ddudu,2),'uniformoutput', ...
                   false);

    bin_down = 1;
% $$$     in = bin_down_corrs(in,'Duu',bin_down);
    
    for k = 1:size(in.Duu,2); 
        stairs(linspace(5,100,2500/bin_down),...
               (in.Duu(:,k)./in.Duu_c(:,k))/...
               (in.msd(k)/in.msd_count(k)));
    end;

    % note normalization
    
    axis([0 100 -.1 5.2])
    grid on;

    h = title([parse_tmp(in.stack_name) ' D_{uu}']);
   

        figure; 
    hold all;
    set(gca,'colorOrder',jet(size(in.Ddudu,2)));
    leg = arrayfun(@(x) num2str(x),1:size(in.Ddudu,2),'uniformoutput', ...
                   false);

    bin_down = 1;
% $$$     in = bin_down_corrs(in,'Duu',bin_down);
    
    for k = 1:size(in.Duu,2); 
        stairs(linspace(5,100,2500/bin_down),...
               (in.DuuT(:,k)./in.DuuT_c(:,k))/...
               (in.msd(k)/in.msd_count(k)));
    end;

    % note normalization
    
    axis([0 100 -.1 5.2])
    grid on;
    h = title([parse_tmp(in.stack_name) ' DuuT']);
   

        figure; 
    hold all;
    set(gca,'colorOrder',jet(size(in.Ddudu,2)));
    leg = arrayfun(@(x) num2str(x),1:size(in.Ddudu,2),'uniformoutput', ...
                   false);

    bin_down = 1;
% $$$     in = bin_down_corrs(in,'Duu',bin_down);
    
    for k = 1:size(in.Duu,2); 
        stairs(linspace(5,100,2500/bin_down),...
               (in.DuuL(:,k)./in.DuuL_c(:,k))/...
               (in.msd(k)/in.msd_count(k)));
    end;

    % note normalization
    
    axis([0 100 -.1 5.2])
    grid on;
    h = title([parse_tmp(in.stack_name) ' DuuL']);
   

end

function out_str = parse_tmp(in_str)

    out_str = in_str((find(in_str=='/',1,'last')+1):...
                     (end-4));
    
end
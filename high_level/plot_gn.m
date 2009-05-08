function plot_gn(in,f,style_)
   
    function out = helper(arr_)
        if(length(arr_) >j)
            out =arr_(j);
        else
            out =NaN;
        end
    end
    
    temps = arrayfun(@(x) parse_tmp(x.stack_name),in);
    
    if(exist('f','var') ==0)
        f = figure;
        hold all;
    else
        figure(f);
        hold all;
    end

    set(gca,'colororder',lines(6))
    if(exist('style_','var') ==0)
        style_ = 'x--';
    end
    
    
    for j = 1:6
        tmp = arrayfun(@(x) helper(x.g),in);
        plot(temps,tmp,style_)
    end
            
            
    leg = arrayfun(@(x) ['g_' num2str(x)],1:6,'uniformoutput', ...
                   false);
    
    legend(leg);
    
    ind = find(in(1).stack_name=='/',3,'last');
    title(in(1).stack_name((ind(1)+1):(ind(2)-1)))
    xlabel('Temerature [ ^0C]')
    ylabel('G(r) peak height')
end


function out = parse_tmp(in_str)

    out_str = in_str((find(in_str=='/',1,'last')+6):...
                     (end-6));

    out_str = in_str((find(in_str=='/',1,'last')+1):...
                     (end-4));

    out = str2double(    [out_str(1:2) '.' out_str(4)]);
end

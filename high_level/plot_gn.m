function plot_gn(in,f,style_,save_)
    
    if nargin<4
        save_ = false;
    end
    
    function out = helper(arr_)
        if(length(arr_) >=j)
            out =arr_(j);
        else
            out =NaN;
        end
    end

    
    temps = arrayfun(@(x) cell2mat(regexpi(x.stack_fname,['[0-9]{2}-' ...
                        '[0-9]'],'match')),in,'uniformoutput', ...
                   false);
    temps = cellfun(@(x) str2double([x(1:2) '.' x(4)]),temps)
    
    

    
    if(exist('f','var') ==0)
        f = figure;
        hold all;
    else
        figure(f);
        hold all;

    end
    grid on
    set(gca,'colororder',lines(6))
    if(exist('style_','var') ==0)
        style_ = 'x--';
    end
    
    
    for j = 1:6
        
        tmp = arrayfun(@(x) helper(x.extrema.g),in);
        plot(temps,tmp,style_)
    end
            
            
    leg = arrayfun(@(x) ['g_' num2str(x)],1:6,'uniformoutput', ...
                   false);
    
    legend(leg);
    
    set(gca,'ylim',[1 3]);
    xlabel('Temerature [^\circC]')
    ylabel('g(r) peak height')
    
    t_date = cell2mat(regexpi(in(1).stack_fname,'[0-9]{8}', ...
                              'match'));


    if(save_)
        save_figure(strcat('gn_',t_date),[5 5],f);
    end

end

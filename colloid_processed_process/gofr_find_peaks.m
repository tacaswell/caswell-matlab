% in is a cell array which is of structs gofr and edges that are the values
% of the bins in g(r) and the bottom edges of the bins

% out is a cell array with vectors of the values of the extreama

function out = gofr_find_peaks(gofr_data, range)
% $$$     
% $$$     max_r = cellfun(@(x) x.edges(find(x.gofr==max(x.gofr))),in, ...
% $$$                     'uniformoutput',false );
% $$$     
% $$$     
% $$$ 
% $$$     tmp = cellfun(@(x) find(diff(sign(diff(x.gofr)))~=0),in,...
% $$$                   'uniformoutput',false);
% $$$     tmp{1}
% $$$     % filters out junk
% $$$     tmp = cellfun(@(x) x(find(diff(x)>1)),tmp,'uniformoutput',false );
% $$$     tmp{1}
% $$$     
% $$$     out = cellfun(@(x,y,z) x.edges(y +1)/z,in,...
% $$$                   tmp,max_r,'uniformoutput',false);
% $$$     
% $$$     out = cellfun(@(x) x(x>=1),out,'uniformoutput',false );
% $$$     
% $$$
    
    range = ones(size(gofr_data))*range;
    out = arrayfun(@(x,y) locate_peak(x.gofr,x.edges,y),gofr_data,range);
    

end

function [out]= locate_peak(gofr,edges,range)
    debug = false;
    cutoff = 0;
    scale = 2;
    if(debug)
    f = figure;
    end

    cur_index = 1;
    g_asmy = 1;
    
    out.peaks = [];
    out.troughs = [];
    out.peaks_indx = [];
    out.troughs_indx = [];
    more_peaks = true;
    
    [f_m working_index] = max(gofr);
    working_index_n = floor(working_index/2);
    while(more_peaks)

        working_ar = gofr((working_index - range):(working_index + ...
                                                   range));
        
        params = lscov([(0:(2*range))'.^2 (0:(2*range))' ones(2*range ...
                                                          +1,1)], working_ar');
        
        a = params(1);
        c = -params(2)/(2*a);
        b = params(3) - a*c*c;
        if(debug)
            figure(f)
            cla
            stairs(0:(2*range),working_ar);
            hold on;
            plot(0:(2*range),b + a*((0:(2*range))-c).^2);
            plot([ c c],[1-.01 1.01],'r');
            pause;
            a
            b
            c
        
        end
        
        
        if(c<0)
            more_peaks = false;
            break;
        end
        if((b-1)<cutoff)
            disp('b less than cut off')
            more_peaks = false;
            break;
        end
        c = c + working_index-range;
        if(c>length(edges))
            disp('c out of range')
            more_peaks = false;
            break;
        end
        
        

        out.peaks_indx = [out.peaks_indx floor(c)];
        
        
        out.peaks = [out.peaks (edges(floor(c))...
                        +mod(c,1)*(diff(edges(floor(c):ceil(c)))))];

           
        window_max = min([length(gofr) working_index+floor(scale* ...
                                                          working_index_n)]);
        [f_m working_index_n] = min(gofr((working_index):(window_max)));
% $$$         if(working_index_n > 5*range)
% $$$             disp('steped too far')
% $$$             more_peaks = false;
% $$$             break;
% $$$         end
        working_index = working_index + working_index_n;
        
        
        
        if(isempty(f_m) || (working_index+range) > length(gofr))
            disp('steped too far or no max')
            more_peaks = false;
            break;
        end
        
        working_ar = gofr((working_index - range):(working_index + ...
                                                   range));
        
        params = lscov([(0:(2*range))'.^2 (0:(2*range))' ones(2*range ...
                                                          +1,1)], working_ar');
        
        a = params(1);
        c = -params(2)/(2*a);
        b = params(3) - a*c*c;
        if(debug)
            figure(f)
            cla
            stairs(0:(2*range),working_ar);
            hold on;
            plot(0:(2*range),b + a*((0:(2*range))-c).^2);
            plot([ c c],[1-.01 1.01],'m');
            pause;
            a
            b
            c
        
        end        
        if((1-b)<cutoff)
            disp('b less than cut off trough')
            more_peaks = false;
            break;
        end
        c = c + working_index-range;
       

        out.troughs_indx = [out.troughs_indx floor(c)];
        out.troughs = [out.troughs (edges(floor(c))...
                                    +mod(c,1)*(diff(edges(floor(c):ceil(c)))))];

        
        

        window_max = min([length(gofr) working_index+floor(scale* ...
                                                          working_index_n)]);
        [f_m working_index_n] = max(gofr((working_index):(window_max)));
% $$$         if(working_index_n > 5*range)
% $$$             disp('steped too far')
% $$$             working_index_n
% $$$             more_peaks = false
% $$$             break;
% $$$         end
        working_index = working_index + working_index_n;

      
        
        if(isempty(f_m) || (working_index+range) > length(gofr))
            disp('steped too far or out of range')
            working_index
            more_peaks = false
        end
    end
    
end
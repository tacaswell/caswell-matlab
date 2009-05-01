function plot_peak_locations(in,symbols,f,cols)
    
    if(nargin<4)
            cols = lines(length(in));
            if(nargin<3)
                figure;hold on;
                if(nargin<2)
                    symbols = ['x','o'];
                end
            else
                figure(f);
                hold on;
            end
            
    end
    

    
    for j = 1:length(in)
        
        plot(0:(length(in(j).peaks)-1),in(j).peaks/ ...
             in(j).peaks(1)-1,symbols(1),'color',cols(j,:));
        plot((0:(length(in(j).troughs)-1)) + .5, ...
             in(j).troughs/in(j).peaks(1)-1,symbols(2),'color',cols(j,:))
    end
    
end
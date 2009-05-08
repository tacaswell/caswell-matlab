function plot_peak_locations(in,symbols,f)
    
    if(nargin<3)

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
    

    

       
        plot(0:(length(in.peaks)-1),in.peaks/ ...
             in.peaks(1)-1,symbols(1));
        plot((0:(length(in.troughs)-1)) + .5, ...
             in.troughs/in.peaks(1)-1,symbols(2))

    
end
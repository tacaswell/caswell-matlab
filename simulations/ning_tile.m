function out = ning_tile()
    
    raw = load('new_ning.txt');
    out = [];
    tile_range = 1;

        
    for j = 0:(2*tile_range)
           
        for k = 0:(2*tile_range)
            
            for m = 0:(2*tile_range)
         
       
                tmp = raw;
                tmp(:,1) = tmp(:,1) +j;
                tmp(:,2) = tmp(:,2) +k;
                tmp(:,3) = tmp(:,3) +m;
                out = [out;tmp];
                
                
            end
        end
    end
function out = dilate(in,box)
    sz_in = size(in);
    count = prod(sz_in);
    out = ones(sz_in);
    r_max = sz_in(1)-2*(box+1);
    c_max = sz_in(2)-2*(box+1);
    %    list = reshape(repmat((box+1):(sz_in(2)-box-1),r_max,1),[],1)*sz_in(1)...
    %       +repmat(((box+1):(sz_in(2)-box-1))',r_max,1);
    list = zeros(sz_in);
    list((box+1):(end-box-1),(box+1):(end-box-1)) = 1;
    list = find(list.*in);
    size(list)
    
    for i = 1:length(list)
        %        if in(i)
            row = mod(list(i)-1,sz_in(1))+1;
            col = floor((list(i)-1)/sz_in(1))+1;
                       
            out(list(i)) = max(max(in((row-box):(row+box),(col-box):(col+box))));
            %end

    end
    
 end
    
    
 
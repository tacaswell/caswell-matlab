function corrs_out = bin_down_corrs(corrs,field,n)
    
    corrs_out = corrs;
    eval(['tmp_data_c = corrs.' field '_c;'])
    eval(['tmp_data = corrs.' field ';'])
    size(tmp_data_c)
    if (mod(size(tmp_data,1),n)~= 0)
        error('can''t evenly bin')
        return;
    end
       
    new_data = zeros(size(tmp_data,1)/n,size(tmp_data,2));
    new_data_c = zeros(size(tmp_data,1)/n,size(tmp_data,2));
    
    for(j = 1:(n-1))
        new_data = new_data + tmp_data(j:n:end,:);
        new_data_c = new_data_c + tmp_data_c(j:n:end,:);
    end
    eval(['corrs_out.' field '= new_data;' ])
    eval(['corrs_out.' field '_c= new_data_c;'] )
    
end
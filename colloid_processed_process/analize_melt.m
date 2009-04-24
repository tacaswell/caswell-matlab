function out = analize_melt
    data_in = open(['/home/tcaswell/collids/processed_data/20090410/' ...
          'processed_melt_3.mat']);
    tmp = data_in.all_pks_trim(:,[2 3 end]);
    tmp(:,3) = tmp(:,3) -1;
    
    %frames per division
    f_p_d = 20;
    out = cell(floor(1200/f_p_d),1);
    
    for j = 1:length(out)
        j
        tmp_sm = tmp(tmp(:,3)<(j*f_p_d) & tmp(:,3)>=((j-1)*f_p_d) ,:);
        tmp_sm(:,3) =tmp_sm(:,3) -tmp_sm(1,3) ;
        [out{j}.gofr out{j}.edges] = basic_static(tmp_sm);
        clear basic_static;
    end
end


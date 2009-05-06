function out =  gofr_fun(fname)
   
    out = mex_gofr(fname);
    
    
    data_in = open(fname);
    tmp = data_in.all_pks_trim(:,[2 3 end]);
    clear data_in;
    tmp(:,3) = tmp(:,3) -1;
    
    %frames per division
    f_p_d = 20;
    
    divs = 10;
    
    frames = 1200;
    
    spacing = linspace(0,frames - f_p_d - 1,divs);
    
    out.uniform_test = struct('gofr',cell(1,divs),'edges',cell(1,divs));
    
    for j = 1:length(spacing)

        tmp_sm = tmp(tmp(:,3)<(spacing(j) + f_p_d) & tmp(:,3)>=(spacing(j)) ,:);
        tmp_sm(:,3) =tmp_sm(:,3) -tmp_sm(1,3) ;
        [out.uniform_test(j).gofr out.uniform_test(j).edges] =...
            basic_static(tmp_sm,520,1390,f_p_d,100,5000);
        clear basic_static;
    end
    
    clear tmp;
    clear tmp_sm;
    
end
function out = analize_melt
    fname = ['/home/tcaswell/collids/processed_data/20090410/' ...
          'processed_melt_3.mat'];
    
% $$$     fname = ['/home/tcaswell/collids/processed_data/20090502/' ...
% $$$              'processed_freeze_1.mat'];
    data_in = open(fname);
    
% $$$     data_in = open('/home/tcaswell/collids/processed_data/20090427/processed_20um_28-5_0.mat')

    tmp = data_in.all_pks_trim(:,[2 3 end]);
    tmp(:,3) = tmp(:,3) -1;
    
    %frames per division
    f_p_d = 20;
    frames = 1200;
    out = cell(floor(frames/f_p_d),1);
    
    for j = 1:length(out)
        j
        tmp_sm = tmp(tmp(:,3)<(j*f_p_d) & tmp(:,3)>=((j-1)*f_p_d) ,:);
        tmp_sm(:,3) =tmp_sm(:,3) -tmp_sm(1,3) ;
        [out{j}.gofr out{j}.edges] = basic_static(tmp_sm,520,1390,f_p_d, ...
                                                  100,5000);
        clear basic_static;
        out{j}.stack_name = data_in.fname;
    end
    
    out = cell2mat(out);
end


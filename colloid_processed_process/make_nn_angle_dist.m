function out = make_nn_angle_dist(fname)
    
    out.fname = fname;
    load(fname,'all_pks_trim');
    frames_cnt = max(all_pks_trim(:,end));
    all_pks_trim(:,end) = all_pks_trim(:,end) -1;
    all_pks_trim = all_pks_trim(:,[2 3 end]);
    %    against the june 23,2009 verision of test
    [pos_data nn_data] = test(all_pks_trim,520,1400,frames_cnt,12);
    
    clear test;
    out.adist = mean(...
        reshape(...
            cell2mat(...
                cellfun(@(x) histc(atan2(x(sum(x.^2,2)~=0, 1),x(sum(x.^2,2)~=0,2)),- pi:.01:pi), ...
                                              nn_data, ...
                                              'uniformoutput', ...
                                              false))...
            ,length(-pi: .01:pi)...
            ,[])...
        ,2);
    
end

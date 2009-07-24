% $$$ function out = make_nn_angle_dist(fname,pos_data,nn_data)
function out = make_nn_angle_dist(fname)
    
    out.fname = fname;
    load(fname,'all_pks_trim');
    frames_cnt = max(all_pks_trim(:,end));
    all_pks_trim(:,end) = all_pks_trim(:,end) -1;
    all_pks_trim = all_pks_trim(:,[2 3 end]);
    %    against the june 23,2009 verision of test
    [pos_data nn_data] = nn_vectors(all_pks_trim,520,1400,frames_cnt,12);
    
    out.fname = fname;
    clear nn_vectors;
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
    

        temperature = regexpi(fname,['[0-9]{2}-' ...
                        '[0-9]'],'match');
    temperature = temperature{1};
    temperature(3) = '.';
    
    f = figure ;
    stairs(out.adist);
    title(strcat('Temperature: ',temperature,'C'))
end


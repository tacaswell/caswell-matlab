function var_out= file_looper( fun)
%o function file_looper( fun)
%o summary: loops over systematically named files and genreates
% file name.  Hands the file names to the fuction fun which
% processes them
%o inputs:
%-fun: function handle to a function that takes a file name as it's only
% arguement and returns a single struct
%o outputs:
%-var_out: cell array of outputs
    
    
    prefix1 = {'d1' 'd2' 'rd' 'ld'};
    prefix2 = {'heating' 'cooling' 'rt'};
    base_path = '/home/tcaswell/collids/processed_data/20081021/';
%    
        
%    base_path = '/home/tcaswell/collids/processed_data/20080808/';
%    prefix1 = {'bot1' 'bot2' 'mid3'};
%    prefix2 = {'heating' 'cooling' 'rt'};
    
%    base_path = '/home/tcaswell/collids/processed_data/20080915/s4/';
%    prefix1 = {''};
%    prefix2 = {'heating' 'cooling' 'rt'};


    ext = 'mat';
    base_name = 'processed';
    delim = '_'
    
    range1 = [20 26 28 29];
    range2 = 1;
    range3 = 1;
    
    var_out = cell(1,length(range1)*length(range2)*length(range3));
    index = 1;
    for j = range1
        for k = range2
            for m = range3
                j
                k
                m
                if k==2&&m==6
                    continue
                end


                
                %                post_fix = sprintf('%s_%s_%d',prefix1{j},prefix2{k},m);
                %post_fix = sprintf('%s%s_%d',prefix1{j},prefix2{k},m);
                post_fix = int2str(j);
                %  
                %               if k==2&m==3
                %    post_fix = [post_fix(1:(end-1)) '2a'];
                %end
             %
                
             
                fname = [base_path base_name delim post_fix '.' ext]
                var_out{index} = fun(fname);
                var_out{index}.name = [base_name post_fix];
                index = index + 1;

            end
        end
    end
    

    var_out = var_out(~cellfun(@isempty,var_out));
   
    
end
    
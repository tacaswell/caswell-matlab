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
    
    

    base_path = '/home/tcaswell/collids/processed_data/20090422/';
    ext = 'mat';
    base_name = 'processed';
    delim = '_';
    fnames     = {'26-8','26-9', '27-7_2','28-7','29-6','30-6','32-0'};

    
    var_out = cell(1,length(fnames));
    index = 1;
    tic;
    for j = 1:length(fnames)

                

        fname = [base_path base_name delim fnames{j} '.' ext]
        
        var_out{j} = fun(fname);
        toc
        

        
    end
    

toc;
   
    
end
    
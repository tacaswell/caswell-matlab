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
    
    

%     base_path = '/home/tcaswell/collids/processed_data/20090427/';
    base_path = '/home/tcaswell/collids/processed_data/20090502/';
    ext = 'mat';
    base_name = 'processed';
    delim = '_';
%     fnames     = {'26-9', '27-7_2','28-7',...
% % $$$                   '29-6','30-6','32-0'...
%                  };

     fnames     ={
 % $$$     '20um_27-2_0',
 % $$$     '20um_28-1_0',
 % $$$     '20um_28-5_0',
 % $$$     '20um_28-9_0',
 % $$$     '20um_29-1_0',
 % $$$     '20um_29-6_0',
         '30um_27-2_0',
 % $$$     '30um_27-9-_0',
         '30um_28-1_0',
 % $$$     '30um_28-3-_0',
 % $$$     '30um_28-3-_1',
         '30um_28-5_0',
         '30um_28-9_0',
         '30um_29-2_0',
         '30um_29-7_0',
 % $$$     '40um_28-1_0',
 % $$$     '40um_28-5_0',
 % $$$     '40um_29-2_0'
                 }


    fnames = cellfun(@(x) [base_path base_name delim x '.' ext] ...
                     ,fnames,'uniformoutput',false)

    var_out = cellfun(fun,fnames)
% $$$     var_out = cell(1,length(fnames));
% $$$     index = 1;
% $$$     tic;
% $$$     for j = 1:length(fnames)
% $$$ 
% $$$                 
% $$$ 
% $$$         fname = 
% $$$         
% $$$         var_out{j} = fun(fname);
% $$$         toc
% $$$         
% $$$ 
% $$$         
% $$$     end
% $$$     


   
    
end

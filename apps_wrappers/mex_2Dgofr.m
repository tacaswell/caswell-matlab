function out = mex_2Dgofr(fname)
% MEX_NN_VECTOR - takes in a file name, opens it up, shoves it thorugh the mex nn code and returns everything in a struct for the file looper scheme
%   
    
       
% $$$     output = open(fname);
    input = trim_proc(fname);
    
    tmp = input.all_pks(:,[2 3 end]);
    tmp(:,3) = tmp(:,3) -1;
    if(isfield(input,'stack_fname'))
        out.stack_fname = input.stack_fname;
    else
        out.stack_fname = input.fname;
    end
    out.proc_fname = input.proc_fname;
    clear input

    frames = 100;
    offset = 200;
    tmp = tmp(tmp(:,3)<(frames+offset) & tmp(:,3)>=offset,:);
    tmp(:,3) = tmp(:,3) - offset;
    

    tic; [out.gofr oun.gofr_bins]    ...
            = basic_static(tmp,520,1390,frames,100,500);toc;
        
    clear test;
    
end

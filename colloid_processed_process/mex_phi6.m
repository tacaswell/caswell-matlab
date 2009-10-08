function out = mex_phi6(fname)
   
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
    
    x_max = 10*ceil(max(tmp(:,1))/10)
    y_max = 10*ceil(max(tmp(:,2))/10)
    tic;
    [out.phi6]...
        = phi6(tmp,x_max,y_max,max(tmp(:,end))+1,11);
    toc;
    clear phi6;
end
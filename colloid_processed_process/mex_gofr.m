function out = mex_gofr(fname)
   
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
   
% $$$     output = open(fname);
% $$$     
% $$$     tmp = output.all_pks_trim(:,[2 3 end]);
% $$$     tmp(:,3) = tmp(:,3) -1;
% $$$     out.stack_name = output.fname;
% $$$     out.fname = fname;
% $$$     clear output
% $$$     
    [out.gofr out.edges]...
        = basic_static(tmp,520,1390,max(tmp(:,end))+1,100,5000);

    clear basic_static;
end
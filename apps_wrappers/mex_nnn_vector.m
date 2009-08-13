function out = mex_nn_vector(fname)
% MEX_NN_VECTOR - takes in a file name, opens it up, shoves it thorugh the mex nn code and returns everything in a struct for the file looper scheme
%   
    
       
    output = open(fname);
    
    tmp = output.all_pks_trim(:,[2 3 end]);
    tmp(:,3) = tmp(:,3) -1;
    out.stack_name = output.fname;
    out.fname = fname;
    clear output

    frames = 1200;
    offset = 0;
    tmp = tmp(tmp(:,3)<(frames+offset) & tmp(:,3)>=offset,:);
    tmp(:,3) = tmp(:,3) - offset;
    

    size(tmp)
    tic; [out.pos out.nn out.nnn]    ...
            = nnn_vectors(tmp,520,1390,frames,6);toc;
        
    clear nnn_vectors;
    
end

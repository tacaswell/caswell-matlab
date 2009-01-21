function out = t_density_wrapper_wrapper(in)
%o function out = t_density_wrapper_wrapper(in)
%o summary: wrapper for t_density_wrapper.m to be handed to file_looper.m
%to extract the desnity and fluctiation information about all individual
%planes in the stack of planes from the processed daat in the file given
%by in.  Returns a struct that contains m*framesx4 matrix, first 3
%columns are given by t_density_wrapper, the last is the plane index
%o inputs:
%-in: file name of processed data that contains the field all_pks_trim
%0 outputs:
%-out: struct with a m*framesx4 matrix, first 3
%columns are given by t_density_wrapper, the last is the plane index in
%the feild all_den
    
    prams.m = 8;
    
    
    data = open(in);
    
    frame_index = t_trim_track_indx(data.all_pks_trim(:,end),5);
    
    out.all_den = zeros(size(frame_index,1)*prams.m,4)
    
    
    for k = 1:size(frame_index,1)
       out.all_den((1+(k-1)*prams.m):k*prams.m,:)=...
          [t_density_wrapper(data.all_pks_trim(frame_index(k,1): ...
                                                  frame_index(k,2),[2 ...
                            3]),prams.m) ones(prams.m,1)];


        
    end
    
    
end

function out = msd_from_struct(fname)
    
    
    post_fix = fname(1+find(fname=='/',1,'last'):(find(fname=='.',1,'last')-1))
    post_fix = post_fix(min(find(post_fix=='_')):end);
    out = struct;
    tmp = struct;
    out.name = post_fix(2:end);
    
    fields = {'all_pks', ' tms', ' all_pks_trim'};
    
    in = open(fname)
%    
%    for j = [2 3]
%        
%        eval(sprintf('tmp.%s = in.%s;',fields{j},fields{j}));
%        
%    end
%    

   
   tic;
       
       eval(sprintf('tmp = in.%s(:,[2 3 10]);',fields{3}));
       tmp(:, 3) = tmp(:, 3) -1;
       [out.msd out.counts] = test(tmp);
   toc;
   
   out.tms = in.tms;
    
    
end

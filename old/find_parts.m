function pks = find_parts(in,d_sz,max_sz)
%o function pks = find_parts(in,d_sz,max_sz)
%o summary: takes in an image that is assumed to be band passed and
%filtered, returns a maxtix for each particle that gives
% pks(n,:) = [x y norm rg size].  Uses matlab code
%o inputs:
%-in
%-d_sz
%max_sz

%%
%%d_sz is the size of the region to be dilated
    
    in_d = t_dilate(in,d_sz);
    [pk(:,2) pk(:,1)] = find(exp(in_d - in)==1);
    pks = tcntrd(in,pk,max_sz);
    
end
    
   
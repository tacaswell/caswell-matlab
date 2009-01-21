function [ dens] = t_density(pks,grid_sz)
    
    com = zeros(1,2);   
    pk_mx_x = max(pks(:,2));
    pk_mx_y = max(pks(:,1));

    range(1) = ceil(pk_mx_x/grid_sz);
    range(2) = ceil(pk_mx_y/grid_sz);
    pks = floor(pks/grid_sz);
    pks = sum((pks-0*[ones(size(pks,1),1) zeros(size(pks,1),1)]).*(ones(size(pks,1),1)*[range(1) 1]),2);
    dens = histc(pks,0:prod(range));
    dens = reshape(dens(1:(end-1)),range(1),range(2));

%     d_max = find(dens==max(dens));
%     if(numel(d_max)~=1)
%         fprintf(2,'more than one global max found, change grid size\n')
%         max_loc = [];
%         dens = [];
%     end
%     max_loc = [ceil((d_max-1)/range)*grid_sz+grid_sz/2 (mod(d_max-1,range)+1)*grid_sz+grid_sz/2];
%     

%    
%    X = 1:range;
%    X = X(ones(1,range),:);
%
%    tot = sum(sum(dens));
%        
%    com(1) = grid_sz*sum(sum(dens.*X))/tot;
%    
%    com(2) = grid_sz*sum(sum(dens.*X'))/tot;
    
    
    
end
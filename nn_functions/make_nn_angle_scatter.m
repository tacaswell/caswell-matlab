function make_nn_angle_scatter(in,dset,plane)
% MAKE_NN_ANGLE_SCATTER - makes a scatter plot of the posistions color coded by the angle btween the nn and nnn
%   
    
    f = figure;
    pos = in(dset).pos{plane};
    nn =  in(dset).nn {plane};
    nnn = in(dset).nnn{plane};
    theta = sum(nn.*nnn,2)./(sqrt(sum(nn.^2,2)).*sqrt(sum(nnn.^2,2)));
    scatter(pos(:,2),pos(:,1),50*(acos(theta)/pi()),theta,'x')
    axis image
    temp_str = parse_temperature(in(dset).fname);
    title(strcat('nn/nnn angle; tmp: ',temp_str))
    colorbar
    axis([ 400 800 200 400]);
    temp_str(3) = '-';
    a =  mfilename('fullpath') ;
    which save_figure
    save_figure(strcat('nnn_angle_scatter_region_',temp_str),[10 5],f,a,in(dset).fname);

    
end

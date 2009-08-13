function plot_nnn_quiver(in,dset)

    
    f = figure;
    imagesc(reshape(in(dset).gofr(:,1),500,500)/sum(in(dset).gofr(:,1)));
    axis image;
    temp_str = parse_temperature(in(dset).fname);
    title(strcat('2D g(r); tmp: ',temp_str))
    caxis([0 1e-5])
    temp_str(3) = '-';
    a =  mfilename('fullpath') ;
    save_figure(strcat('2D_gofr_',temp_str),[5 5],f,a,in(dset).fname);
end
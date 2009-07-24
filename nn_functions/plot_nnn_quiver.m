function plot_nnn_quiver(in,dset,plane)
    
    pos = in(dset).pos{plane};
    nn =  in(dset).nn {plane};
    nnn = in(dset).nnn{plane};
    fname = in(dset).fname;
    temperature = regexpi(fname,['[0-9]{2}-' ...
                        '[0-9]'],'match');
    temperature = temperature{1};
    temperature(3) = '.';
    f =figure;
    quiver(pos(:,2),pos(:,1),nn(:,2),nn(:,1),0);
    hold on;
    quiver(pos(:,2),pos(:,1),nnn(:,2),nnn(:,1),0);

    set(gca,'ydir','reverse');
    axis image;
% $$$     axis([ 400 800 200 400]);

    plot(pos(:,2),pos(:,1),'rx');
    title(strcat('Temperature: ',temperature,'C'))
    
    a =  mfilename('fullpath') ;
    temperature(3) = '-';
    
    save_figure(strcat('nnn_quiver_',temperature),[10 5],f,a,fname);
end
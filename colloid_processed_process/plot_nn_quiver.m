function plot_nn_quiver(pos,nn,fname)
    
    temperature = regexpi(fname,['[0-9]{2}-' ...
                        '[0-9]'],'match');
    temperature = temperature{1};
    temperature(3) = '.';
    f =figure;
    quiver(pos(:,2),pos(:,1),nn(:,2),nn(:,1),0);

    set(gca,'ydir','reverse');
    axis image;
    axis([ 400 800 200 400]);
    hold on;
    plot(pos(:,2),pos(:,1),'rx');
    title(strcat('Temperature: ',temperature,'C'))
    
    a =  mfilename('fullpath') ;
    temperature(3) = '-';
    
% $$$     save_figure(strcat('nn_quiver_region',temperature),[8 4],f,a,fname);
end
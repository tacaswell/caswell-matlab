function plot_nn_quiver(pos,nn)
    figure;
    quiver(pos(:,2),pos(:,1),nn(:,2),nn(:,1),0);
    axis image;
    hold on;
    plot(pos(:,2),pos(:,1),'rx');
end
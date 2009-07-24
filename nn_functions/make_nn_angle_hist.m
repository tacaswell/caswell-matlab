function out= make_nn_angle_hist(in,dset)
% MAKE_NN_ANGLE_SCATTER - makes a scatter plot of the posistions color coded by the angle btween the nn and nnn
%   
    
    bins = linspace(0,180,181); 

    vals = zeros(size(bins));
    for plane = 1:length(in(dset).nn)
        nn =  in(dset).nn {plane};
        nnn = in(dset).nnn{plane};
        theta=sum(nn.*nnn,2)./(sqrt(sum(nn.^2,2)).*sqrt(sum(nnn.^2, ...
                                                          2)));

        theta = acosd(theta);
        if(~any(isreal(theta)))

            theta = theta(isreal(theta));
        else
            vals = vals + histc(theta,bins)';
        end
    end
    f =figure;
    stairs(bins,vals);

    temp_str = parse_temperature(in(dset).fname);
    title(strcat('nn/nnn angle; tmp: ',temp_str))

    temp_str(3) = '-';
    a =  mfilename('fullpath') ;
    which save_figure
% $$$     save_figure(strcat('nnn_angle_hist_',temp_str),[5 5],f,a,in(dset).fname);

    
    out.bins = bins;
    out.vals = vals;
    
end

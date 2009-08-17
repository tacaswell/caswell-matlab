function make_2D_hist(in)
% MAKE_2D_HIST - takes in a struct that is spit out by mex_nnn_vector
%   
    
    arrayfun(@helper,in);
    
end

function helper(in)
% HELPER - helper funtion that does all the work so I can be lazy and use
% arrayfun
%


    

    steps = 200;
    x_range = [-10 10 steps];
    y_range = [-10 10 steps];
    
    
    
    f = figure;
    hist_data = zeros(steps);
    for j = 1:numel(in.nn); 
        hist_data= hist_data + histc2(in.nn{j},x_range,y_range);
    end;
    imagesc(log(hist_data/sum(sum(hist_data))))
    axis image
    caxis(log([0 2e-4]))
    temp_str = parse_temperature(in.fname);
    title(strcat('log nn hist; tmp: ',temp_str))
    temp_str(3) = '-';
    save_figure(strcat('nn_2dhist_',temp_str),[5 5],f,a,in.fname);
    
    f = figure;
    hist_data = zeros(steps);
    for j = 1:numel(in.nn); 
        hist_data= hist_data + histc2(in.nnn{j},x_range,y_range);
    end;
    imagesc(log(hist_data/sum(sum(hist_data))))
    axis image
    caxis(log([0 2e-4]))
    temp_str = parse_temperature(in.fname);
    title(strcat('log nnn hist; tmp: ',temp_str))
    temp_str(3) = '-';
    save_figure(strcat('nnn_2dhist_',temp_str),[5 5],f,a,in.fname);
    
% $$$     save_figure(strcat('nn_quiver_region',temperature),[8 4],f,a,fname);
    
end

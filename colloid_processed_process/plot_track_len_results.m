function plot_track_len_results(results)
%o function plot_track_len_results(results)
%o summary: plots the number of particles in tracks of given lengths
%o inputs:
%-results: array of structs that contain the fields: name, tracks_fill

    format = {'rx-','mx-','bx-','ro-','mo-','bo-','rs-'};
    max_length = 1000;
    min_length = 1;
    
    hist_bins = 0:max_length;
    
    
    f = figure
    hold on
    leg = cell(1,length(results))
    for j = 1:length(results)
       
        tmp_index = t_trim_track_indx(results{j}.tracks_fill,min_length);
        
        hist_val = hist(diff(tmp_index,[],2),hist_bins).*hist_bins;
        
        hist_val = filter(ones(1,5)/5,1,hist_val);
        
        plot(hist_bins,hist_val,format{j})
        leg{j} = results{j}.name;
        
        
    end
    legend(leg)
    
end


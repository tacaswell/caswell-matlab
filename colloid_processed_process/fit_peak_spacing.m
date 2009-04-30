function out = fit_peak_spacing(in)
   
    out = arrayfun(@helper,in);
    
    
end

function out = helper(in)
    diff_vec = zeros(length(in.peaks) +length(in.troughs) ,1);
    diff_vec(1:2:end) = in.peaks/in.peaks(1) -1;
    diff_vec(2:2:end) = in.troughs/in.peaks(1)-1;
    X = .5*(0:(length(diff_vec)-1))';
    [out.fit out.stdx out.mse] = lscov([X],diff_vec);

end
% assumes the input is of the form spit out by gofr_fun

function out = gofr_analyze(in)
   
    range = 15;
    
    out = in;
    % find the peaks of the total gofr
    % store the locations of all of them
    [out.extrema] = gofr_find_peaks(in,range);
    
    % store the height of peaks 1-4
% $$$     out.g = in.gofr(floor(out.extrema.peaks_indx));
    
    % find the peaks of the uniform test
    % store the locations of all of them
    % store the height of peaks 1-4
% $$$     out.uniform_test_extrema =...
% $$$         arrayfun(@(x) gofr_find_peaks(x,range,1),in.uniform_test);
% $$$     out.unifrom_test_g = ...
% $$$         arrayfun(@(x,y) x.gofr(y.peaks)...
% $$$                  ,in.uniform_test,out.uniform_test_extrema);

    
    
    
end

% $$$         
% $$$     figure;hold on;
% $$$     fake_stk_ext =gofr_find_peaks({fake_stack},100)
% $$$     plot(0:(length(fake_stk_ext.peaks)-1),fake_stk_ext.peaks/ ...
% $$$          fake_stk_ext.peaks(1)-1,'*');
% $$$     plot((0:(length(fake_stk_ext.troughs)-1)) + .5, ...
% $$$          fake_stk_ext.troughs/fake_stk_ext.peaks(1)-1,'s')
% $$$     
% $$$     plot(0:10,.87*(0:10),'m')
% $$$     title(['peaks in chp with noise (std = ' num2str(n) ')'])
% $$$     xlabel('peak # (trough # + .5)')
% $$$     ylabel('distance from first peak [multiples of first peak]')
% $$$     
% $$$     figure;hold on;
% $$$     stairs(fake_stack.edges/fake_stk_ext.peaks(1),fake_stack.gofr)
% $$$     arrayfun(@(x) plot([x x]/fake_stk_ext.peaks(1),[0 2.5],'k'), ...
% $$$              fake_stk_ext.troughs)
% $$$     
% $$$     arrayfun(@(x) plot([x x]/fake_stk_ext.peaks(1),[0 2.5],'r'), ...
% $$$              fake_stk_ext.peaks)
% $$$     
% $$$     axis tight
% $$$     title(['g(r) in chp with noise (std = ' num2str(n) ')'])
% $$$     xlabel('r [diameter]')
% $$$     ylabel('g(r)')
% $$$ 

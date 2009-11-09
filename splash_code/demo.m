function demo(fname)
% DEMO - demonstrates the peak finding code
%   
    
    a = importdata(fname);
    % import data
    a = a(2:end,:);
    % get rid of the leaing zeros
    figure
    imagesc((1-a)')
    
    figure
    display('hit enter to go to next frame')
    for j = 1:size(a,2); 
        find_peaks(1-a(:,j),50,true);
        title(j)
        pause;
    end;
end

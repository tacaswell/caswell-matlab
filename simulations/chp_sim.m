function [fd fd_g ] = chp_sim
   noise_level = .5;
    
    fd = make_sim(noise_level);
    [fd_g ]= make_plots(fd,noise_level);
    
end

function fake_data_stack = make_sim(noise_level)
    
    planes = 50;
    a = [0 1];
    b = [cos(30*pi/180) sin(30*pi/180)];
    count = 1;
    fake_data = zeros(501*1001,3);
    for k = -500:500; 
        for j = 0:500; 
            fake_data(count,[1 2]) = k*a + j*b;
            count = count + 1;
        end;
    end;
    fake_data_trim = fake_data(fake_data(:,2)>200 & fake_data(:,2)<500 & ...
                               fake_data(:,1)>0 & fake_data(:,1)<200,:);
    clear fake_data;
    fake_data_trim(:,2) = fake_data_trim(:,2)-200;
    max(fake_data_trim)
    min(fake_data_trim)
    fake_data_trim = fake_data_trim*10;
    fake_data_stack = zeros(size(fake_data_trim,1)*planes,3);
    
    for q = 1:planes; 
        fake_data_stack((1+(q-1)*size(fake_data_trim,1)):...
                        (q*size(fake_data_trim,1)),[1 2])=...
            fake_data_trim(:,[1 2]) +...
            noise_level*randn(size(fake_data_trim,1),2);
        % $$$             noise_level*(1-rand(size(fake_data_trim,1),2))*2;

        fake_data_stack((1+(q-1)*size(fake_data_trim,1)):...
                        (q*size(fake_data_trim,1)),3) =q-1;
    end;
    % make sure it does not randomly go past edge
    fake_data_stack(fake_data_stack<0) = 0;
    fake_data_stack(fake_data_stack(:,1)>2000,1) = 1999;
    fake_data_stack(fake_data_stack(:,2)>3000,2) = 2999;
end


function [fake_stack ]= make_plots(fake_data_stack,n)
        
    clear basic_static
    [fake_stack.gofr fake_stack.edges] = ...
        basic_static(fake_data_stack, 2000,3000, ...
                     max(fake_data_stack(:,3))+1,100,5000);
    
    clear basic_static
    figure;hold on;
    fake_stack.extrema =gofr_find_peaks(fake_stack,100);
    plot(0:(length(fake_stack.extrema.peaks)-1),fake_stack.extrema.peaks/ ...
         fake_stack.extrema.peaks(1)-1,'*');
    plot((0:(length(fake_stack.extrema.troughs)-1)) + .5, ...
         fake_stack.extrema.troughs/fake_stack.extrema.peaks(1)-1,'s')
    
    plot(0:10,.87*(0:10),'m')
    title(['peaks in chp with noise (std = ' num2str(n) ')'])
    xlabel('peak # (trough # + .5)')
    ylabel('distance from first peak [multiples of first peak]')
    
    figure;hold on;
    stairs(fake_stack.edges/fake_stack.extrema.peaks(1),fake_stack.gofr)
    arrayfun(@(x) plot([x x]/fake_stack.extrema.peaks(1),[0 2.5],'k'), ...
             fake_stack.extrema.troughs)
    
    arrayfun(@(x) plot([x x]/fake_stack.extrema.peaks(1),[0 2.5],'r'), ...
             fake_stack.extrema.peaks)
    
    axis tight
    title(['g(r) in chp with noise (std = ' num2str(n) ')'])
    xlabel('r [diameter]')
    ylabel('g(r)')
end
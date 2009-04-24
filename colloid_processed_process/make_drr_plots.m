function make_drr_plots(Drr)
   
    cols = lines(7);
    cols2 = jet(19);
    leg_str = arrayfun(@(x) ['\tau = ' num2str(x)],1:19,'Uniformoutput',false);
    leg_str2 = {'26-8','26-9', '27-7\_2','28-7','29-6','30-6','32-0'};
    
    for k = 1:7; 
        figure;
        hold on; 
        for j = 1:19;
            stairs(linspace(8,50,100)/8.2,Drr{k}.a(:,j)./Drr{k}.b(:,j), ...
                   'color',cols2(j,:));
        end;
        title([leg_str2{k}]);
        legend(leg_str);
        xlabel(['r ' '[diameters]']);
        ylabel('D_{rr} [px^2]');
        axis([0 10 -.5 2]);
        grid on;
    end;
 
    
    
    for k = 1:2; 
        figure;
        hold on; 
        for j = 1:7;
            stairs(linspace(8,50,100)/8.2,Drr{j}.a(:,k)./Drr{j}.b(:,k), ...
                   'color',cols(j,:));
        end;
        title([leg_str{k}]);
        legend(leg_str2);
        xlabel(['r ' '[diameters]']);
        ylabel('D_{rr} [px^2]');
        axis([0 10 -.5 2]);
        grid on;
    end;

    
end
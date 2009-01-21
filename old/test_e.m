function test_e(in1,in2)
    
    range = 7;
    f_h = figure;
    i_h = imagesc(rand(2*range + 1));
    hold on
    p_h = plot(range,range,'x');
    plot(range+1,range+1,'or')
    colormap(gray);
    for j = 1:size(in1,1)
        if in1(j,9)>.1
        [a b] = ind2sub(size(in2),in1(j,1)+1);
        set(i_h,'cdata',in2((a-range):(a+range),(b-range):(b+range)));
        set(p_h,'xdata',1+ range + in1(j,5));
        set(p_h,'ydata',1+ range + in1(j,4  ));

        fprintf('Shift: %f -- e: %f -- I: %f -- rg: %f\n', sqrt(sum(in1(j,[4 ...
                            5]).^2)),in1(j,[9 6 7]))
        pause
        end
    end
    
    
end
    
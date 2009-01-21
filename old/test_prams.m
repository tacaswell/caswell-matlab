function [a b c d] = test_prams(in1, in2,in3,in4,in5,arr_bin)

    tic;
        [a b c d]=  t_hello(arr_bin,[in1,in2,in3,in4,in5,0]);
    toc;
    a = a';
    figure
    imagesc(d+100*c);
    colormap gray
    hold on;
    scatter(a(:,3)+1,a(:,2)+1);
    [dummy(:,1) dummy(:,2)] = t_1d_2d_cords_c(a(:,1),520);
    scatter(dummy(:,2)+1,dummy(:,1)+1);
end  
    
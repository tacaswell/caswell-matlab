function [a a2 b b2 c c2]= t_fit_hist(tracks,range)
%o function [a a2 b b2 c c2]= t_fit_hist(tracks,range) 
%o summary: fits and plots a streched gaussian and to a sum of two
%populations 
%o inputs:
%-tracks: an array of particle tracks
%-range: the maximum distance to fit the population to
%o output:
%-a: 

    
    vals = make_track_hist(tracks,range);
    % gets a histogram of displacements
    plot_index = -range:range/100:range;
    
    vals = vals/sum(vals);
    
    index = ~isinf(log(-log(vals/vals(101))));
    val_norm = vals(101);

    vals = vals(index);
    plot_index = plot_index(index);
    
    
    
    %    figure
    % plot(plot_index,vals,'x')
    [a b c] = tlinfit(log(-log(vals/val_norm))',[log(abs(plot_index))' ...
                        -ones(size(plot_index))'],1);
    
    [a2 b2 c2] = tlinfit(log(vals)',[-abs(plot_index)'.^2 ...
                        ones(size(plot_index,2),1)],1);
    
    cut1 = 1;
    cut2 = 2;
    
    
    index2 = abs(plot_index)<cut1;
    index3 = abs(plot_index)>cut2;
    index4 = ~index2 & ~index3;
    
    [a3 b3 c3] = tlinfit(log(vals(index2))',[- ...
                         abs(plot_index(index2))'.^2 ones(sum(index2), ...
                                                      1)],1);
    
    size([abs(plot_index(index3))' ones(sum(index3),1)])
    [a4 b4 c4] = tlinfit(log(vals(index3))',[- ...
                        abs(plot_index(index3)).^2' ones(sum(index3), ...
                                                      1)],1);
    
    
 %   
   figure

   plot(abs(plot_index)'.^(2),-log(vals) ,'x')
   hold on
   plot(abs(plot_index)'.^(2),a2(1)*abs(plot_index)'.^(2) -a2(2),'r--')
   plot(abs(plot_index)'.^(2),a3(1)*abs(plot_index)'.^(2)-a3(2),'r--') 
   plot(abs(plot_index)'.^(2),a4(1)*abs(plot_index)'.^(2) -a4(2),'r--')
   title('fit assuming gaussian')
   ylabel('-log(\rho)')
   xlabel('|x|^2')
   
 %   figure
 %   
 %   plot(log(abs(plot_index))',log(-log(vals/val_norm))','x')
 %   hold on
 %   plot(log(abs(plot_index))' ,a(1)*log(abs(plot_index))' - a(2));
 %   %size(a)
 %
 %   
    figure
    hold on;
    plot(plot_index(index2),vals(index2),'rx')
    plot(plot_index(index3),vals(index3),'gx')
    plot(plot_index(index4),vals(index4),'bx')
    
    plot(plot_index,exp(-(a2(1)*abs(plot_index)'.^(2) -a2(2))),'b--')
    plot(plot_index,exp(-(a3(1)*abs(plot_index)'.^(2)-a3(2))),'r--') 
    plot(plot_index,exp(-(a4(1)*abs(plot_index)'.^(2) -a4(2))),'g--')
    
    plot(plot_index,val_norm*exp(-exp(a(1)*log(abs(plot_index)) - ...
                                      a(2))),'m--')
    set(gca,'yscale','log');
    grid on
    xlabel('displacement')
    ylabel('p(x)')
    
    
end
    
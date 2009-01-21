function [pram err cov] = tlinfit(data,fit,w)
%o function [pram err cov] = tlinfit(data,fit,w)
%o summary: computes linear least squares fitting and returns
%the parameters, error, and covariance of the fit.  assumes the form
%that data = fit*param = sum( c_i f_i(x))
%o input:
%-data: the data that is being fit in a 1xn vector
%-fit: a nxm, where m is the number of parameters, matrix where
%each row is the values of f_i(x) at each data point in data
%-[opt]w: weighting vector, must either be a scaler or
%the same dimension as data
%o output:
%-pram: coefficents of fit
%-err: error in fit
%-cov: covariance of parameters
if nargin<3
    w = 1;
end

y = data';
w = w';
%fit = [ones(length(y'),1), [1:length(data)]'];
 pram = inv(fit'*diag(w)*fit)*fit'*(y.*w);
 err = y-fit*pram;   
 err=var(err)*(length(err)-1)/(length(err)-length(pram));
 
 cov = inv(fit'*fit)*err;
% 
% data = data - data(1);
% 
% pramstep = -pram/10;
% lb=sum((fit-data).^2);
% fprintf( '%d dummy\n',lb)
% for j = 1:n
%     for k = 1:length(pram)
%         pramt = pram + pramstep;
%         fit = pramt(1)*(1:length(data)) +pramt(2);
%         ls=sum((fit-data).^2);
%         fprintf('%d %d %d %d \n',pram(1), pramt(1),pram(2), pramt(2))
%         if(ls<lb)
%             pramstep(k) = pramstep(k)* 1.7;
%             pram = pramt;
%             lb = ls;
%             fprintf( 'yo2\n')
%         else
%             pramstep(k) = - pramstep(k) *.7;
%         end
%     end
% end

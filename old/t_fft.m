function out = t_fft(y,disp)
%lifted from matlab documentation
if nargin ==1
    disp = 0;
end
    
Fs = 10;                    % Sampling frequency
T = 1/Fs;                     % Sample time
L = length(y);                     % Length of signal
t = (0:L-1)*T;                % Time vector

if disp
figure
plot(t,y)
title('Signal Corrupted with Zero-Mean Random Noise')
xlabel('time (seconds)')
end


NFFT = 2^nextpow2(L); % Next power of 2 from length of y
Y = fft(y,NFFT)/L;
f = Fs/2*linspace(0,1,NFFT/2);

if disp
% Plot single-sided amplitude spectrum.
figure
plot(f,2*abs(Y(1:NFFT/2).^2)) 
title('Single-Sided Amplitude Spectrum of y(t)')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')
end

out = 2*abs(Y(1:NFFT/2)).^2;

end

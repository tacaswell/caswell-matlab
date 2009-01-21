function out = t_fft_2(y,NFFT,disp)
%o function out = t_fft_2(y,NFFT,disp)
%o summary: computer the abssqr of the FFT of a vector y using NFFT points
%for the computation
%
%mostly lifted from matlab documentation.
%o inputs:
%-y: data vector
%-NFFT: length of vector in reciprocal space, works best when set to a
%power of 2
%-[opt]disp: sets if the spectrum is plotted, defaults to not plotting
%o outputs:
%-out: power spectrum
if nargin <3
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


%NFFT = 2^nextpow2(L); % Next power of 2 from length of y
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

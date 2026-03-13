function myFFT_spectrum(x,Fs)
N = length(x);
X = fft(x);
X_mag = abs(X)/N;
f = (0:N-1)*(Fs/N);
half_N = floor(N/2);
X_mag_half = X_mag(1:half_N);
f_half = f(1:half_N);


figure;
plot(f_half, X_mag_half);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Magnitude Spectrum using FFT');
grid on;




%% 1700-200
Fs=10000;
A=0.8;
Ts=1/Fs;
dur=1.5;
t=0:Ts:dur;
Theta=2*pi*(100+1700*t-500*t.*t);
chirpsig=A*sin(Theta);
sound(chirpsig,Fs);
%% FFT of the second chirp signal
len = length(chirpsig);
SSC = fft(chirpsig);
SSR = abs(SSC)./len;
L=round(len/2);
Mag = mag2db(SSR);
f = (Fs/2)*(0:L)/L;
plot(f,Mag(1:L+1));
xlabel('Frequency')
ylabel('dB')
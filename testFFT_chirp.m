
Fs = 10000;
Ts = 1/Fs;
duration = 2;

f_start = 200;
f_end = 1700;
A = 0.8;

t = 0:Ts:duration;
k = (f_end - f_start)/duration;

theta = 2*pi*(f_start*t + (k/2)*t.^2);

chirpSig = A*sin(theta);

figure;
plot(t, chirpSig);
xlabel('Time (seconds)');
ylabel('Amplitude');
title('Chirp Signal');
grid on;

myFFT_spectrum(chirpSig, Fs);
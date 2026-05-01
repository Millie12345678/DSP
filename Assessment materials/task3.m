clear; close all;

fs   = 44100;
NFFT = 2^14;


[b1, a1] = peaking_biquad(600,  1.0, +6.0, fs);   
[b2, a2] = peaking_biquad(7000, 1.5, -4.0, fs);   


impulse = [1, zeros(1, 4095)];
h_hw    = filter(b1, a1, impulse);
h_hw    = filter(b2, a2, h_hw);

H_hw    = fft(h_hw, NFFT);
mag     = abs(H_hw(1:NFFT/2+1));
mag_db  = 20*log10(mag / max(mag) + 1e-12);
freq_hz = (0:NFFT/2) * fs / NFFT;
freq    = freq_hz / (fs/2);                 

figure;
semilogx(freq_hz, mag_db, 'b', 'LineWidth', 1.5);
xlabel('Frequency (Hz)');  ylabel('Magnitude (dB)');
title('Simulated Hardware Response');
xlim([20, fs/2]);  ylim([-15, 10]);  grid on;


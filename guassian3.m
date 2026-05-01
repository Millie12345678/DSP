NoiseFs = 22050;
NoiseDur = 2;
Noise = randn(Fs*Duration,1);

sound(Noise,Fs);
clc;

disp;
filt

b=filt.Numerator;
a = 1;


figure;
stem(b);
title('Impulse Response of Designed FIR Filter');
xlabel()
ylabel('Amplitude');



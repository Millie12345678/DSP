Fs=10000;
A=0.8;
Ts=1/Fs;
dur=1.5;
t=0:Ts:dur;
Theta=2*pi*(100+200*t+500*t.*t);
chirpsig=A*sin(Theta);
audiowrite('mychirp1.wav',chirpsig,Fs);

fs = 1000;          % Sampling frequency (Hz)
t = 0:1/fs:5;       % Time vector (5 seconds)

f0 = 10;            % Start frequency (Hz)
f1 = 200;           % End frequency (Hz)

x = chirp(t, f0, 5, f1);   % Linear chirp

plot(t,x)
xlabel('Time (s)')
ylabel('Amplitude')
title('Chirp Signal')


% write signalAnalyzer

fs = 44100;              % sample rate
T = 2;                   % duration (seconds)
t = 0:1/fs:T-1/fs;

f0 = 220;                % fundamental frequency

sine = sin(2*pi*f0*t);
square_wave = square(2*pi*f0*t);
fc = 220;     % carrier
fm = 110;     % modulator
I = 5;        % modulation index

fm_signal = sin(2*pi*fm*t);
fm_synth = sin(2*pi*fc*t + I*fm_signal);

attack = 0.1;
decay = 0.2;
sustain_level = 0.6;
release = 0.3;

env = zeros(size(t));

A = round(attack*fs);
D = round(decay*fs);
R = round(release*fs);
S = length(t) - (A+D+R);

env(1:A) = linspace(0,1,A);
env(A+1:A+D) = linspace(1,sustain_level,D);
env(A+D+1:A+D+S) = sustain_level;
env(end-R+1:end) = linspace(sustain_level,0,R);

signal = saw .* env;

lfo_freq = 5;
lfo = 0.5*(1 + sin(2*pi*lfo_freq*t)); % 0–1 range

modulated = signal .* lfo;



y = sin(2*pi*f0*t) + 0.5*sin(2*pi*2*f0*t) + 0.25*sin(2*pi*3*f0*t);

y = y / max(abs(y));

fs = 8000; % sampling frequency
t = 1:1/fs:2; % time signal
freq = 440;  % note frequency in Hz (middle C)
y = cos(2*pi*freq*t); %create sine wave
plot(y);
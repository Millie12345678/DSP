fs = 1000;        % sampling frequency (Hz)
t = 0:1/fs:5;     % time vector (5 seconds)

x = chirp(t,10,5,200);   % chirp from 10 Hz to 200 Hz over 5 seconds

window = 128;
noverlap = 120;
nfft = 256;

spectrogram(x, window, noverlap, nfft, fs, 'yaxis')


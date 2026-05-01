fs = 44100;           % CD-quality sample rate
t = 0:1/fs:2;         % 2 seconds, starting at t=0
freq = 261.63;        % Middle C (fix the comment mismatch)
y = sin(2*pi*freq*t); % sine wave
y = y .* linspace(1, 0, length(y)); % fade out to avoid clicking

player = audioplayer(y, fs);
play(player);
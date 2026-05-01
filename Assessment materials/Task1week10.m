clear; close all;

fs  = 44100;
dur = 2.0;     
f0  = 220;    
t = (0 : 1/fs : dur - 1/fs);

x_osc = 2 * mod(f0 * t, 1) - 1;


env   = ones(1, length(t));   
x_env = x_osc .* env;

fc = 1500;                  
Wn = fc / (fs/2);            
[b_filt, a_filt] = butter(2, Wn, 'low');
x_filt = filter(b_filt, a_filt, x_env);


x_out = x_filt / (max(abs(x_filt)) + 1e-12); 

figure;
plot(t, x_out);
xlabel('Time (s)');  ylabel('Amplitude');
title('Synthesiser Output');

figure;
plot_spectrum(x_out, fs);
title('Synthesiser Output: Magnitude Spectrum');
xlim([0, 5000]);
fs = 100000; 
t = 0:1/fs:0.02; 
fc = 1000; 
fm = 100; 
Am = 1; 
kf = 500; 

message = Am * sin(2 * pi * fm * t);

Ac = 1; 
modulated_signal = Ac * cos(2 * pi * fc * t + kf * cumsum(message)/fs);
demodulated_signal = diff(unwrap(angle(hilbert(modulated_signal)))) * fs / (2 * pi * kf);
demodulated_signal = [demodulated_signal, demodulated_signal(end)]; % Match dimensions

figure;
subplot(3,1,1);
plot(t, message);
title('Message Signal');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(3,1,2);
plot(t, modulated_signal);
title('FM Signal');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(3,1,3);
plot(t, demodulated_signal);
title('Demodulated Signal');
xlabel('Time (s)');
ylabel('Amplitude');


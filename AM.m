fs = 10000; 
t = 0:1/fs:0.1; 
fc = 1000; 
fm = 100;  
Am = 1; 
message = Am * sin(2 * pi * fm * t);

Ac = 1;
carrier = Ac * cos(2 * pi * fc * t);

modulated_signal = message .* carrier;

demodulated_signal = modulated_signal .* carrier;
[b, a] = butter(6, fm/(fs/2), 'low'); 
demodulated_signal_filtered = filter(b, a, demodulated_signal);

figure;
subplot(4,1,1);
plot(t, message);
title('Message Signal');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(4,1,2);
plot(t, carrier);
title('Carrier Signal');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(4,1,3);
plot(t, modulated_signal);
title('DSB-SC Modulated Signal');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(4,1,4);
plot(t, demodulated_signal_filtered);
title('Demodulated Signal');
xlabel('Time (s)');
ylabel('Amplitude');

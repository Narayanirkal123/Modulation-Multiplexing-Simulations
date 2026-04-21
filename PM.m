fs = 10000; % Sampling frequency in Hz
t = 0:1/fs:0.1; % Time vector
fc = 1000; % Carrier frequency in Hz
fm = 100; % Message frequency in Hz
Am = 1; % Amplitude of the message signal

% Message Signal
message = Am * sin(2 * pi * fm * t);

% Carrier Signal
Ac = 1; % Amplitude of the carrier
carrier = Ac * cos(2 * pi * fc * t);

% Phase Modulation
kp = pi / 2; % Phase sensitivity (modulation index)
modulated_signal = Ac * cos(2 * pi * fc * t + kp * message);

% Demodulation (Extract the phase variation)
demodulated_signal = diff(unwrap(angle(modulated_signal))) * fs / (2 * pi);
demodulated_signal = [demodulated_signal, 0]; % Match the signal length
[b, a] = butter(6, fm/(fs/2), 'low'); % Low-pass filter to remove high-frequency components
demodulated_signal_filtered = filter(b, a, demodulated_signal);

% Plotting
figure;

% Message Signal
subplot(4, 1, 1);
plot(t, message);
title('Message Signal');
xlabel('Time (s)');
ylabel('Amplitude');

% Carrier Signal
subplot(4, 1, 2);
plot(t, carrier);
title('Carrier Signal');
xlabel('Time (s)');
ylabel('Amplitude');

% Phase Modulated Signal
subplot(4, 1, 3);
plot(t, modulated_signal);
title('Phase Modulated Signal');
xlabel('Time (s)');
ylabel('Amplitude');

% Demodulated Signal
subplot(4, 1, 4);
plot(t, demodulated_signal_filtered);
title('Demodulated Signal');
xlabel('Time (s)');
ylabel('Amplitude');

% Parameters
fs = 1000; % Sampling frequency in Hz
signal_length = 5; % Duration of each signal in seconds
channels = 3; % Number of input signals

% Generate input signals
signal_time = 0:1/fs:signal_length-1/fs;
input_signals = zeros(channels, length(signal_time));

for i = 1:channels
    input_signals(i, :) = sin(2 * pi * (10 * i) * signal_time); % Different frequencies for each channel
end

% FDM Modulation
carrier_frequencies = [50, 150, 250]; % Carrier frequencies for each channel
fdm_signal = zeros(1, length(signal_time));
for i = 1:channels
    fdm_signal = fdm_signal + input_signals(i, :) .* cos(2 * pi * carrier_frequencies(i) * signal_time);
end

% FDM Demodulation
recovered_signals = zeros(channels, length(signal_time));
for i = 1:channels
    recovered_signals(i, :) = fdm_signal .* cos(2 * pi * carrier_frequencies(i) * signal_time);
end

% Filtering to recover baseband signals
[b, a] = butter(4, 30 / (fs/2)); % Low-pass filter
for i = 1:channels
    recovered_signals(i, :) = filtfilt(b, a, recovered_signals(i, :));
end

% Plotting
figure;

% Input Signals
subplot(3, 1, 1);
plot(signal_time, input_signals);
title('Input Signals');
grid on;
xlabel('Time (s)');
ylabel('Amplitude');
legend(arrayfun(@(x) sprintf('Channel %d', x), 1:channels, 'UniformOutput', false));

% FDM Signal
subplot(3, 1, 2);
plot(signal_time, fdm_signal, 'k');
title('FDM Signal');
grid on;
xlabel('Time (s)');
ylabel('Amplitude');

% Recovered Signals
subplot(3, 1, 3);
plot(signal_time, recovered_signals);
title('Recovered Signals');
grid on;
xlabel('Time (s)');
ylabel('Amplitude');
legend(arrayfun(@(x) sprintf('Channel %d', x), 1:channels, 'UniformOutput', false));

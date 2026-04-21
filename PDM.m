% Parameters
fs = 1000; % Sampling frequency in Hz
Tb = 0.1; % Bit duration in seconds
signal_length = 5; % Duration of each signal in seconds
channels = 3; % Number of input signals

% Generate input signals
signal_time = 0:1/fs:signal_length-1/fs;
input_signals = zeros(channels, length(signal_time));

for i = 1:channels
    input_signals(i, :) = sin(2 * pi * (10 * i) * signal_time); % Different frequencies for each channel
end

% PDM Modulation
samples_per_bit = fs * Tb;
pdm_signal = zeros(1, channels * length(signal_time) / samples_per_bit);
pdm_time = linspace(0, signal_length, length(pdm_signal));

for i = 1:samples_per_bit:length(signal_time)
    for j = 1:channels
        idx = ((i-1)/samples_per_bit * channels + j);
        pdm_signal(idx) = input_signals(j, i);
    end
end

% PDM Demodulation
recovered_signals = zeros(channels, length(signal_time));
for i = 1:channels
    recovered_indices = i:channels:length(pdm_signal);
    recovered_signals(i, :) = interp1(pdm_time(recovered_indices), pdm_signal(recovered_indices), signal_time, 'previous', 0);
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

% PDM Signal
subplot(3, 1, 2);
stem(pdm_time, pdm_signal, 'k.');
title('PDM Signal');
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

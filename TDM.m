% Parameters
fs = 1000; % Sampling frequency in Hz

Tb = 1;   % Bit duration in seconds
channels = 3; % Number of input signals
signal_length = 5; % Duration of each signal in seconds

% Generate input signals
signal_time = 0:1/fs:signal_length-1/fs;
input_signals = zeros(channels, length(signal_time));

for i = 1:channels
    input_signals(i, :) = sin(2 * pi * (10 * i) * signal_time); % Different frequencies for each channel
end

% Multiplexing
samples_per_bit = fs * Tb;
tdm_signal = zeros(1, channels * length(signal_time));
tdm_time = linspace(0, channels * signal_length, length(tdm_signal));

for i = 1:length(signal_time)
    for j = 1:channels
        tdm_signal((i-1)*channels + j) = input_signals(j, i);
    end
end

% Demultiplexing
recovered_signals = zeros(channels, length(signal_time));

for i = 1:channels
    recovered_signals(i, :) = tdm_signal(i:channels:end);
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
legend(arrayfun(@(x) sprintf('Channel %d', x), 1:channels,'UniformOutput', false));

% TDM Signal
subplot(3, 1, 2);
plot(tdm_time, tdm_signal, 'k');
title('TDM Signal');
grid on;
xlabel('Time (s)');
ylabel('Amplitude');

% Recovered Signals
for i = 1:channels
    subplot(3,1,3);
    plot(signal_time, recovered_signals(i, :));
    title(sprintf('Recovered Signal - Channel %d', i));
    grid on;
    xlabel('Time (s)');
    ylabel('Amplitude');
end

% Parameters
M = 8; % MPSK (e.g., M = 8 for 8-PSK)
num_symbols = 100; % Number of symbols to transmit
fs = 10000; % Sampling frequency in Hz
symbol_rate = 1000; % Symbol rate in symbols per second
samples_per_symbol = fs / symbol_rate; % Number of samples per symbol
Eb = 1; % Energy per bit

% Generate random message
data = randi([0 M-1], 1, num_symbols); % Random integers from 0 to M-1

% MPSK Modulation
theta = (2 * pi / M) * data; % Phase angles for each symbol
modulated_signal = sqrt(Eb) * exp(1j * theta); % MPSK symbols (complex baseband)

% Upsampling
modulated_signal_upsampled = upsample(modulated_signal, samples_per_symbol);

% Carrier Signal
t = (0:length(modulated_signal_upsampled)-1) / fs; % Time vector
fc = 2000; % Carrier frequency in Hz
carrier = exp(1j * 2 * pi * fc * t); % Complex carrier

% Transmitted Signal (Passband)
transmitted_signal = real(modulated_signal_upsampled .* carrier);

% Add AWGN (optional, adjust SNR)
snr = 20; % Signal-to-noise ratio in dB
received_signal = awgn(transmitted_signal, snr, 'measured');

% Demodulation
demodulated_signal = received_signal .* conj(carrier); % Downconversion
low_pass_filter = fir1(50, 1/(samples_per_symbol)); % Low-pass filter
baseband_signal = filter(low_pass_filter, 1, demodulated_signal); % Extract baseband

% Symbol Recovery
recovered_signal = downsample(baseband_signal, samples_per_symbol); % Downsampling
recovered_phase = angle(recovered_signal); % Phase of the received symbols
recovered_data = mod(round(recovered_phase / (2 * pi / M)), M); % Quantize to nearest phase

% Bit Error Rate (optional)
num_errors = sum(data ~= recovered_data);
ber = num_errors / num_symbols;

% Plotting
figure;

% Transmitted Signal (Real Part)
subplot(3, 1, 1);
plot(real(transmitted_signal));
title('Transmitted Signal (Real Part)');
xlabel('Time (samples)');
ylabel('Amplitude');

% Received Signal
subplot(3, 1, 2);
plot(real(received_signal));
title('Received Signal (Real Part)');
xlabel('Time (samples)');
ylabel('Amplitude');

% Constellation Diagram
subplot(3, 1, 3);
scatter(real(recovered_signal), imag(recovered_signal), 'bo');
hold on;
scatter(real(modulated_signal), imag(modulated_signal), 'rx');
title('Constellation Diagram');
xlabel('In-Phase');
ylabel('Quadrature');
legend('Received Symbols', 'Transmitted Symbols');
grid on;

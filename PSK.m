data = [1 0 1 1 0 0 1];
bit_rate = 1;
carrier_freq = 10;
sampling_rate = 100;
bit_duration = 1 / bit_rate;
t = 0:1/sampling_rate:bit_duration - 1/sampling_rate;
carrier_0 = cos(2 * pi * carrier_freq * t);
carrier_1 = cos(2 * pi * carrier_freq * t + pi);
psk_signal = [];
for i = 1:length(data)
if data(i) == 1
psk_signal = [psk_signal carrier_1];
else
psk_signal = [psk_signal carrier_0];
end
end
demodulated_data = [];
for i = 1:length(data)
segment_start = (i - 1) * length(t) + 1;
segment_end = i * length(t);
received_segment = psk_signal(segment_start:segment_end);
corr_0 = sum(received_segment .* carrier_0);
corr_1 = sum(received_segment .* carrier_1);
if corr_1 > corr_0
demodulated_data = [demodulated_data 1];
else
demodulated_data = [demodulated_data 0];
end
end

figure;
subplot(4, 1, 1);
stairs(0:bit_duration:length(data) * bit_duration, [data 0], 'LineWidth', 1.5);
title('Input Binary Data');
xlabel('Time (s)');
ylabel('Amplitude');
ylim([-0.5 1.5]);
grid on;

subplot(4, 1, 2);
plot(t, carrier_0, 'LineWidth', 1.5);
hold on;
plot(t, carrier_1, 'LineWidth', 1.5);
title('Carrier Signals (Phase 0 and Phase π)');
xlabel('Time (s)');
ylabel('Amplitude');
legend('Phase 0 (binary 0)', 'Phase π (binary 1)');
grid on;

subplot(4, 1, 3);
plot(0:1/sampling_rate:(length(data) * bit_duration - 1/sampling_rate), psk_signal, 'LineWidth', 1.5);
title('PSK Modulated Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

subplot(4, 1, 4);
stairs(0:bit_duration:length(demodulated_data) * bit_duration, [demodulated_data 0], 'LineWidth', 1.5);
title('Demodulated Binary Data');
xlabel('Time (s)');
ylabel('Amplitude');
ylim([-0.5 1.5]);
grid on;

disp('Demodulated Data:');
disp(demodulated_data);

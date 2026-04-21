data = [1 0 1 1 0 0 1]; 
bit_rate = 1; 
carrier_freq = 10; 
amplitude_high = 5; 
amplitude_low = 0; 
sampling_rate = 100; 
bit_duration = 1 / bit_rate; 
t = 0:1/sampling_rate:bit_duration - 1/sampling_rate; 
carrier = cos(2 * pi * carrier_freq * t);
ask_signal = [];
for i = 1:length(data)
    if data(i) == 1
        ask_signal = [ask_signal amplitude_high * carrier]; 
    else
        ask_signal = [ask_signal amplitude_low * carrier]; 
    end
end
total_time = 0:1/sampling_rate:(length(data) * bit_duration - 1/sampling_rate);
demodulated_data = [];
threshold = (amplitude_high + amplitude_low) / 2; 
for i = 1:length(data)
    segment_start = (i - 1) * length(t) + 1;
    segment_end = i * length(t);
    received_segment = ask_signal(segment_start:segment_end);
    received_amplitude = mean(abs(received_segment));
    if received_amplitude > threshold
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
plot(t, carrier, 'LineWidth', 1.5);
title('Carrier Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
subplot(4, 1, 3);
plot(total_time, ask_signal, 'LineWidth', 1.5);
title('ASK Modulated Signal');
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

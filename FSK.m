fs = 1000;
t = 0:1/fs:1-1/fs;
f1 = 100;
f2 = 50;
data = [1 0 1 0];
mod_signal = [];
for bit = data
    if bit == 1
        mod_signal = [mod_signal sin(2*pi*f1*t)];
    else
        mod_signal = [mod_signal sin(2*pi*f2*t)];
    end
end
figure;
subplot(3,1,1);
plot(mod_signal);
title('FSK Modulated Signal');
xlabel('Time');
ylabel('Amplitude');

subplot(3,1,2);
stem(data, 'filled');
title('Original Binary Signal');
xlabel('Time (bits)');
ylabel('Amplitude');
ylim([-0.5 1.5]);
freqs = [f1 f2];
demod_signal = zeros(size(data));
for i = 1:length(data)
    segment = mod_signal((i-1)*fs+1:i*fs);
    f1_power = sum(segment .* sin(2*pi*f1*t));
    f2_power = sum(segment .* sin(2*pi*f2*t));
    demod_signal(i) = f1_power > f2_power;
end
subplot(3,1,3)
stem(demod_signal, 'filled');
title('Demodulated Binary Signal');
xlabel('Time (bits)');
ylabel('Amplitude');
ylim([-0.5 1.5]);
disp('Original Data:');
disp(data);
disp('Demodulated Data:');
disp(demod_signal);

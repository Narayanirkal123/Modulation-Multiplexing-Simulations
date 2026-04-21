% Step 1: Define Parameters
Fs = 1000;               
t = 0:5/Fs:1-1/Fs;       
f =5 ;                   
A = 1;                   
% Step 2: Generate an Analog Signal (Sine Wave)
analogSignal = A * sin(2 * pi * f * t);

% Step 3: Quantization Parameters
numBits = 10;             % Number of bits for quantization
L = 2^numBits;           % Number of quantization levels
minVal = min(analogSignal); % Minimum value of signal
maxVal = max(analogSignal); % Maximum value of signal

% Step 4: Quantize the Signal
quantizedSignal = round((analogSignal - minVal) / (maxVal - minVal) * (L - 1));
quantizedSignal = quantizedSignal / (L - 1) * (maxVal - minVal) + minVal;

% Step 5: Encode to Binary
binaryEncoded = de2bi(round((analogSignal - minVal) / (maxVal - minVal) * (L - 1)), numBits, 'left-msb');
% Step 6: Plot the Results
figure;

% Original Signal
subplot(3,1,1);
plot(t, analogSignal, 'b', 'LineWidth', 1.5);
title('Original Analog Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% Quantized Signal
subplot(3,1,2);
stem(t, quantizedSignal, 'r', 'LineWidth', 1.5);
title('Quantized Signal');
xlabel('Time (s)');
ylabel('Amplitude');

grid on;
% Binary Encoded Signal (Example for First Few Bits)
subplot(3,1,3);
stem(binaryEncoded(1:10,:), 'k', 'LineWidth', 1.5);
title('Binary Encoded (First 10 Samples)');
xlabel('Sample Index');
ylabel('Binary Code');
grid on;

disp('Binary Encoded Signal (First 10 Samples):');
disp(binaryEncoded(1:10,:));

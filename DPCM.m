fs =4000;
t = 0:1/fs:1; 
f = 5; 
signal = sin(2*pi*f*t); 

nBits = 4;
nLevels = 2^nBits; 


signal_min = min(signal);
signal_max = max(signal);
qLevels = linspace(signal_min, signal_max, nLevels); 

encodedSignal = zeros(size(signal));
prediction = 0;
quantizedIndices = zeros(size(signal)); 
for i = 1:length(signal)
difference = signal(i) - prediction;
 [~, idx] = min(abs(qLevels - difference));
    quantizedDifference = qLevels(idx);
    encodedSignal(i) = quantizedDifference;
    quantizedIndices(i) = idx - 1; 
    prediction = prediction + quantizedDifference;
end
dpcmCode = dec2bin(quantizedIndices, nBits); 
decodedSignal = zeros(size(encodedSignal));
prediction = 0; 
for i = 1:length(encodedSignal)
  
 
   decodedSignal(i) = prediction + encodedSignal(i);
    prediction = decodedSignal(i); 
end
figure;
subplot(3, 1, 1);
plot(t, signal);
title('Original Signal');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(3, 1, 2);
stairs(quantizedIndices);
title('DPCM Encoded Signal (Quantized Indices)');
xlabel('Sample Index');
ylabel('Index');

subplot(3, 1, 3);
plot(t, decodedSignal);
title('Reconstructed Signal (DPCM Decoded)');


xlabel('Time (s)');
ylabel('Amplitude');
disp('DPCM Encoded Binary Data:');
disp(dpcmCode);

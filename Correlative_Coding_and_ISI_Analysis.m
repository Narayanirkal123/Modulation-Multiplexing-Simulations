% Generate a pseudo-random binary sequence (PRBS) of order 10
order = 10; % PRBS order
numBits = 2^order - 1; % Length of the sequence
rng(42); % Set a random seed for reproducibility (optional)
bitPattern = randi([0, 1], numBits, 1); % Generate random binary sequence
% Generate NRZ signal (100 samples per bit)
samplePerBit = 100;
sig = repelem(bitPattern, samplePerBit);
% Plot eye diagram of the original signal
timeSlot = 2 * samplePerBit; % Length of one eye diagram window
offset = samplePerBit / 2;   % Offset for better visualization
eyediagram(sig, samplePerBit, timeSlot, offset);
ylim([-0.2, 1.2]);
title('Eye Diagram of Original Signal');
% Generate distorted signal (add noise and smoothing)



sig2 = sig + 0.2 * randn(size(sig)); % Add Gaussian noise
sig2 = movmean(sig2, 50); % Apply moving average for smoothing
% Plot eye diagram of the distorted signal
eyediagram(sig2, samplePerBit, timeSlot, offset);
ylim([-0.2, 1.2]);
title('Eye Diagram of Distorted Signal');

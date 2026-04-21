% Parameters
numBits = 1e6;        % Number of bits to transmit
M = 16;               % Modulation order (16-QAM)
k = log2(M);          % Bits per symbol
snrRange = 0:2:20;    % SNR range in dB


ber = zeros(size(snrRange)); % Bit Error Rate array
% Generate random binary data
data = randi([0 1], numBits, 1);
% Map bits to QAM symbols
dataSymbols = reshape(data, [], k); % Group bits into k-bit symbols
symbolIndices = bi2de(dataSymbols, 'left-msb'); % Convert bit groups to decimal
qamSymbols = qammod(symbolIndices, M, 'UnitAveragePower', true); % QAM modulation
% Analyze BEP for each SNR
for idx = 1:length(snrRange)
    snr = snrRange(idx);
    % Add AWGN
    noisySymbols = awgn(qamSymbols, snr, 'measured');
  % Demodulate received symbols
    receivedIndices = qamdemod(noisySymbols, M, 'UnitAveragePower', true);
    receivedBits = de2bi(receivedIndices, k, 'left-msb'); % Convert to bits
    receivedBits = receivedBits(:); % Reshape to a column vector
    % Calculate BER
    ber(idx) = sum(data ~= receivedBits) / numBits;
end


% Plot BEP vs SNR
figure;
semilogy(snrRange, ber, 'b-o', 'LineWidth', 1.5);
grid on;
title('Bit Error Probability (BEP) for 16-QAM');
xlabel('SNR (dB)');
ylabel('Bit Error Probability (BEP)');
legend('16-QAM');

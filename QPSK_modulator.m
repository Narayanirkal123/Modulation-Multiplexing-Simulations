clc;
clear all;
close all;
Tb = 1;


fc = 2; 
t_carrier = 0:Tb/100:Tb;
c = sqrt(2/Tb) * sin(2 * pi * fc * t_carrier); 
N = 8;
m = rand(1, N); 
t1 = 0; t2 = Tb; 
bpsk_signal = []; 
message_signal = [];
for i = 1:N
    t = t1:Tb/100:t2; 
    if m(i) > 0.5
        m(i) = 1;
        m_s = ones(1, length(t)); 
    else
        m(i) = 0;
        m_s = -1 * ones(1, length(t)); 
    end
    message_signal = [message_signal, m_s];
    bpsk_signal = [bpsk_signal, c .* m_s];
   

 subplot(5, 1, 2);
    axis([0 N -2 2]);
    plot(t, m_s, 'r');
    title('Message Signal (Polar Form)');
    xlabel('t --->');
    ylabel('m(t)');
    grid on;
    hold on;
    subplot(5, 1, 4);
    plot(t, c .* m_s);
    title('PSK Signal');
    xlabel('t --->');
    ylabel('s(t)');
    grid on;
    hold on;
    t1 = t1 + (Tb + 0.01);
    t2 = t2 + (Tb + 0.01);
end
hold off;


subplot(5, 1, 1);
stem(m, 'filled');
title('Binary Data Bits');
xlabel('n --->');
ylabel('b(n)');
grid on;
subplot(5, 1, 3);
plot(t_carrier, c);
title('Carrier Signal');
xlabel('t --->');
ylabel('c(t)');
grid on;
t1 = 0; t2 = Tb; 
demod = zeros(1, N); 
for i = 1:N
    t = t1:Tb/100:t2;
    bpsk_segment = bpsk_signal((i-1)*length(t_carrier) + 1:i*length(t_carrier)); 
    x = sum(c .* bpsk_segment);
    if x > 0
       

 demod(i) = 1; 
    else
        demod(i) = 0;
    end
    t1 = t1 + (Tb + 0.01);
    t2 = t2 + (Tb + 0.01);
end
subplot(5, 1, 5);
stem(demod, 'filled');
title('Demodulated Data');
xlabel('n --->');
ylabel('b(n)');
grid on;

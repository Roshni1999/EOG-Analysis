%% Horizontal EOG

load('roshnieogh.mat');
isi = 0.0001;
Fs = 1/isi;
eogh = data(:,1);
t = 0: 1: length(data) - 1;
time = t.*isi;

[b, a] = butter(2,[0.05/(Fs/2) 35/(Fs/2)],'bandpass'); %EOG: 0.05- 35Hz
eogh = filtfilt(b,a, eogh);                 %filtered signal

ind_signal = find(time > 1.44 & time <7.95);
time_h = time(ind_signal); eog_h = eogh(ind_signal);
L = length(eog_h);

figure(1);
plot(time_h, eog_h, 'LineWidth', 1); xlabel('Time (seconds)'); ylabel ('EOG sigal (mV) (Horizontal)')

Y = fft(eog_h);

P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;

figure(2)
plot(f,P1, 'Linewidth', 1); xlim([0 30])
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')



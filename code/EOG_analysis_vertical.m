%% Vertical EOG

load('roshnieoghv.mat');
isi = 0.0001;
Fs = 1/isi;
eogv = data(:,1);
t = 0: 1: length(data) - 1;
time = t.*isi;

[b, a] = butter(2,[0.05/(Fs/2) 35/(Fs/2)],'bandpass'); %EOG: 0.05- 35Hz
eogv = filtfilt(b,a, eogv);                 %filtered signal

ind_signal = find(time > 12.09 & time <16.8);
%ind_signal = find(time > 0 & time <8.9);
time_v = time(ind_signal); eog_v = eogv(ind_signal);
L = length(eog_v);

figure(1);
plot(time_v, eog_v, 'LineWidth', 1); xlabel('Time (seconds)'); ylabel ('EOG sigal (mV) (Vertical)')

Y = fft(eog_v);

P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;

figure(2)
plot(f,P1, 'Linewidth', 1); xlim([0 30])
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')

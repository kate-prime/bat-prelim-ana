subplot(3,3,4)
spectrogram([stim.LD_00echo_10msdelay; buffer],2^8,(2^8)-1,2^8,fs,'MinThreshold',-60,'power','yaxis');
colorbar('off')
xlim([0 40])
subplot(3,3,5)
spectrogram([stim.LD_45echo_10msdelay; buffer],2^8,(2^8)-1,2^8,fs,'MinThreshold',-60,'power','yaxis');
colorbar('off')
xlim([0 40])
subplot(3,3,6)
spectrogram([stim.LD_90echo_10msdelay; buffer],2^8,(2^8)-1,2^8,fs,'MinThreshold',-60,'power','yaxis');
colorbar('off')
xlim([0 40])
subplot(3,3,1)
hold on
x=stim.LD_00echo_10msdelay;
Fs = 250E3;
N = length(x);
xdft = fft(x);
xdft = xdft(1:N/2+1);
psdx = (1/(Fs*N)) * abs(xdft).^2;
psdx(2:end-1) = 2*psdx(2:end-1);
freq = 0:Fs/length(x):Fs/2;
yy=smooth(10*log10(psdx),15);
plot(xx,yy,'Linewidth',2)
xlabel('Frequency (kHz)')
ylabel('Power/Frequency(dB/Hz)')

x=stim.LD_45echo_10msdelay;
subplot(3,3,2)
hold on
Fs = 250E3;
N = length(x);
xdft = fft(x);
xdft = xdft(1:N/2+1);
psdx = (1/(Fs*N)) * abs(xdft).^2;
psdx(2:end-1) = 2*psdx(2:end-1);
freq = 0:Fs/length(x):Fs/2;
yy=smooth(10*log10(psdx),15);
xx=freq/1000;
plot(xx,yy,'Linewidth',2)
xlabel('Frequency (kHz)')
ylabel('Power/Frequency(dB/Hz)')
x=stim.LD_90echo_10msdelay;

subplot(3,3,3)
hold on
Fs = 250E3;
N = length(x);
xdft = fft(x);
xdft = xdft(1:N/2+1);
psdx = (1/(Fs*N)) * abs(xdft).^2;
psdx(2:end-1) = 2*psdx(2:end-1);
freq = 0:Fs/length(x):Fs/2;
yy=smooth(10*log10(psdx),15);
xx=freq/1000;
plot(xx,yy,'Linewidth',2)
xlabel('Frequency (kHz)')
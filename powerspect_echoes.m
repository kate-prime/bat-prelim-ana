function [yy,xx]=powerspect_echoes(x,idx,modifier)
figure(idx)

hold on
Fs = 250E3;
N = length(x);
xdft = fft(x);
xdft = xdft(1:N/2+1);
psdx = (1/(Fs*N)) * abs(xdft).^2;
psdx(2:end-1) = 2*psdx(2:end-1);

freq = 0:Fs/length(x):Fs/2;
%plot(freq/1000,modifier(smooth(10*log10(psdx),15)),'Linewidth',2)
yy=modifier(smooth(10*log10(psdx),15));
xx=freq/1000;
plot(xx,yy,'Linewidth',2)
grid on

xlabel('Frequency (kHz)','FontSize', 15)

ylabel('Power/Frequency(dB/Hz)','FontSize', 15)

legend({'cylinder','cube','Large dipole','Small dipole','small sphere'}, 'FontSize', 10);
set(gcf, 'color', 'white','Position',[100 100 615 450]);
set(gca,'FontSize',15,'LineWidth',1.5,'Tickdir','out');
title('Power spectrum','FontSize', 20)
%title('Power spectrum of echoes','FontSize', 20)
% title('Frequency response','FontSize', 20)
legend boxoff 
xlim([20,80])
%ylim([-120,-30]) %for good figure
grid off
end
function y =reduceOverNoise(v)
    v_temp = v(v>-80);
    v_temp = v_temp+80;
    v_temp = v_temp*0.7;
    v_temp = v_temp-80;
    v(v>-80)=v_temp;
    y=v;
end



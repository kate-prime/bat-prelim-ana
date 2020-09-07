

function [yy,xx]=plotPower(x,modifier)



Fs = 250E3;
N = length(x);
xdft = fft(x);
xdft = xdft(1:N/2+1);
psdx = (1/(Fs*N)) * abs(xdft).^2;
psdx(2:end-1) = 2*psdx(2:end-1);

freq = 0:Fs/length(x):Fs/2;
yy=modifier(smooth(10*log10(psdx),15));
xx=freq/1000;
plot(xx,yy,'r','Linewidth',2)
grid on

xlabel('Frequency (kHz)')

ylabel('Power/Frequency(dB/Hz)')

title('Power spectrum')
legend off 
xlim([0,100])

end
function y =reduceOverNoise(v)
    v_temp = v(v>-80);
    v_temp = v_temp+80;
    v_temp = v_temp*0.7;
    v_temp = v_temp-80;
    v(v>-80)=v_temp;
    y=v;
end

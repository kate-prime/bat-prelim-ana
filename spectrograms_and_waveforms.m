%you need to pick the stim you want 

[fname, fpath]=uigetfile; %load your stim
load([fpath,fname])

stimname='stim.cube_10echo15msdelay';%change by hand

shape=eval(stimname);

shapename=strsplit(stim_name,'_');
object=shapename{1}(6:end);
clutter=shapename{2}(1:2);
delay=shapename{2}(7:end);


t=0:1/250:length(shape)/250;
figure
subplot(2,1,1)
plot(t(1:end-1),shape)
%[x,~]=ginput
title([object,' - ',clutter ' Clutter - ',delay])%you'll need to put "Angle" here instead of clutter
subplot(2,1,2)
spectrogram(shape,2^8,(2^8)-1,2^8,250e3,'yaxis')
% a=500
% spectrogram(shape(x(1)+a:x(1)+a+3750),2^8,(2^8)-1,2^8,250e3,'yaxis')
colorbar('Off')

caxis([-80 -50])
ylim([0 115])

saveas(gcf,['D:\AngieDrive\Bats\NSF shapes project\ONRmay2019\',object,'_',clutter,' Clutter_',delay,'.png']) %you'll need to put "Angle" here instead of clutter

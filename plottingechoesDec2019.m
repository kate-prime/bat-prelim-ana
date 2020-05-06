%load('/Users/angie/Google Drive/Bats/NSF shapes project/echoes20191219.mat')
close all

object='cube';
for idx1=1:10
    cluttercond= {'no','10','20','40'};
    orient=num2str(idx1);
   f = figure(idx1);
f.WindowState = 'maximized';
    for idx2=1:4
        plotloc={[1,2,3],[4,5,6],[7,8,9],[10 11 12]};
        
       stimname=[object,'_',cluttercond{idx2},'Clut_',orient];
       if ~strcmp(fieldnames(compiled),stimname)
           continue
       end
       stim=compiled.(stimname).MIC1;
        
       [pks,locs] = findpeaks(stim,'MinPeakHeight',0.8);
       windowStart=locs(1)-0.05e5;
        stimuli=stim(windowStart:windowStart+0.1e5);
        
        
        %waveform
        subplot (4,3,plotloc{idx2}(1))
        plot(stimuli)
        
        title([object,'',orient,' ',cluttercond{idx2}])
        ylim([-2 2])
        
        %spectrogram
        subplot (4,3,plotloc{idx2}(2))
        spectrogram(stimuli,2^8,(2^8)-1,2^8,250e3,'yaxis')
        caxis([-120 -60])
        colorbar off
        
        %power
        subplot (4,3,plotloc{idx2}(3))
        [yy,xx]=plotPower(stimuli,@(x)x);
        ylim([-120 -50])
        
    end
    saveas(gcf,['/Users/angie/Google Drive/Bats/NSF shapes project/Neural_stim_figs/NewECHOES_',object,'_',orient,'.png'])
end

%%



    
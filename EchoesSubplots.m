load('clutter_v2.mat')
close all

object={'cyl','cube','sphere', 'LD' ,'SD','MP'};
for idx1=1:size(object,2)
    cluttercond= {'00','10','20'};
    figure
    for idx2=1:size(cluttercond,2)
        plotloc={[1,2,3],[4,5,6],[7,8,9]};
        
        stimname=['echo_',object{idx1},'_',cluttercond{idx2},'echo_10msdelay'];
        stimuli=stim.(stimname)(3000:5000);
        
        %waveform
        subplot (3,3,(idx2-1)*3+1)
        plot(stimuli)
        xlim([0 2000])
        title([object{idx1},' ',cluttercond{idx2}])
        ylim([-1 1])
        
        %spectrogram
        subplot (3,3,(idx2-1)*3+2)
        spectrogram(stimuli,2^8,(2^8)-1,2^8,250e3,'yaxis')
        caxis([-120 -60])
        colorbar off
        
        %power
        subplot (3,3,(idx2-1)*3+3)
        [yy,xx]=plotPower(stimuli,@(x)x);
        ylim([-120 -50])
        
    end
    saveas(gcf,['/Users/angie/Google Drive/Bats/NSF shapes project/neural_stim',object{idx1},'_',cluttercond{idx2},'.png'])
end

%%



    
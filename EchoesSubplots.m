load('3D_v2.mat')
close all

object={'cyl','cube','sphere', 'LD' ,'SD','MP'};
for idx1=1:size(object,2)
    cluttercond= {'00','45','90'};
    figure
    for idx2=1:size(cluttercond,2)
        plotloc={[1,2,3],[4,5,6],[7,8,9]};
        
        stimname=[object{idx1},'_',cluttercond{idx2},'echo_10msdelay'];
       
        if sum(strcmp(fieldnames(stim),stimname))==0
            continue
        end
        
        stimuli=stim.(stimname);
        %stimuli=stim.(stimname)(3000:5000); %this is for just the echoes
        
        %waveform
        subplot (3,3,(idx2-1)*3+1)
        plot(stimuli)
        %xlim([0 2000])
        title([object{idx1},' ',cluttercond{idx2}])
        %ylim([-1 1])
        
        %spectrogram
        subplot (3,3,(idx2-1)*3+2)
        spectrogram(stimuli,2^8,(2^8)-1,2^8,250e3,'yaxis')
        caxis([-85 -60])
        colorbar off
        
        %power
        subplot (3,3,(idx2-1)*3+3)
        [yy,xx]=plotPower(stimuli,@(x)x);
        %ylim([-120 -50])
        
    end
    saveas(gcf,['/Users/angie/Google Drive/Bats/NSF shapes project/Neural_stim_figs/neural_stim_3D_',object{idx1},'_',cluttercond{idx2},'.png'])
end

%%



    
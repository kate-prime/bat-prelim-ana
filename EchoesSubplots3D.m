%load('3D_v2.mat')
close all

object={'cyl','cube', 'LD' ,'SD'};
for idx1=1:size(object,2)
    cluttercond= {'00','45','90'};
    fig=figure;
    fig.Position=[10 10 900 800];
    for idx2=1:size(cluttercond,2)
        plotloc={[1,2,3],[4,5,6],[7,8,9]};
        
        stimname=['echo_',object{idx1},'_',cluttercond{idx2},'echo_10msdelay'];
       
        if sum(strcmp(fieldnames(stim),stimname))==0
            continue
        end
        
        stimuli=stim.(stimname);
        %stimuli=stim.(stimname)(3000:5000); %this is for just the echoes
        
        %waveform
        subplot (3,3,(idx2-1)*3+1)
        t=(1:length(stimuli))./250;
        plot(t,stimuli)
        xlim([0 29])
        title([object{idx1},' ',cluttercond{idx2}])
        ylim([-1 1])
        xlabel('Time (ms)')
        
        %spectrogram
        subplot (3,3,(idx2-1)*3+2)
        spectrogram(stimuli,2^8,(2^8)-1,2^8,250e3,'yaxis','power')
        caxis([-80 0])
        %colorbar off
        %colormap('jet')
        
        %power
        subplot (3,3,(idx2-1)*3+3)
        [yy,xx]=plotPower(stimuli,@(x)x);
        ylim([-120 -50])
        
    end
    %saveas(gcf,['/Users/angie/Google Drive/Bats/NSF shapes project/Neural_stim_figs/neural_stim_',object{idx1},'_',cluttercond{idx2},'.png'])
end

%%



    
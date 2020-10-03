load('cluster_id.mat')
POP=2;%choose the correct POPULATION

catUnits=idbox(find(cell2mat(idbox(:,1))==POP),2);
path=uigetdir; %now need to fish out from sorted?
BFcolAmp=[];
BFcolabs=[];
BFcol70=[];
for idx=1:size(catUnits,1)
    
    neuronInfo=strsplit(catUnits{idx},'_');
    date=neuronInfo{1}(1:8);
    depthChn=strsplit(neuronInfo{2},'C');
    depth=depthChn{1};
    Chn=['C',depthChn{2}];
    WavClust=neuronInfo{3};
    
    neuron2fish=([path,'\',date,'\Clut_',depth,'\',Chn,'_',WavClust,'_neuron.mat']);
    load(neuron2fish)
     if ~exist('trials_FT','var')
        continue
    end
    %trials FT is sorted as frq 20 to 90 steps of 5 at differnet dbs 20-70 in steps of 10, so first 15 are 20kHz at 20 dBs, columns 16 to 30 are 20khz at 30dBs, columns 31 to 45 are 20kHz at 40dBs etc
    neuronname=[date,'_',depth,'_',Chn,'_unit',WavClust]
    Freq=[20:5:90];
    Freqtemp=[];
    for idxb=20:5:90
        Freqtemp=[Freqtemp,repmat(idxb,[1,6])];
    end
    
    Amptemp=repmat([20:10:70],[1,15]);
    
    spknumbFT=[Freqtemp;Amptemp];
    spknumbtemp=[];
    for idx2=1:15:(size(trials_FT,2)-1)
        tempspk=trials_FT(:,idx2:idx2+14);
        spknumbtemp=[spknumbtemp,sum(sum(~isnan(tempspk)))];
    end
    spknumbFT=[spknumbFT;spknumbtemp];
    temp=reshape(spknumbFT(3,:),6,15);
    imagesc(temp)
    
    yticklabels([20:10:70])
    ylabel('Amplitude (dBs)')
    xticks(1:15)
    xticklabels([20:5:90])
    xlabel('Frequency (kHz)')
    colormap('parula')
    title(strrep(neuronname,'_',' '))
    
    %saveas(gcf,['W:\Kate\KA001\FTheatmaps\POP',num2str(POP),'\',neuronname,'.png'])
    
    
    
    
    temp2=sum(temp,1);
    BFidx=find(temp2 == max(temp2(:)));
    BF=Freq(BFidx);
    if length(BF)<2
        
        BFnD=[BF,str2num(depth)]
        BFcolAmp=[BFcolAmp;BFnD]; %summing spikes across dBs
        
        [BFidxabs,id]=(max(max(temp)));
        BFabs=Freq(id);
        BFnD2=[BFabs,str2num(depth)]
        BFcolabs=[BFcolabs;BFnD2];%best freq regardless of dBs
        
        temp3=temp(6,:);
        BF70temp=find(temp3==max(temp3));
        BF70=Freq(BF70temp)
        if length(BF70)<2
            BF70nD=[BF70,str2num(depth)];
            BFcol70=[BFcol70;BF70nD];%best freq at 70dBs
        else
            continue
        end
    else
        continue
    end
end
figure
histogram(BFcolAmp(:,1),15)
xlabel('BF (kHz)')
ylabel('Number of neurons')
title('BF as a sum across Amplitudes')
figure
scatter(BFcolAmp(:,1),BFcolAmp(:,2))
xlabel('BF (kHz)')
ylabel('Depth')
title('BF as a sum across Amplitudes')

figure
histogram(BFcolabs(:,1),15)
xlabel('BF (kHz)')
ylabel('Number of neurons')
title('BF absolute')
figure
scatter(BFcolabs(:,1),BFcolabs(:,2))
xlabel('BF (kHz)')
ylabel('Depth')
title('BF absolute')

figure
histogram(BFcol70(:,1),15)
xlabel('BF (kHz)')
ylabel('Number of neurons')
title('BF at 70 dBs')
figure
scatter(BFcol70(:,1),BFcol70(:,2))
xlabel('BF (kHz)')
ylabel('Depth')
title('BF at 70dBs')


%%


load('clutter_v2.mat')
cyl=stim.cyl_00echo_10msdelay(3750:end);
cube=stim.cube_00echo_10msdelay(3750:end);
LD=stim.LD_00echo_10msdelay(3750:end);
SD=stim.SD_00echo_10msdelay(3750:end);
MP=stim.MP_00echo_10msdelay(3750:end);


[cylE,xx]=powerspect_echoes(cyl,96,@(x)x);
cubeE=powerspect_echoes(cube,96,@(x)x);
LDE=powerspect_echoes(LD,96,@(x)x);
SDE=powerspect_echoes(SD,96,@(x)x);
MPE=powerspect_echoes(MP,96,@(x)x);

%%

[cylE,xx]=powerspect_echoes(cyl,98,@(x)x);
cubeE=powerspect_echoes(cube,98,@(x)x);
LDE=powerspect_echoes(LD,98,@(x)x);
SDE=powerspect_echoes(SD,98,@(x)x);
MPE=powerspect_echoes(MP,98,@(x)x);
 yyaxis right
 histogram(BFcolabs(:,1),15)
 %histogram(BFcol70(:,1),15)
 %histogram(BFcolAmp(:,1),15)
ylabel('Number of neurons')
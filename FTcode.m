load('idbox.mat')

catUnits=idbox(find(cell2mat(idbox(:,1))==2),2);

%now need to fish out from uncat
for idx=1:1%size(catUnits,1)

    neuronInfo=strsplit(catUnits{idx},'_');
    date=neuronInfo{1}(1:8);
    depthChn=strsplit(neuronInfo{2},'C');
    depth=depthChn{1};
    Chn=['C',depthChn{2}];
    WavClust=neuronInfo{3};
    
end
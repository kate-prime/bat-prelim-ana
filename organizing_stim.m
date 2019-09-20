matFile = ['E:\Angie\Bats\NSF shapes project\neural_stim\clutterstim','.mat'];
load(matFile);

stim_names=fieldnames(stim);

stim_clutter=zeros(7500,length(fieldnames(stim)));%carful 7500 is hardcoded and all stimuli are the same. lazy to generalize

for idx=1:length(fieldnames(stim));
    current_stim=stim.(stim_names{idx});
    stim_clutter(:,idx)=current_stim;
end
  

save('E:\Angie\Bats\NSF shapes project\neural_stim\clutterstim_org.mat','stim_clutter');
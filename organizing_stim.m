matFile = ['E:\Angie\Bats\NSF shapes project\neural_stim\clutterstim','.mat'];
load(matFile);
% I cheated a bit cause I changed the 0 for 00 and the 5 for 05 in the stim
% names. next time I make stim I'll just add _ between pieces of
% information

stim_names=fieldnames(stim);

stim_clutter=zeros(7500,length(fieldnames(stim)));%carful 7500 is hardcoded and all stimuli are the same. lazy to generalize

for idx=1:length(fieldnames(stim))
    current_stim=stim.(stim_names{idx});
    stim_clutter(:,idx)=current_stim;
end


for idx2=1:length(fieldnames(stim))
    stim_names=(fieldnames(stim));
    broken_name=strsplit(stim_names{idx2},'_')
    objects={'cyl','cube','sphere','LD','SD','MP'};
    
    if strcmp(broken_name{1,1},'AMP')
       %1st column is delay of echo
        infoname=broken_name{1,3};
        stim_data(idx2,1)=str2num(infoname(end-8:end-7));
        % second colum is shape identity
        for idx3=1:length(objects)
            if strcmp(broken_name{1,2},objects{idx3})
                stim_data(idx2,2)=idx3+6;
            end
        end
        %third column is clutter distance
        stim_data(idx2,3)=str2num(infoname(1:2));
    else
        %1st column is delay of echo
        infoname=broken_name{1,2};
        stim_data(idx2,1)=str2num(infoname(end-8:end-7));
        % second colum is shape identity
        for idx3=1:length(objects)
            if strcmp(broken_name{1,1},objects{idx3})
                stim_data(idx2,2)=idx3;
            end
        end
        %third column is clutter distance
         stim_data(idx2,3)=str2num(infoname(1:2))
    end
    
    
end
    save('E:\Angie\Bats\NSF shapes project\neural_stim\clutterstim_org.mat','stim_clutter','stim_data');
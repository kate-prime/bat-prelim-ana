function wrapper_clutter_2(versionX)
figure(99)

heatcombined=[];

close all
[dates] = datesOrga(versionX);
%a wrapper for automating secondary ana
[stim_data,shapes] = make_stim_data();
idxNeuron=0;

for i_date = 1 : length(dates)
    date= num2str(dates(i_date));
    folder_dir=dir(['W:\Kate\KA001\Analyzed\',date]);
    %    folder_dir=dir(['E:\Angie data\shapes project\badlywavedclused\Analyzed\',date]); %NEEDTOGO
    for i_dep=1:length(folder_dir)
        depth= folder_dir(i_dep).name;
        
        if depth(1)=='.' || depth(1) == 'F' || depth(1) == '3' %for weird empty folders
            continue
        end
        %        file_dir=dir(['E:\Angie data\shapes project\badlywavedclused\Analyzed\',date,'\',depth,'\*.mat']);%NEEDTOGO
        file_dir=dir(['W:\Kate\KA001\Analyzed\',date,'\',depth,'\*.mat']);
        for i_data=1:size(file_dir,1)
            %             cd(['E:\Angie data\shapes project\badlywavedclused\Analyzed\',date,'\',depth])%NEEDTOGO
            % cd(['W:\Kate\KA001\Analyzed\',date,'\',depth])
            fname=file_dir(i_data,1);
            load([file_dir(i_data).folder,'\', fname.name],'spike_data');
            if strcmp(versionX,'V1')
                stim_data=stim_data(1:34,:);%Hardcoded 34 becasue hopefully in the future we won't have versions with a different number if its the same stimulus set.
            end
            disp([file_dir(i_data).folder,'\', file_dir(i_data).name])%can be removed, but lets me keep track
            [h1, h2, h3, pref_delay, pref_obj, pref_clutter_distance,means, use]=second_ana_clut(spike_data,stim_data, shapes);
            
            idxNeuron = idxNeuron + 1;
            nameLookup{idxNeuron,1} = [file_dir(i_data).folder,'\', fname.name];
            [~, heatcombined]=spikePOPclutter(spike_data,stim_data,heatcombined,idxNeuron,shapes);
            if use==1
                %
                %                 saveas(h1,['E:\Angie data\shapes project\Figures\',date,'_',depth,'_',fname.name(1:end-4) '_spike_count.png'])
                %                 saveas(h2,['E:\Angie data\shapes project\Figures\',date,'_',depth,'_',fname.name(1:end-4) '_jitter.png'])
                %                 saveas(h3,['E:\Angie data\shapes project\Figures\',date,'_',depth,'_',fname.name(1:end-4) '_all_fr.png'])
                save([file_dir(i_data).folder,'\', fname.name],'pref_delay','pref_obj','pref_clutter_distance','means','use','-append');
                %[f1]=delaysortedfigs_Angie(fname.name);
                %                 saveas(f1,['E:\Angie data\shapes project\Figures\',date,'_',depth,'_',fname.name(1:end-4),'_delay_sorted.png'])
            elseif use==0
                save([file_dir(i_data).folder,'\', fname.name],'use','-append');
            end
            
            
        end
    end
end
heatcombined([69:79, 87:93], :) = [];
heatcombined_noecho_noAMP=heatcombined(:,[7:11,24]);
heatcombined(:,sum(heatcombined)==0)=[];

close all

figure(100)

imagesc(heatcombined)
title('pre rearrangement')
xlabel('object')
ylabel('neuron')
heatcombined_sorted = colorSortingBySimilarity(heatcombined);
figure
imagesc(heatcombined_sorted);
title('after rearrangement')
xlabel('object')
ylabel('neuron')
figure
imagesc(heatcombined_noecho_noAMP);

heatcombined_noecho_noAMP_sorted = colorSortingBySimilarity(heatcombined_noecho_noAMP);
figure
imagesc(heatcombined_noecho_noAMP_sorted);
% saveas(s,['E:\Angie data\shapes project\Figures\POPspikes.png'])
end
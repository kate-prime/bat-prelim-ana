

function wrapper_clutter_2(versionX)
close all

[dates] = datesOrga(versionX);
%a wrapper for automating secondary ana

load('E:\Angie\Bats\NSF shapes project\neural_stim\clutterstim_org.mat','stim_data');

for i_date = 1 : length(dates)
    date= num2str(dates(i_date));
    folder_dir=dir(['E:\Angie\Bats\NSF shapes project\neural_data_2019\clutter_stim\Analyzed\',date]);
    for i_dep=1:length(folder_dir)
        depth= folder_dir(i_dep).name;
        
        if depth(1)=='.' || depth(1) == 'F' %for weird empty folders
            continue
        end
        file_dir=dir(['E:\Angie\Bats\NSF shapes project\neural_data_2019\clutter_stim\Analyzed\',date,'\',depth,'\*.mat']);
        for i_data=1:size(file_dir,1)
            cd(['E:\Angie\Bats\NSF shapes project\neural_data_2019\clutter_stim\Analyzed\',date,'\',depth])
            fname=file_dir(i_data,1);
            load([file_dir(i_data).folder,'\', file_dir(i_data).name],'spike_data');
            if versionX=='V1'
                stim_data=stim_data(1:34,:);%Hardcoded 34 becasue hopefully in the future we won't have versions with a different number if its the same stimulus set.
            end
            disp([file_dir(i_data).folder,'\', file_dir(i_data).name])%can be removed, but lets me keep track
            [h1,h2,h3,pref_delay,pref_obj,pref_clutter_distance,means,use]=second_ana(spike_data,stim_data);
            if use==1
                saveas(h1,['G:\Angie data\shapes project\Figures\',date,'_',depth,'_',fname.name(1:end-4) '_spike_count.png'])
                saveas(h2,['G:\Angie data\shapes project\Figures\',date,'_',depth,'_',fname.name(1:end-4) '_jitter.png'])
                saveas(h3,['G:\Angie data\shapes project\Figures\',date,'_',depth,'_',fname.name(1:end-4) '_all_fr.png'])
                save(fname.name,'pref_delay','pref_obj','pref_clutter_distance','means','use','-append');
            elseif use==0
                 save(fname.name,'use','-append');
            end
            close all
            
        end
    end
end
end
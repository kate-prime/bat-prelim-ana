

function wrapper_clutter_2(versionX)
close all

[dates] = datesOrga(versionX);
%a wrapper for automating secondary ana

load("W:\Kate\KA001\stimuli\clutter_v2.mat");
fieldN = fieldnames(stim);
fieldN_split =cellfun(@(x){strsplit(x,'_')}, fieldN);
for idx = 1 : length(fieldN_split)
    stim_data{idx,2} = strjoin(fieldN_split{idx}(1:end-2),'');
    stim_data{idx,3} = str2num(fieldN_split{idx}{end-1}(1:2));
    stim_data{idx,1} = str2num(fieldN_split{idx}{end}(1:2));
end
[shapes,~,ic] = unique(stim_data(:,2));
stim_data(:,4) = arrayfun(@(x){x},ic);
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
           cd(['W:\Kate\KA001\Analyzed\',date,'\',depth])
            fname=file_dir(i_data,1);
            load([file_dir(i_data).folder,'\', file_dir(i_data).name],'spike_data');
            if strcmp(versionX,'V1')
                stim_data=stim_data(1:34,:);%Hardcoded 34 becasue hopefully in the future we won't have versions with a different number if its the same stimulus set.
            end
            disp([file_dir(i_data).folder,'\', file_dir(i_data).name])%can be removed, but lets me keep track
            [h1,h2,h3,pref_delay,pref_obj,pref_clutter_distance,means,use]=second_ana_clut(spike_data,stim_data, shapes);
            if use==1
                
%                 saveas(h1,['E:\Angie data\shapes project\badlywavedclused\Figures\',date,'_',depth,'_',fname.name(1:end-4) '_spike_count.png'])%NEEDTOGO
%                 saveas(h2,['E:\Angie data\shapes project\badlywavedclused\Figures\',date,'_',depth,'_',fname.name(1:end-4) '_jitter.png'])%NEEDTOGO
%                 saveas(h3,['E:\Angie data\shapes project\badlywavedclused\Figures\',date,'_',depth,'_',fname.name(1:end-4) '_all_fr.png'])%NEEDTOGO
%                 save(fname.name,'pref_delay','pref_obj','pref_clutter_distance','means','use','-append');%NEEDTOGO
                         
                              
                saveas(h1,['E:\Angie data\shapes project\Figures\',date,'_',depth,'_',fname.name(1:end-4) '_spike_count.png'])
                saveas(h2,['E:\Angie data\shapes project\Figures\',date,'_',depth,'_',fname.name(1:end-4) '_jitter.png'])
                saveas(h3,['E:\Angie data\shapes project\Figures\',date,'_',depth,'_',fname.name(1:end-4) '_all_fr.png'])
                save(fname.name,'pref_delay','pref_obj','pref_clutter_distance','means','use','-append');
            elseif use==0
                 save(fname.name,'use','-append');
            end
            close all
            
        end
    end
end
end
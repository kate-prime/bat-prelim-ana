%a wrapper for automating prelim ana
function wrapper_clutter(versionX)
close all

[dates,~,~,subProws] = datesOrga(versionX);

% source_path='D:\AngieDrive\Bats\NSF shapes project\neural_data_2019\clutter_stim\Sorted\';
% dest_path='D:\AngieDrive\Bats\NSF shapes project\neural_data_2019\clutter_stim\Analyzed\';
source_path='E:\Angie data\shapes project\badlywavedclused\Sorted\';%NEEDTOGO
dest_path='E:\Angie data\shapes project\badlywavedclused\Analyzed\';%NEEDTOGO

for i_date = 1 : length(dates)
    date= num2str(dates(i_date));
    
    
    mkdir([dest_path,date])
    folder_dir=dir([source_path,date]);
    
    for i_dep=1:length(folder_dir)
        depth= folder_dir(i_dep).name;
        
        if depth(1)=='.' || depth(1) == 'F' %for weird empty folders
            continue
        end
        
        mkdir([dest_path,date,'\',depth]);
%         mkdir(['E:\Angie data\shapes project\rasters\']);
mkdir(['E:\Angie data\shapes project\badlywavedclused\rasters\']);%NEEDTOGO
        file_dir=dir([source_path,date,'\',depth,'\*.mat']);
        
        for i_data=1:size(file_dir,1)
            
            fname=file_dir(i_data,1).name;
            load([source_path,date,'\',depth,'\',fname],'trials_clutter','stimon_clutter');
            data=trials_clutter;
            call_onset=stimon_clutter';
            
            [spike_data,fig]=prelim_ana(fname,data,call_onset,5,30,20,subProws,1);
                                      
            %saveas(fig,['E:\Angie data\shapes project\rasters\',date,'_',depth,'_',fname(1:end-4) '_ras.png'])%avoid saving rasters on google drive
            saveas(fig,['E:\Angie data\shapes project\badlywavedclused\rasters\',date,'_',depth,'_',fname(1:end-4) '_ras.png'])%NEEDTOGO
            
            save([dest_path,date,'\',depth,'\',fname(1:end-4), '_prelim'],'spike_data')
            close all
            
        end
    end
end
end
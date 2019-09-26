%a wrapper for automating prelim ana
function wrapper_clutter_FT(versionX)
close all

[dates,~,~,~] = datesOrga(versionX);

source_path='E:\Angie\Bats\NSF shapes project\neural_data_2019\clutter_stim\Sorted\';
dest_path='E:\Angie\Bats\NSF shapes project\neural_data_2019\clutter_stim\Analyzed\FT\';

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
        %mkdir(['G:\Angie data\shapes project\rasters\']);
        file_dir=dir([source_path,date,'\',depth,'\*.mat']);
        
        for i_data=1:size(file_dir,1)
            
            fname=file_dir(i_data,1).name;
            load([source_path,date,'\',depth,'\',fname],'trials_FT','stimon_FT');
            data=trials_FT;
            call_onset=stimon_FT';
            
            [spike_data,fig]=prelim_ana(fname,data,call_onset,5,30,15,10,2);
                                      
            saveas(fig,['G:\Angie data\shapes project\rasters\FT\',date,'_',depth,'_',fname(1:end-4) '_ras.png'])%avoid saving rasters on google drive
            
            save([dest_path,date,'\',depth,'\',fname(1:end-4), '_prelim'],'spike_data')
            close all
            
        end
    end
end
end
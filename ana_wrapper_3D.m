%a wrapper for automating prelim ana
dates=[20190628 20190708 20190628 20190709 20190711 20190710]; 
home=('E:\')
for i_date = 1 : length(dates)
    date= num2str(dates(i_date));
    mkdir(['E:\KA001\Analyzed\',date])
    folder_dir=dir(['E:\KA001\Sorted\',date]);
    for i_dep=1:length(folder_dir)
        depth= folder_dir(i_dep).name;
        
        if depth(1)=='.' || depth(1) == 'F' %for weird empty folders
            continue
        end
        
        mkdir(['E:\KA001\Analyzed\',date,'\',depth]);
        file_dir=dir(['E:\KA001\Sorted\',date,'\',depth,'\clust\*.mat']);
        for i_data=1:size(file_dir,1)
            cd(['E:\KA001\Sorted\',date,'\',depth,'\clust'])
            fname=file_dir(i_data,1).name;
            load(fname,'trials_3D','stimon_3D');
            data=trials_3D;
            call_onset=stimon_3D';
            [spike_data,fig]=prelim_ana(fname,data,call_onset,5,30,20);
            cd(['E:\KA001\Analyzed\',date,'\',depth])
            savefig(fig,[fname(1:end-4) '_ras'])
            save([fname(1:end-4), '_prelim'],'spike_data')
            close all
            cd(home)
        end
    end
end
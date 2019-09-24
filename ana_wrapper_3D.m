%a wrapper for automating prelim ana
dates=20190909; 
home=('E:\');
for i_date = 1 : length(dates)
    date= num2str(dates(i_date));
    mkdir(['E:\KA001\Analyzed\',date])
    folder_dir=dir(['E:\KA001\Sorted\',date]);
    for i_dep=1:length(folder_dir)
        depth= folder_dir(i_dep).name;
        
        if length(depth(10:end))<3 %for weird empty folders
            continue
        end
        
        mkdir(['E:\KA001\Analyzed\',date,'\',depth]);
        file_dir=dir(['E:\KA001\Sorted\',date,'\',depth,'\','*.mat']);
        for i_data=1:size(file_dir,1)
            cd(['E:\KA001\Sorted\',date,'\',depth,'\'])
            fname=file_dir(i_data,1).name;
            load([file_dir(i_data).folder,'\', file_dir(i_data).name],'trials_3D','stimon_3D');
            disp([file_dir(i_data).folder,'\', file_dir(i_data).name]) %can be removed but makes sure I record what files are being loaded
            data=trials_3D;
            call_onset=stimon_3D';
            [fig,spike_data]=prelim_ana(fname,data,call_onset,5,30,10,20,10);
            cd(['E:\KA001\Analyzed\',date,'\',depth])
            savefig(fig,[fname(1:end-4) '_ras'])
            save([fname(1:end-4), '_prelim'],'spike_data')
            close all
            cd(home)
        end
    end
end
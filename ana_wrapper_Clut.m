%Last Touched by KA 20200229
%a wrapper for automating prelim ana
dates=datesOrga('V2');
%dates=[20200120];
home=('Z:\Kate\KA001');
for i_date = 1 : length(dates)
    date= num2str(dates(i_date));
    mkdir([home,'/Analyzed/',date])
    folder_dir=dir([home,'/Sorted/',date,'/All*']);
    for i_dep=1:length(folder_dir)
        depth= folder_dir(i_dep).name;
        
        if length(depth)<3 
            continue
        end
        
        mkdir([home,'/Analyzed/',date,'/',depth]);
        file_dir=dir([home,'/Sorted/',date,'/',depth,'/*.mat']);
        for i_data=1:size(file_dir,1)
            cd([home,'/Sorted/',date,'/',depth,'/'])
            fname=file_dir(i_data,1).name;
            load([file_dir(i_data).folder,'/', file_dir(i_data).name],'trials_clutter','stimon_clutter','stim_reps_clutter');
            disp([file_dir(i_data).folder,'/', file_dir(i_data).name]) %can be removed but makes sure I record what files are being loaded
            data=trials_clutter;
            call_onset=stimon_clutter';
            subrows=10;
            [spike_data]=prelim_ana(fname,data,call_onset,5,40,40,20,subrows);% lets use datesOrga
            cd([home,'/Analyzed/',date,'/',depth])
            %saveas(fig,[fname(1:end-4) '_ras.png'])
            save([fname(1:end-4), '_prelim3'],'spike_data')
            close all
            cd(home)
        end
    end
end

%a wrapper for making psth figures for clutter conditions

dates=datesOrga('V4');

home=('Z:\Kate\KA001');
for i_date = 1 : length(dates)
    date= num2str(dates(i_date));
    folder_dir=dir([home,'/Analyzed/',date,'/Clut*']);
    for i_dep=1:length(folder_dir)
        depth= folder_dir(i_dep).name;
        
        if length(depth)<3 
            continue
        end
        file_dir=dir([home,'/Analyzed/',date,'/',depth,'/*_prelim.mat']);
        for i_data=1:size(file_dir,1)
            cd([home,'/Analyzed/',date,'/',depth,'/'])
            fname=file_dir(i_data,1).name;
            load([file_dir(i_data).folder,'/', file_dir(i_data).name],'spike_data');            
            disp([file_dir(i_data).folder,'/', file_dir(i_data).name]) %can be removed but makes sure I record what files are being loaded
            trials=spike_data.spike_times;
            sr=1000;
            [fig,groups]=makepsth(trials,sr,20);
            save([fname(1:end-4),'_psth'],'groups');
            saveas(fig,[fname(1:end-4) '_psth.png'])
            close all
        end
    end
end
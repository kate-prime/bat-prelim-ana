%a wrapper for automating secondary ana
dates=[ 20190709 20190711 20190710]; %20190628 20190708 20190628
home=('E:\');
cd('E:\KA001\stimuli')
load('3Dstim.mat','stim_data');
for i_date = 1 : length(dates)
    date= num2str(dates(i_date));
    folder_dir=dir(['E:\KA001\Analyzed\',date]);
    for i_dep=1:length(folder_dir)
        depth= folder_dir(i_dep).name;
        
        if depth(1)=='.' || depth(1) == 'F' %for weird empty folders
            continue
        end
        file_dir=dir(['E:\KA001\Analyzed\',date,'\',depth,'\*.mat']);
        for i_data=1:size(file_dir,1)
            cd(['E:\KA001\Analyzed\',date,'\',depth])
            fname=file_dir(i_data,1);
            load([file_dir(i_data).folder,'\', file_dir(i_data).name],'spike_data');
            disp([file_dir(i_data).folder,'\', file_dir(i_data).name])%can be removed, but lets me keep track
            [h1,h2,h3,pref_delay,pref_obj,pref_ang,means,use]=second_ana(spike_data,stim_data);
            if use==1
                savefig(h1,[fname.name(1:end-4) '_spike_count'])
                savefig(h2,[fname.name(1:end-4) '_jitter'])
                savefig(h3,[fname.name(1:end-4) '_all_fr'])
                save(fname.name,'pref_delay','pref_obj','pref_ang','means','use','-append');
            elseif use==0
                 save(fname.name,'use','-append');
            end
            close all
            cd(home)
        end
    end
end
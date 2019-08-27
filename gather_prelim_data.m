dates=[20190628 20190708 20190628 20190709 20190711 20190710]; 
home=('E:\KA001\');

by_delay=struct;
by_obj=struct;
by_angle=struct;

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
            load([file_dir(i_data).folder,'\', file_dir(i_data).name],'use')
            if use==1
              load([file_dir(i_data).folder,'\', file_dir(i_data).name])
              if pref_delay==5
                  by_delay.five.name(size(delay.five.name,1)+1,:)=([date,' ',depth,' ',fname.name]);
                  by_delay.five.count(size(delay.five.count,1)+1,:)=spike_data.count';
                  by_delay.five.jitter(size(delay.five.jitter,1)+1,:)=spike_data.jitter';
              elseif pref_delay==10
                  by_delay.ten.name(size(delay.ten.name,1)+1,:)=([date,' ',depth,' ',fname.name]);
                  by_delay.ten.count(size(delay.ten.count,1)+1,:)=spike_data.count';
                  by_delay.ten.jitter(size(delay.ten.jitter,1)+1,:)=spike_data.jitter';
              elseif pref_delay==15
                  by_delay.fifteen.name(size(delay.fifteen.name,1)+1,:)=([date,' ',depth,' ',fname.name]);
                  by_delay.fifteen.count(size(delay.fifteen.count,1)+1,:)=spike_data.count';
                  by_delay.fifteen.jitter(size(delay.fifteen.jitter,1)+1,:)=spike_data.jitter';
              end
              if pref_angle==0
                  by_angle.zero.name(size(angle.zero.name,1)+1,:)=([date,' ',depth,' ',fname.name]);
                  by_angle.zero.count(size(angle.zero.count,1)+1,:)=spike_data.count';
                  by_angle.zero.jitter(size(angle.zero.jitter,1)+1,:)=spike_data.jitter';
              elseif pref_angle==45
                  by_angle.fortyfive.name(size(angle.fortyfive.name,1)+1,:)=([date,' ',depth,' ',fname.name]);
                  by_angle.fortyfive.count(size(angle.fortyfive.count,1)+1,:)=spike_data.count';
                  by_angle.fortyfive.jitter(size(angle.fortyfive.jitter,1)+1,:)=spike_data.jitter';
              elseif pref_angle==90
                  by_angle.ninety.name(size(angle.ninety.name,1)+1,:)=([date,' ',depth,' ',fname.name]);
                  by_angle.ninety.count(size(angle.ninety.count,1)+1,:)=spike_data.count';
                  by_angle.ninety.jitter(size(angle.ninety.jitter,1)+1,:)=spike_data.jitter';
              end
              if strcmp('cyl',pref_obj)==1
                  by_obj.cyl.name(size(obj.cyl.name,1)+1,:)=([date,' ',depth,' ',fname.name]);
                  by_obj.cyl.count(size(obj.cyl.count,1)+1,:)=spike_data.count';
                  by_obj.cyl.jitter(size(obj.cyl.jitter,1)+1,:)=spike_data.jitter';
              elseif strcmp('cube',pref_obj)==1
                  by_obj.cube.name(size(obj.cube.name,1)+1,:)=([date,' ',depth,' ',fname.name]);
                  by_obj.cube.count(size(obj.cube.count,1)+1,:)=spike_data.count';
                  by_obj.cube.jitter(size(obj.cube.jitter,1)+1,:)=spike_data.jitter';
              elseif strcmp('LD',pref_obj)==1
                  by_obj.LD.name(size(obj.LD.name,1)+1,:)=([date,' ',depth,' ',fname.name]);
                  by_obj.LD.count(size(obj.LD.count,1)+1,:)=spike_data.count';
                  by_obj.LD.jitter(size(obj.LD.jitter,1)+1,:)=spike_data.jitter';
              elseif strcmp('SD',pref_obj)==1
                  by_obj.SD.name(size(obj.SD.name,1)+1,:)=([date,' ',depth,' ',fname.name]);
                  by_obj.SD.count(size(obj.SD.count,1)+1,:)=spike_data.count';
                  by_obj.SD.jitter(size(obj.SD.jitter,1)+1,:)=spike_data.jitter';
              end
            elseif use==0
                 disp('nope');
            end
            close all
            cd(home)
        end
    end
end
save('groupeddata.mat','by_delay','by_obj','by_angle')
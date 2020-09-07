<<<<<<< HEAD
dates=[20190628 20190708 20190628 20190709 20190711 20190710]; 
home=('E:\KA001\');

by_delay=struct;
by_delay.fifteen.name={};
by_delay.fifteen.count=[];
by_delay.fifteen.jitter=[];
by_delay.ten.name={};
by_delay.ten.count=[];
by_delay.ten.jitter=[];
by_delay.five.name={};
by_delay.five.count=[];
by_delay.five.jitter=[];

by_obj=struct;
by_obj.cyl.name={};
by_obj.cyl.count=[];
by_obj.cyl.jitter=[];
by_obj.cube.name={};
by_obj.cube.count=[];
by_obj.cube.jitter=[];
by_obj.LD.name={};
by_obj.LD.count=[];
by_obj.LD.jitter=[];
by_obj.SD.name={};
by_obj.SD.count=[];
by_obj.SD.jitter=[];

by_angle=struct;
by_angle.zero.name={};
by_angle.zero.count=[];
by_angle.zero.jitter=[];
by_angle.fortyfive.name={};
by_angle.fortyfive.count=[];
by_angle.fortyfive.jitter=[];
by_angle.ninety.name={};
by_angle.ninety.count=[];
by_angle.ninety.jitter=[];

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
                  by_delay.five.name(size(by_delay.five.name,1)+1,:)={[date,' ',depth,' ',fname.name]};
                  by_delay.five.count(size(by_delay.five.count,1)+1,:)=spike_data.count';
                  by_delay.five.jitter(size(by_delay.five.jitter,1)+1,:)=spike_data.jitter';
              elseif pref_delay==10
                  by_delay.ten.name(size(by_delay.ten.name,1)+1,:)={[date,' ',depth,' ',fname.name]};
                  by_delay.ten.count(size(by_delay.ten.count,1)+1,:)=spike_data.count';
                  by_delay.ten.jitter(size(by_delay.ten.jitter,1)+1,:)=spike_data.jitter';
              elseif pref_delay==15
                  by_delay.fifteen.name(size(by_delay.fifteen.name,1)+1,:)={[date,' ',depth,' ',fname.name]};
                  by_delay.fifteen.count(size(by_delay.fifteen.count,1)+1,:)=spike_data.count';
                  by_delay.fifteen.jitter(size(by_delay.fifteen.jitter,1)+1,:)=spike_data.jitter';
              end
              if pref_ang==0
                  by_angle.zero.name(size(by_angle.zero.name,1)+1,:)={[date,' ',depth,' ',fname.name]};
                  by_angle.zero.count(size(by_angle.zero.count,1)+1,:)=spike_data.count';
                  by_angle.zero.jitter(size(by_angle.zero.jitter,1)+1,:)=spike_data.jitter';
              elseif pref_ang==45
                  by_angle.fortyfive.name(size(by_angle.fortyfive.name,1)+1,:)={[date,' ',depth,' ',fname.name]};
                  by_angle.fortyfive.count(size(by_angle.fortyfive.count,1)+1,:)=spike_data.count';
                  by_angle.fortyfive.jitter(size(by_angle.fortyfive.jitter,1)+1,:)=spike_data.jitter';
              elseif pref_ang==90
                  by_angle.ninety.name(size(by_angle.ninety.name,1)+1,:)={[date,' ',depth,' ',fname.name]};
                  by_angle.ninety.count(size(by_angle.ninety.count,1)+1,:)=spike_data.count';
                  by_angle.ninety.jitter(size(by_angle.ninety.jitter,1)+1,:)=spike_data.jitter';
              end
              if strcmp('cyl',pref_obj)==1
                  by_obj.cyl.name(size(by_obj.cyl.name,1)+1,:)={[date,' ',depth,' ',fname.name]};
                  by_obj.cyl.count(size(by_obj.cyl.count,1)+1,:)=spike_data.count';
                  by_obj.cyl.jitter(size(by_obj.cyl.jitter,1)+1,:)=spike_data.jitter';
              elseif strcmp('cube',pref_obj)==1
                  by_obj.cube.name(size(by_obj.cube.name,1)+1,:)={[date,' ',depth,' ',fname.name]};
                  by_obj.cube.count(size(by_obj.cube.count,1)+1,:)=spike_data.count';
                  by_obj.cube.jitter(size(by_obj.cube.jitter,1)+1,:)=spike_data.jitter';
              elseif strcmp('LD',pref_obj)==1
                  by_obj.LD.name(size(by_obj.LD.name,1)+1,:)={[date,' ',depth,' ',fname.name]};
                  by_obj.LD.count(size(by_obj.LD.count,1)+1,:)=spike_data.count';
                  by_obj.LD.jitter(size(by_obj.LD.jitter,1)+1,:)=spike_data.jitter';
              elseif strcmp('SD',pref_obj)==1
                  by_obj.SD.name(size(by_obj.SD.name,1)+1,:)={[date,' ',depth,' ',fname.name]};
                  by_obj.SD.count(size(by_obj.SD.count,1)+1,:)=spike_data.count';
                  by_obj.SD.jitter(size(by_obj.SD.jitter,1)+1,:)=spike_data.jitter';
              end
            elseif use==0
                 disp('nope');
            end
            close all
            cd(home)
        end
    end
end
=======
dates=[20190628 20190708 20190628 20190709 20190711 20190710]; 
home=('E:\KA001\');

by_delay=struct;
by_delay.fifteen.name={};
by_delay.fifteen.count=[];
by_delay.fifteen.jitter=[];
by_delay.ten.name={};
by_delay.ten.count=[];
by_delay.ten.jitter=[];
by_delay.five.name={};
by_delay.five.count=[];
by_delay.five.jitter=[];

by_obj=struct;
by_obj.cyl.name={};
by_obj.cyl.count=[];
by_obj.cyl.jitter=[];
by_obj.cube.name={};
by_obj.cube.count=[];
by_obj.cube.jitter=[];
by_obj.LD.name={};
by_obj.LD.count=[];
by_obj.LD.jitter=[];
by_obj.SD.name={};
by_obj.SD.count=[];
by_obj.SD.jitter=[];

by_angle=struct;
by_angle.zero.name={};
by_angle.zero.count=[];
by_angle.zero.jitter=[];
by_angle.fortyfive.name={};
by_angle.fortyfive.count=[];
by_angle.fortyfive.jitter=[];
by_angle.ninety.name={};
by_angle.ninety.count=[];
by_angle.ninety.jitter=[];

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
                  by_delay.five.name(size(by_delay.five.name,1)+1,:)={[date,' ',depth,' ',fname.name]};
                  by_delay.five.count(size(by_delay.five.count,1)+1,:)=spike_data.count';
                  by_delay.five.jitter(size(by_delay.five.jitter,1)+1,:)=spike_data.jitter';
              elseif pref_delay==10
                  by_delay.ten.name(size(by_delay.ten.name,1)+1,:)={[date,' ',depth,' ',fname.name]};
                  by_delay.ten.count(size(by_delay.ten.count,1)+1,:)=spike_data.count';
                  by_delay.ten.jitter(size(by_delay.ten.jitter,1)+1,:)=spike_data.jitter';
              elseif pref_delay==15
                  by_delay.fifteen.name(size(by_delay.fifteen.name,1)+1,:)={[date,' ',depth,' ',fname.name]};
                  by_delay.fifteen.count(size(by_delay.fifteen.count,1)+1,:)=spike_data.count';
                  by_delay.fifteen.jitter(size(by_delay.fifteen.jitter,1)+1,:)=spike_data.jitter';
              end
              if pref_ang==0
                  by_angle.zero.name(size(by_angle.zero.name,1)+1,:)={[date,' ',depth,' ',fname.name]};
                  by_angle.zero.count(size(by_angle.zero.count,1)+1,:)=spike_data.count';
                  by_angle.zero.jitter(size(by_angle.zero.jitter,1)+1,:)=spike_data.jitter';
              elseif pref_ang==45
                  by_angle.fortyfive.name(size(by_angle.fortyfive.name,1)+1,:)={[date,' ',depth,' ',fname.name]};
                  by_angle.fortyfive.count(size(by_angle.fortyfive.count,1)+1,:)=spike_data.count';
                  by_angle.fortyfive.jitter(size(by_angle.fortyfive.jitter,1)+1,:)=spike_data.jitter';
              elseif pref_ang==90
                  by_angle.ninety.name(size(by_angle.ninety.name,1)+1,:)={[date,' ',depth,' ',fname.name]};
                  by_angle.ninety.count(size(by_angle.ninety.count,1)+1,:)=spike_data.count';
                  by_angle.ninety.jitter(size(by_angle.ninety.jitter,1)+1,:)=spike_data.jitter';
              end
              if strcmp('cyl',pref_obj)==1
                  by_obj.cyl.name(size(by_obj.cyl.name,1)+1,:)={[date,' ',depth,' ',fname.name]};
                  by_obj.cyl.count(size(by_obj.cyl.count,1)+1,:)=spike_data.count';
                  by_obj.cyl.jitter(size(by_obj.cyl.jitter,1)+1,:)=spike_data.jitter';
              elseif strcmp('cube',pref_obj)==1
                  by_obj.cube.name(size(by_obj.cube.name,1)+1,:)={[date,' ',depth,' ',fname.name]};
                  by_obj.cube.count(size(by_obj.cube.count,1)+1,:)=spike_data.count';
                  by_obj.cube.jitter(size(by_obj.cube.jitter,1)+1,:)=spike_data.jitter';
              elseif strcmp('LD',pref_obj)==1
                  by_obj.LD.name(size(by_obj.LD.name,1)+1,:)={[date,' ',depth,' ',fname.name]};
                  by_obj.LD.count(size(by_obj.LD.count,1)+1,:)=spike_data.count';
                  by_obj.LD.jitter(size(by_obj.LD.jitter,1)+1,:)=spike_data.jitter';
              elseif strcmp('SD',pref_obj)==1
                  by_obj.SD.name(size(by_obj.SD.name,1)+1,:)={[date,' ',depth,' ',fname.name]};
                  by_obj.SD.count(size(by_obj.SD.count,1)+1,:)=spike_data.count';
                  by_obj.SD.jitter(size(by_obj.SD.jitter,1)+1,:)=spike_data.jitter';
              end
            elseif use==0
                 disp('nope');
            end
            close all
            cd(home)
        end
    end
end
>>>>>>> 7a55f90d7837dca246b385592c74044dc7ee2903
save('groupeddata.mat','by_delay','by_obj','by_angle')
%% for automating loading
function stimsort(versionX)
close all
%clear
%versionX='V3' made inputable

[ dates, stimnumb3D, stimnumbClutter, stimnumbFT ] = datesOrga(versionX)
%dates=20200120;
% if strcmp(versionX,'V3')
%     dates = [20180411  20180608  20180611 20180606 20180607];
%     stimnumb=680; %change if needed is numb of different stim*times played each stim, usually 20
%     A=setdiff(1:34,[3,4,5,6,7,18,19,20,21]);%number of stimuli minus the ones that are not 100
%     onehund=A;%put in all stim that are 100ms long for the stim set
% end
%% for getting spike times. Has a lot for automagic, but can be ui-ed
sourcepath='W:\Kate\KA001\uncat\';
destpath='W:\Kate\KA001\Sorted\';

for i_date = 1 : length(dates)
    %load the spike times after spike sorting
    % [file_spk_times,path_spk_times] = uigetfile('*.mat', 'Open the spike times');
    date= num2str(dates(i_date));% this I need to change for every date of recordings
    mkdir([destpath,date])
    folder_dir=dir([sourcepath,date]);
    
    
    
    for i_dep=1:length(folder_dir)
        depth= folder_dir(i_dep).name;
        
        if depth(1)=='.' || depth(1) == 'F' %for weird empty folders
            continue
        end
        
        conditions={'Clut','3D'};
        for idx_cond=1:2;
            if idx_cond == 1
                boink=6;
            else
                boink=4;
            end
            
            file_dir=dir([sourcepath,date,'\',conditions{idx_cond},'_',depth(boink:end),'\times*.mat']);
            
            for i_clust=1:length(file_dir) %loads clusters, changed for split files
                file_s1=strsplit(file_dir(i_clust).name,'_');%splits up file names
                file_s2=strsplit(file_s1{2},'.');
                ch= file_s2{1};
                if idx_cond==1
                    path_spk_times=([sourcepath,date,'\',conditions{idx_cond},'_',depth(boink:end),'\']);
                    
                    x=load([path_spk_times,file_dir(i_clust).name]);
                    
                    
                    for t=1:size(x.spkClutter,1);%rescale FT spike times so that stim switch time is 0, because FT was collected after Clutter
                        x.spkClutter(t,2)=x.spkClutter(t,2)-x.ref;%
                    end
                    clusters_Clutter = cell(1, max(x.spkClutter(:,1)));
                    clusters_FT = cell(1, max(x.spkFT(:,1)));
                    
                    for j=1:max(x.spkFT(:,1))
                        idx=find(x.spkFT(:,1)==j);
                        for i=1:length(idx)
                            clusters_FT{1,j}(i,1)=x.spkFT(idx(i),2);
                        end
                    end
                    for j=1:max(x.spkClutter(:,1))
                        idx=find(x.spkClutter(:,1)==j);
                        for i=1:length(idx)
                            clusters_Clutter{1,j}(i,1)=x.spkClutter(idx(i),2);
                        end
                    end
                    %loading channel with TTLs
                    path=(['W:\Kate\KA001\IC units\',date,'\Matfile\','Clut_',depth(boink:end)]);
                    file='\Chn17.mat';
                    ch17=load([path,file],'data','sr');
                    ch17_Clutter=ch17.data;
                    
%                     file='\Chn18.mat'; %added 20200303
%                     if exist([path,file])
%                         ch18=load([path,file],'data','sr');
%                         ch18_Clutter=ch18.data;
%                     end
                    
                    tdms_pathClutter=(['W:\Kate\KA001\IC units\',date,'\NI\Clut_',depth(boink:end),'\']);
                    tdmsClutter=dir([tdms_pathClutter,'*.tdms']);
                    assert(length(tdmsClutter)==1) % will error if TDMS is wrong
                    tdmsfileClutter={[tdms_pathClutter,'/',tdmsClutter(1).name]};
                    ConvertedDataClutter = convertTDMS(1,tdmsfileClutter);
                    
                elseif idx_cond==2
                    path_spk_times=([sourcepath,date,'\',conditions{idx_cond},'_',depth(boink:end),'\']);
                    
                    x=load([path_spk_times,file_dir(i_clust).name]);
                    for t=1:size(x.spk3D,1);%rescale FT spike times so that stim switch time is 0, because FT was collected after Clutter
                        x.spk3D(t,2)=x.spk3D(t,2)-x.ref;%
                    end
                    clusters_3D = cell(1, max(x.spk3D(:,1)));
                    clusters_FT = cell(1, max(x.spkFT(:,1)));
                    
                    for j=1:max(x.spkFT(:,1))
                        idx=find(x.spkFT(:,1)==j);
                        for i=1:length(idx)
                            clusters_FT{1,j}(i,1)=x.spkFT(idx(i),2);
                        end
                    end
                    for j=1:max(x.spk3D(:,1))
                        idx=find(x.spk3D(:,1)==j);
                        for i=1:length(idx)
                            clusters_3D{1,j}(i,1)=x.spk3D(idx(i),2);
                        end
                    end
                    %loading channel with TTLs
                    path=(['W:\Kate\KA001\IC units\',date,'\Matfile\','3D_', depth(boink:end)]);
                    file='\Chn17.mat';
                    ch17=load([path,file],'data');
                    ch17_3D=ch17.data;
                    
%                     file='\Chn18.mat';
%                     if exist([path,file])
%                         %added 20200303
%                         ch18=load([path,file],'data','sr');
%                         ch18_3D=ch18.data;
%                     end
                    
                    tdms_path3D=(['W:\Kate\KA001\IC units\',date,'\NI\3D_',depth(boink:end),'\']);
                    tdms3D=dir([tdms_path3D,'*.tdms']);
                    assert(length(tdms3D)==1) % will error if TDMS is wrong
                    tdmsfile3D={[tdms_path3D,'/',tdms3D(1).name]};
                    ConvertedData3D = convertTDMS(1,tdmsfile3D);
                    
                end
                
                %% load TTLs-automagic for now, can be ui-ed
                
                %loading channel with TTLs for FTs .
                % change path and name accordingly
                % [file,path] = uigetfile('*.mat', 'Open the TTL channel',path_spk_times);
                
                
                path_FT=(['W:\Kate\KA001\IC units\',date,'\Matfile\','FT_',depth(boink:end)]);
                file='\Chn17.mat';
                ch17=load([path_FT,file],'data');
                ch17_FT=ch17.data;
                
                
%                 file='\Chn18.mat'; %added 20200303
%                 if exist([path_FT,file])
%                     ch18=load([path_FT,file],'data','sr');
%                     ch18_FT=ch18.data;
%                 end
                
                tdms_pathFT=(['W:\Kate\KA001\IC units\',date,'\NI\FT_',depth(boink:end),'\']);
                tdmsFT=dir([tdms_pathFT,'*.tdms']);
                assert(length(tdmsFT)==1) % will error if TDMS is wrong
                tdmsfileFT={[tdms_pathFT,'/',tdmsFT(1).name]};
                ConvertedDataFT = convertTDMS(1,tdmsfileFT);
                
                sr=40000;% careful with this
                
                %% find onset of the TTL, set to loop twice for 3d and ft
                if idx_cond==1
                    ii=[1,2];
                elseif idx_cond==2
                    ii=[3,2];
                end
                
                for idx_ii=1:2
                    if ii(idx_ii)==1
                        ch17=ch17_Clutter;
                        %ch18=ch18_Clutter;
                    elseif ii(idx_ii)==2
                        ch17=ch17_FT;
                        %ch18=ch18_FT;
                    elseif ii(idx_ii)==3
                        ch17=ch17_3D;
                        %ch18=ch18_3D;
                    end
                    threshold = (max(ch17)+min(ch17))/2;
                    loc = [];
                    j = 1;
                    insidepulse = 0;
                    for i=1:numel(ch17)
                        if insidepulse
                            if ch17(i) < threshold
                                insidepulse = 0;
                            end
                        else
                            if ch17(i) >= threshold
                                insidepulse = 1;
                                loc(1,j) = i;
                                j = j + 1;
                            end
                        end
                    end
                    if ch17(1) > threshold
                        warning(['unusual high TTL start in ', num2str(i_clust), ' ', num2str(i_dep)])
                        loc = loc(2 : end);
                    end
                    %pull out stim
                    
                    
                    % test if the onset of the TTLs are correct
                    % plot (ch17)
                    % hold on
                    % plot(loc,ones(length(loc),1),'or')
                    
                    % load trial presentation from a .tdms file
                    % [file,path] = uigetfile('*.tdms','Open .tdms file with info about trials',path);
                    % ConvertedData = convertTDMS(1,[path file]);
                    
                    if ii(idx_ii)==1
                        stim_reps=[];
                        ConvertedData=ConvertedDataClutter;
%                         exCrisis=exist('ch18');
%                         if exCrisis==1
%                             stim_reps=zeros(size(loc,2),6001);
%                             for stimIDX=1:length(loc)
%                                 temp2=ch18(1,(loc(stimIDX)-150*(sr/1000)):loc(stimIDX));
%                                 stim_reps(stimIDX,:)=temp2;
%                             end
%                         end
                        loc_times=loc*1000/sr; % onset times of the TTLs in ms
                    elseif ii(idx_ii)==2
                        stim_reps=[];
                        ConvertedData=ConvertedDataFT;
%                         exCrisis=exist('ch18');
%                         if exCrisis==1
%                             stim_reps=zeros(size(loc,2),5001);
%                             for stimIDX=1:length(loc)
%                                 temp2=ch18(1,(loc(stimIDX)-125*(sr/1000)):loc(stimIDX));
%                                 stim_reps(stimIDX,:)=temp2;
%                             end
%                         end
                        loc_times=loc*1000/sr; % onset times of the TTLs in ms
                    elseif ii(idx_ii)==3
                        stim_reps=[];
                        ConvertedData=ConvertedData3D;
%                         exCrisis=exist('ch18');
%                         if exCrisis==1
%                             stim_reps=zeros(size(loc,2),6001);
%                             for stimIDX=1:length(loc)
%                                 temp2=ch18(1,(loc(stimIDX)-150*(sr/1000)):loc(stimIDX));
%                                 stim_reps(stimIDX,:)=temp2;
%                             end
%                         end
                        loc_times=loc*1000/sr; % onset times of the TTLs in ms
                    end
                    
                    
                    
                    % calculate stimulus onset (stim_onset)
                    if ii(idx_ii)==1
                        temp=ConvertedData.Data.MeasuredData(3).Data;
                        temp=temp';
                        loc_times(2,:)=temp;
                        stimnumb=stimnumbClutter;
                    elseif ii(idx_ii)==2
                        temp=[ConvertedData.Data.MeasuredData(3).Data,ConvertedData.Data.MeasuredData(4).Data];
                        temp=temp';
                        loc_times(2:3,:)=temp;
                        stimnumb=stimnumbFT;
                    elseif ii(idx_ii)==3
                        temp=ConvertedData.Data.MeasuredData(3).Data;
                        temp=temp';
                        loc_times(2,:)=temp;
                        stimnumb=stimnumb3D;
                    end
                    
                    assert(isequal(length(loc_times),stimnumb));
                    stim_onset = zeros(1,stimnumb);
                    if ii(idx_ii)==1
                        for iON=1:length(loc_times)
                            
                            stim_onset(1,iON)=loc_times(1,iON)-150; %resized for 30 ms stims, I think, yes
                        end
                    elseif ii(idx_ii)==2
                        for iON=1:length(loc_times)
                            
                            stim_onset(1,iON)=loc_times(1,iON)-125;
                        end
                    elseif ii(idx_ii)==3
                        for iON=1:length(loc_times)
                            
                            stim_onset(1,iON)=loc_times(1,iON)-150;
                        end
                    end
                    
                    stim_onset(2,:)=loc_times(2,:);
                    % x(1,:)=loc_times(1,:)-stim_onset(1,:);
                    % x(2,:)=loc_times(2,:);
                    
                    % separate response in columns in trials_sorted
                    if ii(idx_ii)==1
                        clusters=clusters_Clutter;
                    elseif ii(idx_ii)==2
                        stim_onset(3,:)=loc_times(3,:);
                        clusters=clusters_FT;
                    elseif ii(idx_ii)==3
                        clusters=clusters_3D;
                    end
                    for d=1:size(clusters,2)
                        clear trials
                        for i=1:length(loc)
                            m=clusters{1,d}((clusters{1,d}>stim_onset(1,i)));
                            m=m(m<loc_times(1,i));
                            trials(1:length(m),i)=m;
                        end
                        
                        trials(trials==0)=NaN;
                        
                        for i=1:length(trials)
                            trials(:,i)=trials(:,i)-stim_onset(1,i);
                        end
                        if ii(idx_ii)==1
                            trials = [trials(1:0,:); stim_onset(2,:); trials(0+1:end,:)];
                            trials=trials';
                            stim_reps(:,end+1)=trials(:,1);
                            stim_reps=sortrows(stim_reps,size(stim_reps,2));
                            stim_reps=stim_reps(1:stimnumb,:);
                            trials_sorted=sortrows(trials,1);
                            trials_sorted=trials_sorted';
                            trials_sorted(1,:)=[];
                            
                            
                            trials_clutter=trials_sorted;
                            stimon_clutter=stim_onset;
                            stim_reps_clutter=stim_reps;
                            
                        elseif ii(idx_ii)==2
                            trials = [trials(1:0,:); stim_onset(2:3,:); trials(0+1:end,:)];
                            trials=trials';
                            stim_reps(:,end+1:end+2)=trials(:,1:2);
                            stim_reps=sortrows(stim_reps,[-1,0]+size(stim_reps,2));
                            stim_reps=stim_reps(1:stimnumb,:);
                            trials_sorted=sortrows(trials,[1 2]);
                            trials_sorted=trials_sorted';
                            trials_sorted(1:2,:)=[];
                            trials_FT=trials_sorted; % frequs 20 to 90 steps of 5 at differnet dbs 20-70 in steps of 10, so first 15 are 20kHz at 20 dBs, columns 16 to 30 are 20khz at 30dBs, columns 31 to 45 are 20kHz at 40dBs 
                            stimon_FT=stim_onset;
                            stim_reps_FT=stim_reps;
                        elseif ii(idx_ii)==3
                            trials = [trials(1:0,:); stim_onset(2,:); trials(0+1:end,:)];
                            trials=trials';
                            stim_reps(:,end+1)=trials(:,1);
                            stim_reps=sortrows(stim_reps,size(stim_reps,2));
                            stim_reps=stim_reps(1:stimnumb,:);
                            trials_sorted=sortrows(trials,1);
                            trials_sorted=trials_sorted';
                            trials_sorted(1,:)=[];
                            trials_3D=trials_sorted;
                            stimon_3D=stim_onset;
                            stim_reps_3D=stim_reps;
                        end
                        
                        mkdir([destpath,date,'\',conditions{idx_cond},'_',depth(boink:end),'\']);
                        savepath=([destpath,date,'\',conditions{idx_cond},'_',depth(boink:end),'\']);
                        if ii(idx_ii)==1
                            save([savepath,ch,'_',num2str(d),'_neuron.mat'],'trials_clutter','stimon_clutter','stim_reps_clutter')
                        elseif ii(idx_ii)==2
                            if exist([savepath,ch,'_',num2str(d),'_neuron.mat'])
                                save([savepath,ch,'_',num2str(d),'_neuron.mat'],'trials_FT','stimon_FT','stim_reps_FT','-append')
                            else
                                save([savepath,ch,'_',num2str(d),'_neuron.mat'],'trials_FT','stimon_FT','stim_reps_FT')
                            end
                        elseif ii(idx_ii)==3
                            if exist([savepath,ch,'_',num2str(d),'_neuron.mat'])
                                save([savepath,ch,'_',num2str(d),'_neuron.mat'],'trials_3D','stimon_3D','stim_reps_3D','-append')
                            else
                                save([savepath,ch,'_',num2str(d),'_neuron.mat'],'trials_3D','stimon_3D','stim_reps_3D')
                            end
                        end
                    end
                end
                
            end
        end
    end
end


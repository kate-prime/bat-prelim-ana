%% for automating loading
function stimsort(versionX)
close all
%clear
%versionX='V3' made inputable

if strcmp(versionX,'V1')
    dates=[20190628 20190708 20190709 20190711 20190710]; 
    stimnumb3D=680;
    stimnumbFT=1350;%change if needed; stimuli*reps, usually 20
end

if strcmp(versionX,'V2')
    dates=[20190904 20190905 20190906 20190909 20190910 20190911]; %
    stimnumb3D=1320;
    stimnumbFT=1350;%change if needed; stimuli*reps, usually 20
end
%% for getting spike times. Has a lot for automagic, but can be ui-ed

for i_date = 1 : length(dates)
    %load the spike times after spike sorting
    % [file_spk_times,path_spk_times] = uigetfile('*.mat', 'Open the spike times');
    date= num2str(dates(i_date));% this I need to chane for every date of recordings
    mkdir(['E:\KA001\Sorted\',date])
    folder_dir=dir(['E:\KA001\IC units\',date,'\Matfile\']);   
    for i_dep=1:length(folder_dir)
        depth= folder_dir(i_dep).name;
        
        if length(depth(10:end))<3 %this gets rid of empties and selects the 3DplusFT folders
            continue
        end
        
        mkdir(['E:\KA001\Sorted\',date,'\',depth,'\']);
        file_dir=dir(['E:\KA001\IC units\',date,'\Matfile\',depth,'\times_','*.mat']);
        
        for i_clust=1:length(file_dir) %loads clusters, changed for split files
            file_s1=strsplit(file_dir(i_clust).name,'_');%splits up file names
            file_s2=strsplit(file_s1{2},'.');
            ch= file_s2{1};
            
            path_spk_times=(['E:\KA001\IC units\',date,'\Matfile\',depth,'\']); 
            
            
             x=load([path_spk_times,file_dir(i_clust).name]);
%             for t=1:size(x.spkClutter,1);%rescale FT spike times so that stim switch time is 0, because FT was collected after Clutter
%                 x.spkClutter(t,2)=x.spkClutter(t,2)-x.ref;%
            for t=1:size(x.spk3D,1)%rescale 3D spike times so that stim switch time is 0
                x.spk3D(t,2)=x.spk3D(t,2)-x.ref;
            end
            clusters_FT = cell(1, max(x.spkFT(:,1)));
            clusters_3D = cell(1, max(x.spk3D(:,1)));
            
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
            %% load TTLs-automagic for now, can be ui-ed
            
            %loading channel with TTLs
            % change path and name accordingly
            % [file,path] = uigetfile('*.mat', 'Open the TTL channel',path_spk_times);
            path=(['E:\KA001\IC units\',date,'\Matfile\','3D', depth(9:end-1),'1']);%FIX in a minute
            file='\Chn17.mat';
            ch17=load([path,file],'data','sr');
            ch17_3D=ch17.data;
            sr=ch17.sr;
            path=(['E:\KA001\IC units\',date,'\Matfile\','FT',depth(9:end)]);
            ch17=load([path,file],'data');
            ch17_FT=ch17.data;

            tdms_path3D=(['E:\KA001\IC units\', date,'\NI\Nat',depth(9:end-1),'1']);
            tdms3D=dir([tdms_path3D,'\*.tdms']);
            assert(length(tdms3D)==1); % will error if TDMS is wrong
            tdmsfile3D={[tdms_path3D,'\',tdms3D(1).name]};
            ConvertedData3D = convertTDMS(1,tdmsfile3D);
            
            tdms_pathFT=(['E:\KA001\IC units\', date,'\NI\FT',depth(9:end)]);
            tdmsFT=dir([tdms_pathFT,'\*.tdms']);
            assert(length(tdmsFT)==1); % will error if TDMS is wrong
            tdmsfileFT={[tdms_pathFT,'\',tdmsFT(1).name]};
            ConvertedDataFT = convertTDMS(1,tdmsfileFT);

            
            %% find onset of the TTL, set to loop twice for 3d and ft
            for ii=1:2
                if ii==1
                    ch17=ch17_FT;
                elseif ii==2
                    ch17=ch17_3D;
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
                loc_times=loc*1000/sr; % onset times of the TTLs
                
                % test if the onset of the TTLs are correct
                % plot (ch17)
                % hold on
                % plot(loc,ones(length(loc),1),'or')
                
                % load trial presentation from a .tdms file
                % [file,path] = uigetfile('*.tdms','Open .tdms file with info about trials',path);
                % ConvertedData = convertTDMS(1,[path file]);
                if ii==1
                    ConvertedData=ConvertedDataFT;
                elseif ii==2
                    ConvertedData=ConvertedData3D;
                end
                temp=ConvertedData.Data.MeasuredData(3).Data;
                temp=temp';
                loc_times(2,:)=temp;
                
                % calculate stimulus onset (stim_onset)
                if ii==1
                    stimnumb=stimnumbFT;
                elseif ii==2
                    stimnumb=stimnumb3D;
                end
                assert(isequal(size(loc_times),[2,stimnumb]));
                stim_onset = zeros(1,stimnumb);
                if ii==2
                    for iON=1:length(loc_times) 
                        stim_onset(1,iON)=loc_times(1,iON)-150; %resized for 30 ms stims, I think, yes
                    end
                elseif ii==1
                    for iON=1:length(loc_times)
                        
                        stim_onset(1,iON)=loc_times(1,iON)-125; %resized for FT
                    end
                end
                stim_onset(2,:)=loc_times(2,:);
                % x(1,:)=loc_times(1,:)-stim_onset(1,:);
                % x(2,:)=loc_times(2,:);
                
                % separate response in columns in trials_sorted
                if ii==2
                    clusters=clusters_3D;
                elseif ii==1
                    clusters=clusters_FT;
                end
                for d=1:max(x.cluster_class(:,1))
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
                    trials = [trials(1:0,:); stim_onset(2,:); trials(0+1:end,:)];
                    trials=trials';
                    trials_sorted=sortrows(trials,1);
                    trials_sorted=trials_sorted';
                    trials_sorted(1,:)=[];
 %% DANGER DANGER REMEMBER TO FIX
                    if ii==1
                        trials_FT=trials_sorted;
                        stimon_FT=stim_onset;
                    elseif ii==2
                        trials_3D=trials_sorted;
                        stimon_3D=stim_onset;
                    end
                    savepath=(['E:\KA001\Sorted\',date,'\',depth]);
                    if ii==1
                        %cd(savepath)
                        save([savepath,'/',ch,'_',num2str(d),'_neuron.mat'],'trials_FT','stimon_FT')
                    elseif ii==2
                        %cd(savepath)
                        save([savepath,'/',ch,'_',num2str(d),'_neuron.mat'],'trials_3D','stimon_3D','-append')
                    end    
                end
            end
            
        end
    end
end


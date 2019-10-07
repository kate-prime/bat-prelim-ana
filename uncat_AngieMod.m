function uncat_AngieMod (versionX) %written by KAllen, modified by ASalles
%separates spike times for concatenated files, select a reference file for
%each depth, each reference works for all channels

dates = datesOrga(versionX);

for idx_day=1:length(dates)
    day=num2str(dates(idx_day))
    
 pathtouncat=['D:\AngieDrive\Bats\NSF shapes project\neural_data_2019\clutter_stim\',day,'\'];%put the path that leads to the files you want to uncat
%pathtouncat=['E:\Angie data\shapes project\badlywavedclused\',day,'\'];%NEEDTOGO

depthlist=dir(pathtouncat);

for idx_depth=1:length(depthlist)
    if length(depthlist(idx_depth).name)<3 %this is to get rid of weird emty files . and ..
        continue
    end
    
    depth=depthlist(idx_depth).name(5:end); %this will need to be 10:end for Kate
    
    pathref=['E:\Angie data\shapes project\',day,'\Matfile\FT_',depth,'\';];%put the path that you want as reference, always use FT becuase it was concatenated with FT first
    
    
    %num=input('number of files to uncat');% all channels per depth
    %disp('select reference file')% reference file is one of the original mat files
    %[refname,fpath1]=uigetfile;
    refname=[pathref,'Chn1.mat'];%I always use chn1 as ref
    
    %cd(fpath1);
    load(refname, 'data','sr'); % use FT file
    
    ref=size(data,2)/(sr/1000);
    num=dir([pathtouncat,'\All_',depth,'\times_','*.mat']);
 for i=1:length(num)
        %disp('channel to uncat')%choose the channel of the times_ files, it saves over it adding the new info
        %     [fname,fpath2]=uigetfile;
        %     cd(fpath2)
       fname=[pathtouncat,'\All_',depth,'\',num(i).name];
        load(fname,'cluster_class');
        ind1=find(cluster_class(:,2)<ref);
        ind2=find(cluster_class(:,2)>ref);
        spkFT=cluster_class(ind1,:);
        spkClutter=cluster_class(ind2,:);
        
        save(fname, 'spkFT','spkClutter','ref','-append');
    end
    
end
end
end
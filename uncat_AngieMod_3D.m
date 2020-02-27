function uncat_AngieMod_3D (versionX) %written by KAllen, modified by ASalles
%separates spike times for concatenated files, select a reference file for
%each depth, each reference works for all channels

dates = datesOrga(versionX);

for idx_day=1:length(dates)
    day=num2str(dates(idx_day));
pathtouncat=['Z:\Kate\KA001\IC units\',day,'\Matfile'];%put the path that leads to the files you want to uncat
depthlist=dir([pathtouncat,'\3DplusFT*']);

for idx_depth=1:length(depthlist)
    if length(depthlist(idx_depth).name)<3 %this is to get rid of weird empty files . and ..
        continue
    end
    if strcmp(depthlist(idx_depth).name,'.DS_Store')==1
        continue
    end
    depth=depthlist(idx_depth).name(10:end); %this will need to be 10:end for Kate
    pathref=['Z:\Kate\KA001\IC units\',day,'\Matfile\FT_',depth,'\';];%put the path that you want as reference, always use FT becuase it was concatenated with FT first
    %num=input('number of files to uncat');% all channels per depth
    %disp('select reference file')% reference file is one of the original mat files
    %[refname,fpath1]=uigetfile;
    refname=[pathref,'Chn1.mat'];%I always use chn1 as ref
    
    %cd(fpath1);
    load(refname, 'data','sr'); % use FT file
    ref=size(data,2)/(sr/1000);
    num=dir([pathtouncat,'\3DplusFT_',depth,'\times_','*.mat']);
    
    
 for i=1:length(num)
        %disp('channel to uncat')%choose the channel of the times_ files, it saves over it adding the new info
        %     [fname,fpath2]=uigetfile;
        %     cd(fpath2)
       fname=[pathtouncat,'\3DplusFT_',depth,'\',num(i).name];
        load(fname,'cluster_class');

        ind1=find(cluster_class(:,2)>ref);
        ind2=find(cluster_class(:,2)<ref);
        spkFT=cluster_class(ind1,:);
        spk3D=cluster_class(ind2,:);

        ind1=find(cluster_class(:,2)<ref);
        ind2=find(cluster_class(:,2)>ref);
        spkFT=cluster_class(ind1,:);
        spk3D=cluster_class(ind2,:);
        newpath=(['Z:\Kate\KA001\uncat\',day,'\3D_',depth,'\']);
        mkdir(newpath);
       save([newpath,num(i).name,'.mat'],'spkFT','spk3D','ref','sr');
    end
    
end
end
end
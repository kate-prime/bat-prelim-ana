function uncat
%separates spike times for concatenated files. select a reference file for
%each depth, each reference works for all channels at that depth

num=input('number of files to uncat');% all channels per depth
disp('select reference file')% reference file is one of the original mat files
[refname,fpath1]=uigetfile;
cd(fpath1);
load(refname, 'data','sr'); %for Kate, use FT file, For Angie use clutter file because it comes first.

ref=size(data,2)/(sr/1000);

for i=1:num;
    disp('channel to uncat')%choose the channel of the times_ files, it saves over it adding the new info
    [fname,fpath2]=uigetfile;
    cd(fpath2)
    load(fname,'cluster_class');
    ind1=find(cluster_class(:,2)<ref);
    ind2=find(cluster_class(:,2)>ref);
    spkFT=cluster_class(ind1,:);
    spkClutter=cluster_class(ind2,:);
    save(fname, 'spkFT','spkClutter','ref','-append');
end
    

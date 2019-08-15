function uncat
%separates spike times for concatenated files, select a reference file for
%each depth, each reference works for all channels

num=input('number of files to uncat');
disp('select reference file')
[refname,fpath1]=uigetfile;
cd(fpath1);
load(refname, 'data','sr'); %for Kate, use FT file

ref=size(data,2)/(sr/1000);

for i=1:num;
    disp('channel to uncat')
    [fname,fpath2]=uigetfile;
    cd(fpath2)
    load(fname,'cluster_class');
    ind1=find(cluster_class(:,2)<ref);
    ind2=find(cluster_class(:,2)>ref);
    spkFT=cluster_class(ind1,:);
    spk3D=cluster_class(ind2,:);
    save(fname, 'spkFT','spk3D','ref','-append');
end
    

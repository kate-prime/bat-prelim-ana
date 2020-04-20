function [peak_data]=findresptype(data)
%finds response type (onset-y==1,n==0,tonic y==1, n==0,sharp y==1 no==0) from psth
list = fieldnames(data);
storageunit_means=[];
storageunit_names={};
for i=1:size(list,1)
    obj=cell2mat(list(i));
    temp=data.(obj).mdata;
    storageunit_means=[storageunit_means; temp];
    storageunit_names=[storageunit_names; obj; obj; obj];
end
peak_data=struct;
onset=zeros(size(storageunit_means,1));
tonic=zeros(size(storageunit_means,1));
sharp=zeros(size(storageunit_means,1));

for ii=1:size(storageunit_means,1)
    [pks, locs, widths, proms]=findpeaks(storageunit_means(ii)); %finds local peaks in smoothed data
    %measures peak at half prom, but can be changed to half height
    name=storageunit_names(ii,:);
    peak_data.(name).pks=pks;
    peak_data.(name).locs=locs;
    peak_data.(name).widths=widths;
    peak_data.(name).proms=proms;
   if find(max(pks))<10
       onset(ii)=1;
   end
   if max(widths)>=4%4 ms threshold for defining sharp, can be adjusted
       tonic(ii)=1;
   else
       sharp(ii)=1;
   end
end
onset=sum(onset);
tonic=sum(tonic);
sharp=sum(sharp);
peak_data.onset=onset;
peak_data.tonic=tonic;
peak_data.sharp=sharp;




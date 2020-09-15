function [peak_data]=findresptype(data)
%finds response type (onset,tonic,sharp, echo) from psth
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
tonic=zeros(size(storageunit_means,1),1);
sharp=zeros(size(storageunit_means,1),1);
echo=zeros(size(storageunit_means,1),1);
early=zeros(size(storageunit_means,1),1);
late=zeros(size(storageunit_means,1),1);

for ii=1:size(storageunit_means,1)
    [pks, locs, widths, proms]=findpeaks(storageunit_means(ii,:),'MinPeakHeight',30);%remember that you lowered this %finds local peaks in smoothed data
    %measures peak at half prom, but can be changed to half height
    name=cell2mat(storageunit_names(ii,:));
    try
        peak_data.(name).pks(size(peak_data.(name).pks,1)+1,:)={pks};
    catch
        peak_data.(name).pks={pks};
    end
    try
        peak_data.(name).locs(size(peak_data.(name).locs,1)+1,:)={locs};
    catch
        peak_data.(name).locs={locs};
    end
    try
        peak_data.(name).widths(size(peak_data.(name).widths,1)+1,:)={widths};
    catch
        peak_data.(name).widths={widths};
    end
    try
        peak_data.(name).proms(size(peak_data.(name).proms)+1,:)={proms};
    catch
        peak_data.(name).proms={proms};
    end
    
   ind=find(max(pks)); 
   if locs(ind)<10
       early(ii)=1;
   else
       late(ii)=1;
    [pks, locs, widths, proms]=findpeaks(storageunit_means(ii,:)); %finds local peaks in smoothed data
    %measures peak at half prom, but can be changed to half height
    name=cell2mat(storageunit_names(ii,:));
    peak_data.(name).pks=pks;
    peak_data.(name).locs=locs;
    peak_data.(name).widths=widths;
    peak_data.(name).proms=proms;
   if find(max(pks))<10
       onset(ii)=1;
   end
   if max(widths)>=3%3 ms threshold for defining sharp, can be adjusted
       tonic(ii)=1;
   else
       sharp(ii)=1;
   end
   if max(locs)>12 %threshold for calling it an echo response, can be adjusted
       echo(ii)=1;
   end
end
%onset=sum(onset);
early=sum(early);
late=sum(late);
tonic=sum(tonic);
sharp=sum(sharp);
echo=sum(echo);
%peak_data.onset=onset;
peak_data.tonic=tonic;
peak_data.sharp=sharp;
peak_data.echo=echo;
peak_data.late=late;
peak_data.early=early;
end
end




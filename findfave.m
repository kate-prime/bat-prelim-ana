function fave=findfave(data)

list = fieldnames(data);
storageunit_means=[];
storageunit_names={};
for i=1:size(list,1)
    obj=cell2mat(list(i));
    temp=data.(obj).mdata;
    storageunit_means=[storageunit_means; temp];
    storageunit_names=[storageunit_names; obj; obj; obj];
end
peak_ind=max(storageunit_means(:,6:end),[],2); %in case peak fr is an onset response
[r,~]=find(storageunit_means==max(peak_ind));
fave=storageunit_names(r);

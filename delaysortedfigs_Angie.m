function [f1]=delaysortedfigs_Angie(fname)
%creates a scatter plotsa that only display trials from neuron's preferred
%delay
%it calls the same stim data file used in second ana
load(fname,'spike_data', 'pref_delay','pref_obj');
[stim_data,shapes] = make_stim_data();
%% find relevant data  and means
data=[spike_data.count cell2mat(stim_data(:,[1,4,3]))];
ind=find(data(:,2)==pref_delay);
data=data(ind,:);

obj_means=zeros(2,max(data(:,3)));
for i=1:max(data(:,3))
    ind2=find(data(:,3)==i);
    m=mean(data(ind2,1));
    s=std(data(ind2,1));
    obj_means(1,i)=m;
    obj_means(2,i)=s;
end

ang_means=zeros(2,3);
for i=[0 45 90]
    ind2=find(data(:,4)==i);
    m=mean(data(ind2,1));
    s=std(data(ind2,1));
    ang_means(1,(i/45)+1)=m;
    ang_means(2,(i/45)+1)=s;
end

%% make the figure
f1=figure;
set(f1,'Position',[150 150 1000 500])
f(1)=subplot(1,2,1);
hold on
scatter(data(:,3),data(:,1),'filled','MarkerFaceColor',[.6 1 .6])
% scatter(1:size(obj_means,2),obj_means(1,:),'filled','k')
boxplot(data(:,1),data(:,3),'Labels',stim_data(:,2),'LabelOrientation','inline')

xlim([0 (size(obj_means,2)+1)])
%ylim([0 40]) %super aribitrary
title(f(1),'Object')
set(findobj(gca,'type','line'),'linew',1.5)
ylabel('spike count(20 summed repetitions)')
hold off

f(2)=subplot(1,2,2);
hold on
%to pick out object

for idx = 1 : length(pref_obj)
    clutterspikes=[];
    clutterspikes(:,1)=cell2mat(stim_data((cell2mat(stim_data(:,4))==pref_obj(idx)),3));
    clutterspikes(:,2)=spike_data.spikenumber(cell2mat(stim_data(:,4))==pref_obj(idx));
    clutterspikes=sortrows(clutterspikes);%this fixes the sphere being out of order problem
     
    plot(clutterspikes(:,1),clutterspikes(:,2),'LineWidth',1.5)
    
end
%xlim([0 4])
uppylim=max(clutterspikes(:,2))+20;
ylim([0 uppylim]) %the +20 is super aribitrary, just to make sure that previous lines get in too, because this only looks at the last pref object
title(f(2),[shapes{pref_obj(1)},' Clutter'])

legend(shapes(pref_obj));
xlabel('Clutter distance')
hold off
%% save
end



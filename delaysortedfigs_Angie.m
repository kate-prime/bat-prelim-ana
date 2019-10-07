function f1=delaysortedfigs
%creates a scatter plotsa that only display trials from neuron's preferred
%delay
%it calls the same stim data file used in second ana
disp('chose a neuron')
[fname, fpath]=uigetfile;
load([fpath,fname],'spike_data', 'pref_delay');
load('D:\AngieDrive\Bats\NSF shapes project\neural_stim\clutterstim_org.mat','stim_data');
%% find relevant data  and means
data=[spike_data.count stim_data];
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
% scatter(data(:,3),data(:,1),'filled','MarkerFaceColor',[.6 1 .6])
% scatter(1:size(obj_means,2),obj_means(1,:),'filled','k')
boxplot(data(:,1),data(:,3),'Labels',{'cylinder','cube','shpere','LD','SD','MP','AMPcyl','AMPcube','AMPsphere','AMPLD','AMPSD','AMPMP'},'LabelOrientation','inline')

xlim([0 (size(obj_means,2)+1)])
%ylim([0 40]) %super aribitrary
title(f(1),'Object')
set(findobj(gca,'type','line'),'linew',1.5)
ylabel('spike count(20 summed repitions)')
hold off

f(2)=subplot(1,2,2);
 hold on
% scatter(data(:,4),data(:,1),'filled','MarkerFaceColor',[1 .6 1])
% scatter([0 10 20],ang_means(1,:),'filled','k')
orgbyclutter=sortrows(data,4);%to fix problem that it looks at it as a group
boxplot(orgbyclutter(:,1),(orgbyclutter(:,4))) %turns out this is a super pain in the ass
%because it treats them as a group, not numbers, so scale gets fucked up I
%can do it if we like it, but ehhhhh
%xlim([-10 30])
%ylim([0 40]) %super aribitrary
set(findobj(gca,'type','line'),'linew',1.5)
xlabel('clutter distance')
title(f(2),'Clutter')
hold off
%% save
saveas(f1,[fname(1:end-4) '_delay_sorted.png'])


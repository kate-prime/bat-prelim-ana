
%creates a scatter plotsa that only display trials from neuron's preferred
%delay
%it calls the same stim data file used in second ana
disp('chose a neuron')
[fname, fpath]=uigetfile;
load([fpath,fname],'spike_data', 'pref_delay','pref_obj');
load('D:\AngieDrive\Bats\NSF shapes project\neural_stim\3Dstim.mat','stim_data')
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
scatter(data(:,3),data(:,1),'filled','MarkerFaceColor',[.6 1 .6])
%scatter(1:size(obj_means,2),obj_means(1,:),'filled','k')
boxplot(data(:,1),data(:,3),'Labels',{'cylinder','cube','LD','SD','AMPcyl','AMPcube','AMPLD','AMPSD'},'LabelOrientation','inline');
xlim([0 (size(obj_means,2)+1)])
ylim([0 50]) %super aribitrary
title(f(1),'Object')
set(findobj(gca,'type','line'),'linew',1.5)
ylabel('spike count(20 summed repetitions)')
hold off

f(2)=subplot(1,2,2);
hold on
 %to pick out object
if strcmp('cyl',pref_obj)==1
    y=1;
elseif strcmp('cube',pref_obj)==1
    y=2;
elseif strcmp('LD',pref_obj)==1
    y=3;
elseif strcmp('SD',pref_obj)==1
    y=4;
elseif strcmp('AMPcyl',pref_obj)==1
    y=5;
elseif strcmp('AMPcube',pref_obj)==1
    y=6;
elseif strcmp('AMPLD',pref_obj)==1
    y=7;
elseif strcmp('AMPSD',pref_obj)==1
    y=8;
end
ind3=find(data(:,3)==y);
data2=data(ind3,:);
temp=(data2(:,4)./45)+1; %to fix scaling
scatter(temp,data2(:,1),'filled','MarkerFaceColor',[1 .6 1])
%scatter([0 45 90],ang_means(1,:),'filled','k')
boxplot(data2(:,1),(data2(:,4))) 
xlim([0 4])
ylim([0 50]) %super aribitrary
title(f(2),[pref_obj,' Angle'])
set(findobj(gca,'type','line'),'Color',[1 0 1],'linew',1.5)
xlabel('Degrees Rotated')
hold off
%% save
saveas(f1,[fname(1:end-4) '_delay_sorted.png'])
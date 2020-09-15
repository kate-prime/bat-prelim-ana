%quick and dirty analysis for grouping neurons and plotting
function [distances,idx,scplot,frplot]=quickcluster(summary)

list=fieldnames(summary.allpop);
dumb=zeros(size(summary.allpop.cyls.ID,1),45*length(list));
for i =1:length(list)
    shape=cell2mat(list(i));
    dumb(:,((i*45)-44):i*45)=summary.allpop.(shape).mean_10(:,:); %this is not a great solution, 
    %but the idea is to keep time as a variable, but collapse across shapes
end
    
distances=tsne(dumb,'NumDimensions',3);

figure;
scatter3(distances(:,1),distances(:,2),distances(:,3));
%scatter(distances(:,1),distances(:,2))
pause;
close

num=input('number of clusters?');

idx=kmeans(distances,num);

colors=hsv(num);

scplot=figure;
hold on
for j=1:length(idx)
    scatter3(distances(j,1),distances(j,2),distances(j,3),15, colors(idx(j),:),'filled');
    %scatter(distances(j,1),distances(j,2),15, colors(idx(j),:),'filled');
end
hold off
mbox=NaN(num,size(dumb,2));
devbox=NaN(num,size(dumb,2));
for k=1:num
    ind=find(idx==k);
    mbox(k,:)=mean(dumb(ind,:));
    devbox(k,:)=std(dumb(ind,:));
end

frplot=figure;
frplot.Position=[100,50,1000,700];

for m=1:size(list,1)
    subplot(2,(size(list,1)/2),m)
    shape=cell2mat(list(m));
    hold on
    for n=1:num
        seg=mbox(n,((m*45)-44):m*45);
        t=1:size(seg,2);
        plot(t,seg,'LineWidth',2,'color',colors(n,:))
        plot(t,seg+devbox(n),'LineWidth',.5,'color',colors(n,:))
        plot(t,seg-devbox(n),'LineWidth',.5,'color',colors(n,:))
    end
    title(shape)
    xlabel('Time (ms)')
    ylabel('spike count')
end
    
    
%for plotting data that has already been clustered
list=fieldnames(summary.allpop);
dumb=zeros(size(summary.allpop.cyls.ID,1),45*length(list));
for i =1:length(list)
    shape=cell2mat(list(i));
    try
    dumb(:,((i*45)-44):i*45)=summary.allpop.(shape).mean_90(:,:); %this is what to change
    end
end
num=3;    
colors=parula(num);
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
    ylabel('Firing Rate (Hz)')
end
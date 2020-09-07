%for plotting data that has already been clustered
list=fieldnames(summary.allpop);
dumb=zeros(size(summary.allpop.cyls.ID,1),45*length(list));
for i =1:length(list)
    shape=cell2mat(list(i));
    dumb(:,((i*45)-44):i*45)=summary.allpop.(shape).mean_0(:,:); 
    dumb2(:,((i*45)-44):i*45)=summary.allpop.(shape).mean_45(:,:);
    try
    dumb3(:,((i*45)-44):i*45)=summary.allpop.(shape).mean_90(:,:);
    end
end
num=3;    
colors=hsv(num);
mbox1=NaN(num,size(dumb,2));
devbox1=NaN(num,size(dumb,2));

mbox2=NaN(num,size(dumb2,2));
devbox2=NaN(num,size(dumb2,2));

mbox3=NaN(num,size(dumb3,2));
devbox3=NaN(num,size(dumb3,2));

for k=1:num
    ind=find(idx==k);
    mbox1(k,:)=mean(dumb(ind,:));
    devbox1(k,:)=std(dumb(ind,:));
    
    mbox2(k,:)=mean(dumb2(ind,:));
    devbox2(k,:)=std(dumb2(ind,:));
    
    mbox3(k,:)=mean(dumb3(ind,:));
    devbox3(k,:)=std(dumb3(ind,:));
end

    frplot=figure;
    frplot.Position=[100,50,1000,700];
for m=1:size(list,1)

    subplot(2,(size(list,1)/2),m)
    shape=cell2mat(list(m));
    hold on
    
    seg=mbox1(1,((m*45)-44):m*45);
    t=1:size(seg,2);
    plot(t,seg,'LineWidth',2,'color',colors(1,:))
    plot(t,seg+devbox1(n),'LineWidth',.5,'color',colors(1,:))
    plot(t,seg-devbox1(n),'LineWidth',.5,'color',colors(1,:))
    
    seg2=mbox2(1,((m*45)-44):m*45);
    t=1:size(seg2,2);
    plot(t,seg2,'LineWidth',2,'color',colors(2,:))
    plot(t,seg2+devbox2(n),'LineWidth',.5,'color',colors(2,:))
    plot(t,seg2-devbox2(n),'LineWidth',.5,'color',colors(2,:))
    
    seg3=mbox3(1,((m*45)-44):m*45);
    t=1:size(seg3,2);
    plot(t,seg3,'LineWidth',2,'color',colors(3,:))
    plot(t,seg3+devbox3(n),'LineWidth',.5,'color',colors(3,:))
    plot(t,seg3-devbox3(n),'LineWidth',.5,'color',colors(3,:))
    
    title(shape)
    xlabel('Time (ms)')
    ylabel('spike count')
end

    frplot=figure;
    frplot.Position=[100,50,1000,700];
for m=1:size(list,1)

    subplot(2,(size(list,1)/2),m)
    shape=cell2mat(list(m));
    hold on
    
    seg=mbox1(2,((m*45)-44):m*45);
    t=1:size(seg,2);
    plot(t,seg,'LineWidth',2,'color',colors(1,:))
    plot(t,seg+devbox1(n),'LineWidth',.5,'color',colors(1,:))
    plot(t,seg-devbox1(n),'LineWidth',.5,'color',colors(1,:))
    
    seg2=mbox2(2,((m*45)-44):m*45);
    t=1:size(seg2,2);
    plot(t,seg2,'LineWidth',2,'color',colors(2,:))
    plot(t,seg2+devbox2(n),'LineWidth',.5,'color',colors(2,:))
    plot(t,seg2-devbox2(n),'LineWidth',.5,'color',colors(2,:))
    
    seg3=mbox3(2,((m*45)-44):m*45);
    t=1:size(seg3,2);
    plot(t,seg3,'LineWidth',2,'color',colors(3,:))
    plot(t,seg3+devbox3(n),'LineWidth',.5,'color',colors(3,:))
    plot(t,seg3-devbox3(n),'LineWidth',.5,'color',colors(3,:))
    
    title(shape)
    xlabel('Time (ms)')
    ylabel('spike count')
end

    frplot=figure;
    frplot.Position=[100,50,1000,700];
for m=1:size(list,1)

    subplot(2,(size(list,1)/2),m)
    shape=cell2mat(list(m));
    hold on
    
    seg=mbox1(3,((m*45)-44):m*45);
    t=1:size(seg,2);
    plot(t,seg,'LineWidth',2,'color',colors(1,:))
    plot(t,seg+devbox1(n),'LineWidth',.5,'color',colors(1,:))
    plot(t,seg-devbox1(n),'LineWidth',.5,'color',colors(1,:))
    
    seg2=mbox2(3,((m*45)-44):m*45);
    t=1:size(seg2,2);
    plot(t,seg2,'LineWidth',2,'color',colors(2,:))
    plot(t,seg2+devbox2(n),'LineWidth',.5,'color',colors(2,:))
    plot(t,seg2-devbox2(n),'LineWidth',.5,'color',colors(2,:))
    
    seg3=mbox3(3,((m*45)-44):m*45);
    t=1:size(seg3,2);
    plot(t,seg3,'LineWidth',2,'color',colors(3,:))
    plot(t,seg3+devbox3(n),'LineWidth',.5,'color',colors(3,:))
    plot(t,seg3-devbox3(n),'LineWidth',.5,'color',colors(3,:))
    
    title(shape)
    xlabel('Time (ms)')
    ylabel('spike count')
end
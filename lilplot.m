%dumb script for plotting
scplot=figure;
hold on
for i=1:length(idx)
    val=idx(i);
    if val==1
        scatter3(test1(i,1),test1(i,2),test1(i,3),'b');
    elseif val==2
        scatter3(test1(i,1),test1(i,2),test1(i,3),'g');
    elseif val==3
        scatter3(test1(i,1),test1(i,2),test1(i,3),'r');
    end
end
hold off

ind1=find(idx==1);
ind2=find(idx==2);
ind3=find(idx==3);

frplot=figure;
hold on
plot(mean(experimental(ind1,:),1),'b')
plot(mean(experimental(ind2,:),1),'g')
plot(mean(experimental(ind3,:),1),'r')

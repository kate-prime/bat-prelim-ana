function fig=RASnew(data,bins,val,call_onset,stim_reps)
reps=20;
num=length(data);
%stims=sortrows(stim_reps,6002);
%stims=stims(:,1:30*40000/1000);
fig=figure;
fig.WindowState='fullscreen'%makes them big
t=(1:size(stim_reps,2))./40;
%call_onset=call_onset';
call_onset(:,1)=call_onset(:,1)./40000;
for idxRAS=1:20:length(data)
    subplot(10,round((num/reps)/10),round(idxRAS/reps)+1)
     for jRAS=0:reps-1
        plot(data(1:end,idxRAS+jRAS),jRAS+1,'.k')
        hold on
        %plot(call_onset(idxRAS,1),10,'*b');
        %plot(call_onset(idxRAS,1)+5,10,'*b');
        %plot(call_onset(idxRAS,1)+15,10,'*b');
        %title(num2str(call_onset(idxRAS,1)))
     end
     plot(t,(mean(stim_reps(idxRAS:idxRAS+19,:),1)*2))
    plot(bins((round(idxRAS/reps)+1),:),val((round(idxRAS/reps)+1),:),'-r')

end

end 
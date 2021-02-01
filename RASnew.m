function fig=RASnew(data,bins,val,call_onset,stim_reps)
reps=20;
num=size(data,2);
fig=figure;
fig.WindowState='minimized';%hides while plotting
fig.Position=[1,1,1700,900];
t=(1:size(stim_reps,2))./40;

stim_reps=stim_reps+8;
%call_onset=call_onset';
call_onset(:,1)=call_onset(:,1)./40000;
for idxRAS=1:20:length(data)
    subplot(10,ceil((num/reps)/10),round(idxRAS/reps)+1)
     for jRAS=0:reps-1
        plot(data(1:end,idxRAS+jRAS),jRAS+1,'.k')
        hold on
        %plot(call_onset(idxRAS,1),10,'*b');
        %plot(call_onset(idxRAS,1)+5,10,'*b');
        %plot(call_onset(idxRAS,1)+15,10,'*b');
        %title(num2str(call_onset(idxRAS,1)))
     end
     %plot(t,(mean(stim_reps(idxRAS:idxRAS+19,:),1).*2),'b')
     thing = val((round(idxRAS/reps)+1),:); %changed because it kept plotting sideways? KA;
     t2=bins((round(idxRAS/reps)+1),:);
    %plot(t2,thing,'-r')
    ylim([0 reps+10]);

end

end 
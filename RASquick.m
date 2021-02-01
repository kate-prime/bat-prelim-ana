function fig=RASquick(data,bins,call_onset,usethese)
reps=20;
num=size(usethese,2);
fig=figure;
%fig.WindowState='minimized';%hides while plotting
fig.Position=[1,1,1000,500];

%call_onset=call_onset';
call_onset(:,1)=call_onset(:,1)./40000;
subs=[7,8,9];
counter=0;
for idxRAS=usethese.*20
    counter=counter+1;
    subplot(3,3,subs(counter))
     for jRAS=0:reps-1
        plot(data(1:end,idxRAS+jRAS),jRAS+1,'.k','MarkerSize',10)
        hold on
     end
     t2=bins((round(idxRAS/reps)+1),:);
    ylim([0 reps+2]);
    xlim([0 40])
    ylabel('Repitition')
    xlabel('Time (ms)')

end

end 
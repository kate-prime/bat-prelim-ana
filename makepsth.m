function [fig,groups]=makepsth(trials,sr,reps)
%make semi useful plots
%trials = sorted wave_clus spike times
%sr = sampling rate
%reps = repititions
%select just non amp corrected echos
%it was probably a dumb idea to hardcode those stim numbers, but sphere was
%a problem

%load data
groups=struct;
groups.cyls.nums=[36 37 38];
groups.cubes.nums=[39 40 41];
groups.spheres.nums=[53 42 43];
groups.LDs.nums=[44 45 46];
groups.SDs.nums=[47 48 49];
groups.MPs.nums=[50 51 52];

list=fieldnames(groups);
fig=figure;
fig.Position=[100,50,1000,700];
for i=1:size(list,1)
    shape=cell2mat(list(i));
    use=groups.(shape).nums;
    subplot(2,(size(list,1)/2),i)
    hold on
    for j=1:size(use,2)
        if j==1
            col = [0 0.4470 0.7410];
        elseif j==2
            col = [0.6350 0.0780 0.1840];
        elseif j==3
            col = [0.4660 0.6740 0.1880];
        end
        data=trials(:,use(j)*20:use(j)*20+reps-1);
        [bins,val]=binfun2(data,45,1);
        [gdata,mdata,dev]=gsmooth(val,sr,2);%hardcoded 2 for gauss width, see how it does
        t=bins(1,1:end-1);
        plot(t,mdata,'LineWidth',2,'color',col)
        %plot(t,(mdata+dev),'LineWidth',.5,'color',col)
        %plot(t,(mdata-dev),'LineWidth',.5,'color',col)
        groups.(shape).gdata(:,:,j)=gdata;
        groups.(shape).mdata(j,:)=mdata;
        groups.(shape).dev(j,:)=dev;
    end
    title(shape)
    xlabel('Time (ms)')
    ylabel('FR (Hz)')
    %ylim([0 200])
end
        
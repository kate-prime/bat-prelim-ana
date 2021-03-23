function [fig,groups]=makepsth(trials,sr,reps,pull)
%make semi useful plots
%trials = sorted wave_clus spike times
%sr = sampling rate
%reps = repititions

groups=pullversion(pull);
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
        data=trials(:,(use(j)*reps-19):use(j)*reps);
        [bins,val]=binfun2(data,45,1);
        [gdata,mdata,dev]=gsmooth(val,sr,3);%lets just go with spike count
        %for now
        %mdata=sum(val,1);
        t=bins(1,1:end-1);
        plot(t,mdata,'LineWidth',2,'color',col)
        %plot(t,(mdata+dev),'LineWidth',.5,'color',col)
        %plot(t,(mdata-dev),'LineWidth',.5,'color',col)
        %groups.(shape).gdata(:,:,j)=val;
        groups.(shape).gdata(:,:,j)=gdata;
        groups.(shape).mdata(j,:)=mdata;
        groups.(shape).dev(j,:)=dev;
    end
    title(shape)
    xlabel('Time (ms)')
    ylabel('FR (Hz)')
    %ylim([0 200])
end
        
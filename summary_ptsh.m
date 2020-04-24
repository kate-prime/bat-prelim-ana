function fig=summary_ptsh(summary, pop)
%
list=fieldnames(summary.(pop));
fig=figure;
fig.Position=[100,50,1000,700];

for i=1:size(list,1)
    shape=cell2mat(list(i));
    subplot(2,(size(list,1)/2),i)
    hold on
    for j=1:3 %remember that you hard coded this
        if j==1
            %col = [0 0.4470 0.7410];
            col = 'k';
            data=summary.tonicpop.(shape).mean_10;
        elseif j==2
            col = [0.6350 0.0780 0.1840];
            data=summary.tonicpop.(shape).mean_20;
        elseif j==3
            col = [0.4660 0.6740 0.1880];
            data=summary.tonicpop.(shape).mean_40;
        end
        mdata=mean(data,1);
        dev=std(data,0,1);
        t=1:size(mdata,2);
        plot(t,mdata,'LineWidth',2,'color',col)
        plot(t,(mdata+dev),'LineWidth',.5,'color',col)
        plot(t,(mdata-dev),'LineWidth',.5,'color',col)
    
    title(shape)
    xlabel('Time (ms)')
    ylabel('FR (Hz)')
    ylim([0 150])
    end
end
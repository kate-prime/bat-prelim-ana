
function [h1,h2,h3,pref_delay,pref_obj,pref_clutter_distance,means,use]=second_ana(spike_data,stim_data)
%KA 2019
%after prelim analysis, check neurons for responses and find some basics
%like prefered delay and plots them
%still in testing for thresholds

%% initial sorting steps
%check for <5 spikes per stim to throw out bad ones quick
n=(max(spike_data.count)<=5);
object_number=max(stim_data(:,2));

if n~=1  %find peaks in post call hist
    pks_box=nan(size (spike_data.hist{1,2}));
    locs_box=nan(size (spike_data.hist{1,2}));
    for p=1:size(spike_data.hist{1,2},1)
        [pks, locs]=findpeaks(spike_data.hist{1,2}(p,:),'MinPeakHeight',3); %can be made more strict, but purposely ~1/2 of thresh (5) in case responses are split over 2 bins
        pks_box(p,1:size(pks,2))=pks;
        locs_box(p,1:size(locs,2))=locs;
    end
    
    %This next few lines are useful when we are looking at the whole stim set (call and
    %echo) and therefore have to choose if the neuron responds to the call
    %or the echo. in the case of this code we are only looking at responses
    %that occur after the echo (see prelim_ana line 48) so having only one
    %response is good.
    
    %tests if majority of responses have only one peak 
%     for q=1:size(locs_box,1)
%         test(q,1:2)=isnan(locs_box(q,1:2));
%     end
%     test=sum(test,1);
%     %creates a scatter plot of peaks from hist vals to check if timing is
%     %consistent or not
%     if (test(1,2)-test(1,1))>3 %can be more or less strict. 2 works, but you gotta sift more.
%         disp('seems like theres only 1 peak, plotting to check timing')
%         h=figure;
%         for r=1:size(locs_box,1)
%             hold on
%             scatter(locs_box(r,:),pks_box(r,:),'filled');
%             x(1:20)=5;
%             plot (x,'r')
%             xlim([0 20])
%             ylim([0 25])
%             title([spike_data.unit])
%             hold off
%         end
%         use=inputdlg('looks ok? 1=yes, 0=no, 9=not sure, show me by stimulus');
%         use=str2double(use);
%         %plots again by stimulus group (useful to see if it's not responsive
%         %and noisy or just very selective)
%         if use==9
%             h=figure;
%             for r=1:size(locs_box,1)
%                 scatter(locs_box(r,:),pks_box(r,:),'filled');
%                 title(r)
%                 xlim([0 20])
%                 ylim([0 25])
%                 pause;
%             end
%             use=inputdlg('looks ok? 1=yes, 0=no');
%             use=str2double(use);
%         end
%         close (h)
%     else
%         use=1;
%     end
    
%% starts generating plots if use==1
use=1;
    if use==1 %find preferred stims based on total spike count (maybe try peak fr instead)
        [pref_delay,pref_obj,pref_clutter_distance,means]=pref_finder(spike_data,stim_data);
        h1=figure('units','normalized','outerposition',[0 0 1 1]);
        
        set(h1,'Position',[150 150 1000 500])
        h(1)=subplot(1,3,1);
        hold on
        scatter(stim_data(:,1),spike_data.count,'filled','r')
        scatter([5 10 15],means(1,1:3),'filled','k')
        xlim([0 20])
        title(h(1),'Delay')
        ylabel('spike count(every dot is for the 20 presentationson that stim)')
        hold off
        h(2)=subplot(1,3,2);
        hold on
        scatter(stim_data(:,2),spike_data.count,'filled','b')
        scatter((1:4),means(2,1:4),'filled','k')
        xlim([0 (object_number+1)])
        title(h(2),'Object')
        hold off
        h(3)=subplot(1,3,3);
        hold on
        scatter(stim_data(:,3),spike_data.count,'filled','g')
        xlim([-5 25])
        scatter([0 10 20],means(3,1:3),'filled','k')
        title(h(3),'Clutter distance')
        hold off
    end
    %% Plot jitter
    if use==1
        
        jitter_box=[spike_data.jitter stim_data]; %by delay
        ind5=find(jitter_box(:,2)==5);
        ind10=find(jitter_box(:,2)==10);
        ind15=find(jitter_box(:,2)==15);
        means(1,1,2)=mean(jitter_box(ind5,1));
        means(1,2,2)=mean(jitter_box(ind10,1));
        means(1,3,2)=mean(jitter_box(ind15,1));
        means(1,4,2)=nan;
        
        indcyl=find(jitter_box(:,3)==1);%by object
        indcube=find(jitter_box(:,3)==2);
        indsphere=find(jitter_box(:,3)==3);
        indLD=find(jitter_box(:,3)==3);
        indSD=find(jitter_box(:,3)==5);
        indMP=find(jitter_box(:,3)==6);
        means(2,1,2)=mean(jitter_box(indcyl,1));
        means(2,2,2)=mean(jitter_box(indcube,1));
        means(2,3,2)=mean(jitter_box(indLD,1));
        means(2,4,2)=mean(jitter_box(indSD,1));
        
        ind0=find(jitter_box(:,4)==0);%by clutter distance
        ind10=find(jitter_box(:,4)==10);
        ind20=find(jitter_box(:,4)==20);
        means(3,1,2)=mean(jitter_box(ind0,1));
        means(3,2,2)=mean(jitter_box(ind10,1));
        means(3,3,2)=mean(jitter_box(ind20,1));
        means(3,4,2)=nan;
        
        h2=figure('units','normalized','outerposition',[0 0 1 1]);
        
        set(h2,'Position',[150 150 1000 500])
        h(1)=subplot(1,3,1);
        hold on
        scatter(stim_data(:,1),spike_data.jitter,'filled','r')
        scatter([5 10 15],means(1,1:3,2),'filled','k')
        xlim([0 20])
        title(h(1),'Delay')
        ylabel('jitter(every dot is for the 20 presentationson that stim)')
        hold off
        h(2)=subplot(1,3,2);
        hold on
        scatter(stim_data(:,2),spike_data.jitter,'filled','b')
        scatter((1:4),means(2,1:4,2),'filled','k')
        xlim([0 (object_number+1)])
        title(h(2),'Object')
        hold off
        h(3)=subplot(1,3,3);
        hold on
        scatter(stim_data(:,3),spike_data.jitter,'filled','g')
        scatter([0 10 20],means(3,1:3,2),'filled','k')
        xlim([-5 25])
        title(h(3),'Clutter distance')
        hold off
    end
    %% simple bar graph for fr in each stim condition
    if use==1
        fr_box=[spike_data.fr stim_data];
        fr_box=sortrows(fr_box);
        x={};
        for i=1:(length(fr_box))
            if fr_box(i,3)==1
                nom='cyl';
            elseif fr_box(i,3)==2
                nom='cube';
            elseif fr_box(i,3)==3
                nom='shpere';
            elseif fr_box(i,3)==4
                nom='LD';
            elseif fr_box(i,3)==5
                nom='SD';
            elseif fr_box(i,3)==6
                nom='MP';
            elseif fr_box(i,3)==7
                nom='AMPcyl';
            elseif fr_box(i,3)==8
                nom='AMPcube';
            elseif fr_box(i,3)==9
                nom='AMPshpere';
            elseif fr_box(i,3)==10
                nom='AMPLD';
            elseif fr_box(i,3)==11
                nom='AMPSD';
            elseif fr_box(i,3)==12
                nom='AMPMP';
            end
            x{i}=[num2str(fr_box(i,2)), num2str(fr_box(i,4)),nom];
        end
        x1=(1:length(x));
        h3=figure('units','normalized','outerposition',[0 0 1 1]);
        hold on
        bar(x1,fr_box(:,1))
        xticks(1:length(x))
        xticklabels(x)
        xtickangle(45)
        hold off
    end
    
else
    use=0;
end
if use==0
    h1=0;
    h2=0;
    h3=0;
    pref_delay=0;
    pref_obj=0;
    pref_clutter_distance=0;
    means=0;
end
% Kate: worth determinine peak fr from isi? probably unless most are very low
% firing
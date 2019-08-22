%Modified from AS by KA 2019

function [spk_number,jitter,spikerate,resp_dur_total,latency] = Countspikes_ana(times,spiketimes,r,x,bins,delay,val,len,reps)
%function for preliminary analysis on spikes data from wave_clus
%x=stim you're on (numeral)
%times=vector of stim start times for stim x + delay
%spiketimes=matrix of spike times for stim x
%r=size of spike matrix
%bins is from hist
%val is from hist
%len=length of stimulus window in ms
%delay=length from stim start to call onset in ms
%reps is stimulus repeats


%% find bins and number of spikes after call onset
%resp1st is a filtered version of bins removes spikes occoring before first
%pulse. FUTURE KATE:consider filtering each stim for after echo onset
for i=1:size(bins,2)
    for j=1:2:reps %20 
        if bins(x,i)>delay/2 %looking at line X of bins and val %SOMETHING FUCKY IN HERE
            resp1st((j*.5)+.5,i)=bins(x,i);%looking at line X of bins and val
        else
            resp1st((j*.5)+.5,i)=NaN;
        end
    end
end
% pos is a lookup on resp1st
for i=1:length(times)/2
    pos(i,1:length(find(isnan(resp1st(i,:))==0)))=find(isnan(resp1st(i,:))==0);
end

pos(pos==0)=NaN;
resp_y=[];
resp_x=[];
for i=1:(length(times)/2)
    try
        resp_x(i,1:length(bins(x,min(pos(i,:)):max(pos(i,:)))))=bins(x,min(pos(i,:)):max(pos(i,:)));
    catch
        resp_x(i,1:size(pos,2))=nan;
    end
    try
        resp_y(i,1:length(val(x,min(pos(i,:)):max(pos(i,:)))))=val(x,min(pos(i,:)):max(pos(i,:)));
    catch
        resp_y(i,1:size(pos,2))=nan;
    end
end
resp_y(resp_x==0)=NaN;
resp_x(resp_x==0)=NaN;

for i=1:length(times)/2;
    %resp_dur_total(i) = times(i*2)-times(i*2-1);
    resp_dur_total = len-delay; %needed to calculate fr, currently only works if all stims are same length
end
% KATE-consider fixing response_dur or adding to response_dur to find time
% from first spike to last spike, although might not be informative for
% low FR neurons
%latency=lat-(call_onset(calls));
%% analyze spike times

spike_times(r,length(times))=NaN; 
%for k=1:2:length(times) %filters for only spikes after stim onset
    for i=1:length(times)
        for j=1:r
            if (spiketimes(j,i)>=(delay-1)) %looks like spike times are already... 
                spike_times(j,i)=spiketimes(j,i);%based on relative time, not clock time,...
            else                                 %so delay works here %something weird where responses start before delay? check sr
                spike_times(j,i)=NaN;
            end
        end
    end
%end

for i=1:size(spike_times,2) %pulls out earliest spike times
    min_col(i)=min(spike_times(:,i));
end

jitter=[];
latency=[];
for i=1:reps:length(min_col)
    jitter1=nanstd(min_col(1,i:i+(reps-1))); %calculates std of min start times
    jitter=[jitter,jitter1];
    latency=[latency,nanmean(min_col(1,i:i+(reps-1)))-times((i-1)/10+1)]; %check scaling here too
end
spk_number=[];
for i=1:reps:size(spike_times,2) %count # of spikes
    spk_number1=numel(spike_times(:,i:i+(reps-1)))-sum(sum(isnan(spike_times(:,i:i+(reps-1)))));
    spk_number=[spk_number,spk_number1];
end
spikerate = spk_number/resp_dur_total/reps*1000;
% for i=1:(length(times)/2) %for if you have multiple response durations
%     spikerate(i) = spk_number(i)/resp_dur_total/20*1000;
% end

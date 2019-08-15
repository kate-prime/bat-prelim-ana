%Modified from AS by KA 2019
function [spike_data,fig]=prelim_ana(fname,data,call_onset,delay,len,reps)
%type: 1=3D, 2=FT
%FUTURE KATE: figure out if you wanna loop or run FT and 3D separate, just
%does 3d for now
%delay=length to stim onset-KATE: use 5 ms
%len=length of stimulus in ms
%reps is stimulus repeats
%% load data and stim files
spike_data.unit{1,1}=fname;%

 
%Not strictly necessary, but handy
matFile = ['E:\KA001\stimuli\3Dstim2','.mat'];%loads stimuli
if exist(matFile,'file')
    load(matFile);
    stim3D=stims3D.stim;
    spike_data.stims{1,1}=stim3D;
else
    disp('you gonna need 3D stims')
end


%% make the bins
[data,bins,val]=binfun(data,len,2,reps);
bins(:,size(bins,2))=[];
spike_data.hist{1,1}=bins;
spike_data.hist{1,2}=val;

%% get call onset times
%takes stim onset from ttls then adds delay to determine actual call onset
%might be worth figuring out echo onset too

 ind=[];
for i=1:(size(call_onset,1)/reps) %sorts stims
    temp=find(call_onset(:,2)==i); 
    ind=[ind,temp];
end

% FOR FT STIMS
% ind1=(20:5:90);
% for i=1:length(ind1)
%     temp=find(call_onset(:,2)==ind1(i));
%     ind=[ind,temp];
% end
call_onset=call_onset(ind,1);
for n=1:size(call_onset,1)
    call_onset(n)=call_onset(n)+delay;
end

%% Make the rasters
fig=makeras(data,len,reps,40000,stims3D); %including stims here isn't necessesary, just adds a plot on the raster

%% set up storage cells
num=(size(data,2)/reps);
spike_data.latency=NaN(num,1);
spike_data.jitter=NaN(num,1);
spike_data.count=NaN(num,1);
spike_data.times=NaN(num,reps);%
spike_data.dur_total=NaN(num,1);
spike_data.fr=NaN(num,1);

%% loop for each stim
for x=1:(size(data,2)/reps)
    r2=x*reps; %end of range
    r1=r2-(reps-1); %start of range
%     r3=r1-1;
%     r4=r2+1; %what is this?
    r=size(data(:,r1:r2),1);%looking at stim X
    spiketimes=data(:,r1:r2); %all spike times for that stim
    times=call_onset(r1:r2,:); %all onset times for that stim
    %% Actually do the analysis
    [spk_number,jitter,spikerate,resp_dur_total,latency] = Countspikes_ana(times,spiketimes,r,x,bins,delay,val,len,reps);
    
    spike_data.spikenumber(x,:) =spk_number';
    spike_data.jitter(x,:)=jitter;
    spike_data.latency(x,:)=latency;
    spike_data.count(x,:)=spk_number;
    spike_data.times(x,:)=times';
    spike_data.dur_total(x,:) = resp_dur_total;
    spike_data.fr(x,:) = spikerate;

    %KATE figure out new way to ignore bad neurons
%     if isempty(timesave) || all(isnan(timesave)) % allows me to ignore bad neurons
%         spike_data.calls=[];
%         return
%     end
end

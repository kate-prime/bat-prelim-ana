%Last touched by KA 20200229
%Modified from AS by KA 2019
%counts spikes and builds rasters for prelim data analysis
function [spike_data, fig]=prelim_ana(fname,data,call_onset,delay,len,reps,stim_reps)

%FUTURE KATE: figure out if you wanna loop or run FT and clutter separate, just
%does 3d for now
%delay=length to stim onset-KATE: use 5 ms
%len=length of stimulus in ms
%wind=window of the response to analayze in ms
%reps=stimulus repeats

%% load data and stim files
spike_data.unit{1,1}=fname;%
%tidy this up
%     %Not strictly necessary, but handy
%     matFile = ['D:\AngieDrive\Bats\NSF shapes project\neural_stim\clutterstim_org.mat'];%loads stimuli
%     if exist(matFile,'file')
%         load(matFile);
%         spike_data.stims{1,1}=stim;
%     end

%% make the bins
[data,bins,val]=binfun(data,(len+15),1,reps); %added some cushion for delay+echo
bins(:,size(bins,2))=[];
spike_data.hist{1,1}=bins;
spike_data.hist{1,2}=val;

%% get call onset times
%takes stim onset from ttls then adds delay to determine actual call onset
call_onset_temp=call_onset;
ind=[];
for i=1:(size(call_onset,1)/reps) %sorts stims
    temp=find(call_onset(:,2)==i);
    ind=[ind,temp];
end

% call_onset=call_onset(ind,1);
% for n=1:size(call_onset,1)
%     call_onset(n)=call_onset(n)+delay;
% end
call_onset=sortrows(call_onset,2); %added 20200303

%% Make the rasters
fig=RASnew(data,bins,val,call_onset,stim_reps);
%fig=makeras(data,len,reps,subProws); %including stims here isn't necessesary, just adds a plot on the raster


%% set up storage cells
num=(size(data,2)/reps);
spike_data.latency=NaN(num,1);
spike_data.jitter=NaN(num,1);
spike_data.count=NaN(num,1);
spike_data.call_times=NaN(num,reps);%
spike_data.dur_total=NaN(num,1);
spike_data.fr_all=NaN(num,1);
spike_data.spike_times=data;

%% generates a box of expected echo onset delays. only works if stims are in 5,10,15ms order
%this may not be necessary anymore
% echos=[]; 
%        for i=1:round(num/3) %makes a column corresponding to echo delays
%            echos=[echos;[5;10;15]];
%        end
%        if num-length(echos)==1 %this is not an elegant solution
%            echos=[echos;5];
%        elseif num-length(echos)==2
%            echos=[echos;5;10];
%        end

%% loop for each stim
for x=1:(size(data,2)/reps)
    r2=x*reps; %end of range
    r1=r2-(reps-1); %start of range
    %     r3=r1-1;
    %     r4=r2+1; %what is this?
    r=size(data(:,r1:r2),1);%looking at stim X
    spiketimes=data(:,r1:r2); %all spike times for that stim
    times=call_onset(r1:r2,1); %all onset times for that stim
    echo=10; %FUTURE KATE remember that you hard coded this

    %% Actually do the analysis
    [spk_number,jitter,spikerate,resp_dur_total,latency] = Countspikes_ana(times,spiketimes,r,x,bins,delay,val,45,reps,echo);
    
    spike_data.spikenumber(x,:) =spk_number';
    spike_data.jitter(x,:)=jitter;
    spike_data.latency(x,:)=latency;
    spike_data.count(x,:)=spk_number;
    spike_data.times(x,:)=times';
    spike_data.dur_total(x,:) = resp_dur_total;

    spike_data.fr_all(x,:) = spikerate;

%    spike_data.fr(x,:) = spikerate;
    

    %bad neurons will be filtered at next step by spike count and echo
    %response
end

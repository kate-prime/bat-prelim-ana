function [pref_delay,pref_obj,pref_clutter_distance,means]=pref_finder(spike_data,stim_data)
%finds preferred angle,delay, and echo for 3d stims based on total spike
%count in response window. can be reconfigured to use peak fr
%% find preferred delay
delay_box(:,1)=spike_data.count;
%Kate, keep this for when stim_data isn't premade variable
% delays=[]
%        for i=1:round(length(delay_box)/3) %makes a column corresponding to echo delays
%            delays=[delays;[5;10;15]];
%        end
%        if length(delay_box)-length(delays)==1 %this is not an elegant solution
%            delays=[delays;5];
%        elseif length(delay_box)-length(delays)==2
%            delays=[delay;5;10];
%        end
delay_box(:,2)=cell2mat(stim_data(:,1));
delay_box=sortrows(delay_box,'descend');
pref_delay=mode(delay_box(1:11,2)); %finds most common delay value in top 1/3

%find means
ind5=find(delay_box(:,2)==5);
ind10=find(delay_box(:,2)==10);
ind15=find(delay_box(:,2)==15);
means(1,1)=mean(delay_box(ind5,1));
means(1,2)=mean(delay_box(ind10,1));
means(1,3)=mean(delay_box(ind15,1));
means(1,4:length(unique(stim_data(:,2))))=nan;
%%  find preferred object

obj_box(:,1)=spike_data.count;
obj_box(:,2)=cell2mat(stim_data(:,4));
obj_box=sortrows(obj_box,'descend');
for idx = 1 : length(unique(obj_box(:,2)))
    means(2,idx)=mean(delay_box(obj_box(:,2)==idx),1);
end
pref_obj=find(means(2,:)==max(means(2,:))); %finds max from mean counts
%assert(length(pref_obj)==1);

%% find preferred angle
clut_dist_box(:,1)=spike_data.count;
clut_dist_box(:,2)=cell2mat(stim_data(:,3));
clut_dist_box=sortrows(clut_dist_box,'descend');
pref_clutter_distance=mode(clut_dist_box(1:11,2)); %finds most common ang value in top 1/3
%use w/ caution, might be biased against 90 because of cube
ind0=find(clut_dist_box(:,2)==0);
ind10=find(clut_dist_box(:,2)==10);
ind20=find(clut_dist_box(:,2)==20);
means(3,1)=mean(clut_dist_box(ind0,1));
means(3,2)=mean(clut_dist_box(ind10,1));
means(3,3)=mean(clut_dist_box(ind20,1));
means(3,4:length(unique(stim_data(:,2))))=nan;


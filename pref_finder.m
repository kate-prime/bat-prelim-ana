function [pref_delay,pref_obj,pref_ang,means]=pref_finder(spike_data,stim_data)
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
delay_box(:,2)=stim_data(:,1);
delay_box=sortrows(delay_box,'descend');
pref_delay=mode(delay_box(1:11,2)); %finds most common delay value in top 1/3
%find means
ind5=find(delay_box(:,2)==5);
ind10=find(delay_box(:,2)==10);
ind15=find(delay_box(:,2)==15);
means(1,1)=mean(delay_box(ind5,1));
means(1,2)=mean(delay_box(ind10,1));
means(1,3)=mean(delay_box(ind15,1));
means(1,4)=nan;
 %%  find preferred object
 
 obj_box(:,1)=spike_data.count;
 obj_box(:,2)=stim_data(:,2);
 obj_box=sortrows(obj_box,'descend');
indcyl=find(obj_box(:,2)==1);
indcube=find(obj_box(:,2)==2);
indLD=find(obj_box(:,2)==3);
indSD=find(obj_box(:,2)==4);
means(2,1)=mean(delay_box(indcyl,1));
means(2,2)=mean(delay_box(indcube,1));
means(2,3)=mean(delay_box(indLD,1));
means(2,4)=mean(delay_box(indSD,1));
pref_obj=find(means(2,:)==max(means(2,:))); %finds max from mean counts
 if pref_obj==1
     pref_obj=('cyl');
 elseif pref_obj==2
     pref_obj=('cube');
 elseif pref_obj==3
     pref_obj=('LD');
 elseif pref_obj==4
     pref_obj=('SD');
 end

%% find preferred angle
ang_box(:,1)=spike_data.count;
ang_box(:,2)=stim_data(:,3);
ang_box=sortrows(ang_box,'descend');
pref_ang=mode(ang_box(1:11,2)); %finds most common ang value in top 1/3
%use w/ caution, might be biased against 90 because of cube
ind0=find(ang_box(:,2)==0);
ind45=find(ang_box(:,2)==45);
ind90=find(ang_box(:,2)==90);
means(3,1)=mean(ang_box(ind0,1));
means(3,2)=mean(ang_box(ind45,1));
means(3,3)=mean(ang_box(ind90,1));
means(3,4)=nan;

function [pref_delay,pref_obj,pref_clutter_distanc,means]=pref_finder(spike_data,stim_data)
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
indsphere=find(obj_box(:,2)==3);
indLD=find(obj_box(:,2)==4);
indSD=find(obj_box(:,2)==5);
indMP=find(obj_box(:,2)==6);
indAMPcyl=find(obj_box(:,2)==7);
indAMPcube=find(obj_box(:,2)==8);
indAMPsphere=find(obj_box(:,2)==9);
indAMPLD=find(obj_box(:,2)==10);
indAMPSD=find(obj_box(:,2)==11);
indAMPMP=find(obj_box(:,2)==12);
means(2,1)=mean(delay_box(indcyl,1));
means(2,2)=mean(delay_box(indcube,1));
means(2,3)=mean(delay_box(indsphere,1));
means(2,4)=mean(delay_box(indLD,1));
means(2,5)=mean(delay_box(indSD,1));
means(2,6)=mean(delay_box(indMP,1));
means(2,7)=mean(delay_box(indAMPcyl,1));
means(2,8)=mean(delay_box(indAMPcube,1));
means(2,9)=mean(delay_box(indAMPsphere,1));
means(2,10)=mean(delay_box(indAMPLD,1));
means(2,11)=mean(delay_box(indAMPSD,1));
means(2,12)=mean(delay_box(indAMPMP,1));
pref_obj=find(means(2,:)==max(means(2,:))); %finds max from mean counts
if pref_obj==1
    pref_obj=('cyl');
elseif pref_obj==2
    pref_obj=('cube');
elseif pref_obj==3
    pref_obj=('shpere');
elseif pref_obj==4
    pref_obj=('LD');
elseif pref_obj==5
    pref_obj=('SD');
elseif pref_obj==6
    pref_obj=('MP');
elseif pref_obj==7
    pref_obj=('AMPcyl');
elseif pref_obj==8
    pref_obj=('AMPcube');
elseif pref_obj==9
    pref_obj=('AMPshpere');
elseif pref_obj==10
    pref_obj=('AMPLD');
elseif pref_obj==11
    pref_obj=('AMPSD');
elseif pref_obj==12
    pref_obj=('AMPMP');
end

%% find preferred angle
clut_dist_box(:,1)=spike_data.count;
clut_dist_box(:,2)=stim_data(:,3);
clut_dist_box=sortrows(clut_dist_box,'descend');
pref_clutter_distanc=mode(clut_dist_box(1:11,2)); %finds most common ang value in top 1/3
%use w/ caution, might be biased against 90 because of cube
ind0=find(clut_dist_box(:,2)==0);
ind10=find(clut_dist_box(:,2)==10);
ind20=find(clut_dist_box(:,2)==20);
means(3,1)=mean(clut_dist_box(ind0,1));
means(3,2)=mean(clut_dist_box(ind10,1));
means(3,3)=mean(clut_dist_box(ind20,1));
means(3,4)=nan;

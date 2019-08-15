function fig=makeras(data,len,reps,sr,stim,varargin)
%modified from AS by KA 2019
%data is a matrix of spike times of of (m * n) where m is spike times in bin and
%n is number of trials * reps. 
%len is the length of response window/stim length in ms
%stimuli should be organized a struct with stim name and
%stimulus as separate cells
%sr=sampling rate
%reps is stimulus repeats
%FUTURE KATE
%   still need to make cells for FT stim
%   consider making reps inputtable
%   consider restructuring into 3d matrices

if exist('sr')==0
    sr=40000;
end

[r,num]=size(data);
for i=1:reps:num;
    data(r+1,i:i+(reps-1))=-20;
    data(r+2,i:i+(reps-1))=150;
    data(data==0)=NaN;
    f=figure; set(f,'Visible','off')
    his=histogram(data(:,i:i+(reps-1)),170);
    bins(round(i/reps)+1,1:length(his.BinEdges))=his.BinEdges;
    val(round(i/reps)+1,1:length(his.Values))=his.Values;

end
%
bins(:,length(bins))=[];
n=0;
fig=figure;
for i=1:reps:num
    n=n+1; %counter
    subplot(4,round((num/reps)/4),round(i/reps)+1)
    for j=0:reps-1
        plot(data(:,i+j),j+1,'.k')
        hold on
    end
    plot(bins((round(i/reps)+1),:),val((round(i/reps)+1),:),'-r') %plot spk count
%     try %adds stimulus to hist to visualize onset and echo - Not strictly necessary, just handy
%         temp=cell2mat(stim.stim(n));
%         ind=find(temp>.05);
%         temp2=zeros(size(temp));
%         temp2(ind)=2;
%         temp2=temp2+22;
%         xax=(1:length(temp))./(sr/100); %there is a scaling issue in here somewhere
%         plot(xax,temp2,'-b')
%     end

    
    
    xlim([0 len+10]); ylim([0 reps+5])
    %try title(stim.name(n)); end %labels individual plots, remember to fix names
end

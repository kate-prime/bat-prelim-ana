%Last touched by KA 20200229

function fig=makeras(data,len,reps,subProws)

%modified from AS by KA 2019
%data is a matrix of spike times of of (m * n) where m is spike times in bin and
%n is number of trials * reps. 
%len is stim length in ms
%stimuli should be organized in a struct with stim name and
%stimulus as separate cells
%sr=sampling rate
%reps is stimulus repeats
%FUTURE KATE
%   consider restructuring into 3d matrices


[r,num]=size(data);
for i=1:reps:num
    data(r+1,i:i+(reps-1))=-20;
    data(r+2,i:i+(reps-1))=150;
    data(data==0)=NaN;
    f=figure; set(f,'Visible','off')
    his=histogram(data(2:end,i:i+(reps-1)),150);%remember to fix the two
    bins(round(i/reps)+1,1:length(his.BinEdges))=his.BinEdges;
    val(round(i/reps)+1,1:length(his.Values))=his.Values;

end
%
bins(:,length(bins))=[];
n=0;
fig=figure('units','normalized','outerposition',[0 0 1 1]);
for i=1:reps:num
    n=n+1; %counter
    subplot(subProws,round((num/reps)/subProws),round(i/reps)+1)
    for j=0:reps-1
        plot(data(1:end,i+j),j+1,'.k')
        hold on
    end
    plot(bins((round(i/reps)+1),:),val((round(i/reps)+1),:),'-r') %plot spk count

    %title(data(1,i+j));
%     try %adds stimulus to hist to visualize onset and echo - Not strictly necessary, just handy
%         temp=(stim(:,n));
%         ind=find(temp>.06);
%         temp2=zeros(size(temp));
%         temp2(ind)=2;
%         temp2=temp2+22;
%         xax=(1:length(temp))./(250);
%         plot(xax,temp2,'-b')
%     end

    

    xlim([0 len+10]); ylim([0 reps+5])
    %try title(stim.name(n)); end %labels individual plots, remember to fix names
end

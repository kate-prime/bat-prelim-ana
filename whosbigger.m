
function [clutterPOPspikes,sterrorPOP,labelshape]=whosbigger(stim_data,spike_data,idxShape)
clutterPOPspikes(:,1)=cell2mat(stim_data((cell2mat(stim_data(:,4))==idxShape),3));
clutterPOPspikes(:,2)=spike_data.spikenumber(cell2mat(stim_data(:,4))==idxShape);
clutterPOPspikes=sortrows(clutterPOPspikes);%this fixes the sphere being out of order problem

jitterbug=-2 + (2+2)*rand(length(clutterPOPspikes),1);
clutterPOPspikes(:,1)=clutterPOPspikes(:,1)+ jitterbug;

sterrorPOP=std(clutterPOPspikes(:,2))/sqrt(3);
labelshape=cell2mat(stim_data((cell2mat(stim_data(:,4))==idxShape),2));
labelshape=labelshape(1,:);
end
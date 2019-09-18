
function [data,bins,val]=binfun(data,len,wid,reps)
%modified from AS by KA 2019
%bins sorted trials
%data is a sorted matrix of spike times of of (m * n) where m is spikes in bin and
%n is number of trials * num reps.
%len=stimulus length in ms
%wid=bin width
%reps is stimulus repeats


for j=1:reps:length(data) %deletes spikes that happen after stimulus (between stim and TTL)
    trials_temp = data (:,j:j+reps-1);
    trials_temp(trials_temp > (len+reps)) = NaN;
    data (:,j:j+(reps-1)) = trials_temp;
end
  
for i=1:reps:length(data)
    binstemp = 0:wid:(len); %KATE: +reps that was in there for reasons, but I'm not sure why
    bins(round(i/reps)+1,1:length(binstemp))=binstemp;
    val(round(i/reps)+1,1:length(binstemp)-1)=histcounts(data(:,i:i+reps-1),binstemp);   
end
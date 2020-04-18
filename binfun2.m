
function [bins,val]=binfun2(data,len,wid)
%modified from AS by KA 2019
%bins individual trials instead of summed repeats
%data is a sorted matrix of spike times of of (m * n) where m is spikes in bin and
%n is number of trials * num reps.
%len=stimulus length in ms
%wid=bin width
%reps is stimulus repeats
  
for i=1:size(data,2)
    binstemp = 0:wid:(len);
    bins(i,1:size(binstemp,2))=binstemp;
    val(i,1:size(binstemp,2)-1)=histcounts(data(:,i),binstemp);   
end
function cmat=dumbheat(vals,tidle) 
%a function for making a confusion matrix from pairwise discrim ana
%vals=mean min err values

box=[];
for i=1:6
    
        temp=vals((i*6)-5:i*6);
    box=[box,temp];
end
for j=1:size(box,1)
    for k=1:size(box,2)
        termp=(box(j,k)+box(k,j))/2;
        box(j,k)=termp;
        box(k,j)=termp;
    end
end

othertemp=ones(size(box));
correct=othertemp-box;
correct=correct.*100;


cmat=figure;
heatmap(correct)
colormap('parula')

xlabel('Object')
ylabel('Object')
caxis([50 100])

title(tidle)
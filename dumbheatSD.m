function cmat=dumbheatSD(vals) 
%A dumb solution to a silly problem!

%remember that you cut out sphere later

box=[];
for i=1:6
    if i==3
      continue
    end
    temp=vals((i*6)-5:i*6);
    box=[box,temp];
end
box=box([1 2 4 5 6],:);
for j=1:size(box,1)
    for k=1:size(box,2)
        termp=(box(j,k)+box(k,j))/2;
        box(j,k)=termp;
        box(k,j)=termp;
    end
end

box=round(box,2);
cmat=figure;
heatmap(box)
colormap('parula')

xlabel('Object')
ylabel('Object')
caxis([50 100])

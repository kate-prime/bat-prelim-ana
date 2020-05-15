function friends=findbuddies(data)

for i=1:size(data,3)
    comp=data(:,:,i);
    temp=[];
    for j=1:size(comp,1)
        if (max(comp(j,:))<100)==1
            temp=[temp,j];
        end
    end
    friends(i)={temp};
end
